From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/3] rbd: don't use index in __rbd_add_snap_dev()
Date: Tue, 11 Sep 2012 15:49:20 -0700
Message-ID: <504FBFF0.5030007@inktank.com>
References: <504A498D.30708@inktank.com> <504A4A06.8050101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35198 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab2IKWtX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 18:49:23 -0400
Received: by pbbrr13 with SMTP id rr13so1426398pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 15:49:23 -0700 (PDT)
In-Reply-To: <504A4A06.8050101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 12:24 PM, Alex Elder wrote:
> Pass the snapshot id and snapshot size rather than an index
> to __rbd_add_snap_dev() to specify values for a new snapshot.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d73edb1..2b048e3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2031,7 +2031,8 @@ static int rbd_register_snap_dev(struct rbd_snap
> *snap,
>   }
>
>   static struct rbd_snap *__rbd_add_snap_dev(struct rbd_device *rbd_dev,
> -					      int i, const char *name)
> +						const char *snap_name,
> +						u64 snap_id, u64 snap_size)
>   {
>   	struct rbd_snap *snap;
>   	int ret;
> @@ -2041,12 +2042,12 @@ static struct rbd_snap
> *__rbd_add_snap_dev(struct rbd_device *rbd_dev,
>   		return ERR_PTR(-ENOMEM);
>
>   	ret = -ENOMEM;
> -	snap->name = kstrdup(name, GFP_KERNEL);
> +	snap->name = kstrdup(snap_name, GFP_KERNEL);
>   	if (!snap->name)
>   		goto err;
>
> -	snap->size = rbd_dev->header.snap_sizes[i];
> -	snap->id = rbd_dev->header.snapc->snaps[i];
> +	snap->id = snap_id;
> +	snap->size = snap_size;
>
>   	return snap;
>
> @@ -2111,12 +2112,13 @@ static int rbd_dev_snaps_update(struct
> rbd_device *rbd_dev)
>   		dout("entry %u: snap_id = %llu\n", (unsigned int) snap_count,
>   			(unsigned long long) snap_id);
>   		if (!snap || (snap_id != CEPH_NOSNAP && snap->id < snap_id)) {
> +			struct rbd_image_header	*header = &rbd_dev->header;
>   			struct rbd_snap *new_snap;
>
>   			/* We haven't seen this snapshot before */
>
> -			new_snap = __rbd_add_snap_dev(rbd_dev, index,
> -							snap_name);
> +			new_snap = __rbd_add_snap_dev(rbd_dev, snap_name,
> +					snap_id, header->snap_sizes[index]);
>   			if (IS_ERR(new_snap)) {
>   				int err = PTR_ERR(new_snap);
>

