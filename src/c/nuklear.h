#ifndef ZIG_NK_NUKLEAR_H_
#define ZIG_NK_NUKLEAR_H_

/* No need to depend on a libc just for these two things, when we can hack them in with the
 * pre processor */
#define size_t nk_size
#define NULL (void *)0

void zigNuklearAssert(int ok);
float zigNuklearSqrt(float x);
float zigNuklearSin(float x);
float zigNuklearCos(float x);
float zigNuklearAcos(float x);
float zigNuklearFmod(float x, float y);
float zigNuklearFabs(float x);
char *zigNuklearDtoa(char *s, double n);

#define STBTT_ifloor(x) nk_ifloorf(x)
#define STBTT_iceil(x) nk_iceilf(x)
#define STBTT_pow(x,y) nk_pow(x,y)
#define STBTT_sqrt(x) zigNuklearSqrt(x)
#define STBTT_fmod(x,y) zigNuklearFmod(x,y)
#define STBTT_cos(x) zigNuklearCos(x)
#define STBTT_acos(x) zigNuklearAcos(x)
#define STBTT_fabs(x) zigNuklearFabs(x)
#define STBTT_assert(x) zigNuklearAssert((x) != 0)

#define STBRP_ASSERT(ok) STBTT_assert(ok)

#define NK_ASSERT(ok) STBTT_assert(ok)
#define NK_SQRT STBTT_sqrt
#define NK_SIN STBTT_sin
#define NK_COS STBTT_cos
#define NK_DTOA zigNuklearDtoa

/* Some of these we cannot define until we have seen the nuklear header. Define dummies so that
 * nuklear does not include its own implementation in the header and redefine these macros
 * later */
#define STBTT_memcpy
#define STBTT_memset
#define STBTT_strlen(x)
#define NK_MEMSET
#define NK_MEMCPY
#define NK_STRTOD

#define NK_INCLUDE_FONT_BAKING
#define NK_INCLUDE_DEFAULT_FONT
#define NK_ZERO_COMMAND_MEMORY
#include "nuklear/nuklear.h"

nk_size zigNuklearStrlen(const char *x);
void *zigNuklearMemcopy(void *dst, const void *src, nk_size n);
void *zigNuklearMemset(void *ptr, int c0, nk_size size);
void zigNuklearSort(void *base, nk_size nmemb, nk_size size,
                     int(*compar)(const void *, const void *));
double zigNuklearStrtod(struct nk_slice str, struct nk_slice *endptr);

#undef NK_MEMSET
#undef NK_MEMCPY
#undef NK_STRTOD
#undef STBTT_memcpy
#undef STBTT_memset
#undef STBTT_strlen
#define STBTT_memcpy zigNuklearMemcopy
#define STBTT_memset zigNuklearMemset
#define STBTT_strlen(x) zigNuklearStrlen(x)

#define STBRP_SORT zigNuklearSort

#define NK_MEMCPY STBTT_memcpy
#define NK_MEMSET STBTT_memset
#define NK_STRTOD zigNuklearStrtod

#endif
