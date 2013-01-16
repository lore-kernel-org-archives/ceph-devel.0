From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST 2/2] rbd: only get snap context for write requests
Date: Tue, 15 Jan 2013 17:23:57 -0800
Message-ID: <50F6012D.8090102@inktank.com>
References: <50E60BD0.30408@inktank.com> <50E60C19.9060305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:49702 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756246Ab3APBZH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 20:25:07 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so307892dae.3
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 17:25:06 -0800 (PST)
In-Reply-To: <50E60C19.9060305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 02:54 PM, Alex Elder wrote:
> Right now we get the snapshot context for an rbd image (under
> protection of the header semaphore) for every request processed.
>
> There's no need to get the snap context if we're doing a read,
> so avoid doing so in that case.
>
> Note that we no longer need to hold the header semaphore to
> check the rbd_dev's existence flag.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   drivers/block/rbd.c |   36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index a3b0d43..fd6a708 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1331,7 +1331,7 @@ static int rbd_do_op(struct request *rq,
>   	} else {
>   		opcode = CEPH_OSD_OP_READ;
>   		flags = CEPH_OSD_FLAG_READ;
> -		snapc = NULL;
> +		rbd_assert(!snapc);
>   		snapid = rbd_dev->spec->snap_id;
>   		payload_len = 0;
>   	}
> @@ -1661,22 +1661,25 @@ static void rbd_rq_fn(struct request_queue *q)
>   		}
>   		spin_unlock_irq(q->queue_lock);
>
> -		/* Stop writes to a read-only device */
> -
> -		result = -EROFS;
> -		if (read_only && rq_data_dir(rq) == WRITE)
> -			goto out_end_request;
> -
> -		/* Grab a reference to the snapshot context */
> -
> -		down_read(&rbd_dev->header_rwsem);
> -		if (atomic_read(&rbd_dev->exists)) {
> +		/* Write requests need a reference to the snapshot context */
> +
> +		if (rq_data_dir(rq) == WRITE) {
> +			result = -EROFS;
> +			if (read_only) /* Can't write to a read-only device */
> +				goto out_end_request;
> +
> +			/*
> +			 * Note that each osd request will take its
> +			 * own reference to the snapshot context
> +			 * supplied.  The reference we take here
> +			 * just guarantees the one we provide stays
> +			 * valid.
> +			 */
> +			down_read(&rbd_dev->header_rwsem);
>   			snapc = ceph_get_snap_context(rbd_dev->header.snapc);
> +			up_read(&rbd_dev->header_rwsem);
>   			rbd_assert(snapc != NULL);
> -		}
> -		up_read(&rbd_dev->header_rwsem);
> -
> -		if (!snapc) {
> +		} else if (!atomic_read(&rbd_dev->exists)) {
>   			rbd_assert(rbd_dev->spec->snap_id != CEPH_NOSNAP);
>   			dout("request for non-existent snapshot");
>   			result = -ENXIO;
> @@ -1687,7 +1690,8 @@ static void rbd_rq_fn(struct request_queue *q)
>   				blk_rq_pos(rq) * SECTOR_SIZE,
>   				blk_rq_bytes(rq), rq->bio);
>   out_end_request:
> -		ceph_put_snap_context(snapc);
> +		if (snapc)
> +			ceph_put_snap_context(snapc);
>   		spin_lock_irq(q->queue_lock);
>   		if (result < 0)
>   			__blk_end_request_all(rq, result);
>

