#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <string>
#include <cassert>
#include <iostream>
#include <raft>
#include <raftio>
#include <cmd>
#include <type_traits>

#include "util.h"
#include "debug.h"
#include "dedupdef.h"
#include "encoder.h"
#include "decoder.h"
#include "config.h"
#include "queue.h"


extern config_t * conf;

/**
 * used interface found here:
 * http://www.bzip.org/1.0.3/html/hl-interface.html
 */



int
main( int argc, char **argv )
{


    int32 compress = TRUE;

    //We force the sha1 sum to be integer-aligned, check that the length of a sha1 sum is a multiple of unsigned int
    assert(SHA1_LEN % sizeof(unsigned int) == 0);

    conf = (config_t *) malloc(sizeof(config_t));
    if (conf == NULL) {
        EXIT_TRACE("Memory allocation failed\n");
    }

    strcpy(conf->outfile, "");
    conf->compress_type = COMPRESS_GZIP;
    conf->preloading = 0;
    conf->nthreads = 1;
    conf->verbose = 0;

    //parse the args
    int ch;
    
    //opterr = 0;
    //optind = 1;
  
    /*while (-1 != (ch = getopt(argc, argv, "cupvo:i:w:t:h"))) {
        switch (ch) {
        case 'c':
          compress = TRUE;
          strcpy(conf->infile, "test.txt");
          strcpy(conf->outfile, "out.ddp");
          break;
        case 'u':
          compress = FALSE;
          strcpy(conf->infile, "out.ddp");
          strcpy(conf->outfile, "new.txt");
          break;
        case 'w':
          if (strcmp(optarg, "gzip") == 0)
            conf->compress_type = COMPRESS_GZIP;
          else if (strcmp(optarg, "bzip2") == 0) 
            conf->compress_type = COMPRESS_BZIP2;
          else if (strcmp(optarg, "none") == 0)
            conf->compress_type = COMPRESS_NONE;
          else {
            fprintf(stdout, "Unknown compression type `%s'.\n", optarg);
            usage(argv[0]);
            return -1;
          }
          break;
        case 'o':
          strcpy(conf->outfile, optarg);
          break;
        case 'i':
          strcpy(conf->infile, optarg);
          break;
        case 'h':
          usage(argv[0]);
          return -1;
        case 'p':
          conf->preloading = TRUE;
          break;
        case 't':
          conf->nthreads = atoi(optarg);
          break;
        case 'v':
          conf->verbose = TRUE;
          break;
        case '?':
          fprintf(stdout, "Unknown option `-%c'.\n", optopt);
          usage(argv[0]);
          return -1;
        }
  }*/

#ifndef ENABLE_GZIP_COMPRESSION
 if (conf->compress_type == COMPRESS_GZIP){
    printf("Gzip compression not supported\n");
    exit(1);
  }
#endif

#ifndef ENABLE_STATISTICS
 if (conf->verbose){
    printf("Statistics collection not supported\n");
    exit(1);
  }
#endif

#ifndef ENABLE_PTHREADS
 if (conf->nthreads != 1){
    printf("Number of threads must be 1 (serial version)\n");
    exit(1);
  }
#endif

    /*if (compress) {
        Encode(conf);
    } 
    else {
        Decode(conf);
    }*/

    free(conf);


    Prod producer;
    Kernel kernel;

    raft::map m;
    m += producer >> kernel;
    m.exe();

    return (EXIT_SUCCESS);

}
