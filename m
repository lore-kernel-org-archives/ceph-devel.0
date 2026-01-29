Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52F2EB5A6
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2026 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676780; cv=none; b=e06jDTq/m9GCZ99gvG7JEsVP+BBRA7FPZ5EFHbpsihT3Ia3/WrXYposvlveOhpRqAX8QrN9DrN3eFYW2f2sYtp52SlefvkpGC5622oHCDyNJvNtR+17qBRIz5BTZDn7iJYnme0OKWnMPt3qpKbkZQ1a9DatlyJ5wLd7kj7ml250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676780; c=relaxed/simple;
	bh=C0ksHRsIgCWgWeIAg1O63aRdYpWJetdDMKcyHPON3BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKhGs4lFDFW2GpJuRK6Bnf2PHWxlqtEDwnrPZ9fCOfqS3c4RcOiB5kYrwaVoCwm0UfjuLy/Bv9jGdkclO473/Qmd8oRYdqsF5m7sawGlX11POWOV6hi6QHGvTvOzOjzQN+s8oqfFzqNGPzPWFLnCa5awItzioEpRm16QOgRGrG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WBbgBQ4b; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WBbgBQ4b"
Message-ID: <fad9d632-5d27-4ff1-b787-48134f73853a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769676775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+DSgS59sVo7p306No/mxBmR9LvGPB0G+jfY9S1NY4Y=;
	b=WBbgBQ4bVOUIry7yjVNuz4D2Qe/5jJljeiBDgndKRfIInwyO7ra+v334ESitqXt8FERxo4
	Opg9XPXkaHxqn4fZ+ePoeedZnknaCts2FXBAt0AQu1CPeskr8VS4y4PK/Qt11Zm+rKsAfC
	mjBd9WI4hlztDjVjJERQGPdWDmWoQOM=
Date: Thu, 29 Jan 2026 16:52:46 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] rbd: check for EOD after exclusive lock is ensured to
 be held
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
References: <20260128124623.970785-1-idryomov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
In-Reply-To: <20260128124623.970785-1-idryomov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 1/28/2026 8:46 PM, Ilya Dryomov 写道:
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

Reviewed-by: Dongsheng Yang <dongsheng.yang@linux.dev>


Thanx

> ---
> v1 -> v2:
> - refactor to avoid taking header_rwsem for IMG_REQ_CHILD requests
>    unnecessarily
>
>   drivers/block/rbd.c | 33 +++++++++++++++++++++------------
>   1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index af0e21149dbc..8f441eb8b192 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3495,11 +3495,29 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
>   	rbd_assert(!need_exclusive_lock(img_req) ||
>   		   __rbd_is_lock_owner(rbd_dev));
>   
> -	if (rbd_img_is_write(img_req)) {
> -		rbd_assert(!img_req->snapc);
> +	if (test_bit(IMG_REQ_CHILD, &img_req->flags)) {
> +		rbd_assert(!rbd_img_is_write(img_req));
> +	} else {
> +		struct request *rq = blk_mq_rq_from_pdu(img_req);
> +		u64 off = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
> +		u64 len = blk_rq_bytes(rq);
> +		u64 mapping_size;
> +
>   		down_read(&rbd_dev->header_rwsem);
> -		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
> +		mapping_size = rbd_dev->mapping.size;
> +		if (rbd_img_is_write(img_req)) {
> +			rbd_assert(!img_req->snapc);
> +			img_req->snapc =
> +			    ceph_get_snap_context(rbd_dev->header.snapc);
> +		}
>   		up_read(&rbd_dev->header_rwsem);
> +
> +		if (unlikely(off + len > mapping_size)) {
> +			rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)",
> +				 off, len, mapping_size);
> +			img_req->pending.result = -EIO;
> +			return;
> +		}
>   	}
>   
>   	for_each_obj_request(img_req, obj_req) {
> @@ -4725,7 +4743,6 @@ static void rbd_queue_workfn(struct work_struct *work)
>   	struct request *rq = blk_mq_rq_from_pdu(img_request);
>   	u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
>   	u64 length = blk_rq_bytes(rq);
> -	u64 mapping_size;
>   	int result;
>   
>   	/* Ignore/skip any zero-length requests */
> @@ -4738,17 +4755,9 @@ static void rbd_queue_workfn(struct work_struct *work)
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
