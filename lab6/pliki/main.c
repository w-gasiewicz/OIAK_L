#include <stdio.h>
extern int readFile(char* filename, char* read_buffer, int buffer_size);
extern int writeToFile(char* filename, char* read_buffer, int text_size);
extern void cpu_check(char name [33]);

void fillArr(char bytes[33]){
	for(int i = 0; i < 33; ++i)
		bytes[i] = '\0';
}

int main()
{ 
    char input_filename[20], output_filename[20];

    printf("Podaj nazwę pliku z danymi >> ");
    scanf("%19s", input_filename);
    printf("Podaj nazwę pliku wyjściowego >> ");
    scanf("%19s", output_filename);

    int buff_size = 250;
    char buffer[buff_size];
    int bytes_read = readFile(input_filename, buffer, buff_size);
    int text_len = bytes_read - 1;
    printf("Wczytano %dB z pliku \"%s\".\n", bytes_read, input_filename);
    
    writeToFile(output_filename, buffer, bytes_read);
    
    return 0;
}
