From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH] configure.ac: Fix up --with-profiler test
Date: Wed, 2 Mar 2011 12:01:18 -0800
Message-ID: <AANLkTimsChcqrjzvYJc7bSb9o8XP5gEv6OYOyJa-E3jD@mail.gmail.com>
References: <1299095521-20220-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42094 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670Ab1CBUBa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 15:01:30 -0500
Received: by fxm17 with SMTP id 17so371349fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2011 12:01:29 -0800 (PST)
In-Reply-To: <1299095521-20220-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Hmm. Does this handle --without-profiler correctly?

I have a vague memory that you need to check "withval" to do that...
(As with most of the other automake memories, I'm trying to repress it.=
)

cheers,
Colin


On Wed, Mar 2, 2011 at 11:52 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> According to http://www.gnu.org/software/autoconf/manual/autoconf.htm=
l,
> the <action-if-given> test for AC_ARG_WITH is done if either of
> --with-package or --without-package is on the configure line.
> The <action-if-not-given> is done if neither is present on
> the command line.
>
> This commit causes both --without-profiler and --with-profiler=3Dno
> to work correctly. =A0It also allows a default configure/build
> (i.e. --with-profiler not specified) to work correctly on a system
> that does not have the appropriate profiling library.
>
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
> =A0configure.ac | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index c76f605..9357a47 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -37,9 +37,9 @@ PKG_CHECK_MODULES([CRYPTOPP], [libcrypto++], [], [
> =A0# profiler?
> =A0AC_ARG_WITH([profiler],
> =A0 =A0 =A0 =A0 =A0 =A0 [AS_HELP_STRING([--with-profiler], [build ext=
ra profiler binaries])],
> - =A0 =A0 =A0 =A0 =A0 [with_profiler=3Dyes],
> + =A0 =A0 =A0 =A0 =A0 [],
> =A0 =A0 =A0 =A0 =A0 =A0 [with_profiler=3Dno])
> -AS_IF([test "x$with_profiler" !=3D xyes],
> +AS_IF([test "x$with_profiler" !=3D xno],
> =A0 =A0 =A0 =A0 =A0 =A0[AC_CHECK_LIB([profiler], [ProfilerFlush], [],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[AC_MSG_FAILURE([-=
-with-profiler was given but libprofiler (libgoogle-perftools-dev on de=
bian) not found])])],
> =A0 =A0 =A0 =A0 =A0 =A0[])
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
