From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH] rbd: fix integer overflow in rbd_header_from_disk()
Date: Wed, 18 Apr 2012 09:21:46 -0500
Message-ID: <4F8ECDFA.70209@dreamhost.com>
References: <1334008335-8377-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48195 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab2DROVs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:21:48 -0400
In-Reply-To: <1334008335-8377-1-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xi Wang <xi.wang@gmail.com>
Cc: ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>, Sage Weil <sage@newdream.net>

On 04/09/2012 04:52 PM, Xi Wang wrote:
> ondisk->snap_count is read from disk via rbd_req_sync_read() and thus
> needs validation.  Otherwise, a bogus `snap_count' could overflow the
> kmalloc() size, leading to memory corruption.
>
> Also use `u32' consistently for `snap_count'.

This looks good, however I have changed it to use UINT_MAX
rather than ULONG_MAX, because on some architectures size_t
(__kernel_size_t) is defined as type (unsigned int).  It
is the more conservative value, and even on architectures
where __BITS_PER_LONG is 64, it still offers a sane upper
bound on the number of snapshots for a rbd device.

Reviewed-by: Alex Elder <elder@dreamhost.com>

> Signed-off-by: Xi Wang<xi.wang@gmail.com>
> ---
>   drivers/block/rbd.c |   12 +++++++-----
>   1 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 013c7a5..d47f7e6 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -487,18 +487,20 @@ static void rbd_coll_release(struct kref *kref)
>    */
>   static int rbd_header_from_disk(struct rbd_image_header *header,
>   				 struct rbd_image_header_ondisk *ondisk,
> -				 int allocated_snaps,
> +				 u32 allocated_snaps,
>   				 gfp_t gfp_flags)
>   {
> -	int i;
> -	u32 snap_count;
> +	u32 i, snap_count;
>
>   	if (memcmp(ondisk, RBD_HEADER_TEXT, sizeof(RBD_HEADER_TEXT)))
>   		return -ENXIO;
>
>   	snap_count = le32_to_cpu(ondisk->snap_count);
> +	if (snap_count>  (ULONG_MAX - sizeof(struct ceph_snap_context))
> +			 / sizeof(*ondisk))
> +		return -EINVAL;
>   	header->snapc = kmalloc(sizeof(struct ceph_snap_context) +
> -				snap_count * sizeof (*ondisk),
> +				snap_count * sizeof(*ondisk),
>   				gfp_flags);
>   	if (!header->snapc)
>   		return -ENOMEM;
> @@ -1592,7 +1594,7 @@ static int rbd_read_header(struct rbd_device *rbd_dev,
>   {
>   	ssize_t rc;
>   	struct rbd_image_header_ondisk *dh;
> -	int snap_count = 0;
> +	u32 snap_count = 0;
>   	u64 ver;
>   	size_t len;
>

