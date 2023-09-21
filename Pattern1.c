//         1
//       2 1
//     3 2 1
//   4 3 2 1
// 5 4 3 2 1 

#include<stdio.h>

void main()
{
	for(int i=1; i<=5; i++)
	{
		for(int s=5;s>=i;s--){
		    printf(" ");
		}
		for(int j=i; j>=1; j--)
		{
			printf("%d",j);
		}
		printf("\n");
	}
	
}