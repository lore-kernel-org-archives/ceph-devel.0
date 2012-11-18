From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH] rgw: add -lresolv flags to Makefile.am
Date: Sat, 17 Nov 2012 23:27:54 -0800
Message-ID: <CAC-hyiF6Q9Yp2e==N2HVzSm-mNf3kN9GGZs+X5_gmvGzsEO+XA@mail.gmail.com>
References: <1353220461-6436-1-git-send-email-baozich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:53237 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab2KRH1y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Nov 2012 02:27:54 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2670369iay.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Nov 2012 23:27:54 -0800 (PST)
In-Reply-To: <1353220461-6436-1-git-send-email-baozich@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chen Baozi <baozich@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks. Pushed to the next branch.

Yehuda

On Sat, Nov 17, 2012 at 10:34 PM, Chen Baozi <baozich@gmail.com> wrote:
>
> radosgw depends on libresolv since since the commit 951c6be. So we need to
> add -lresolve flags, or it cannot link right library.
>
> Signed-off-by: Chen Baozi <baozich@gmail.com>
> ---
>  configure.ac    | 1 +
>  src/Makefile.am | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index aa10143..d978565 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -80,6 +80,7 @@ AC_CHECK_CC_FLAG([-Wignored-qualifiers], [WARN_IGNORED_QUALIFIERS])
>  ACX_PTHREAD
>  AC_CHECK_LIB([uuid], [uuid_parse], [true], AC_MSG_FAILURE([libuuid not found]))
>  AC_CHECK_LIB([m], [pow], [true], AC_MSG_FAILURE([libm not found]))
> +AC_CHECK_LIB([resolv], [__res_nquery], [true], AC_MSG_FAILURE([libresolv not found]))
>  if test x"$linux" = x"yes"; then
>         AC_CHECK_LIB([keyutils], [add_key], [true], AC_MSG_FAILURE([libkeyutils not found]))
>  fi
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 8b5e63d..16a7ed3 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -366,7 +366,7 @@ radosgw_SOURCES = \
>          rgw/rgw_swift.cc \
>         rgw/rgw_swift_auth.cc \
>         rgw/rgw_main.cc
> -radosgw_LDADD = $(my_radosgw_ldadd) -lfcgi
> +radosgw_LDADD = $(my_radosgw_ldadd) -lfcgi -lresolv
>  radosgw_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
>  bin_PROGRAMS += radosgw
>
> --
> 1.7.11.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
