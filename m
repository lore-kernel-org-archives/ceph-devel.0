Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5065307494
	for <ceph-devel@vger.kernel.org>; Tue, 27 Jan 2026 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769514747; cv=none; b=IiOWR3FEt6id8NdFJ1EfC42JZBR2yBfti2zB10mk+gRLDvTMabtgZO01C3HNYvxaGdXDl1UpQVuTXKhrq15LpKn4S6WNN/kzwJHJXU89YFJ+iFStRYYJkOP4Pg17WEwKUuVQjWONMMPJpXS9UW3BBaY2UXup4R6iK2MGawbeq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769514747; c=relaxed/simple;
	bh=XZj1tU/HgIUx2cjR84Q5AjOepYO5OkR/SeQNZGuHZ3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AwWivbGgWa0vVf0zs0D22GpIQzSChOKx35nNqmtK1YNUtuoJJ3jAzdkaJhCYTx1bXfPG4FCH9UzhHDXEA0EcXIy9aQ/KZCeg2NEcoU9j679rEC2/mhRq+tVXNy8x1G+SIgWQbdzWTOGxF4AWPVV2QQRKWnBVYvoBxaWHFLU1IIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pLOCbqlc; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pLOCbqlc"
Message-ID: <69115424-f57c-4e27-847f-67f0c8b8ef02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769514744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyOCJxaJ6IIh/4ZJhxeiVWTYdNJ2cu7hVP0LXzH44eM=;
	b=pLOCbqlcPuW0//uvh5g322z9w7FzfMbXvowlFhMgsSEA2zJfWw4GGGXelNvF5kxbvtjf/q
	S8X6DUE1G4tCO5BdOnBxtxUBKc/A+96ejutmabtOJZP/inVvuSsjm1A4KHMpG4LN9fQRtp
	j8QbbIiI1BpbrblxCLdB7drvKLlNofY=
Date: Tue, 27 Jan 2026 19:52:11 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rbd: check for EOD after exclusive lock is ensured to be
 held
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
References: <20260126133729.867488-1-idryomov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
In-Reply-To: <20260126133729.867488-1-idryomov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 1/26/2026 9:37 PM, Ilya Dryomov 写道:
> Similar to commit 870611e4877e ("rbd: get snapshot context after
> exclusive lock is ensured to be held"), move the "beyond EOD" check
> into the image request state machine so that it's performed after
> exclusive lock is ensured to be held.  This avoids various race
> conditions which can arise when the image is shrunk under I/O (in
> practice, mostly readahead).  In one such scenario
>
>      rbd_assert(objno < rbd_dev->object_map_size);
>
> can be triggered if a close-to-EOD read gets queued right before the
> shrink is initiated and the EOD check is performed against an outdated
> mapping_size.  After the resize is done on the server side and exclusive
> lock is (re)acquired bringing along the new (now shrunk) object map, the
> read starts going through the state machine and rbd_obj_may_exist() gets
> invoked on an object that is out of bounds of rbd_dev->object_map array.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>   drivers/block/rbd.c | 28 +++++++++++++++++-----------
>   1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index af0e21149dbc..44f4dd6e98d9 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3490,16 +3490,31 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
>   {
>   	struct rbd_device *rbd_dev = img_req->rbd_dev;
>   	struct rbd_obj_request *obj_req;
> +	u64 mapping_size;
>   
>   	rbd_assert(!img_req->pending.result && !img_req->pending.num_pending);
>   	rbd_assert(!need_exclusive_lock(img_req) ||
>   		   __rbd_is_lock_owner(rbd_dev));
>   
> +	down_read(&rbd_dev->header_rwsem);
> +	mapping_size = rbd_dev->mapping.size;
>   	if (rbd_img_is_write(img_req)) {
>   		rbd_assert(!img_req->snapc);
> -		down_read(&rbd_dev->header_rwsem);
>   		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
> -		up_read(&rbd_dev->header_rwsem);
> +	}
> +	up_read(&rbd_dev->header_rwsem);
> +
> +	if (!test_bit(IMG_REQ_CHILD, &img_req->flags)) {
> +		struct request *rq = blk_mq_rq_from_pdu(img_req);
> +		u64 off = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
> +		u64 len = blk_rq_bytes(rq);
> +
> +		if (unlikely(off + len > mapping_size)) {
> +			rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)",
> +				 off, len, mapping_size);
> +			img_req->pending.result = -EIO;
> +			return;
> +	
> 	}


Hi Ilya,


Fix looks good in logic. But one potential concern is that with this 
change all child read requests will also acquire |header_rwsem| for 
reading.

In principle this could be avoided, since child read requests do not 
need to fetch |snapc| and do not need to perform the beyond-EOD check.


Dongsheng

>   	}
>   
>   	for_each_obj_request(img_req, obj_req) {
> @@ -4725,7 +4740,6 @@ static void rbd_queue_workfn(struct work_struct *work)
>   	struct request *rq = blk_mq_rq_from_pdu(img_request);
>   	u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
>   	u64 length = blk_rq_bytes(rq);
> -	u64 mapping_size;
>   	int result;
>   
>   	/* Ignore/skip any zero-length requests */
> @@ -4738,17 +4752,9 @@ static void rbd_queue_workfn(struct work_struct *work)
>   	blk_mq_start_request(rq);
>   
>   	down_read(&rbd_dev->header_rwsem);
> -	mapping_size = rbd_dev->mapping.size;
>   	rbd_img_capture_header(img_request);
>   	up_read(&rbd_dev->header_rwsem);
>   
> -	if (offset + length > mapping_size) {
> -		rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)", offset,
> -			 length, mapping_size);
> -		result = -EIO;
> -		goto err_img_request;
> -	}
> -
>   	dout("%s rbd_dev %p img_req %p %s %llu~%llu\n", __func__, rbd_dev,
>   	     img_request, obj_op_name(op_type), offset, length);
>   
