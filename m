From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] mkcephfs: Do not pipe echo output into --allhosts
Date: Tue, 7 Sep 2010 11:49:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009071149060.28511@cobra.newdream.net>
References: <1282947606-23020-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60970 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab0IGSsD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Sep 2010 14:48:03 -0400
In-Reply-To: <1282947606-23020-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Thanks, fixed this in the unstable branch.
sage

On Fri, 27 Aug 2010, Jim Schutt wrote:

> 
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
>  src/mkcephfs.in |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/mkcephfs.in b/src/mkcephfs.in
> index 288cbd4..fa35382 100644
> --- a/src/mkcephfs.in
> +++ b/src/mkcephfs.in
> @@ -86,7 +86,7 @@ done
>  [ -z "$conf" ] && usage_exit
>  
>  if [ $allhosts -eq 0 ]; then
> -    echo mkcephfs currently requires -a|--allhosts to initialize the whole fs at once.
> +    echo mkcephfs currently requires "-a|--allhosts" to initialize the whole fs at once.
>      usage_exit
>  fi
>  
> -- 
> 1.6.6.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
