/* Shortest distance-based statistics.
 * 
 * Input:  adjacency data in out.adj format
 */

/* For efficiency, we don't check the return value of malloc() and
 * related functions.  The program will fail on access. 
 */

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <limits.h>
#include <strings.h>
#include <string.h>

#include "config.hh"

#ifdef NDEBUG
const int USER_COUNT_EVAL = USER_COUNT; 
#else
const int USER_COUNT_EVAL = 100;
#endif

const int LINE_LEN = 20;
const int INT_BIT = sizeof(int) * CHAR_BIT;

const int DIST_MAX = 6;

/* Adjacency data.
 * First index is left user ID, which begins at 1, so adj[0] is unused. 
 * Second index is [0] for the neighbor count (excluding [0]), and [1+i]
 * for neighbor ID. 
 * All IDs are ordered and begin at 1. 
 */
int *adj[1 + USER_COUNT];

/* Distances to the current node.
 * Values are actually 1 << distance. 
 */ 
unsigned dist[1 + USER_COUNT]; 

/* Bitvectors by user ID.  [0] is unused.
 */
unsigned visited[(USER_COUNT + INT_BIT) / INT_BIT]; 
unsigned queued[(USER_COUNT + INT_BIT) / INT_BIT];


/* set user in bitvector */
inline void b_set(int user_id, unsigned bitvector[]) {
	bitvector[user_id / INT_BIT] |= 1 << user_id % INT_BIT;
}

inline void b_clr(int user_id, unsigned bitvector[]) {
	bitvector[user_id / INT_BIT] &= ~ (1 << user_id % INT_BIT);
}

inline bool b_is(int user_id, unsigned bitvector[]) {
	return bitvector[user_id / INT_BIT] & 1 << user_id % INT_BIT;
}

/* Circular buffer of users to visit.
 * The distance for these users is already set. 
 * Users are unique in the queue. 
 * q_* are always valid user IDs. 
 * +1 because we write at [q_end] even without incrementing q_end. 
 */
int queue[USER_COUNT + 1], q_beg, q_end;

/* Compute distances for user ID. 
 * Put output into dist. 
 */
void user(int id) {
	
	bzero(visited, sizeof(visited));

	bzero(queued, sizeof(queued));
	b_set(id, queued);
	
	q_beg= 0, q_end= 1;
	queue[0]= id; 
	
	memset(dist, 0xFF, sizeof(dist));

	dist[id] = 1;

	while (q_beg != q_end) {
		assert (q_beg < q_end); 
		int next = queue[q_beg++];

		assert (b_is(next, queued));
		assert (! b_is(next, visited)); 
		
		int neighbors= adj[next][0]; 

		for (int i= 1;  i < 1 + neighbors;  ++i) {

			int neighbor = adj[next][i];

			assert (neighbor != next);
			
			unsigned newdist = (dist[next] << 1) | 1;

			dist[neighbor] &= newdist;

			assert (dist[neighbor] & 1);

#ifndef NDEBUG
			int o_end= q_end;
			bool cond = ! (b_is(neighbor, queued) || b_is(neighbor, visited));
#endif
			
			unsigned mask = ~(queued[neighbor / INT_BIT] | visited[neighbor / INT_BIT]);
			mask &= 1 << neighbor % INT_BIT;
			queued[neighbor / INT_BIT] |= mask;
			queue[q_end]= neighbor;
			int inc = mask != 0;
			assert ((inc & ~1) == 0);
			q_end += inc;

#ifndef NDEBUG
			if (cond) {
				assert (b_is(neighbor, queued));
				assert (q_end == o_end + 1);
				assert (queue[q_end-1] == neighbor);
			} else {
				assert (q_end == o_end);
			}
#endif
			
			assert (q_end <= USER_COUNT); 
		}

		b_set(next, visited);
		b_clr(next, queued);
	}

#ifndef NDEBUG
	for (int i= 1;  i <= USER_COUNT;  ++i) {
		assert( b_is(i, visited));
		assert( ! b_is(i, queued));
	}
#endif	
}

int main() {
	int verbose= getenv("verbose") != NULL;

	int a= 0, b;
	int na, nb;

	while (2 == scanf("%d %d\n", &na, &nb)) {
		if (! (na == a || na == a+1))
			{
				fprintf(stderr, "*** error:  first column is not continuous\n");
				exit(1); 
			}
		assert (na == a+1 || nb > b);

		if (na == a+1) {
			adj[na]= (int *) calloc(1, sizeof(int)); 
			/* initialize count to 0 */
		}

		a= na;
		b= nb;

		adj[a]= (int *) realloc(adj[a], (2 + adj[a][0]) * sizeof(int));
		adj[a][++adj[a][0]]= b;
	}

	if (! feof(stdin)) {
		if (ferror(stdin)) {
			perror("reading input");
			exit(1); 
		}
		else {
			perror("scanf:  format error");
			exit(1); 
		}
	}

	assert (a == USER_COUNT);
	
	printf("Parsed %d users\n", USER_COUNT);


	int bits[1 + (1 << DIST_MAX)];
	for (int d= 0; d <= DIST_MAX;  ++d)
		bits[(1 << (d+1)) - 1] = d;

	int diameter = 0, radius = INT_MAX;
	double sum= 0.;

	
	const int chunk = USER_COUNT_EVAL/1000 ? USER_COUNT_EVAL/1000 : 1;

	for (int u= 1;  u < USER_COUNT_EVAL;  ++u) {
		if (u % chunk == 0) {
			printf("\033[2K\033[1GComputing...%02.1f%% diameter = %d, radius = %d, avg_dist = %f",
			       100. * u / USER_COUNT_EVAL,
			       diameter, radius,
			       sum / (u-1)
			       );
			fflush(stdout); 
		}
		user(u);
		
		int max_dist= 0;
		int dist_sum= 0;

		for (int v= 1;  v <= USER_COUNT;  ++v) {

			unsigned d = dist[v]; 
			assert (d <= (1 << (DIST_MAX +1)) - 1);
			assert ((d & (d + 1)) == 0);
			assert (d); 
			int di = bits[d];
			assert (di >= 0 && di <= DIST_MAX); 

			dist_sum += di; 

			if (max_dist < di)
				max_dist = di;
		}

		if (max_dist > diameter)  diameter = max_dist;
		if (max_dist < radius)    radius   = max_dist; 
		sum += 1. * dist_sum / USER_COUNT; 
	}
	printf("\n"); 

	double avg_dist = sum / USER_COUNT_EVAL; 

	printf("diameter = %d, radius = %d, avg_dist = %f\n", diameter, radius, avg_dist); 

	FILE *out= fopen("out.net", "w");
	if (!out) {perror("Opening out.net"); exit(1); }
	fprintf(out, "diameter = %d, radius = %d, avg_dist = %f\n", diameter, radius, avg_dist); 
	if (fclose(out)) {perror("Closing out.net"); exit(1); }
}
