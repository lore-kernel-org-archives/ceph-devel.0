From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 3/3] libceph: fix overflow in osdmap_apply_incremental()
Date: Wed, 06 Jun 2012 11:26:15 -0500
Message-ID: <4FCF84A7.4030907@dreamhost.com>
References: <1335682765-1643-1-git-send-email-xi.wang@gmail.com> <1335682765-1643-3-git-send-email-xi.wang@gmail.com>
Reply-To: elder@inktank.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:36330 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab2FFQ0K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 12:26:10 -0400
In-Reply-To: <1335682765-1643-3-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xi Wang <xi.wang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On 04/29/2012 01:59 AM, Xi Wang wrote:
> On 32-bit systems, a large `pglen' would overflow `pglen*sizeof(u32)'
> and bypass the check ceph_decode_need(p, end, pglen*sizeof(u32), bad).
> It would also overflow the subsequent kmalloc() size, leading to
> out-of-bounds write.
> 
> Signed-off-by: Xi Wang <xi.wang@gmail.com>

This looks good.  I'll wait to hear back on my comments on
your earlier patches before committing these.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/osdmap.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 774eac6..b1ea6d1 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -891,6 +891,10 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
>  
>  		if (pglen) {
>  			/* insert */
> +			if (pglen > (UINT_MAX - sizeof(*pg)) / sizeof(u32)) {
> +				err = -EINVAL;
> +				goto bad;
> +			}
>  			ceph_decode_need(p, end, pglen*sizeof(u32), bad);
>  			pg = kmalloc(sizeof(*pg) + sizeof(u32)*pglen, GFP_NOFS);
>  			if (!pg) {

