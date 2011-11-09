From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] automake: enable 'make V=0'
Date: Wed, 9 Nov 2011 12:55:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111091254420.31435@cobra.newdream.net>
References: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51408 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab1KIUzD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 15:55:03 -0500
In-Reply-To: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ah, much nicer.  Applied!

sage


On Tue, 8 Nov 2011, Noah Watkins wrote:

> From: Noah Watkins <noahwatkins@gmail.com>
> 
> Enables silent mode for automake generated Makefiles,
> and silent mode is _off_ by default. Using V=0 the output
> is much easier to read when trying to find warnings:
> 
> nwatkins@piha:~/Projects/ceph/ceph$ make -j8 V=0
> make[3]: Entering directory `/users/nwatkins/Projects/ceph/ceph/src'
>   CC     locks.o
>   CXX    journal.o
>   CXX    Server.o
>   CXX    Mutation.o
>   CXX    MDCache.o
>   CXX    Locker.o
>   CXX    Migrator.o
>   CXX    MDBalancer.o
>   CXX    CDentry.o
>   CXX    CDir.o
>   CXX    CInode.o
>   CXX    LogEvent.o
>   CXX    MDSTable.o
> 
> Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
> ---
>  configure.ac |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 54582e9..1700daa 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -20,6 +20,9 @@ AM_INIT_AUTOMAKE
>  AM_PROG_CC_C_O
>  AM_PROG_LIBTOOL
>  
> +# Enable make V=0
> +AM_SILENT_RULES([yes])
> +
>  # Platform
>  case "${target_os}" in
>  darwin*)
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
