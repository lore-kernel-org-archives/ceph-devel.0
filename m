From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH v2 1/3] libceph: fix overflow in __decode_pool_names()
Date: Wed, 06 Jun 2012 11:26:07 -0500
Message-ID: <4FCF849F.7000704@dreamhost.com>
References: <1335682765-1643-1-git-send-email-xi.wang@gmail.com> <4F9CE8A0.80306@gmail.com>
Reply-To: elder@inktank.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:36317 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab2FFQ0E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 12:26:04 -0400
In-Reply-To: <4F9CE8A0.80306@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xi Wang <xi.wang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On 04/29/2012 02:07 AM, Xi Wang wrote:
> `len' is read from network and thus needs validation.  Otherwise a
> large `len' would cause out-of-bounds access via the memcpy() call.
> In addition, len = 0xffffffff would overflow the kmalloc() size,
> leading to out-of-bounds write.
> 
> This patch adds a check of `len' via ceph_decode_need().  Also use
> kstrndup rather than kmalloc/memcpy.

This looks good, however I'd like to correct one thing, and fix
another (both noted below) before committing.  Please confirm/ack my
suggested change; I'll still credit you with the original patch.
Thanks.

					-Alex

> Signed-off-by: Xi Wang <xi.wang@gmail.com>
> ---
> Subject corrected.  Sorry, my bad.
> ---
>  net/ceph/osdmap.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 29ad46e..f80afc3 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -495,15 +495,12 @@ static int __decode_pool_names(void **p, void *end, struct ceph_osdmap *map)
>  		ceph_decode_32_safe(p, end, pool, bad);
>  		ceph_decode_32_safe(p, end, len, bad);
>  		dout("  pool %d len %d\n", pool, len);
> +		ceph_decode_need(p, end, len, bad);
>  		pi = __lookup_pg_pool(&map->pg_pools, pool);
>  		if (pi) {
>  			kfree(pi->name);
> -			pi->name = kmalloc(len + 1, GFP_NOFS);
> -			if (pi->name) {
> -				memcpy(pi->name, *p, len);
> -				pi->name[len] = '\0';
> -				dout("  name is %s\n", pi->name);
> -			}
> +			pi->name = kstrndup(*p, len, GFP_NOFS);
> +			dout("  name is %s\n", pi->name);

Instead:
		if (pi) {
			char *name = kstrndup(*p, len, GFP_NOFS);

			if (!name)
				return -ENOMEM;
			kfree(pi->name);
			pi->name = name;
			dout("  name is %s\n", pi->name);
		}

>  		}
>  		*p += len;
>  	}

