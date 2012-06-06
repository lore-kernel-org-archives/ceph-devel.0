From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 2/3] libceph: fix overflow in osdmap_decode()
Date: Wed, 06 Jun 2012 11:26:12 -0500
Message-ID: <4FCF84A4.4040005@dreamhost.com>
References: <1335682765-1643-1-git-send-email-xi.wang@gmail.com> <1335682765-1643-2-git-send-email-xi.wang@gmail.com>
Reply-To: elder@inktank.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:36321 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643Ab2FFQ0H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 12:26:07 -0400
In-Reply-To: <1335682765-1643-2-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xi Wang <xi.wang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On 04/29/2012 01:59 AM, Xi Wang wrote:
> On 32-bit systems, a large `n' would overflow `n * sizeof(u32)' and bypass
> the check ceph_decode_need(p, end, n * sizeof(u32), bad).  It would also
> overflow the subsequent kmalloc() size, leading to out-of-bounds write.

This looks good.

Your previous patch made me look at something else though.  If
you can think of a good solution would you be willing to send a
patch to implement it?  (See below.)  I won't hold up committing
this for it, but I'd like your opinion.

Reviewed-by: Alex Elder <elder@inktank.com>

> Signed-off-by: Xi Wang <xi.wang@gmail.com>
> ---
>  net/ceph/osdmap.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index f80afc3..774eac6 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -670,6 +670,9 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)

Just above here we see:
        /* pg_temp */
        ceph_decode_32_safe(p, end, len, bad);
        for (i = 0; i < len; i++) {

We haven't validated "len" here either.  Looking at it I'm not sure
we can do much, but I think we do know a few things should be true:
- (len & (sizeof (u32) - 1)) == 0
- len <= (UINT_MAX / (sizeof (struct ceph_pg) + sizeof (u32)))
    and further, if it's invalid to have a value for pg->len of
    zero, then we can instead assert:
- len <= (UINT_MAX / (sizeof (struct ceph_pg) + 2 * sizeof (u32)))

I don't know if it's that important do do a check like this though.

I appreciate these detail-oriented fixes that you've been sending.

>  		ceph_decode_need(p, end, sizeof(u32) + sizeof(u64), bad);
>  		ceph_decode_copy(p, &pgid, sizeof(pgid));
>  		n = ceph_decode_32(p);
> +		err = -EINVAL;
> +		if (n > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
> +			goto bad;
>  		ceph_decode_need(p, end, n * sizeof(u32), bad);
>  		err = -ENOMEM;
>  		pg = kmalloc(sizeof(*pg) + n*sizeof(u32), GFP_NOFS);

