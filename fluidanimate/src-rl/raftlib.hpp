#ifndef RAFTLIB_H
#define RAFTLIB_H

#include "fluid.hpp"
#include <raft>

// Info
// Main function is AdvanceFrameMT, which calls all of the other functions
// Goal is to make a kernel out of all of these functions
/**
 * Kernels
 * 
 * ClearParticlesMT
 * RebuildGridMT
 * InitDensitiesAndForcesMT
 * ComputeDensitiesMT
 * ComputeForcesMT
 * ProcessCollisionsMT
 * AdvanceParticlesMT
 * 
 */

struct Grid
{
  union {
    struct {
      int sx, sy, sz;
      int ex, ey, ez;
    };
    unsigned char pp[CACHELINE_SIZE];
  };
};

class ClearParticlesMTKernel : public raft::kernel
{
private:
    Grid* g_Grids;
    Cell* g_Cells;
    Cell** g_last_cells;
    int* g_cnumPars;
    int g_ny;
    int g_nx;
public:
    ClearParticlesMTKernel(Grid* grids, Cell* cells, Cell** last_cells, int* cnumPars, int ny, int nx)
        : g_Grids(grids), g_Cells(cells), g_last_cells(last_cells), g_cnumPars(cnumPars), g_ny(ny), g_nx(nx)
    {
        input.addPort<int>("in");
        output.addPort<int>("out");
    }

    virtual raft::kstatus run()
    {
        int tid = input["in"].peek<int>();
        for(int iz = g_Grids[tid].sz; iz < g_Grids[tid].ez; ++iz)
            for(int iy = g_Grids[tid].sy; iy < g_Grids[tid].ey; ++iy)
                for(int ix = g_Grids[tid].sx; ix < g_Grids[tid].ex; ++ix)
                {
                    int index = (iz*g_ny + iy)*g_nx + ix;
                    g_cnumPars[index] = 0;
                    g_Cells[index].next = NULL;
                    g_last_cells[index] = &g_Cells[index];
                }     

        input["in"].recycle();
        output["out"].push<int>(tid);

        return raft::proceed;
    }
};

class RebuildGridMTKernel : public raft::kernel
{
private:
    Grid* g_Grids;
    Cell* g_Cells;
    Cell** g_last_cells;
    int* g_cnumPars;
    int g_ny;
    int g_nx;
public:
    RebuildGridMTKernel(Grid* grids, Cell* cells, Cell** last_cells, int* cnumPars, int ny, int nx)
        : g_Grids(grids), g_Cells(cells), g_last_cells(last_cells), g_cnumPars(cnumPars), g_ny(ny), g_nx(nx)
    {
        input.addPort<int>("in");
        output.addPort<int>("out");
    }

    virtual raft::kstatus run()
    {
        int tid = input["in"].peek<int>();



        return raft::proceed;
    }
};

#endif