# include "intlen.hpp"
//# include <iostream>
std::uint64_t mdl::intlen(std::uint64_t __int)
{
    std::uint64_t len_of_int = 0;
    std::uint64_t base_unit = 10;
    //std::uint64_t start_unit = 10;

    for (std::uint64_t i = base_unit;; i *= base_unit) {
        if (i <= __int) {
                if (i == 10)
                    len_of_int = 2;
                else
                    len_of_int ++;
        } else break;
    }

    if (len_of_int == 0) len_of_int = 1;

    return len_of_int;
}
