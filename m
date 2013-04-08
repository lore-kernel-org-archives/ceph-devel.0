From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 13/20] rbd: separate initialization of osd data
Date: Mon, 08 Apr 2013 11:14:40 -0700
Message-ID: <51630910.2020302@inktank.com>
References: <515ED849.9060901@inktank.com> <515ED9F7.3070908@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:42465 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935289Ab3DHSPK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 14:15:10 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so2733428dae.37
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 11:15:09 -0700 (PDT)
In-Reply-To: <515ED9F7.3070908@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:04 AM, Alex Elder wrote:
> The osd data for a request is currently initialized inside
> rbd_osd_req_create(), but that assumes an object request's data
> belongs in the osd request's data in or data out field.
>
> There are only three places where requests with data are set up, and
> it turns out it's easier to call just the osd data init routines
> directly there rather than handling it in rbd_osd_req_create().
>
> (The real motivation here is moving toward getting rid of the
> osd request in and out data fields.)
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   27 ++++++++-------------------
>   1 file changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3b90283..1cd776b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1344,8 +1344,6 @@ static struct ceph_osd_request *rbd_osd_req_create(
>   	struct ceph_snap_context *snapc = NULL;
>   	struct ceph_osd_client *osdc;
>   	struct ceph_osd_request *osd_req;
> -	struct ceph_osd_data *osd_data;
> -	u64 offset = obj_request->offset;
>
>   	if (img_request) {
>   		rbd_assert(img_request->write_request == write_request);
> @@ -1359,23 +1357,6 @@ static struct ceph_osd_request *rbd_osd_req_create(
>   	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_ATOMIC);
>   	if (!osd_req)
>   		return NULL;	/* ENOMEM */
> -	osd_data = write_request ? &osd_req->r_data_out : &osd_req->r_data_in;
> -
> -	rbd_assert(obj_request_type_valid(obj_request->type));
> -	switch (obj_request->type) {
> -	case OBJ_REQUEST_NODATA:
> -		break;		/* Nothing to do */
> -	case OBJ_REQUEST_BIO:
> -		rbd_assert(obj_request->bio_list != NULL);
> -		ceph_osd_data_bio_init(osd_data, obj_request->bio_list,
> -					obj_request->length);
> -		break;
> -	case OBJ_REQUEST_PAGES:
> -		ceph_osd_data_pages_init(osd_data, obj_request->pages,
> -				obj_request->length, offset & ~PAGE_MASK,
> -				false, false);
> -		break;
> -	}
>
>   	if (write_request)
>   		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
> @@ -1596,6 +1577,8 @@ static int rbd_img_request_fill_bio(struct
> rbd_img_request *img_request,
>   					 : &osd_req->r_data_in;
>   		osd_req_op_extent_init(osd_req, 0, opcode, offset, length,
>   						0, 0);
> +		ceph_osd_data_bio_init(osd_data, obj_request->bio_list,
> +					obj_request->length);
>   		osd_req_op_extent_osd_data(osd_req, 0, osd_data);
>   		rbd_osd_req_format(obj_request, write_request);
>
> @@ -1873,6 +1856,8 @@ static int rbd_obj_method_sync(struct rbd_device
> *rbd_dev,
>   	osd_req_op_cls_init(obj_request->osd_req, 0, CEPH_OSD_OP_CALL,
>   					class_name, method_name,
>   					outbound, outbound_size);
> +	ceph_osd_data_pages_init(osd_data, obj_request->pages, 0, 0,
> +					false, false);
>   	osd_req_op_cls_response_data(obj_request->osd_req, 0, osd_data);
>   	rbd_osd_req_format(obj_request, false);
>
> @@ -2081,6 +2066,10 @@ static int rbd_obj_read_sync(struct rbd_device
> *rbd_dev,
>   	osd_data = &obj_request->osd_req->r_data_in;
>   	osd_req_op_extent_init(obj_request->osd_req, 0, CEPH_OSD_OP_READ,
>   					offset, length, 0, 0);
> +	ceph_osd_data_pages_init(osd_data, obj_request->pages,
> +					obj_request->length,
> +					obj_request->offset & ~PAGE_MASK,
> +					false, false);
>   	osd_req_op_extent_osd_data(obj_request->osd_req, 0, osd_data);
>   	rbd_osd_req_format(obj_request, false);
>

