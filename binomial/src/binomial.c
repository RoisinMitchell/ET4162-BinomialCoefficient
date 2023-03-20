/*
 ============================================================================
 Name        : binomial.c
 Author      : Ciaran
 Version     :
 Copyright   : Your copyright notice
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include "binomial_asm.h"

long long int binomial_c(long long int n, long long int r);
long long int factorial_c(long long int n);

int main(void) {

	long long int binomial_nCr, n, r;

//	printf("Input a number here (up to 20)"); /* prints Prompt */
	//scanf ("%lld", &n);

	n = 9;

	printf("Binomial Coefficients calculated in a C loop:\n");
	for (r=0; r<=n;r++)
	{
		binomial_nCr = binomial_c(n, r);
		printf("%lld\t", binomial_nCr);
	}

	printf("\n");

	printf("Binomial Coefficients calculated in ASM loop:\n");
	for (r=0; r<=n;r++)
	{
		binomial_nCr = binomial_asm(n, r);
		printf("%lld\t", binomial_nCr);
	}
	printf("\n");

	return EXIT_SUCCESS;;
}


long long int binomial_c(long long int n, long long int r)
{
	long long int coefficient, numerator, denom1, denom2;

	if (n < 0)
		return -1;
	else if (r<0)
		return -1;
	else if (n > 10)
		return -1;
	else if (n < r)
		return -1;
	else if (n==0)
		return 1;
	else if (r==0)
		return 1;
	else {
		numerator = factorial_c (n);
		denom1 = factorial_c (n-r);
		denom2 = factorial_c (r);

		coefficient = numerator / (denom1 * denom2);
	}
	return coefficient;
}


long long factorial_c(long long int n)
{
	long long int fact, i;

	if (n<0)
		return -1;
	else if (n > 10)
		return -1;
	else if (n == 0)
		return 1;
	else
	{
		fact = 1;
		for (i = 1; i <= n; i++)
			fact = fact * i;
	}

	return fact;
}
