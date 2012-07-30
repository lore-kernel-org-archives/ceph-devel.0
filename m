From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/7] rbd: always pass ops array to rbd_req_sync_op()
Date: Mon, 30 Jul 2012 13:51:56 -0700
Message-ID: <5016F3EC.4010001@inktank.com>
References: <50119421.1090702@inktank.com> <501195C3.1070005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49326 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab2G3UwA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 16:52:00 -0400
Received: by pbbrp8 with SMTP id rp8so10406926pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 13:51:59 -0700 (PDT)
In-Reply-To: <501195C3.1070005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2012 12:08 PM, Alex Elder wrote:
> All of the callers of rbd_req_sync_op() except one pass a non-null
> "ops" pointer.  The only one that does not is rbd_req_sync_read(),
> which passes CEPH_OSD_OP_READ as its "opcode" and, CEPH_OSD_FLAG_READ
> for "flags".
>
> By allocating the ops array in rbd_req_sync_read() and moving the
> special case code for the null ops pointer into it, it becomes
> clear that much of that code is not even necessary.
>
> In addition, the "opcode" argument to rbd_req_sync_op() is never
> actually used, so get rid of that.
>
> Signed-off-by: Alex Elder <elder@inktank.com>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> ---
>   drivers/block/rbd.c |   46 ++++++++++++++++------------------------------
>   1 file changed, 16 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index eacf255..4584500 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1019,9 +1019,8 @@ static void rbd_simple_req_cb(struct
> ceph_osd_request *req, struct ceph_msg *msg
>   static int rbd_req_sync_op(struct rbd_device *rbd_dev,
>   			   struct ceph_snap_context *snapc,
>   			   u64 snapid,
> -			   int opcode,
>   			   int flags,
> -			   struct ceph_osd_req_op *orig_ops,
> +			   struct ceph_osd_req_op *ops,
>   			   const char *object_name,
>   			   u64 ofs, u64 len,
>   			   char *buf,
> @@ -1031,28 +1030,14 @@ static int rbd_req_sync_op(struct rbd_device
> *rbd_dev,
>   	int ret;
>   	struct page **pages;
>   	int num_pages;
> -	struct ceph_osd_req_op *ops = orig_ops;
> -	u32 payload_len;
> +
> +	BUG_ON(ops == NULL);
>
>   	num_pages = calc_pages_for(ofs , len);
>   	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
>   	if (IS_ERR(pages))
>   		return PTR_ERR(pages);
>
> -	if (!orig_ops) {
> -		payload_len = (flags & CEPH_OSD_FLAG_WRITE ? len : 0);
> -		ret = -ENOMEM;
> -		ops = rbd_create_rw_ops(1, opcode, payload_len);
> -		if (!ops)
> -			goto done;
> -
> -		if ((flags & CEPH_OSD_FLAG_WRITE) && buf) {
> -			ret = ceph_copy_to_page_vector(pages, buf, ofs, len);
> -			if (ret < 0)
> -				goto done_ops;
> -		}
> -	}
> -
>   	ret = rbd_do_request(NULL, rbd_dev, snapc, snapid,
>   			  object_name, ofs, len, NULL,
>   			  pages, num_pages,
> @@ -1062,14 +1047,11 @@ static int rbd_req_sync_op(struct rbd_device
> *rbd_dev,
>   			  NULL,
>   			  linger_req, ver);
>   	if (ret < 0)
> -		goto done_ops;
> +		goto done;
>
>   	if ((flags & CEPH_OSD_FLAG_READ) && buf)
>   		ret = ceph_copy_from_page_vector(pages, buf, ofs, ret);
>
> -done_ops:
> -	if (!orig_ops)
> -		rbd_destroy_ops(ops);
>   done:
>   	ceph_release_page_vector(pages, num_pages);
>   	return ret;
> @@ -1176,12 +1158,20 @@ static int rbd_req_sync_read(struct rbd_device
> *rbd_dev,
>   			  char *buf,
>   			  u64 *ver)
>   {
> -	return rbd_req_sync_op(rbd_dev, NULL,
> +	struct ceph_osd_req_op *ops;
> +	int ret;
> +
> +	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_READ, 0);
> +	if (!ops)
> +		return -ENOMEM;
> +
> +	ret = rbd_req_sync_op(rbd_dev, NULL,
>   			       snapid,
> -			       CEPH_OSD_OP_READ,
>   			       CEPH_OSD_FLAG_READ,
> -			       NULL,
> -			       object_name, ofs, len, buf, NULL, ver);
> +			       ops, object_name, ofs, len, buf, NULL, ver);
> +	rbd_destroy_ops(ops);
> +
> +	return ret;
>   }
>
>   /*
> @@ -1260,7 +1250,6 @@ static int rbd_req_sync_watch(struct rbd_device
> *rbd_dev)
>
>   	ret = rbd_req_sync_op(rbd_dev, NULL,
>   			      CEPH_NOSNAP,
> -			      0,
>   			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>   			      ops,
>   			      rbd_dev->header_name,
> @@ -1299,7 +1288,6 @@ static int rbd_req_sync_unwatch(struct rbd_device
> *rbd_dev)
>
>   	ret = rbd_req_sync_op(rbd_dev, NULL,
>   			      CEPH_NOSNAP,
> -			      0,
>   			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>   			      ops,
>   			      rbd_dev->header_name,
> @@ -1357,7 +1345,6 @@ static int rbd_req_sync_notify(struct rbd_device
> *rbd_dev)
>
>   	ret = rbd_req_sync_op(rbd_dev, NULL,
>   			       CEPH_NOSNAP,
> -			       0,
>   			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>   			       ops,
>   			       rbd_dev->header_name,
> @@ -1408,7 +1395,6 @@ static int rbd_req_sync_exec(struct rbd_device
> *rbd_dev,
>
>   	ret = rbd_req_sync_op(rbd_dev, NULL,
>   			       CEPH_NOSNAP,
> -			       0,
>   			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>   			       ops,
>   			       object_name, 0, 0, NULL, NULL, ver);
>

