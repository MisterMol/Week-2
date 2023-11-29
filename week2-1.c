#include <stdio.h>

void maxArrays(const float *array1, const float *array2, float *array3, int lengte) {
    for (int i = 0; i < lengte; ++i) {
        array3[i] = (array1[i] > array2[i]) ? array1[i] : array2[i];
    }
}

int main() {
    printf("\n");
    float array1[] = {0.7, 3.3, 0.5, 10.3};
    float array2[] = {4.1, 1.5, 0.5, 2.3};

    int array_length = sizeof(array1) / sizeof(array1[0]);

    float array3[array_length];

    printf("De waarden van array 1:\n");
    for (int i = 0; i < array_length; ++i) {
        printf("%.1f ", array1[i]);
    }
    printf("\n");
    printf("\n");

    printf("De waarden van array 2:\n");
    for (int i = 0; i < array_length; ++i) {
        printf("%.1f ", array2[i]);
    }
    printf("\n");
    printf("\n");

    maxArrays(array1, array2, array3, array_length);

    printf("De waarden van array 3:\n");
    for (int i = 0; i < array_length; ++i) {
        printf("%.1f ", array3[i]);
    }
}
