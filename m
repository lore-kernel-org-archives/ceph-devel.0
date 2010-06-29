From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] mkcephfs: Fix wrong maxosd when OSD ids are random
 ordered in ceph.conf
Date: Tue, 29 Jun 2010 08:37:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006290837130.12768@cobra.newdream.net>
References: <AANLkTimunpW727r2xM0itVW6iHRIxKTuYLK4kBHCsF3Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34826 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795Ab0F2Pf6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jun 2010 11:35:58 -0400
In-Reply-To: <AANLkTimunpW727r2xM0itVW6iHRIxKTuYLK4kBHCsF3Z@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: CC Lien <cc_lien@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!
sage

On Tue, 29 Jun 2010, CC Lien wrote:

> Hi
> 
> I got a trouble that mkcephfs will have wrong "maxosd" when you have
> ceph.conf with OSD ids in random order like:
> 
> [osd2]
> ...
> [osd0]
> ...
> [osd1]
> ...
> 
> In this case, you will got "2" for the "maxosd", instead of 3.
> After adding a sort, the problem seems solved.
> 
> 
> Cheers,
> CC Lien
> 
> Signed-off-by: CC Lien <cc_lien@tcloudcomputing.com>
> ---
>  src/mkcephfs.in |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/mkcephfs.in b/src/mkcephfs.in
> index 2edaad1..3cad4cf 100644
> --- a/src/mkcephfs.in
> +++ b/src/mkcephfs.in
> @@ -110,7 +110,7 @@ if echo $what | grep -q mon0 ; then
>      # build osdmap
>      osdmap="/tmp/osdmap.$$"
>      if [ -z "$numosd" ]; then
> -	maxosd=`$CCONF -c $conf -l osd | egrep -v '^osd$' | tail -1 | cut -c 4-`
> +	maxosd=`$CCONF -c $conf -l osd | egrep -v '^osd$' | cut -c 4- | sort
> -n | tail -1`
>  	numosd=$(($maxosd + 1))
>  	echo max osd in $conf is $maxosd, num osd is $numosd
>      fi
> -- 
> 1.7.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
