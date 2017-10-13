# include "intlen.hpp"
mdl::uint_t mdl::intlen(uint_t __no)
{
	uint_t len_of_int = 0;
	uint_t base_unit = 10;
	for (uint_t i = base_unit;; i *= base_unit) {
		if (i <= __no) {
			if (i == base_unit)
				len_of_int = 2;
			else len_of_int ++;
		} else break;
	}

	if (len_of_int == 0) len_of_int = 1;
	return len_of_int;
}

extern "C" {
    mdl::uint_t mdl_intlen(mdl::uint_t __no) {
        return mdl::intlen(__no);
    }
}

