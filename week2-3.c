#include <stdio.h>
#include <string.h>

struct opleiding {
    char naamOpleiding[100];
    int instroomJaar;
};

struct student {
    char naam[100];
    int leeftijd;
    struct opleiding studie;
};

int main() {
    struct student studenten[3]; 

    for (int i = 0; i < 3; ++i) {
        printf("Voer de naam van student %d in: ", i + 1);
        scanf("%99s", studenten[i].naam);

        printf("Voer de leeftijd van student %d in: ", i + 1);
        scanf("%d", &studenten[i].leeftijd);

        printf("Voer de opleiding van student %d in: ", i + 1);
        scanf("%99s", studenten[i].studie.naamOpleiding);

        printf("Voer het instroomjaar van student %d in: ", i + 1);
        scanf("%d", &studenten[i].studie.instroomJaar); 
        printf("\n");
    }

    printf("Gegevens van alle studenten:\n");
    for (int i = 0; i < 3; ++i) {
        printf("Student naam: %s\n", studenten[i].naam); 
        printf("Leeftijd: %d\n", studenten[i].leeftijd);
        printf("Opleiding: %s\n", studenten[i].studie.naamOpleiding);
        printf("Instroomjaar: %d\n", studenten[i].studie.instroomJaar); 
        printf("\n");
    }

    return 0;
}
