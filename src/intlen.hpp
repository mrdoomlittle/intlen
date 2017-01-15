# ifndef __intlen__hpp
# define __intlen__hpp
# include <cstdint>
# include <boost/cstdint.hpp>
namespace mdl
{
    # ifdef ARC64
        typedef boost::uint64_t uint_t;
    # elif ARC32
        typedef boost::uint32_t uint_t;
    # else
        typedef unsigned int uint_t;
    # endif

    std::size_t intlen(uint_t __uint);
}

# endif /*__intlen__hpp*/
