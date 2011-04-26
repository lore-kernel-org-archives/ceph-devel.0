From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH] configure.ac: Add a macro to check for supported compiler flags.
Date: Tue, 26 Apr 2011 15:39:15 -0700
Message-ID: <BANLkTininugbUkCwa50g73dts+nuKffexQ@mail.gmail.com>
References: <1303851974-29838-1-git-send-email-jaschut@sandia.gov>
	<1303851974-29838-2-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58090 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab1DZWjR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Apr 2011 18:39:17 -0400
Received: by fxm17 with SMTP id 17so766972fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2011 15:39:16 -0700 (PDT)
In-Reply-To: <1303851974-29838-2-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

applied, thanks
C.

On Tue, Apr 26, 2011 at 2:06 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> Ancient versions of gcc, such as the gcc 4.1.2 in RHEL 5.5, don't
> support some -W flags that newer versions do. =A0Fix up configure.ac
> and Makefile.am to use them if you have them.
>
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
> =A0configure.ac =A0 =A0| =A0 21 +++++++++++++++++++++
> =A0src/Makefile.am | =A0 =A02 +-
> =A02 files changed, 22 insertions(+), 1 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 5642717..dc4d710 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -33,6 +33,27 @@ AC_PROG_CXX
> =A0AC_PROG_MAKE_SET
> =A0AC_PROG_LIBTOOL
>
> +# Checks for compiler warning types
> +
> +# AC_CHECK_CC_FLAG(FLAG_TO_TEST, VARIABLE_TO_SET_IF_SUPPORTED)
> +# ---------
> +AC_DEFUN([AC_CHECK_CC_FLAG],
> +[{
> + =A0 =A0 =A0 AC_LANG_PUSH([C])
> + =A0 =A0 =A0 my_cflags_save=3D"$CFLAGS"
> + =A0 =A0 =A0 CFLAGS=3D"$my_cflags_save $1"
> + =A0 =A0 =A0 AC_MSG_CHECKING([whether $CC accepts $1])
> + =A0 =A0 =A0 AC_COMPILE_IFELSE(AC_LANG_PROGRAM(),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [AC_MSG_RESULT([yes=
]); AC_SUBST([$2], ["$1"])],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [AC_MSG_RESULT([no]=
)]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0)
> + =A0 =A0 =A0 CFLAGS=3D"$my_cflags_save"
> + =A0 =A0 =A0 AC_LANG_POP([C])
> +}])
> +
> +AC_CHECK_CC_FLAG([-Wtype-limits], [WARN_TYPE_LIMITS])
> +AC_CHECK_CC_FLAG([-Wignored-qualifiers], [WARN_IGNORED_QUALIFIERS])
> +
> =A0# Checks for libraries.
> =A0AC_CHECK_LIB([m], [pow], [true], AC_MSG_FAILURE([libm not found]))
> =A0AC_CHECK_LIB([pthread], [pthread_create], [true], AC_MSG_FAILURE([=
libpthread not found]))
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 3113111..071360e 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -479,7 +479,7 @@ CLEANFILES +=3D \
> =A0##
>
> =A0AM_COMMON_FLAGS =3D -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D_R=
EENTRANT -D_THREAD_SAFE -rdynamic \
> --Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith \
> +${WARN_TYPE_LIMITS} ${WARN_IGNORED_QUALIFIERS} -Winit-self -Wpointer=
-arith \
> =A0-fno-strict-aliasing
>
> =A0AM_CFLAGS =3D $(AM_COMMON_FLAGS)
> --
> 1.6.6
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
