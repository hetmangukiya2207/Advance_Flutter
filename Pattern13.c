//         5
//       4 5 4
//     3 4 5 4 3
//   3 3 4 5 4 3 2
// 1 2 3 4 5 4 3 2 1

#include<stdio.h>

main()
{
	int i, k, j;
	
	for(i=5; i>=1; i--)
	{
		for(k=1; k<i; k++)
		{
			printf(" ");
		}
		for(j=i; j<=5; j++)
		{
			printf("%d", j);
		}
		for(j=5; j>=i; j--)
		{
			if(j!=5)
			{
				printf("%d", j);
			}
		}
		printf("\n");
	}	
}