# ifndef __intlen__hpp
# define __intlen__hpp
# include <cstdint>
# include <boost/cstdint.hpp>
namespace mdl
{
    # ifdef ARC64
        typedef boost::uint64_t int_t;
    # elif ARC32
        typedef boost::uint32_t int_t;
    # else
        typedef unsigned int int_t;
    # endif

    int_t intlen(int_t __int);
}

# endif /*__intlen__hpp*/
