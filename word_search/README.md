Run
===

~~~
# run 1 search worker with 2 cpus in the topology file
export HWLOC_XMLFILE=$PWD/topo_xmls/2cpu.xml
./bmh alice.txt 1

# run 2 search workers with 4 cpus in the topology file
export HWLOC_XMLFILE=$PWD/topo_xmls/4cpu.xml
./bmh alice.txt 2

# run 14 search workers with 16 cpus in the topology file
export HWLOC_XMLFILE=$PWD/topo_xmls/16cpu.xml
./bmh alice.txt 14
~~~
