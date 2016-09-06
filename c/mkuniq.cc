/* A C++ implementation of mkuniq.
 *
 * Optimized for using little memory, and being fast. 
 *
 * ASSUMPTIONS
 *      * There is at least one content line
 *      * All lines are terminated with \n
 *      * All lines have at least two columns
 *      * Only space and tab used for separation 
 *      * Header lines have no space before '%'
 */

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <ctype.h>
#include <assert.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>

#include <map>

using namespace std; 

typedef uintmax_t node_t;

/* A string represented by a char pointer, terminated by space, tab or \n.
 * No memory management is performed.  The string cannot contain space,
 * tab, or \n and also does not contain \0. 
 */
class refstring
{
private:
	const char *str;

public:
	refstring(const char *const str_new)
		:  str(str_new) 
	{ }

	bool operator<(const refstring& r) const { 
		
		const char *a= this->str;
		const char *b= r.str;

		for (;;) {
			bool sa= isspace(*a);
			bool sb= isspace(*b);
		
			if (sa && sb)  return false;
			if (sa && !sb) return true;
			if (!sa && sb) return false;
			if (*a < *b)   return true;
			if (*b < *a)   return false;
			++a;
			++b;
		}
	}
};

node_t get(map <refstring, node_t> &m, refstring s, node_t &next)
{
	auto i= m.insert((pair <refstring, node_t> (s, next)));

        if (i.second == false) {
		/* Was already in it */
		return i.first->second;
	} else {
		/* Was successfully inserted */
		return next++; 
        }
}

void print_node(node_t node, char *&q)
{
	assert(node > 0); 
#define LEN 100
        static char buf[LEN];
        char *p= buf + (LEN - 1); 
	while (node) {
		*p-- = '0' + node % 10;
		node /= 10;
	}
	size_t len= buf - p + (LEN - 1);
	memcpy(q, p + 1, len);
	q += len; 
}
       
/*
 * INVOCATION 
 *	$0 INPUT-FILE OUTPUT-FILE
 */
int main(const int argc, const char *const *const argv)
{
	if (argc != 3) {
		fprintf(stderr, "*** Arguments\n");
		exit(1); 
	}

	const char *const filename_in= argv[1];
	const char *const filename_out= argv[2]; 

	const int fd_in= open(filename_in, O_RDONLY);
	if (fd_in < 0) {
		perror(filename_in);
		exit(1); 
	}

	const int fd_out= open(filename_out, O_RDWR | O_CREAT, 0666);
	if (fd_out < 0) {
		perror(filename_out);
		exit(1); 
	}

	if (0 != posix_fadvise(fd_in, 0, 0, POSIX_FADV_SEQUENTIAL)) {
		perror(filename_in);
		exit(1); 
	}

	if (0 != posix_fadvise(fd_out, 0, 0, POSIX_FADV_SEQUENTIAL)) {
		perror(filename_out);
		exit(1); 
	}

	struct stat buf_in;
	
	if (0 != fstat(fd_in, &buf_in)) {
		perror(filename_in);
		exit(1); 
	}
	const size_t size_in= buf_in.st_size; 

	const char *const begin_in= (const char *)
		mmap(nullptr, size_in, PROT_READ, MAP_SHARED, fd_in, 0);
	if (begin_in == MAP_FAILED) {
		perror(filename_in);
		exit(1); 
	}

	const char *const end_in= begin_in + size_in; 

	/* We assume the filesize will never double */ 
	const size_t size_out_initial= 2 * size_in;

	if (0 != ftruncate(fd_out, size_out_initial)) {
		perror(filename_out);
		exit(1); 
	}

	char *const begin_out= (char *)
		mmap(nullptr, size_out_initial, PROT_WRITE, MAP_SHARED, fd_out, 0);
	if (begin_out == MAP_FAILED) {
		perror(filename_out);
		exit(1); 
	}
	char *const end_out= begin_out + size_out_initial; 

	/* 'map' is a tree.  Should take less memory than
	 * 'unordered_map', which is a hashtable */ 
	map <refstring, node_t> map_u, map_v;

	node_t next_u= 1, next_v= 1; 

	const char *p= begin_in;
        char *q= begin_out; 

	/* Header */
	const char *const p_header= p;
	while (*p == '%') {
		while (*p != '\n')  ++p;
		++p;
	}
	if (p > p_header) {
		memcpy(q, p_header, p - p_header);
		q += p - p_header;
	}

	/* Content */ 
	while (p < end_in) {
		
		/* Skip spaces */
		while (*p == ' ' || *p == '\t')  ++p;

		refstring u= p;
		
		/* Skip U */ 
		while (! isspace(*p))  ++p;

		/* Skip spaces */
		while (*p == ' ' || *p == '\t')  ++p;

		refstring v= p;
		
		/* Skip U */ 
		while (! isspace(*p))  ++p;

		const char *p_rest= p;

		/* Skip rest */
		while (*p != '\n')  ++p;
		++p; /* Skip over \n */ 

		const node_t uid= get(map_u, u, next_u);
		const node_t vid= get(map_v, v, next_v); 

		print_node(uid, q);
		*q++= '\t';
		print_node(vid, q);
		memcpy(q, p_rest, p - p_rest);
		q += p - p_rest;

		assert(p <= end_in); 
		assert(q <= end_out); 
	}

	if (0 != munmap(begin_out, size_out_initial)) {
		perror(filename_out);
		exit(1); 
	}

	const size_t size_out_final= q - begin_out;

	if (0 != ftruncate(fd_out, size_out_final)) {
		perror(filename_out);
		exit(1); 
	}
	
	if (0 != close(fd_out)) {
		perror(filename_out);
		exit(1); 
	}

	/* Don't bother closing the input */ 

	exit(0);
}
