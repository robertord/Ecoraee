#include <stdio.h>
#include <stdlib.h>

int main() {

  long int npts = 10000000000;

  long int i;

  double f,sum;
  double xmin,xmax,x;

  xmin = 0.0;
  xmax = 1.0;

  for (i=0; i<npts; i++) {
    x = (double) rand()/RAND_MAX*(xmax-xmin) + xmin;
    sum += 4.0/(1.0 + x*x);
  }
  f = sum/npts;

  printf("PI calculated with %ld points = %f \n",npts,f);

}
