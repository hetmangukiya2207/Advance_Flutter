//          *
//        *  *
//      *     *
//    *  *  * *
//  *            *
// *              *
//
//
//
//
// * * * * * 
// *            *
// *            *
// * * * * * *
// *            *
// *            *
// * * * * *

#include <stdio.h>

int main() {
    int n = 6; // Number of rows for the pattern

    for (int i = 1; i <= n; i++) {
        // Print leading spaces
        for (int j = 1; j <= n - i; j++) {
            printf("  "); // Two spaces for each leading space
        }

        // Print asterisks
        for (int k = 1; k <= 2 * i - 1; k++) {
            if (k == 1 || k == 2 * i - 1 || i == n) {
                printf("* ");
            } else {
                printf("  "); // Two spaces for each internal space
            }
        }

        // Move to the next line
        printf("\n");
    }

    printf("\n");
    printf("\n");
    printf("\n");
    printf("\n");

    int rows = 7;
    int cols = 5; 

    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= cols; j++) {
            if (i == 1 || i == rows || i == rows / 2 + 1) {
                printf("* ");
            } else {
                if (j == 1 || j == cols) {
                    printf("* ");
                } else {
                    printf("  ");
                }
            }
        }
        printf("\n");
    }
    
    return 0;
}
