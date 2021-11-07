#include <algorithm>
#include <ctime>
#include <iostream>

/* Function to reverse arr[] from start to end*/
void reverseArray(int arr[], int start, int end)
{
    while (start < end)
    {
        int temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
} 

/* Utility function to print an array */
void printArray(int arr[], int size)
{
   for (int i = 0; i < size; i++)
   std::cout << arr[i] << " ";
 
   std::cout << std::endl;
}


int main()
{
    // Generate data
    const unsigned arraySize = 32768;
    int data[arraySize];

    for (unsigned c = 0; c < arraySize; ++c)
        data[c] = std::rand() % 256;


    // !!! With this, the next loop runs faster
    std::sort(data, data + arraySize);

    // Test
    clock_t start = clock();
    long long sum = 0;

    for (unsigned i = 0; i < 100000; ++i)
    {
        // Primary loop
        for (unsigned c = arraySize; c > 0; --c)
        {
            if (data[c] >= 128)
                sum += data[c-1];
        }
    }

    double elapsedTime = static_cast<double>(clock() - start) / CLOCKS_PER_SEC;

    std::cout << "Time: " << elapsedTime << std::endl;
    std::cout << "sum = " << sum << "\n" << std::endl;
    
}