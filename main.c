#include "functions.h"
#include <stdio.h>

int main(){
int a=10;
int b=25;
printf("\nLa différence de %i et %i est %lf \n",b,a,soustraction(b,a));
printf("La somme de %i et %i est %li \n",b,a,addition(a,b));
printf("La multiplication de %i par %i est %lf \n",b,a,multiplication(a,b));
printf("La division de %i par %i est %f \n\n",b,a,division(b,a));
return 0;
}
