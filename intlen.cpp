# include "inc/intlen.hpp"
# include <cstdio>
# include <cstdlib>
//# include <iostream>
int main(int argc, char * argv [])
{
    if (argc < 2) {
        printf("ERROR: please provide 1 more extra argument\n");
        printf("Usage: intlen (NUMBER)\n");
        return 1;
    } 
    
    if (atoi(argv[1]) > 2000000000 || atoi(argv[1]) < 0) {
        printf("ERROR: the number can be grater then '2000000000'\n");
        printf("NOTE: your must use the library for large numbers!\n");
        return 1;
    }
    //std::cout << atoi(argv[1]) << std::endl;
  
    int output = mdl::intlen(std::atoi(argv[1]));

    printf("%d\n", output);

    return 0;
}
