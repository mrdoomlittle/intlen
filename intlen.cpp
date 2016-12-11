# include "inc/intlen.hpp"
# include <cstdio>
# include <cstdlib>
//# include <iostream>
int main(int argc, char * argv [])
{
    if (argc < 2) {
        return 1;
        printf("error: needs more then 2 args!\n");
    } 
    
    if (atoi(argv[1]) > 2000000 || atoi(argv[1]) < 0) {
        printf("error: number is to large to pass thru!! or it might be to small\n");
        return 1;
    }
  //  std::cout << atoi(argv[1]) << std::endl;
  
    int output = mdl::intlen(atoi(argv[1]));

    printf("%d\n", output);

    return 0;
}
