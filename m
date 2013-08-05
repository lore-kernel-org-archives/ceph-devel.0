From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: Update FUSE_USE_VERSION from 26 to 30.
Date: Mon, 5 Aug 2013 13:26:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308051325330.18013@cobra.newdream.net>
References: <201308011109083820483@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48746 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab3HEU0s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 16:26:48 -0400
In-Reply-To: <201308011109083820483@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 1 Aug 2013, majianpeng wrote:
> When compiling, it met this error:
> >In file included from /usr/local/include/fuse/fuse.h:19:0,
> >                 from client/fuse_ll.cc:17:
> >/usr/local/include/fuse/fuse_common.h:474:4: error: #error only API
> >version 30 or greater is supported
> Update FUSE_USE_VERSION from 26 to 30.

What platform was this on?  It looks like this change builds on all the 
gitbuilders, but I'm worried that there are older distros we're missing 
that will lose out here.

Thanks!
sage

> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fusetrace/fusetrace_ll.cc | 2 +-
>  src/client/fuse_ll.cc     | 2 +-
>  src/rbd_fuse/rbd-fuse.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fusetrace/fusetrace_ll.cc b/fusetrace/fusetrace_ll.cc
> index eb7100a..7f2b843 100644
> --- a/fusetrace/fusetrace_ll.cc
> +++ b/fusetrace/fusetrace_ll.cc
> @@ -11,7 +11,7 @@
>      gcc -Wall `pkg-config fuse --cflags --libs` -lulockmgr fusexmp_fh.c -o fusexmp_fh
>  */
>  
> -#define FUSE_USE_VERSION 26
> +#define FUSE_USE_VERSION 30
>  
>  #ifdef HAVE_CONFIG_H
>  #include <config.h>
> diff --git a/src/client/fuse_ll.cc b/src/client/fuse_ll.cc
> index 0812c9a..c82d004 100644
> --- a/src/client/fuse_ll.cc
> +++ b/src/client/fuse_ll.cc
> @@ -12,7 +12,7 @@
>   * 
>   */
>  
> -#define FUSE_USE_VERSION 26
> +#define FUSE_USE_VERSION 30
>  
>  #include <fuse/fuse.h>
>  #include <fuse/fuse_lowlevel.h>
> diff --git a/src/rbd_fuse/rbd-fuse.c b/src/rbd_fuse/rbd-fuse.c
> index 5a4bfe2..195cb76 100644
> --- a/src/rbd_fuse/rbd-fuse.c
> +++ b/src/rbd_fuse/rbd-fuse.c
> @@ -1,7 +1,7 @@
>  /*
>   * rbd-fuse
>   */
> -#define FUSE_USE_VERSION 26
> +#define FUSE_USE_VERSION 30
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> -- 
> 1.8.3.rc1.44.gb387c77
> 
> 
> Thanks!
> Jianpeng Ma
