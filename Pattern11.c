//  Q
// Z

#include <stdio.h>

int main() {
    int rows = 2;

    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= rows - i; j++) {
            printf(" "); 
        }

        if (i == 1) {
            printf("Q");
        } else {
            printf("Z");
        }

        printf("\n");
    }

    return 0;
}
