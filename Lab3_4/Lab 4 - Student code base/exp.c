#include <stdio.h>

int main() {
    float num = 123456789.123456789f;

    int maxLen = snprintf(NULL, 0, "%e", num);

    printf("%d", maxLen);

    return 0;
    
}