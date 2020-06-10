# Notes
* Most of the benchmarks are derived from other sources,
where this is so we've listed them as such to give credit
to the original source. 

# benchmarks
* parallel-bzip
    * Original open source code is contained within this folder
    along with respective license
    * RaftLib version of bzip compress is also included
    * Datasets: 
        * large - (1<<30)
        * medium - (1 << 20)
        * small  - (1 << 10)

* streamcluster - part of the PARSEC benchmark suite, original
papers and information is available [here](https://parsec.cs.princeton.edu)
    * Still in progress (as in not finished yet for the RL version)
    * TBB and Pthreads versions exist and are included as well. 


* dedup - todo
    * designed to be pipelined so should be easy 

* ferret - todo
    * designed to be pipelined so should be easy 

* x264 - todo 
    * likely pretty easy to parallelize


* fluidanimate

* stringmatch
    * not sure if this is the best benchmark given
    it almost always ends up being RAM speed limited
    in the RL case vs. coompute limited...but, maybe
    not a bad idea to add. 

