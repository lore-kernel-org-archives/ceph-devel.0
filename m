From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] AArch64: Detect crc32 extension support from assembler
Date: Mon, 26 Sep 2016 14:40:36 +0200
Message-ID: <CAOi1vP8F26QTRjUe-CUHfMOor61H-wi1KoLmYoeov9shyOUF2A@mail.gmail.com>
References: <1474892258-178638-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33207 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965304AbcIZMkn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Sep 2016 08:40:43 -0400
Received: by mail-vk0-f68.google.com with SMTP id z126so2472851vkd.0
        for <ceph-devel@vger.kernel.org>; Mon, 26 Sep 2016 05:40:42 -0700 (PDT)
In-Reply-To: <1474892258-178638-1-git-send-email-agraf@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.com>, Yazen Ghannam <yazen.ghannam@linaro.org>, Steve Capper <steve.capper@linaro.org>

On Mon, Sep 26, 2016 at 2:17 PM, Alexander Graf <agraf@suse.de> wrote:
> The used compiler may or may not be recent enough to recognize the
> crc32 extended cpu type. However, it does not really have to know about
> them either, since all we do is pass inline assembly instructions to
> the assembler.
>
> This patch moves the crc cpu extension detection from compiler based
> to assembler based, so that we can build optimized code even when the
> compiler does not know about the cpu type yet.
>
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  m4/ax_arm.m4                | 15 +++++++++++----
>  src/common/Makefile.am      |  2 +-
>  src/common/crc32c_aarch64.c |  3 +++
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/m4/ax_arm.m4 b/m4/ax_arm.m4
> index 37ea0aa..26b5258 100644
> --- a/m4/ax_arm.m4
> +++ b/m4/ax_arm.m4
> @@ -26,12 +26,19 @@ AC_DEFUN([AX_ARM_FEATURES],
>          AC_DEFINE(HAVE_NEON,,[Support NEON instructions])
>          AC_SUBST(ARM_NEON_FLAGS)
>        fi
> -      AX_CHECK_COMPILE_FLAG(-march=armv8-a+crc, ax_cv_support_crc_ext=yes, [])
> +
> +      AC_LANG_SAVE
> +      AC_LANG_CPLUSPLUS
> +      AC_CACHE_CHECK(whether the assembler supports crc extensions,
> +                     ax_cv_support_crc_ext, AC_TRY_COMPILE([
> +          #define CRC32CX(crc, value) __asm__("crc32cx %w[c], %w[c], %x[v]":[c]"+r"(crc):[v]"r"(value))
> +          asm(".arch_extension crc");
> +          unsigned int foo(unsigned int ret) {
> +              CRC32CX(ret, 0);
> +              return ret;
> +          }],[ foo(0); ], ax_cv_support_crc_ext=yes, []))
>        if test x"$ax_cv_support_crc_ext" = x"yes"; then
> -        ARM_ARCH_FLAGS="$ARM_ARCH_FLAGS+crc"
> -        ARM_CRC_FLAGS="-march=armv8-a+crc -DARCH_AARCH64"
>          AC_DEFINE(HAVE_ARMV8_CRC,,[Support ARMv8 CRC instructions])
> -        AC_SUBST(ARM_CRC_FLAGS)
>        fi
>          ARM_FLAGS="$ARM_ARCH_FLAGS $ARM_DEFINE_FLAGS"
>      ;;
> diff --git a/src/common/Makefile.am b/src/common/Makefile.am
> index 8b30eea..e92e51c 100644
> --- a/src/common/Makefile.am
> +++ b/src/common/Makefile.am
> @@ -144,7 +144,7 @@ noinst_LTLIBRARIES += libcommon_crc.la
>
>  if HAVE_ARMV8_CRC
>  libcommon_crc_aarch64_la_SOURCES = common/crc32c_aarch64.c
> -libcommon_crc_aarch64_la_CFLAGS = $(AM_CFLAGS) $(ARM_CRC_FLAGS)
> +libcommon_crc_aarch64_la_CFLAGS = $(AM_CFLAGS) $(ARM_ARCH_FLAGS)
>  LIBCOMMON_DEPS += libcommon_crc_aarch64.la
>  noinst_LTLIBRARIES += libcommon_crc_aarch64.la
>  endif
> diff --git a/src/common/crc32c_aarch64.c b/src/common/crc32c_aarch64.c
> index d33827d..d2be6dd 100644
> --- a/src/common/crc32c_aarch64.c
> +++ b/src/common/crc32c_aarch64.c
> @@ -2,6 +2,9 @@
>  #include "include/int_types.h"
>  #include "common/crc32c_aarch64.h"
>
> +/* Request crc extension capabilities from the assembler */
> +asm(".arch_extension crc");
> +
>  #define CRC32CX(crc, value) __asm__("crc32cx %w[c], %w[c], %x[v]":[c]"+r"(crc):[v]"r"(value))
>  #define CRC32CW(crc, value) __asm__("crc32cw %w[c], %w[c], %w[v]":[c]"+r"(crc):[v]"r"(value))
>  #define CRC32CH(crc, value) __asm__("crc32ch %w[c], %w[c], %w[v]":[c]"+r"(crc):[v]"r"(value))

Hi Alexander,

We've been working on switching to cmake and actually ripped autotools
out of master a couple of weeks ago, so this won't apply.  Also, github
pull requests are preferred for everything but the kernel client - less
work for the reviewers.

Thanks,

                Ilya
