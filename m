From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Detect broken system linux/fiemap.h
Date: Wed, 17 Nov 2010 12:53:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011171252280.12432@cobra.newdream.net>
References: <1290026392-10127-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53970 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364Ab0KQUs6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Nov 2010 15:48:58 -0500
In-Reply-To: <1290026392-10127-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Applied.  

sage


On Wed, 17 Nov 2010, Jim Schutt wrote:

> RedHat 5.5 has a /usr/include/linux/fiemap.h, but it is
> broken because it does not itself include linux/types.h.
> As a result, __u64 and friends are not defined.
> 
> We have a Ceph-local copy of fiemap.h, so use it
> if the system version is broken.
> 
> While we're at it, fix up the configure message to
> note we're using a local copy.
> 
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
>  configure.ac |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 000e892..e00cdbf 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -162,9 +162,10 @@ AC_CHECK_HEADER([openssl/md5.h],
>  	[AC_MSG_ERROR([Sorry you need openssl dev files (libssl-dev on debian)])])
>  PKG_CHECK_MODULES([OPENSSL], [openssl])
>  
> -AC_CHECK_HEADER([linux/fiemap.h],
> +AC_CHECK_MEMBER([struct fiemap_extent.fe_logical],
>  	[AC_DEFINE([HAVE_FIEMAP_H], [], [linux/fiemap.h was found, fiemap ioctl will be used])],
> -	[AC_MSG_NOTICE([linux/fiemap.h was not found, fiemap ioctl will not be used])])
> +	[AC_MSG_NOTICE([linux/fiemap.h was not found or not usable; using local Ceph copy])],
> +	[[#include <linux/fiemap.h>]])
>  
>  AC_CHECK_HEADERS([sys/xattr.h arpa/inet.h netdb.h netinet/in.h sys/file.h sys/ioctl.h sys/mount.h sys/param.h sys/socket.h sys/statvfs.h sys/time.h sys/vfs.h syslog.h utime.h])
>  
> -- 
> 1.6.6
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
