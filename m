From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] fix syncfs handling in error case
Date: Tue, 27 Nov 2012 08:53:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211270853170.30109@cobra.newdream.net>
References: <1354031680-17610-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33576 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab2K0QxV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 11:53:21 -0500
In-Reply-To: <1354031680-17610-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

sage

On Tue, 27 Nov 2012, Danny Al-Gaaf wrote:

> If the call to syncfs() fails, don't try to call syncfs again via
> syscall(). If HAVE_SYS_SYNCFS is defined, don't fall through to try
> syscall() with SYS_syncfs or __NR_syncfs.
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  src/common/sync_filesystem.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/src/common/sync_filesystem.h b/src/common/sync_filesystem.h
> index 5b23576..eff18d2 100644
> --- a/src/common/sync_filesystem.h
> +++ b/src/common/sync_filesystem.h
> @@ -34,14 +34,10 @@ inline int sync_filesystem(int fd)
>  #ifdef HAVE_SYS_SYNCFS
>    if (syncfs(fd) == 0)
>      return 0;
> -#endif
> -
> -#ifdef SYS_syncfs
> +#elif defined(SYS_syncfs)
>    if (syscall(SYS_syncfs, fd) == 0)
>      return 0;
> -#endif
> -
> -#ifdef __NR_syncfs
> +#elif defined(__NR_syncfs)
>    if (syscall(__NR_syncfs, fd) == 0)
>      return 0;
>  #endif
> -- 
> 1.8.0
> 
> 
