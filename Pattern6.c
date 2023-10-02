 #include <stdio.h>

void main(){
    for(int i=5;i>=1;i--){
        for(int j=1;j<=i;j++){
            if(j%2==0){printf("0",j);}
            else{printf("1",j);}
        }
        printf("\n");
    }
}
