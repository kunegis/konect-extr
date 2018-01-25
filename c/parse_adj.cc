/*
 * Parse an "adjacency file" format.  This is used e.g. by the DIMACS10
 * networks (family "dimacs10"). 
 *
 * This program is independent of the directedness of the network:  all
 * edges are passed from input to output as they are.  Duplicate edges,
 * edge directions etc. are thus passed through. 
 *
 * INVOCATION
 *	$0 INPUT-FILE OUTPUT-FILE 
 *
 * INPUT-FILE
 *	The first line contains the number of nodes and edges, and is ignored
 *	As text, one node per line, containing all IDs of nodes
 *	connected to it.  The from-node-ID is not saved, but is implicit
 *	in the line numbering.  Additionally, weights can be included
 *	after each to-node-ID.  This is the case if the third number in
 *	the first line is '1'. 
 *
 * OUTPUT-FILE
 *	Two numbers per line:  the individual node IDs for each edge
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>
#include <fcntl.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>

int main(const int argc, const char *const *const argv)
{
	if (argc != 3) {
		fprintf(stderr, "*** Error: Expected INPUT-FILE and OUTPUT-FILE\n"); 
		exit(1);
	}

	const char *const filename_in= argv[1];
	const char *const filename_out= argv[2]; 

	const int fd_in= open(filename_in, O_RDONLY);
	if (fd_in < 0) {
		perror(filename_in);
		exit(1); 
	}

	if (0 != posix_fadvise(fd_in, 0, 0, POSIX_FADV_SEQUENTIAL)) {
		perror(filename_in);
		exit(1); 
	}

	/* The output file is not mapped because we can't easily predict
	 * its size.  It would be possible to do with resizing at each
	 * step  */

	struct stat buf_in;
	
	if (0 != fstat(fd_in, &buf_in)) {
		perror(filename_in);
		exit(1); 
	}
	const size_t size_in= buf_in.st_size; 

	const char *const p_begin= (const char *)
		mmap(nullptr, size_in, PROT_READ, MAP_SHARED, fd_in, 0);
	if (p_begin == MAP_FAILED) {
		perror(filename_in);
		exit(1); 
	}

	const char *p= p_begin;
	const char *const p_end= p_begin + size_in; 

	/* Output */
	FILE *out= fopen(filename_out, "w");
	if (! out) {
		fprintf(stderr, "*** Error: fopen\n"); 
		perror(filename_out); 
		exit(1);
	}
	
	/* Header */
	while (p < p_end && *p != '\n')
		++p;
	char c= '\0'; 
	if (p < p_end) {
		if (p > p_begin) { 
			c= p[-1]; /* Determines format */
			switch (c) {
			default:
				fprintf(stderr, "*** Error: invalid format \'%c\'\n", c); 
				exit(1);
			case '0':  case '1':  ;
			}
		} else {
			fprintf(stderr, "*** Error: Expected non-empty header (first line)\n"); 
			exit(1); 
		}
		++p;
	}

	uintmax_t line= 1; 
	
	/* Content */
	while (p < p_end) {
		++line; 

		static char from[20];
		if (0 > sprintf(from, "%ju", line-1)) {
			fprintf(stderr, "%s:%ju: Error: From-node-ID error\n", filename_in, line); 
			perror("sprintf"); 
			exit(1); 
		}
//		fprintf(stderr, "XXX(%s)\n", from); 

		switch (c) {
		default:  assert(0);  exit(1); 
		case '0':
		while (p < p_end && *p != '\n') {
			while (p < p_end && isblank(*p))
				++p;
			const char *const p_v= p;
			while (p < p_end && ! isspace(*p))
				++p;
			if (p == p_v) 
				break;
			fputs(from, out);
			fputc('\t', out);
			fwrite(p_v,    p - p_v,          1, out); 
			fputc('\n', out); 
			if (ferror(out)) {
				perror(filename_out); 
				fprintf(stderr, "%s:%ju: Error: Write error in output\n", filename_in, line); 
				exit(1); 
			}
		}
		break;
		
		case '1':
		while (p < p_end && *p != '\n') {
			while (p < p_end && isblank(*p))
				++p;
			const char *const p_v= p;
			while (p < p_end && ! isspace(*p))
				++p;
			if (p == p_v)
				break; 
			const char *const p_v_end= p; 
			while (p < p_end && isblank(*p))
				++p;
			if (p == p_v_end) {
				fprintf(stderr, "%s:%ju: Error: missing weight\n", filename_in, line); 
				exit(1); 
			}
			const char *const p_w= p;
			while (p < p_end && ! isspace(*p))
				++p;
			if (p == p_w) {
				fprintf(stderr, "%s:%ju: Error: missing weight\n", filename_in, line); 
				exit(1); 
			}
			fputs(from, out);
			fputc('\t', out);
			fwrite(p_v,    p_v_end - p_v,          1, out); 
			fputc('\t', out);
			fwrite(p_w,    p - p_w,                1, out); 
			fputc('\n', out); 
			if (ferror(out)) {
				perror(filename_out); 
				fprintf(stderr, "%s:%ju: Error: Write error in output\n", filename_in, line); 
				exit(1); 
			}
		}
		break;
		}

		if (p < p_end && *p == '\n')
			++p; 
	}

	if (fclose(out)) {
		fprintf(stderr, "*** Error: fclose\n"); 
		perror(filename_out); 
		exit(1); 
	}
	
	/* Don't bother closing the input */ 

	exit(0); 
}
