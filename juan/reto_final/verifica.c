#include <stdio.h>
#include <string.h>

int main() {
    // Clave real: MAX1RED33 -- guardada invertida a nivel de bits (NOT)
    unsigned char clave_ofuscada[] = {
        ~'M', ~'A', ~'X', ~'1', ~'R', ~'E', ~'D', ~'3', ~'3', 0
    };

    // Flag tambien ofuscada con NOT, se descifra solo si la clave es correcta
    unsigned char flag_ofuscada[] = {
        ~'F', ~'L', ~'A', ~'G', ~'{', ~'i', ~'n', ~'g', ~'e', ~'n', ~'i',
        ~'e', ~'r', ~'i', ~'a', ~'_', ~'i', ~'n', ~'v', ~'e', ~'r', ~'s',
        ~'a', ~'_', ~'s', ~'u', ~'p', ~'e', ~'r', ~'a', ~'d', ~'a', ~'_',
        ~'r', ~'b', ~'3', ~'3', ~'}', 0
    };

    char input[50];
    printf("=== SISTEMA DE ACCESO - INGENIERIA RED BULL RACING ===\n");
    printf("Ingrese el codigo de acceso al box: ");
    fgets(input, sizeof(input), stdin);
    input[strcspn(input, "\n")] = 0;

    if (strlen(input) != strlen((char*)clave_ofuscada)) {
        printf("ACCESO DENEGADO\n");
        return 1;
    }

    int correcto = 1;
    for (int i = 0; i < strlen(input); i++) {
        unsigned char transformado = ~input[i];
        if (transformado != clave_ofuscada[i]) {
            correcto = 0;
            break;
        }
    }

    if (correcto) {
        char flag_real[50];
        int i;
        for (i = 0; flag_ofuscada[i] != 0; i++) {
            flag_real[i] = ~flag_ofuscada[i];
        }
        flag_real[i] = 0;
        printf("ACCESO CONCEDIDO. %s\n", flag_real);
    } else {
        printf("ACCESO DENEGADO\n");
    }

    return 0;
}
