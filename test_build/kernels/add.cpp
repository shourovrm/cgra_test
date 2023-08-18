#include <stdio.h>

// Define the size of the arrays
#define SIZE 32

// Input and output arrays
int input1[SIZE];
int input2[SIZE];
int output[SIZE];

// Kernel function for addition
void kernel(int input1[], int input2[], int output[], int size) {
    for (int i = 0; i < size; i++) {
        output[i] = input1[i] + input2[i];
    }
}

int main() {
    // Initialize input arrays for demonstration purposes
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++)
        {
            input1[i] = i;
            input2[j] = SIZE - i;
        }
        
        
    }

    // Call the kernel function to add the arrays
    kernel(input1, input2, output, SIZE);

    // Print the results (optional, for verification)
    for (int i = 0; i < SIZE; i++) {
        // printf("%d \t", input2[i]);
        printf("input1[%d] + input2[%d] = %d\n", i, i, output[i]);
    }

    return 0;
}
