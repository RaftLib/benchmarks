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

struct RebuildGridMTAccumulator_Input
{
    int ck;
    int cj;
    int ci;
    int tid;

    RebuildGridMTAccumulator_Input() : ck(0), cj(0), ci(0), tid(0) {}
    RebuildGridMTAccumulator_Input(int ck, int cj, int ci, int tid) : ck(ck), cj(cj), ci(ci), tid(tid) {}
};

class RebuildGridMTAccumulator : public raft::kernel
{
private:
    Grid* g_Grids;
    Cell* g_Cells;
    Cell** g_last_cells;
    cellpool* g_Pools;
    int* g_cnumPars;
    int g_ny;
    int g_nx;
public:
    RebuildGridMTAccumulator(Grid* grids, Cell* cells, Cell** last_cells, int* cnumPars, int ny, int nx, cellpool* pools)
        : g_Grids(grids), g_Cells(cells), g_last_cells(last_cells), g_cnumPars(cnumPars), g_ny(ny), g_nx(nx), g_Pools(pools)
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

class InitDensitiesAndForcesMTKernel : public raft::kernel
{
private:
    Grid* g_Grids;
    Cell* g_Cells;
    int* g_cnumPars;
    int g_ny;
    int g_nx;
public:
    InitDensitiesAndForcesMTKernel(Grid* grids, Cell* cells, int* cnumPars, int ny, int nx)
        : g_Grids(grids), g_Cells(cells), g_cnumPars(cnumPars), g_ny(ny), g_nx(nx)
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
                Cell *cell = &g_Cells[index];
                int np = g_cnumPars[index];
                for(int j = 0; j < np; ++j)
                {
                    cell->density[j % PARTICLES_PER_CELL] = 0.0;
                    cell->a[j % PARTICLES_PER_CELL] = externalAcceleration;
                    //move pointer to next cell in list if end of array is reached
                    if(j % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1) {
                        cell = cell->next;
                }
                }
            }

        output["out"].push<int>(tid);
        input["in"].recycle();

        return raft::proceed;
    }
};

class ProcessCollisionsMTKernel : public raft::kernel
{
private:
    Grid* g_Grids;
    Cell* g_Cells;
    int* g_cnumPars;
    int g_ny;
    int g_nx;
public:
    ProcessCollisionsMTKernel(Grid* grids, Cell* cells, int* cnumPars, int ny, int nx)
        : g_Grids(grids), g_Cells(cells), g_cnumPars(cnumPars), g_ny(ny), g_nx(nx)
    {
        input.addPort<int>("in");
        output.addPort<int>("out");
    }

    virtual raft::kstatus run()
    {
        int tid = input["in"].peek<int>();
        for(int iz = g_Grids[tid].sz; iz < g_Grids[tid].ez; ++iz)
        {
            for(int iy = g_Grids[tid].sy; iy < g_Grids[tid].ey; ++iy)
            {
                for(int ix = g_Grids[tid].sx; ix < g_Grids[tid].ex; ++ix)
                {
                    if(!((ix==0)||(iy==0)||(iz==0)||(ix==(nx-1))||(iy==(ny-1))==(iz==(nz-1))))
                        continue;	// not on domain wall
                    int index = (iz*g_ny + iy)*g_nx + ix;
                    Cell *cell = &g_Cells[index];
                    int np = g_cnumPars[index];
                    for(int j = 0; j < np; ++j)
                    {
                        int ji = j % PARTICLES_PER_CELL;
                        Vec3 pos = cell->p[ji] + cell->hv[ji] * timeStep;

                        if(ix==0)
                        {
                            fptype diff = parSize - (pos.x - domainMin.x);
                            if(diff > epsilon)
                            cell->a[ji].x += stiffnessCollisions*diff - damping*cell->v[ji].x;
                        }
                        if(ix==(nx-1))
                        {
                            fptype diff = parSize - (domainMax.x - pos.x);
                            if(diff > epsilon)
                            cell->a[ji].x -= stiffnessCollisions*diff + damping*cell->v[ji].x;
                        }
                        if(iy==0)
                        {
                            fptype diff = parSize - (pos.y - domainMin.y);
                            if(diff > epsilon)
                            cell->a[ji].y += stiffnessCollisions*diff - damping*cell->v[ji].y;
                        }
                        if(iy==(ny-1))
                        {
                            fptype diff = parSize - (domainMax.y - pos.y);
                            if(diff > epsilon)
                            cell->a[ji].y -= stiffnessCollisions*diff + damping*cell->v[ji].y;
                        }
                        if(iz==0)
                        {
                            fptype diff = parSize - (pos.z - domainMin.z);
                            if(diff > epsilon)
                            cell->a[ji].z += stiffnessCollisions*diff - damping*cell->v[ji].z;
                        }
                        if(iz==(nz-1))
                        {
                            fptype diff = parSize - (domainMax.z - pos.z);
                            if(diff > epsilon)
                            cell->a[ji].z -= stiffnessCollisions*diff + damping*cell->v[ji].z;
                        }
                        //move pointer to next cell in list if end of array is reached
                        if(ji == PARTICLES_PER_CELL-1) 
                            cell = cell->next;
                    }
                }
            }
        }
        output["out"].push<int>(tid);
        input["in"].recycle();

        return raft::proceed;
    }
};

class ProcessCollisions2MTKernel : public raft::kernel
{
private:
    Grid* g_Grids;
    Cell* g_Cells;
    int* g_cnumPars;
    int g_ny;
    int g_nx;
public:
    ProcessCollisions2MTKernel(Grid* grids, Cell* cells, int* cnumPars, int ny, int nx)
        : g_Grids(grids), g_Cells(cells), g_cnumPars(cnumPars), g_ny(ny), g_nx(nx)
    {
        input.addPort<int>("in");
        output.addPort<int>("out");
    }

    virtual raft::kstatus run()
    {
        int tid = input["in"].peek<int>();
        for(int iz = g_Grids[tid].sz; iz < g_Grids[tid].ez; ++iz)
        {
            for(int iy = g_Grids[tid].sy; iy < g_Grids[tid].ey; ++iy)
            {
                for(int ix = g_Grids[tid].sx; ix < g_Grids[tid].ex; ++ix)
                {
                    int index = (iz*g_ny + iy)*g_nx + ix;
                    Cell *cell = &g_Cells[index];
                    int np = g_cnumPars[index];
                    for(int j = 0; j < np; ++j)
                    {
                        int ji = j % PARTICLES_PER_CELL;
                        Vec3 pos = cell->p[ji];

                        if(ix==0)
                        {
                            fptype diff = pos.x - domainMin.x;
                            if(diff < Zero)
                            {
                                cell->p[ji].x = domainMin.x - diff;
                                cell->v[ji].x = -cell->v[ji].x;
                                cell->hv[ji].x = -cell->hv[ji].x;
                            }
                        }
                        if(ix==(nx-1))
                        {
                            fptype diff = domainMax.x - pos.x;
                            if(diff < Zero)
                            {
                                cell->p[ji].x = domainMax.x + diff;
                                cell->v[ji].x = -cell->v[ji].x;
                                cell->hv[ji].x = -cell->hv[ji].x;
                            }
                        }
                        if(iy==0)
                        {
                            fptype diff = pos.y - domainMin.y;
                            if(diff < Zero)
                            {
                                cell->p[ji].y = domainMin.y - diff;
                                cell->v[ji].y = -cell->v[ji].y;
                                cell->hv[ji].y = -cell->hv[ji].y;
                            }
                        }
                        if(iy==(ny-1))
                        {
                            fptype diff = domainMax.y - pos.y;
                            if(diff < Zero)
                            {
                                cell->p[ji].y = domainMax.y + diff;
                                cell->v[ji].y = -cell->v[ji].y;
                                cell->hv[ji].y = -cell->hv[ji].y;
                            }
                        }
                        if(iz==0)
                        {
                            fptype diff = pos.z - domainMin.z;
                            if(diff < Zero)
                            {
                                cell->p[ji].z = domainMin.z - diff;
                                cell->v[ji].z = -cell->v[ji].z;
                                cell->hv[ji].z = -cell->hv[ji].z;
                            }
                        }
                        if(iz==(nz-1))
                        {
                            fptype diff = domainMax.z - pos.z;
                            if(diff < Zero)
                            {
                                cell->p[ji].z = domainMax.z + diff;
                                cell->v[ji].z = -cell->v[ji].z;
                                cell->hv[ji].z = -cell->hv[ji].z;
                            }
                        }
                        //move pointer to next cell in list if end of array is reached
                        if(ji == PARTICLES_PER_CELL-1)
                        cell = cell->next;
                    }
                }
            }
        }
        output["out"].push<int>(tid);
        input["in"].recycle();

        return raft::proceed;
    }
};

class AdvanceParticlesMTKernel : public raft::kernel
{
private:
    Grid* g_Grids;
    Cell* g_Cells;
    int* g_cnumPars;
    int g_ny;
    int g_nx;
public:
    AdvanceParticlesMTKernel(Grid* grids, Cell* cells, int* cnumPars, int ny, int nx)
        : g_Grids(grids), g_Cells(cells), g_cnumPars(cnumPars), g_ny(ny), g_nx(nx)
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
                    int index = (iz*ny + iy)*nx + ix;
                    Cell *cell = &g_Cells[index];
                    int np = g_cnumPars[index];
                    for(int j = 0; j < np; ++j)
                    {
                        Vec3 v_half = cell->hv[j % PARTICLES_PER_CELL] + cell->a[j % PARTICLES_PER_CELL]*timeStep;
                        cell->p[j % PARTICLES_PER_CELL] += v_half * timeStep;
                        cell->v[j % PARTICLES_PER_CELL] = cell->hv[j % PARTICLES_PER_CELL] + v_half;
                        cell->v[j % PARTICLES_PER_CELL] *= 0.5;
                        cell->hv[j % PARTICLES_PER_CELL] = v_half;

                        //move pointer to next cell in list if end of array is reached
                        if(j % PARTICLES_PER_CELL == PARTICLES_PER_CELL-1)
                            cell = cell->next;
                    }
                }

        output["out"].push<int>(tid);
        input["in"].recycle();

        return raft::proceed;
    }
};




#endif