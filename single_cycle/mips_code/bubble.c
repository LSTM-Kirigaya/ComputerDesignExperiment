#include "stdio.h"

int main()
{
    int a[] = {4,3,1,6,2,5};
    int n = 6, i, j, temp;
    for (i = 0; i < n; ++ i)
    {
        for (j = 0; j < n - i - 1; ++ j)
        {
            if (a[j + 1] < a[j])
            {
                temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
            }
        }
    }
    for (i = 0; i < n; ++ i)
        printf("%d ", a[i]);
    return 0;
}