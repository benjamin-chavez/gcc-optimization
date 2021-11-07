/*#define SIZE (5)
long sum(int v[SIZE]) throw()
{
    long s = 0;
    for (unsigned i=0; i<SIZE; i++) s += v[i];
    return s;
}

*/
#define SIZE (100)
 
struct Foo { int v[100]; } __attribute__ ((aligned (__BIGGEST_ALIGNMENT__)));
long sum(Foo * v) throw()
{
    long s = 0;
    for (unsigned i=0; i<SIZE; i++) s += v->v[i];
    return s;
}

// g++ -O2 -ftree-vectorize -fopt-info-vec-missed -S -c foo.cpp -o /dev/stdout | c++filt
// g++-4.9 -O2 -ftree-vectorize -fopt-info-vec-missed elapsedtime.cpp  |& tee -a  vectorize.txt