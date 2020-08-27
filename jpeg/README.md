# Notes
* This is an old "auto-pipe" application, 
that to get working for RL should be relatively
straightforward. 
* Auto-pipe encoded the topolgoy in one file, the
shared memory mappings in another. The C-code files
themselves are in separate "block" directories. 


# Steps to bring up for RL
* Convert to CMake build system
* keep the individual folders for the blocks, maybe rename, 
but include each as a subdirectory, each "block" should have
its own include/src/etc. directories internally. 
* Make main.cpp file in the source somewhere so we 
can take the X-language topolgoy and convert for RL. 
* Once we have that done, we can merge. 
