From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH] fix syncfs handling in error case
Date: Tue, 27 Nov 2012 16:42:35 +0100
Message-ID: <50B4DF6B.9090304@bisect.de>
References: <1354029799-14465-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:56551 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753310Ab2K0Pmk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Nov 2012 10:42:40 -0500
In-Reply-To: <1354029799-14465-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Hi,

forget this patch, I'll send a new version due to changes in master.

Danny

Am 27.11.2012 16:23, schrieb Danny Al-Gaaf:
> If the call to syncfs() fails, don't try to call syncfs again via
> syscall(). If HAVE_SYS_SYNCFS is defined, don't use syscall() with
> SYS_syncfs.
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  src/common/sync_filesystem.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/src/common/sync_filesystem.h b/src/common/sync_filesystem.h
> index dc90b89..976400f 100644
> --- a/src/common/sync_filesystem.h
> +++ b/src/common/sync_filesystem.h
> @@ -34,9 +34,7 @@ inline int sync_filesystem(int fd)
>  #ifdef HAVE_SYS_SYNCFS
>    if (syncfs(fd) == 0)
>      return 0;
> -#endif
> -
> -#ifdef SYS_syncfs
> +#elif defined(SYS_syncfs)
>    if (syscall(SYS_syncfs, fd) == 0)
>      return 0;
>  #endif
> 

