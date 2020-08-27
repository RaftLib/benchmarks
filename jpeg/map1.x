
#define ARRAYSIZE 64
#define ARRAYLENGTH 64
#define RUNLENGTH 1
#define NUMFRAME 256

#include "std.x"
#include "ipc.x"
#include "algo1.x"


resource proc[1] is C_x86{
	(file="proc_1_.cpp", cxx="true", xsim="false")
};

map proc[1] = {app};
