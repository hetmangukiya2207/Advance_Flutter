// 11
// 1213
// 141516
// 17181920
// 2122232425

#include<stdio.h>

void main()
{
    
    int sum=11;
	for(int i=11; i<=15; i++)
	{
		for(int j=11; j<=i; j++)
		{
			printf("%d",sum);
			sum+=1;
		}
		printf("\n");
	}
	
}