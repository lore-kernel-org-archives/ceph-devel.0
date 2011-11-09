From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] rbd: Fix the showmapped cmd usage
Date: Wed, 9 Nov 2011 14:07:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111091407210.31435@cobra.newdream.net>
References: <1320876335-671-1-git-send-email-psomas@grnet.gr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38827 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab1KIWHw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 17:07:52 -0500
In-Reply-To: <1320876335-671-1-git-send-email-psomas@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stratos Psomadakis <psomas@grnet.gr>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

On Thu, 10 Nov 2011, Stratos Psomadakis wrote:

> If the rbd showmapped cmd is given any extra arguments, rbd will fail
> with "assert(0)". Fix it by exiting with "usage_exit()", if any
> arguments are present, instead of failing.
> 
> Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
> ---
>  src/rbd.cc |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/src/rbd.cc b/src/rbd.cc
> index 30f045f..47b556d 100644
> --- a/src/rbd.cc
> +++ b/src/rbd.cc
> @@ -986,6 +986,9 @@ int main(int argc, const char **argv)
>        case OPT_RENAME:
>  	set_conf_param(v, &imgname, &destname);
>  	break;
> +      case OPT_SHOWMAPPED:
> +	usage_exit();
> +	break;
>        default:
>  	assert(0);
>  	break;
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
