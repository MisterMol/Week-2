#include <stdio.h>
#include <string.h>

#define MAX_LENGTH 1000 

int main() {
    char input[MAX_LENGTH];

    printf("Voer een zin in: ");
    fgets(input, sizeof(input), stdin);

    input[strcspn(input, "\n")] = '\0';

    int length = strlen(input);

    printf("De ingevoerde zin heeft %d tekens.\n", length);

    return 0;
}
