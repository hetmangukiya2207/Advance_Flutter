 #include <stdio.h>

void main(){
    for(char i='A';i<='E';i++){
        for(char j=i;j>='A';j--){
          printf("%c",j);
        }
        printf("\n");
    }
}
