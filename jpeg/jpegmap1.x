#ifndef __std_x__
#include "std.x"
#endif

#include "jpegalgo1.x"

//#include "ipc.x"

#if (FPGA == 1)
#ifndef __exegy_x__
#include "exegy.x"
#endif
#endif

//uncomment for apps that include hardware
//resource fpga is HDL_Brutus(file="fpga_x.vhd",
                            //wrapfile="fpga_wrap.vhd",
                            //topfile="brutus_top0.v");

//uncomment for apps that include hardware
//resource inter is ExegyDMA ({ proc, fpga },
                            //buffer="yes",
                            //hugeSize=4,
                            //bufferSize=768000,
                            //bufferTimeout=1000000,
                            //debugWrites="no",
                            //dumpToCard="");
resource proc[1] is C {(file = "proc_1_.cpp", cpunum=0, xsim="false")};

/*resource shared_mem[8] is SHM {
                                 ({proc_1_,proc_2_},queuelength=16384),
                                 ({proc_1_,proc_2_},queuelength=16384),
                                 ({proc_1_,proc_2_},queuelength=16384),
                                 ({proc_1_,proc_2_},queuelength=16384),
                                 ({proc_2_,proc_3_},queuelength=16384),
                                 ({proc_2_,proc_3_},queuelength=16384),
                                 ({proc_2_,proc_3_},queuelength=16384),
                                 ({proc_2_,proc_3_},queuelength=16384)
                              };
*/
//fpga processes go here.
//map fpga = {};

//cpu prcesses go here, see wiki on how to add more processes.
//uncomment for apps that include hardware
map proc[1] = { app };
//map proc[2] = { app.ycbcr };
//map proc[3] = { app.vis };
/*
map shared_mem[1] = {app.e0};
map shared_mem[2] = {app.e1};
map shared_mem[3] = {app.e2};
map shared_mem[4] = {app.e3};
map shared_mem[5] = {app.e4};
map shared_mem[6] = {app.e5};
map shared_mem[7] = {app.e6};
map shared_mem[8] = {app.e7};
*/
//uncomment for apps that include hardware to software links
//edges between resources cpu/fpga/gpu go here, i.e. hardware-software edges app.e0 = cpu -> fpga.
//map inter = {};
