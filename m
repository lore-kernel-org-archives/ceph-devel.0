From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 2/3] rbd: combine object method calls in header refresh
 using fewer ceph_msgs
Date: Fri, 24 Apr 2015 05:14:00 -0500
Message-ID: <553A1768.1060300@redhat.com>
References: <cover.1429814290.git.dfuller@redhat.com> <f3f943be6265506edcbee5b634ce49c4323ecd15.1429814290.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42475 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbbDXKOC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Apr 2015 06:14:02 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3OAE29C023663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2015 06:14:02 -0400
In-Reply-To: <f3f943be6265506edcbee5b634ce49c4323ecd15.1429814290.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, ceph-devel@vger.kernel.org

On 04/23/2015 02:06 PM, Douglas Fuller wrote:
> Signed-off-by: Douglas Fuller <douglas.fuller@gmail.com>
> ---
>  drivers/block/rbd.c             | 337 ++++++++++++++++++++++++++++++++++++----
>  include/linux/ceph/osd_client.h |   2 +-
>  2 files changed, 312 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8125233..63771f6 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4577,6 +4577,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
>  				"rbd", "get_snapcontext", NULL, 0,
>  				reply_buf, size);
>  	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
> +printk(KERN_INFO "%s: rbd_obj_method_sync returned %d\n", __func__, ret);

You probably forgot to remove that debug printk.

>  	if (ret < 0)
>  		goto out;
>  
> @@ -4667,20 +4668,23 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
>  	bool first_time = rbd_dev->header.object_prefix == NULL;
>  	int ret;
>  
> -	ret = rbd_dev_v2_image_size(rbd_dev);
> -	if (ret)
> -		return ret;
> +	if (!first_time)
> +	{

You want to follow the coding style in the existing code or follow the
style in Documentation/CodingStyle. The {} use in your if/elses do not
follow either one.

> +		ret = rbd_dev_v2_image_size(rbd_dev);
> +		if (ret)
> +			return ret;
>  
> -	if (first_time) {
> +		ret = rbd_dev_v2_snap_context(rbd_dev);
> +		dout("rbd_dev_v2_snap_context returned %d\n", ret);
> +		return ret;
> +	}
> +	else
> +	{
>  		ret = rbd_dev_v2_header_onetime(rbd_dev);
>  		if (ret)
>  			return ret;
>  	}
> -
> -	ret = rbd_dev_v2_snap_context(rbd_dev);
> -	dout("rbd_dev_v2_snap_context returned %d\n", ret);
> -
> -	return ret;
> +	return ret; /* XXX change logic? */
>  }
>  
>  static int rbd_dev_header_info(struct rbd_device *rbd_dev)
> @@ -5091,36 +5095,317 @@ static void rbd_dev_unprobe(struct rbd_device *rbd_dev)
>  	memset(header, 0, sizeof (*header));
>  }
>  
> -static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev)
> +static struct ceph_osd_request * rbd_obj_header_req_alloc(
> +		struct rbd_device *rbd_dev,
> +		int num_ops)
> +{
> +	struct ceph_osd_request *osd_req;
> +	struct page ***replies;
> +	
> +	replies = kmalloc(CEPH_OSD_MAX_OP * sizeof(*replies), GFP_KERNEL);
> +	if (!replies)
> +		return NULL;
> +
> +	osd_req = ceph_osdc_alloc_request(&rbd_dev->rbd_client->client->osdc,
> +		NULL, num_ops, false, GFP_ATOMIC);

I think you can just use GFP_KERNEL here. You used it above and it looks
like we have process context and are not under any locks.

You might have to use GFP_NOIO if we think that these functions are
called from the watch_cb for something like a resize and we need to
update the rbd_dev's size before we can execute IO. I do not think that
is the case though, so I think GFP_KERNEL is ok.


> +	if (!osd_req)
> +	{
> +		kfree(replies);
> +		return NULL;
> +	}
> +
> +	osd_req->r_flags = CEPH_OSD_FLAG_READ;
> +	osd_req->r_base_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->layout);
> +	osd_req->r_priv = (void *)replies;

No need to cast to a void pointer.

> +	ceph_oid_set_name(&osd_req->r_base_oid, rbd_dev->header_name);
> +
> +	return osd_req;
> +}
> +
> +static int rbd_obj_header_method_add(struct ceph_osd_request *osd_req,
> +		int which,
> +		const char *class_name,
> +		const char *method_name,
> +		const void *outbound,
> +		size_t outbound_size,
> +		size_t inbound_size)

I think you want to follow the existing code's tab style for function
arguments.

> +{
> +	u32 page_count;
> +	struct page ***replies = (struct page ***)osd_req->r_priv;

Don't need to cast from a void pointer.

> +
> +	BUG_ON(which >= osd_req->r_num_ops);
> +
> +	osd_req_op_cls_init(osd_req, which, CEPH_OSD_OP_CALL,
> +		class_name, method_name);
> +
> +	if (outbound_size)
> +	{
> +		struct ceph_pagelist *pagelist;
> +		pagelist = kmalloc(sizeof(*pagelist), GFP_NOFS);

I think you can use GFP_KERNEL here. You used it below.

If you cannot use GFP_KERNEL, then you really want to be using GFP_NOIO
instead of GFP_NOFS.

> +		/* XXX is this ever freed? */
> +		if (!pagelist)
> +			return -ENOMEM;
> +
> +		ceph_pagelist_init(pagelist);
> +		ceph_pagelist_append(pagelist, outbound, outbound_size);
> +		osd_req_op_cls_request_data_pagelist(osd_req, which, pagelist);
> +	}
> +
> +	page_count = (u32)calc_pages_for(0, inbound_size);
> +	replies[which] = ceph_alloc_page_vector(page_count, GFP_KERNEL);
> +	if (IS_ERR(replies[which]))
> +		return PTR_ERR(replies[which]);
> +	osd_req_op_cls_response_data_pages(osd_req, which, replies[which],
> +		inbound_size, 0, false, false);
> +
> +	return 0;
> +}
> +
> +static int rbd_obj_header_req_exec(struct rbd_device * rbd_dev,
> +		struct ceph_osd_request *osd_req)
>  {
>  	int ret;
>  
> -	ret = rbd_dev_v2_object_prefix(rbd_dev);
> +	ceph_osdc_build_request(osd_req, 0, NULL, cpu_to_le64(CEPH_NOSNAP), NULL);
> +	ret = ceph_osdc_start_request(&rbd_dev->rbd_client->client->osdc,
> +		osd_req, false);
>  	if (ret)
> +	{
> +		ceph_osdc_put_request(osd_req);
> +		return ret;
> +	}
> +
> +	ret = ceph_osdc_wait_request(&rbd_dev->rbd_client->client->osdc, osd_req);
> +	if (ret < 0)
> +	{
> +		ceph_osdc_cancel_request(osd_req);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rbd_obj_header_method_retrieve(struct ceph_osd_request *osd_req,
> +		int which, void *buf, size_t length)
> +{
> +	struct page ***replies = (struct page ***)osd_req->r_priv;
> +	size_t reply_length = osd_req->r_reply_op_len[which];
> +
> +	BUG_ON(reply_length > length);
> +
> +	ceph_copy_from_page_vector(replies[which], buf, 0, reply_length);
> +	ceph_release_page_vector(replies[which], calc_pages_for(0, reply_length));
> +
> +	return reply_length;
> +}
> +
> +static void rbd_obj_header_req_destroy(struct ceph_osd_request *osd_req)
> +{
> +	if (osd_req)
> +	{
> +		kfree(osd_req->r_priv);
> +		ceph_osdc_put_request(osd_req);
> +	}
> +}
> +
> +static int __extract_prefix(struct rbd_device *rbd_dev,
> +		struct ceph_osd_request *osd_req,
> +		int which)
> +{
> +	void *prefix_buf;
> +	void * p;
> +	size_t prefix_buflen;
> +	int ret;
> +
> +	prefix_buf = kzalloc(RBD_OBJ_PREFIX_LEN_MAX, GFP_KERNEL);
> +	if (!prefix_buf)
> +		return -ENOMEM;
> +
> +	prefix_buflen = rbd_obj_header_method_retrieve(osd_req, which,
> +		prefix_buf, RBD_OBJ_PREFIX_LEN_MAX);
> +	p = prefix_buf;
> +	rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
> +		p + prefix_buflen, NULL, GFP_NOIO);

I think this can be GFP_KERNEL like above.

> +
> +	if (IS_ERR(rbd_dev->header.object_prefix))
> +	{
> +		ret = PTR_ERR(rbd_dev->header.object_prefix);
> +		rbd_dev->header.object_prefix = NULL;
>  		goto out_err;
> +	}
>  
> -	/*
> -	 * Get the and check features for the image.  Currently the
> -	 * features are assumed to never change.
> -	 */
> -	ret = rbd_dev_v2_features(rbd_dev);
> -	if (ret)
> +	ret = 0;
> +
> +out_err:
> +	kfree(prefix_buf);
> +	return ret;
> +}
> +
> +static int __extract_features(struct rbd_device *rbd_dev,
> +		struct ceph_osd_request *osd_req,
> +		int which)
> +{
> +	int ret;
> +	struct
> +	{
> +		__le64 features;
> +		__le64 incompat;
> +	} __attribute__((packed)) features_buf = { 0 };
> +	u64 incompat;
> +
> +	rbd_obj_header_method_retrieve(osd_req, which,
> +		&features_buf, sizeof(features_buf));
> +	incompat = le64_to_cpu(features_buf.incompat);
> +	if (incompat & ~RBD_FEATURES_SUPPORTED)
> +	{
> +		ret = -ENXIO;
>  		goto out_err;
> +	}
> +	rbd_dev->header.features = le64_to_cpu(features_buf.features);
>  
> -	/* If the image supports fancy striping, get its parameters */
> +	ret = 0;
>  
> -	if (rbd_dev->header.features & RBD_FEATURE_STRIPINGV2) {
> -		ret = rbd_dev_v2_striping_info(rbd_dev);
> -		if (ret < 0)
> -			goto out_err;
> +out_err:
> +	return ret;
> +}
> +
> +static int __extract_snapcontext(struct rbd_device *rbd_dev,
> +		struct ceph_osd_request *osd_req,
> +		int which)
> +{
> +	void *snapc_buf;
> +	size_t snapc_max;
> +	size_t snapc_buflen;
> +
> +	void *p;
> +	void *q;
> +
> +	struct ceph_snap_context * snapc;
> +
> +	u32 seq;
> +	u32 snap_count;
> +
> +	int i;
> +	int ret;
> +
> +	snapc_max = sizeof(__le64) + sizeof(__le32) +
> +		RBD_MAX_SNAP_COUNT * sizeof(__le64);
> +
> +	snapc_buf = kzalloc(snapc_max, GFP_KERNEL);
> +	BUG_ON(!snapc_buf);

Why a BUG_ON for a allocation failure?

> +
> +	snapc_buflen = rbd_obj_header_method_retrieve(osd_req, which,
> +		snapc_buf, snapc_max);
> +
> +	p = snapc_buf;
> +	q = snapc_buf + snapc_buflen;
> +	ret = -ERANGE;
> +	ceph_decode_64_safe(&p, q, seq, out_err);
> +	ceph_decode_32_safe(&p, q, snap_count, out_err);
> +
> +	if (snap_count > (SIZE_MAX - sizeof(struct ceph_snap_context)) /
> +		sizeof(u64))
> +	{
> +		ret = -EINVAL;
> +		goto out_err;
>  	}
> -	/* No support for crypto and compression type format 2 images */
> +	if (!ceph_has_room(&p, q, snap_count * sizeof(__le64)))
> +		goto out_err;
> +
> +	snapc = ceph_create_snap_context(snap_count, GFP_KERNEL);
> +	BUG_ON(!snapc);

Again why a BUG_ON?

I think it is best to handle it gracefully. There is no need to kill the
box for a allocation failure.
