From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: [PATCH] autoconf: Fix detection of sync_file_range.
Date: Fri, 16 Apr 2010 15:55:52 -0700
Message-ID: <g2q1471eea71004161555nac2dfa1ckc75ceb6bd74218fd@mail.gmail.com>
References: <1271456749-12510-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:56513 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669Ab0DPWzx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Apr 2010 18:55:53 -0400
Received: by iwn35 with SMTP id 35so611235iwn.21
        for <ceph-devel@vger.kernel.org>; Fri, 16 Apr 2010 15:55:52 -0700 (PDT)
In-Reply-To: <1271456749-12510-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Thanks! This is pushed into unstable now. :)

On Fri, Apr 16, 2010 at 3:25 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> Without this patch, on CentOS 5.4 ./configure reports that
> sync_file_range is missing, but HAVE_SYNC_FILE_RANGE ends
> up being defined in src/acconfig.h anyway.
>
> Compile tested on CentOS 5.4 (which does not have sync_file_range(2)
> in distro glibc) and Fedora 11 (which does).
>
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
> =A0configure.ac | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 665fcdd..4abcbe1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -148,9 +148,8 @@ AC_CHECK_HEADER([openssl/md5.h],
> =A0AC_CHECK_HEADERS([sys/xattr.h arpa/inet.h netdb.h netinet/in.h sys=
/file.h sys/ioctl.h sys/mount.h sys/param.h sys/socket.h sys/statvfs.h =
sys/time.h sys/vfs.h syslog.h utime.h])
>
> =A0# sync_file_range
> -AC_DEFINE([HAVE_SYNC_FILE_RANGE], [], [sync_file_range(2) is support=
ed])
> =A0AC_CHECK_FUNC([sync_file_range],
> - =A0 =A0 =A0 [AC_DEFINE([HAVE_SYNC_FILE_RANGE])],
> + =A0 =A0 =A0 [AC_DEFINE([HAVE_SYNC_FILE_RANGE], [], [sync_file_range=
(2) is supported])],
> =A0 =A0 =A0 =A0[])
>
> =A0# Checks for typedefs, structures, and compiler characteristics.
> --
> 1.6.6.1
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
