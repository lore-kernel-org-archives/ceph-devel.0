From: Yazen Ghannam <yazen.ghannam@linaro.org>
Subject: Re: [PATCH] crc32c: add aarch64 optimized crc32c implementation
Date: Tue, 3 Feb 2015 13:31:44 -0600
Message-ID: <CA+dbMpsSqY2f9GzLz34xOgwaSb7yBuFaO8kg+QHmbRkOMYhZxw@mail.gmail.com>
References: <1422282035-30121-1-git-send-email-yazen.ghannam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:64413 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966273AbbBCTbp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 14:31:45 -0500
Received: by mail-ob0-f179.google.com with SMTP id wp4so10041777obc.10
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 11:31:44 -0800 (PST)
In-Reply-To: <1422282035-30121-1-git-send-email-yazen.ghannam@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@linaro.org>, Sage Weil <sweil@redhat.com>, Loic Dachary <loic@dachary.org>

Hi All,

I just want to check on the status of this submission. Is there
anything I can do to assist in having this patch accepted? I have
access to ARMv8 hardware in the Linaro Austin Colocation Lab and I
have my own personal AMD Seattle development board. I can do further
testing and performance profiling if that is needed.

Thanks,
Yazen

On Mon, Jan 26, 2015 at 8:20 AM, Yazen Ghannam <yazen.ghannam@linaro.org> wrote:
> ARMv8 defines a set of optional CRC32/CRC32C instructions.
> This patch defines an optimized function that uses these
> instructions when available rather than table-based lookup.
> Optimized function based on a Hadoop patch by Ed Nevill.
>
> Autotools updated to check for compiler support.
> Optimized function is selected at runtime based on HWCAP_CRC32.
> Added crc32c "performance" unit test and arch unit test.
>
> Tested on AMD Seattle.
> Passes all crc32c unit tests.
> Unit test shows ~4x performance increase versus sctp.
>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@linaro.org>
> Reviewed-by: Steve Capper <steve.capper@linaro.org>
> ---
>  configure.ac                   |  1 +
>  m4/ax_arm.m4                   | 18 ++++++++++++++--
>  src/arch/arm.c                 |  2 ++
>  src/arch/arm.h                 |  1 +
>  src/common/Makefile.am         | 10 ++++++++-
>  src/common/crc32c.cc           |  6 ++++++
>  src/common/crc32c_aarch64.c    | 47 ++++++++++++++++++++++++++++++++++++++++++
>  src/common/crc32c_aarch64.h    | 27 ++++++++++++++++++++++++
>  src/test/common/test_crc32c.cc | 10 +++++++++
>  src/test/test_arch.cc          | 14 +++++++++++++
>  10 files changed, 133 insertions(+), 3 deletions(-)
>  create mode 100644 src/common/crc32c_aarch64.c
>  create mode 100644 src/common/crc32c_aarch64.h
>
> diff --git a/configure.ac b/configure.ac
> index d836b02..60e4feb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -575,6 +575,7 @@ AC_LANG_POP([C++])
>  # Find supported SIMD / NEON / SSE extensions supported by the compiler
>  AX_ARM_FEATURES()
>  AM_CONDITIONAL(HAVE_NEON, [ test "x$ax_cv_support_neon_ext" = "xyes"])
> +AM_CONDITIONAL(HAVE_ARMV8_CRC, [ test "x$ax_cv_support_crc_ext" = "xyes"])
>  AX_INTEL_FEATURES()
>  AM_CONDITIONAL(HAVE_SSSE3, [ test "x$ax_cv_support_ssse3_ext" = "xyes"])
>  AM_CONDITIONAL(HAVE_SSE4_PCLMUL, [ test "x$ax_cv_support_pclmuldq_ext" = "xyes"])
> diff --git a/m4/ax_arm.m4 b/m4/ax_arm.m4
> index 2ccc9a9..37ea0aa 100644
> --- a/m4/ax_arm.m4
> +++ b/m4/ax_arm.m4
> @@ -13,13 +13,27 @@ AC_DEFUN([AX_ARM_FEATURES],
>        fi
>      ;;
>      aarch64*)
> +      AX_CHECK_COMPILE_FLAG(-march=armv8-a, ax_cv_support_armv8=yes, [])
> +      if test x"$ax_cv_support_armv8" = x"yes"; then
> +        ARM_ARCH_FLAGS="-march=armv8-a"
> +        ARM_DEFINE_FLAGS="-DARCH_AARCH64"
> +      fi
>        AX_CHECK_COMPILE_FLAG(-march=armv8-a+simd, ax_cv_support_neon_ext=yes, [])
>        if test x"$ax_cv_support_neon_ext" = x"yes"; then
> +        ARM_ARCH_FLAGS="$ARM_ARCH_FLAGS+simd"
> +        ARM_DEFINE_FLAGS="$ARM_DEFINE_FLAGS -DARM_NEON"
>          ARM_NEON_FLAGS="-march=armv8-a+simd -DARCH_AARCH64 -DARM_NEON"
> -        AC_SUBST(ARM_NEON_FLAGS)
> -        ARM_FLAGS="$ARM_FLAGS $ARM_NEON_FLAGS"
>          AC_DEFINE(HAVE_NEON,,[Support NEON instructions])
> +        AC_SUBST(ARM_NEON_FLAGS)
> +      fi
> +      AX_CHECK_COMPILE_FLAG(-march=armv8-a+crc, ax_cv_support_crc_ext=yes, [])
> +      if test x"$ax_cv_support_crc_ext" = x"yes"; then
> +        ARM_ARCH_FLAGS="$ARM_ARCH_FLAGS+crc"
> +        ARM_CRC_FLAGS="-march=armv8-a+crc -DARCH_AARCH64"
> +        AC_DEFINE(HAVE_ARMV8_CRC,,[Support ARMv8 CRC instructions])
> +        AC_SUBST(ARM_CRC_FLAGS)
>        fi
> +        ARM_FLAGS="$ARM_ARCH_FLAGS $ARM_DEFINE_FLAGS"
>      ;;
>    esac
>
> diff --git a/src/arch/arm.c b/src/arch/arm.c
> index 93d079a..5a47e33 100644
> --- a/src/arch/arm.c
> +++ b/src/arch/arm.c
> @@ -2,6 +2,7 @@
>
>  /* flags we export */
>  int ceph_arch_neon = 0;
> +int ceph_arch_aarch64_crc32 = 0;
>
>  #include <stdio.h>
>
> @@ -47,6 +48,7 @@ int ceph_arch_arm_probe(void)
>         ceph_arch_neon = (get_hwcap() & HWCAP_NEON) == HWCAP_NEON;
>  #elif __aarch64__ && __linux__
>         ceph_arch_neon = (get_hwcap() & HWCAP_ASIMD) == HWCAP_ASIMD;
> +       ceph_arch_aarch64_crc32 = (get_hwcap() & HWCAP_CRC32) == HWCAP_CRC32;
>  #else
>         if (0)
>                 get_hwcap();  // make compiler shut up
> diff --git a/src/arch/arm.h b/src/arch/arm.h
> index f613438..1659b2e 100644
> --- a/src/arch/arm.h
> +++ b/src/arch/arm.h
> @@ -6,6 +6,7 @@ extern "C" {
>  #endif
>
>  extern int ceph_arch_neon;  /* true if we have ARM NEON or ASIMD abilities */
> +extern int ceph_arch_aarch64_crc32;  /* true if we have AArch64 CRC32/CRC32C abilities */
>
>  extern int ceph_arch_arm_probe(void);
>
> diff --git a/src/common/Makefile.am b/src/common/Makefile.am
> index 2888194..37d1404 100644
> --- a/src/common/Makefile.am
> +++ b/src/common/Makefile.am
> @@ -112,11 +112,19 @@ endif
>  LIBCOMMON_DEPS += libcommon_crc.la
>  noinst_LTLIBRARIES += libcommon_crc.la
>
> +if HAVE_ARMV8_CRC
> +libcommon_crc_aarch64_la_SOURCES = common/crc32c_aarch64.c
> +libcommon_crc_aarch64_la_CFLAGS = $(AM_CFLAGS) $(ARM_CRC_FLAGS)
> +LIBCOMMON_DEPS += libcommon_crc_aarch64.la
> +noinst_LTLIBRARIES += libcommon_crc_aarch64.la
> +endif
> +
>  noinst_HEADERS += \
>         common/bloom_filter.hpp \
>         common/sctp_crc32.h \
>         common/crc32c_intel_baseline.h \
> -       common/crc32c_intel_fast.h
> +       common/crc32c_intel_fast.h \
> +       common/crc32c_aarch64.h
>
>
>  # important; libmsg before libauth!
> diff --git a/src/common/crc32c.cc b/src/common/crc32c.cc
> index e2e81a4..45432f5 100644
> --- a/src/common/crc32c.cc
> +++ b/src/common/crc32c.cc
> @@ -5,9 +5,11 @@
>
>  #include "arch/probe.h"
>  #include "arch/intel.h"
> +#include "arch/arm.h"
>  #include "common/sctp_crc32.h"
>  #include "common/crc32c_intel_baseline.h"
>  #include "common/crc32c_intel_fast.h"
> +#include "common/crc32c_aarch64.h"
>
>  /*
>   * choose best implementation based on the CPU architecture.
> @@ -24,6 +26,10 @@ ceph_crc32c_func_t ceph_choose_crc32(void)
>      return ceph_crc32c_intel_fast;
>    }
>
> +  if (ceph_arch_aarch64_crc32){
> +    return ceph_crc32c_aarch64;
> +  }
> +
>    // default
>    return ceph_crc32c_sctp;
>  }
> diff --git a/src/common/crc32c_aarch64.c b/src/common/crc32c_aarch64.c
> new file mode 100644
> index 0000000..d33827d
> --- /dev/null
> +++ b/src/common/crc32c_aarch64.c
> @@ -0,0 +1,47 @@
> +#include "acconfig.h"
> +#include "include/int_types.h"
> +#include "common/crc32c_aarch64.h"
> +
> +#define CRC32CX(crc, value) __asm__("crc32cx %w[c], %w[c], %x[v]":[c]"+r"(crc):[v]"r"(value))
> +#define CRC32CW(crc, value) __asm__("crc32cw %w[c], %w[c], %w[v]":[c]"+r"(crc):[v]"r"(value))
> +#define CRC32CH(crc, value) __asm__("crc32ch %w[c], %w[c], %w[v]":[c]"+r"(crc):[v]"r"(value))
> +#define CRC32CB(crc, value) __asm__("crc32cb %w[c], %w[c], %w[v]":[c]"+r"(crc):[v]"r"(value))
> +
> +uint32_t ceph_crc32c_aarch64(uint32_t crc, unsigned char const *buffer, unsigned len)
> +{
> +       int64_t length = len;
> +
> +       if (!buffer) {
> +
> +               while ((length -= sizeof(uint64_t)) >= 0)
> +                       CRC32CX(crc, 0);
> +
> +               /* The following is more efficient than the straight loop */
> +               if (length & sizeof(uint32_t))
> +                       CRC32CW(crc, 0);
> +
> +               if (length & sizeof(uint16_t))
> +                       CRC32CH(crc, 0);
> +
> +               if (length & sizeof(uint8_t))
> +                       CRC32CB(crc, 0);
> +       } else {
> +               while ((length -= sizeof(uint64_t)) >= 0) {
> +                       CRC32CX(crc, *(uint64_t *)buffer);
> +                       buffer += sizeof(uint64_t);
> +               }
> +
> +               /* The following is more efficient than the straight loop */
> +               if (length & sizeof(uint32_t)) {
> +                       CRC32CW(crc, *(uint32_t *)buffer);
> +                       buffer += sizeof(uint32_t);
> +               }
> +               if (length & sizeof(uint16_t)) {
> +                       CRC32CH(crc, *(uint16_t *)buffer);
> +                       buffer += sizeof(uint16_t);
> +               }
> +               if (length & sizeof(uint8_t))
> +                       CRC32CB(crc, *buffer);
> +       }
> +       return crc;
> +}
> diff --git a/src/common/crc32c_aarch64.h b/src/common/crc32c_aarch64.h
> new file mode 100644
> index 0000000..3727f54
> --- /dev/null
> +++ b/src/common/crc32c_aarch64.h
> @@ -0,0 +1,27 @@
> +#ifndef CEPH_COMMON_CRC32C_AARCH64_H
> +#define CEPH_COMMON_CRC32C_AARCH64_H
> +
> +#include "arch/arm.h"
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#ifdef HAVE_ARMV8_CRC
> +
> +extern uint32_t ceph_crc32c_aarch64(uint32_t crc, unsigned char const *buffer, unsigned len);
> +
> +#else
> +
> +static inline uint32_t ceph_crc32c_aarch64(uint32_t crc, unsigned char const *buffer, unsigned len)
> +{
> +       return 0;
> +}
> +
> +#endif
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> diff --git a/src/test/common/test_crc32c.cc b/src/test/common/test_crc32c.cc
> index b4297c6..527f115 100644
> --- a/src/test/common/test_crc32c.cc
> +++ b/src/test/common/test_crc32c.cc
> @@ -13,6 +13,7 @@
>
>  #include "common/sctp_crc32.h"
>  #include "common/crc32c_intel_baseline.h"
> +#include "common/crc32c_aarch64.h"
>
>  TEST(Crc32c, Small) {
>    const char *a = "foo bar baz";
> @@ -80,6 +81,15 @@ TEST(Crc32c, Performance) {
>      std::cout << "intel baseline = " << rate << " MB/sec" << std::endl;
>      ASSERT_EQ(261108528u, val);
>    }
> +  if (ceph_arch_aarch64_crc32) // Skip if CRC32C instructions are not defined.
> +  {
> +    utime_t start = ceph_clock_now(NULL);
> +    unsigned val = ceph_crc32c_aarch64(0, (unsigned char *)a, len);
> +    utime_t end = ceph_clock_now(NULL);
> +    float rate = (float)len / (float)(1024*1024) / (float)(end - start);
> +    std::cout << "aarch64 baseline = " << rate << " MB/sec" << std::endl;
> +    ASSERT_EQ(261108528u, val);
> +  }
>
>  }
>
> diff --git a/src/test/test_arch.cc b/src/test/test_arch.cc
> index b129262..e2c225b 100644
> --- a/src/test/test_arch.cc
> +++ b/src/test/test_arch.cc
> @@ -47,9 +47,20 @@ TEST(Arch, all)
>
>    int expected;
>
> +#if (__arm__ || __aarch64__)
> +
>    expected = (strstr(flags, " neon ") || strstr(flags, " asimd ")) ? 1 : 0;
>    EXPECT_EQ(expected, ceph_arch_neon);
>
> +#endif
> +#if (__aarch64__)
> +
> +  expected = strstr(flags, " crc32 ") ? 1 : 0;
> +  EXPECT_EQ(expected, ceph_arch_aarch64_crc32);
> +
> +#endif
> +#if (__x86_64__)
> +
>    expected = strstr(flags, " pclmulqdq ") ? 1 : 0;
>    EXPECT_EQ(expected, ceph_arch_intel_pclmul);
>
> @@ -67,6 +78,9 @@ TEST(Arch, all)
>
>    expected = strstr(flags, " sse2 ") ? 1 : 0;
>    EXPECT_EQ(expected, ceph_arch_intel_sse2);
> +
> +#endif
> +
>  #endif
>  }
>
> --
> 2.1.0
>
