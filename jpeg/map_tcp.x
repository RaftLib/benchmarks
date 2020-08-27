#define ARRAYSIZE 64
#define ARRAYLENGTH 64
#define RUNLENGTH 1
#define NUMFRAME 256

#include "std.x"
#include "ipc.x"
#include "algo1.x"
#include "tcp.x"
#include "fileio.x"


resource net is TCP ({proc[1] (addr="cinnaprob.int.seas.wustl.edu"), proc[2] (addr="cinnaproa.int.seas.wustl.edu")});

resource proc[2] is C_x86{
	(file="proc_1_.cpp", cxx="true", xsim="false", cpunum=1),
	(file="proc_2_.cpp", cxx="true", xsim="false", cpunum=2)
};

map proc[1] = {app.gen, app.color, app.luminance, app.chrominanceB, app.chrominanceR};
map proc[2] = {app.fw};

map net = {app.e5, app.e6, app.e7};

/*
resource net1 is TCP ({proc[1] (addr="127.0.0.1"), proc[2] (addr="cinnaproa.int.seas.wustl.edu")});
resource net1 is TCP ({proc[1] (addr="127.0.0.1"), proc[2] (addr="cinnaproa.int.seas.wustl.edu")});
resource net1 is TCP ({proc[1] (addr="127.0.0.1"), proc[2] (addr="cinnaproa.int.seas.wustl.edu")});
resource net1 is TCP ({proc[1] (addr="127.0.0.1"), proc[2] (addr="cinnaproa.int.seas.wustl.edu")});

resource proc[4] is C_x86{
	(file="proc_1_.cpp", cxx="true", xsim="false", cpunum=1),
	(file="proc_1_.cpp", cxx="true", xsim="false", cpunum=2)
};

map proc[1] = {app};

*/
