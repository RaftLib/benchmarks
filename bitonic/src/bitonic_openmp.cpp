#include<stdio.h>
#include<stdlib.h>

#define MAX(A, B) (((A) > (B)) ? (A) : (B))
#define MIN(A, B) (((A) > (B)) ? (B) : (A))
#define UP 0
#define DOWN 1

double walltime(double*); /* the clock on the wall */
void bitonic_sort_seq(int start, int length, int *seq, int flag);
void bitonic_sort_par(int start, int length, int *seq, int flag);
void swap(int *a, int *b);

int m;

main()
{
    int i, j;
    int n;
    int flag;
    int *seq;

    double startTime, elapsedTime; /* for checking/testing timing */
    double clockZero = 0.0;

    int numThreads,id;

    printf("Input the length of a sequence(a power of 2): ");
    scanf("%d", &n);

    seq = (int *) malloc (n * sizeof(int));

    printf("Input the sequence: ");
    for (i = 0; i < n; i++)
    {
        scanf("%d", &seq[i]);
    }

    // start
    startTime = walltime( &clockZero );

    numThreads =  omp_get_max_threads();

    // making sure input is okay
    if ( n < numThreads * 2 )
    {
        printf("The size of the sequence is less than 2 * the number of processes.\n");
        exit(0);
    }

    // the size of sub part
    m = n / numThreads;

    // make the sequence bitonic - part 1
    for (i = 2; i <= m; i = 2 * i)
    {
#pragma omp parallel for shared(i, seq) private(j, flag)
        for (j = 0; j < n; j += i)
        {
            if ((j / i) % 2 == 0)
                flag = UP;
            else
                flag = DOWN;
            bitonic_sort_seq(j, i, seq, flag);
        }
    }

    // make the sequence bitonic - part 2
    for (i = 2; i <= numThreads; i = 2 * i)
    {
        for (j = 0; j < numThreads; j += i)
        {
            if ((j / i) % 2 == 0)
                flag = UP;
            else
                flag = DOWN;
            bitonic_sort_par(j*m, i*m, seq, flag);
        }
#pragma omp parallel for shared(j)
        for (j = 0; j < numThreads; j++)
        {
            if (j < i)
                flag = UP;
            else
                flag = DOWN;
            bitonic_sort_seq(j*m, m, seq, flag);
        }
    }

    // bitonic sort
    //bitonic_sort_par(0, n, seq, UP);
    //bitonic_sort_seq(0, n, seq, UP);

    //end
    elapsedTime = walltime( &startTime );

    /*
    // print a sequence
    for (i = 0; i < n; i++){
      printf("%d ", seq[i]);
    }
    printf("\n");
    */

    printf("Elapsed time = %.2f sec.\n", elapsedTime);

    free(seq);
}
