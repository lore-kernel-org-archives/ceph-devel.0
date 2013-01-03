From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH REPOST 2/2] rbd: standardize ceph_osd_request variable
 names
Date: Thu, 03 Jan 2013 15:06:26 -0800
Message-ID: <50E60EF2.3080302@inktank.com>
References: <50E60842.2040204@inktank.com> <50E608CD.1000301@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:36749 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab3ACXGa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 18:06:30 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so7246611dad.41
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 15:06:29 -0800 (PST)
In-Reply-To: <50E608CD.1000301@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Dan Mick <dan.mick@inktank.com>

On 01/03/2013 02:40 PM, Alex Elder wrote:
> There are spots where a ceph_osds_request pointer variable is given
> the name "req".  Since we're dealing with (at least) three types of
> requests (block layer, rbd, and osd), I find this slightly
> distracting.
>
> Change such instances to use "osd_req" consistently to make the
> abstraction represented a little more obvious.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   60
> ++++++++++++++++++++++++++-------------------------
>   1 file changed, 31 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 0091fa4..85131de 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1111,12 +1111,12 @@ static int rbd_do_request(struct request *rq,
>   			  struct ceph_osd_req_op *ops,
>   			  struct rbd_req_coll *coll,
>   			  int coll_index,
> -			  void (*rbd_cb)(struct ceph_osd_request *req,
> -					 struct ceph_msg *msg),
> +			  void (*rbd_cb)(struct ceph_osd_request *,
> +					 struct ceph_msg *),
>   			  struct ceph_osd_request **linger_req,
>   			  u64 *ver)
>   {
> -	struct ceph_osd_request *req;
> +	struct ceph_osd_request *osd_req;
>   	struct ceph_file_layout *layout;
>   	int ret;
>   	u64 bno;
> @@ -1143,67 +1143,68 @@ static int rbd_do_request(struct request *rq,
>   		(unsigned long long) len, coll, coll_index);
>
>   	osdc = &rbd_dev->rbd_client->client->osdc;
> -	req = ceph_osdc_alloc_request(osdc, flags, snapc, ops,
> +	osd_req = ceph_osdc_alloc_request(osdc, flags, snapc, ops,
>   					false, GFP_NOIO, pages, bio);
> -	if (!req) {
> +	if (!osd_req) {
>   		ret = -ENOMEM;
>   		goto done_pages;
>   	}
>
> -	req->r_callback = rbd_cb;
> +	osd_req->r_callback = rbd_cb;
>
>   	rbd_req->rq = rq;
>   	rbd_req->bio = bio;
>   	rbd_req->pages = pages;
>   	rbd_req->len = len;
>
> -	req->r_priv = rbd_req;
> +	osd_req->r_priv = rbd_req;
>
> -	reqhead = req->r_request->front.iov_base;
> +	reqhead = osd_req->r_request->front.iov_base;
>   	reqhead->snapid = cpu_to_le64(CEPH_NOSNAP);
>
> -	strncpy(req->r_oid, object_name, sizeof(req->r_oid));
> -	req->r_oid_len = strlen(req->r_oid);
> +	strncpy(osd_req->r_oid, object_name, sizeof(osd_req->r_oid));
> +	osd_req->r_oid_len = strlen(osd_req->r_oid);
>
> -	layout = &req->r_file_layout;
> +	layout = &osd_req->r_file_layout;
>   	memset(layout, 0, sizeof(*layout));
>   	layout->fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
>   	layout->fl_stripe_count = cpu_to_le32(1);
>   	layout->fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
>   	layout->fl_pg_pool = cpu_to_le32((int) rbd_dev->spec->pool_id);
>   	ret = ceph_calc_raw_layout(osdc, layout, snapid, ofs, &len, &bno,
> -				   req, ops);
> +				   osd_req, ops);
>   	rbd_assert(ret == 0);
>
> -	ceph_osdc_build_request(req, ofs, &len,
> +	ceph_osdc_build_request(osd_req, ofs, &len,
>   				ops,
>   				snapc,
>   				&mtime,
> -				req->r_oid, req->r_oid_len);
> +				osd_req->r_oid, osd_req->r_oid_len);
>
>   	if (linger_req) {
> -		ceph_osdc_set_request_linger(osdc, req);
> -		*linger_req = req;
> +		ceph_osdc_set_request_linger(osdc, osd_req);
> +		*linger_req = osd_req;
>   	}
>
> -	ret = ceph_osdc_start_request(osdc, req, false);
> +	ret = ceph_osdc_start_request(osdc, osd_req, false);
>   	if (ret < 0)
>   		goto done_err;
>
>   	if (!rbd_cb) {
> -		ret = ceph_osdc_wait_request(osdc, req);
> +		u64 version;
> +
> +		ret = ceph_osdc_wait_request(osdc, osd_req);
> +		version = le64_to_cpu(osd_req->r_reassert_version.version);
>   		if (ver)
> -			*ver = le64_to_cpu(req->r_reassert_version.version);
> -		dout("reassert_ver=%llu\n",
> -			(unsigned long long)
> -				le64_to_cpu(req->r_reassert_version.version));
> -		ceph_osdc_put_request(req);
> +			*ver = version;
> +		dout("reassert_ver=%llu\n", (unsigned long long) version);
> +		ceph_osdc_put_request(osd_req);
>   	}
>   	return ret;
>
>   done_err:
>   	bio_chain_put(rbd_req->bio);
> -	ceph_osdc_put_request(req);
> +	ceph_osdc_put_request(osd_req);
>   done_pages:
>   	rbd_coll_end_req(rbd_req, ret, len);
>   	kfree(rbd_req);
> @@ -1213,9 +1214,9 @@ done_pages:
>   /*
>    * Ceph osd op callback
>    */
> -static void rbd_req_cb(struct ceph_osd_request *req, struct ceph_msg *msg)
> +static void rbd_req_cb(struct ceph_osd_request *osd_req, struct
> ceph_msg *msg)
>   {
> -	struct rbd_request *rbd_req = req->r_priv;
> +	struct rbd_request *rbd_req = osd_req->r_priv;
>   	struct ceph_osd_reply_head *replyhead;
>   	struct ceph_osd_op *op;
>   	__s32 rc;
> @@ -1246,13 +1247,14 @@ static void rbd_req_cb(struct ceph_osd_request
> *req, struct ceph_msg *msg)
>   	if (rbd_req->bio)
>   		bio_chain_put(rbd_req->bio);
>
> -	ceph_osdc_put_request(req);
> +	ceph_osdc_put_request(osd_req);
>   	kfree(rbd_req);
>   }
>
> -static void rbd_simple_req_cb(struct ceph_osd_request *req, struct
> ceph_msg *msg)
> +static void rbd_simple_req_cb(struct ceph_osd_request *osd_req,
> +				struct ceph_msg *msg)
>   {
> -	ceph_osdc_put_request(req);
> +	ceph_osdc_put_request(osd_req);
>   }
>
>   /*
>
