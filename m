From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST] rbd: separate layout init
Date: Wed, 16 Jan 2013 14:58:37 -0800
Message-ID: <50F7309D.5080208@inktank.com>
References: <50E60C49.3020207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:40406 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757773Ab3APW6k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 17:58:40 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so1062058pad.32
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 14:58:39 -0800 (PST)
In-Reply-To: <50E60C49.3020207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 02:55 PM, Alex Elder wrote:
> Pull a block of code that initializes the layout structure in an osd
> request into its own function so it can be reused.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   drivers/block/rbd.c |   23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index fd6a708..8e030d1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -54,6 +54,7 @@
>
>   /* It might be useful to have this defined elsewhere too */
>
> +#define	U32_MAX	((u32) (~0U))
>   #define	U64_MAX	((u64) (~0ULL))
>
>   #define RBD_DRV_NAME "rbd"
> @@ -1096,6 +1097,16 @@ static void rbd_coll_end_req(struct rbd_request
> *rbd_req,
>   				ret, len);
>   }
>
> +static void rbd_layout_init(struct ceph_file_layout *layout, u64 pool_id)
> +{
> +	memset(layout, 0, sizeof (*layout));
> +	layout->fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
> +	layout->fl_stripe_count = cpu_to_le32(1);
> +	layout->fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
> +	rbd_assert(pool_id <= (u64) U32_MAX);
> +	layout->fl_pg_pool = cpu_to_le32((u32) pool_id);
> +}
> +
>   /*
>    * Send ceph osd request
>    */
> @@ -1117,7 +1128,6 @@ static int rbd_do_request(struct request *rq,
>   			  u64 *ver)
>   {
>   	struct ceph_osd_request *osd_req;
> -	struct ceph_file_layout *layout;
>   	int ret;
>   	u64 bno;
>   	struct timespec mtime = CURRENT_TIME;
> @@ -1161,14 +1171,9 @@ static int rbd_do_request(struct request *rq,
>   	strncpy(osd_req->r_oid, object_name, sizeof(osd_req->r_oid));
>   	osd_req->r_oid_len = strlen(osd_req->r_oid);
>
> -	layout = &osd_req->r_file_layout;
> -	memset(layout, 0, sizeof(*layout));
> -	layout->fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
> -	layout->fl_stripe_count = cpu_to_le32(1);
> -	layout->fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
> -	layout->fl_pg_pool = cpu_to_le32((int) rbd_dev->spec->pool_id);
> -	ret = ceph_calc_raw_layout(osdc, layout, snapid, ofs, &len, &bno,
> -				   osd_req, ops);
> +	rbd_layout_init(&osd_req->r_file_layout, rbd_dev->spec->pool_id);
> +	ret = ceph_calc_raw_layout(osdc, &osd_req->r_file_layout,
> +				snapid, ofs, &len, &bno, osd_req, ops);
>   	rbd_assert(ret == 0);
>
>   	ceph_osdc_build_request(osd_req, ofs, &len,
>

