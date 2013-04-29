From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: avoid dropping extra reference in rbd_free_disk()
Date: Mon, 29 Apr 2013 08:33:15 -0700
Message-ID: <517E92BB.6060106@inktank.com>
References: <517A944C.1090503@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:46936 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab3D2Pc4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:32:56 -0400
Received: by mail-pd0-f182.google.com with SMTP id 14so2114741pdj.41
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 08:32:55 -0700 (PDT)
In-Reply-To: <517A944C.1090503@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/26/2013 07:50 AM, Alex Elder wrote:
> I found during some failure injection testing that the call to
> rbd_free_disk() in the error path of rbd_dev_probe_finish() was
> dropping an extra reference to the disk queue.  The problem
> occurred when put_disk tried to drop a reference to the disk's
> queue.  A call to blk_cleanup_queue() just prior to that will have
> also dropped a reference to the queue.
>
> The problem is that the reference dropped by put_disk() is assumed
> to have been taken by add_disk().  Our code has error paths that can
> occur after the disk and its queue are initialized, but before the
> call to add_disk(), and in those paths we won't have that extra
> reference.
>
> The fix is easy though.  In rbd_free_disk() we're already checking
> the disk's GENHD_FL_UP flag.  That flag is an indication that
> add_disk() has been called, so just call blk_cleanup_queue()
> conditional on that flag being set.
>
> This resolves:
>      http://tracker.ceph.com/issues/4800
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index dcd8e58..9e38967 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2844,10 +2844,12 @@ static void rbd_free_disk(struct rbd_device
> *rbd_dev)
>   	if (!disk)
>   		return;
>
> -	if (disk->flags & GENHD_FL_UP)
> +	rbd_dev->disk = NULL;
> +	if (disk->flags & GENHD_FL_UP) {
>   		del_gendisk(disk);
> -	if (disk->queue)
> -		blk_cleanup_queue(disk->queue);
> +		if (disk->queue)
> +			blk_cleanup_queue(disk->queue);
> +	}
>   	put_disk(disk);
>   }
>

