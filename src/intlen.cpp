# include "intlen.hpp"
//# include <iostream>

mdl::int_t mdl::intlen(int_t __int)
{
    int_t len_of_int = 0;
    int_t base_unit = 10;
    //std::uint64_t start_unit = 10;

    for (int_t i = base_unit;; i *= base_unit) {
        if (i <= __int) {
                if (i == base_unit)
                    len_of_int = 2;
                else len_of_int ++;
        } else break;
    }

    if (len_of_int == 0) len_of_int = 1;

    return len_of_int;
}
