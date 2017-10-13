#[link(name="getdigit", kind="static")]
#[cfg(ARC64)] type uint_t = u64;
#[cfg(ARC32)] type uint_t = u32;
#[cfg(ARC16)] type uint_t = u16;
#[cfg(ARC8)] type uint_t = u8;

#[cfg(not(any(ARC64, ARC32, ARC16, ARC8)))]
type uint_t = u32;

extern "C" {
    pub fn mdl_intlen(__no: uint_t)->uint_t;
}
