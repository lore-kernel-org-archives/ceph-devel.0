From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: fix overflow check in crush_decode()
Date: Thu, 16 Feb 2012 09:55:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202160952350.11317@cobra.newdream.net>
References: <1329411348-13456-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58146 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab2BPRz0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2012 12:55:26 -0500
In-Reply-To: <1329411348-13456-1-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xi Wang <xi.wang@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Applied these both, thanks!

sage

On Thu, 16 Feb 2012, Xi Wang wrote:

> The existing overflow check (n > ULONG_MAX / b) didn't work, because
> n = ULONG_MAX / b would both bypass the check and still overflow the
> allocation size a + n * b.
> 
> The correct check should be (n > (ULONG_MAX - a) / b).
> 
> Signed-off-by: Xi Wang <xi.wang@gmail.com>
> ---
>  net/ceph/osdmap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index fd863fe..29ad46e 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -283,7 +283,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>  		ceph_decode_32_safe(p, end, yes, bad);
>  #if BITS_PER_LONG == 32
>  		err = -EINVAL;
> -		if (yes > ULONG_MAX / sizeof(struct crush_rule_step))
> +		if (yes > (ULONG_MAX - sizeof(*r))
> +			  / sizeof(struct crush_rule_step))
>  			goto bad;
>  #endif
>  		r = c->rules[i] = kmalloc(sizeof(*r) +
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
