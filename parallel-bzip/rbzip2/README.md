# rbzip2 README

```bash
g++ `pkg-config --cflags raftlib` rbzip2.cpp -o rbzip `pkg-config --libs raftlib`
```

```bash
./rbzip2 -i [input] -o [output.bz2] -th [thread count]
```
