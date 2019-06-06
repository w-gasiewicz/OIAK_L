#include <stdio.h>
#include <stdlib.h>

int readFile(const char* filename, char* buffer, size_t buff_size)
{
    FILE* file_ptr = fopen(filename, "r"); // <- r/w/a read/write/append
    if (file_ptr == NULL)
        return -1;

    char ch;
    size_t index = 0;
    while ((ch = fgetc(file_ptr)) != EOF) {
        if (index >= buff_size) {
            fclose(file_ptr);
            return -1;
        }
        buffer[index] = ch;
        ++index;
    }
    
    fclose(file_ptr);
    return index;
}

int writeToFile(const char* filename, char* buffer, size_t text_size)
{
    FILE* file_ptr = fopen(filename, "a");
    if (file_ptr == NULL)
        return -1;
    fprintf(file_ptr, "%.*s", text_size, buffer);
    fclose(file_ptr);
    return 0;
}

int main()
{
    const char* in_file = "./plik_in.txt";
    const char* out_file = "./plik_out.txt";

    char buffer[500];
    int bytesRead = readFile(in_file, buffer, 500);
    return bytesRead <= 0 ? -1 : writeToFile(out_file, buffer, bytesRead);
}