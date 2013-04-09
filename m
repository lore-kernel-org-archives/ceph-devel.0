From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 6/6] libceph: add, don't set data for a message
Date: Mon, 08 Apr 2013 17:11:38 -0700
Message-ID: <51635CBA.7020909@inktank.com>
References: <515F4F01.2000704@inktank.com> <515F4FA6.8020209@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:57465 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761961Ab3DIAMF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 20:12:05 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so3459312pab.8
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 17:12:04 -0700 (PDT)
In-Reply-To: <515F4FA6.8020209@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 03:26 PM, Alex Elder wrote:
> Change the names of the functions that put data on a pagelist to
> reflect that we're adding to whatever's already there rather than
> just setting it to the one thing.  Currently only one data item is
> ever added to a message, but that's about to change.
>
> This resolves:
>      http://tracker.ceph.com/issues/2770
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   fs/ceph/mds_client.c           |    4 ++--
>   include/linux/ceph/messenger.h |    6 +++---
>   net/ceph/messenger.c           |   12 ++++++------
>   net/ceph/osd_client.c          |   16 ++++++++--------
>   4 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index c07ab3c..15c265c 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1724,7 +1724,7 @@ static struct ceph_msg
> *create_request_message(struct ceph_mds_client *mdsc,
>   	if (req->r_data_len) {
>   		/* outbound data set only by ceph_sync_setxattr() */
>   		BUG_ON(!req->r_pages);
> -		ceph_msg_data_set_pages(msg, req->r_pages, req->r_data_len, 0);
> +		ceph_msg_data_add_pages(msg, req->r_pages, req->r_data_len, 0);
>   	}
>
>   	msg->hdr.data_len = cpu_to_le32(req->r_data_len);
> @@ -2608,7 +2608,7 @@ static void send_mds_reconnect(struct
> ceph_mds_client *mdsc,
>   	if (pagelist->length) {
>   		/* set up outbound data if we have any */
>   		reply->hdr.data_len = cpu_to_le32(pagelist->length);
> -		ceph_msg_data_set_pagelist(reply, pagelist);
> +		ceph_msg_data_add_pagelist(reply, pagelist);
>   	}
>   	ceph_con_send(&session->s_con, reply);
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index de1d2e1..7c1420b 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -275,12 +275,12 @@ extern void ceph_msg_revoke_incoming(struct
> ceph_msg *msg);
>
>   extern void ceph_con_keepalive(struct ceph_connection *con);
>
> -extern void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page
> **pages,
> +extern void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page
> **pages,
>   				size_t length, size_t alignment);
> -extern void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
> +extern void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
>   				struct ceph_pagelist *pagelist);
>   #ifdef CONFIG_BLOCK
> -extern void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio,
> +extern void ceph_msg_data_add_bio(struct ceph_msg *msg, struct bio *bio,
>   				size_t length);
>   #endif /* CONFIG_BLOCK */
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 3f78944..c46c4df 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -3003,7 +3003,7 @@ static void ceph_msg_data_destroy(struct
> ceph_msg_data *data)
>   	kfree(data);
>   }
>
> -void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page **pages,
> +void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
>   		size_t length, size_t alignment)
>   {
>   	struct ceph_msg_data *data;
> @@ -3023,9 +3023,9 @@ void ceph_msg_data_set_pages(struct ceph_msg *msg,
> struct page **pages,
>   	list_add_tail(&data->links, &msg->data);
>   	msg->data_length += length;
>   }
> -EXPORT_SYMBOL(ceph_msg_data_set_pages);
> +EXPORT_SYMBOL(ceph_msg_data_add_pages);
>
> -void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
> +void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
>   				struct ceph_pagelist *pagelist)
>   {
>   	struct ceph_msg_data *data;
> @@ -3042,10 +3042,10 @@ void ceph_msg_data_set_pagelist(struct ceph_msg
> *msg,
>   	list_add_tail(&data->links, &msg->data);
>   	msg->data_length += pagelist->length;
>   }
> -EXPORT_SYMBOL(ceph_msg_data_set_pagelist);
> +EXPORT_SYMBOL(ceph_msg_data_add_pagelist);
>
>   #ifdef	CONFIG_BLOCK
> -void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio,
> +void ceph_msg_data_add_bio(struct ceph_msg *msg, struct bio *bio,
>   		size_t length)
>   {
>   	struct ceph_msg_data *data;
> @@ -3062,7 +3062,7 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
> struct bio *bio,
>   	list_add_tail(&data->links, &msg->data);
>   	msg->data_length += length;
>   }
> -EXPORT_SYMBOL(ceph_msg_data_set_bio);
> +EXPORT_SYMBOL(ceph_msg_data_add_bio);
>   #endif	/* CONFIG_BLOCK */
>
>   /*
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2562e4e..7322785 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -550,7 +550,7 @@ void osd_req_op_watch_init(struct ceph_osd_request
> *osd_req,
>   }
>   EXPORT_SYMBOL(osd_req_op_watch_init);
>
> -static void ceph_osdc_msg_data_set(struct ceph_msg *msg,
> +static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
>   				struct ceph_osd_data *osd_data)
>   {
>   	u64 length = ceph_osd_data_length(osd_data);
> @@ -558,14 +558,14 @@ static void ceph_osdc_msg_data_set(struct ceph_msg
> *msg,
>   	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
>   		BUG_ON(length > (u64) SIZE_MAX);
>   		if (length)
> -			ceph_msg_data_set_pages(msg, osd_data->pages,
> +			ceph_msg_data_add_pages(msg, osd_data->pages,
>   					length, osd_data->alignment);
>   	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
>   		BUG_ON(!length);
> -		ceph_msg_data_set_pagelist(msg, osd_data->pagelist);
> +		ceph_msg_data_add_pagelist(msg, osd_data->pagelist);
>   #ifdef CONFIG_BLOCK
>   	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
> -		ceph_msg_data_set_bio(msg, osd_data->bio, length);
> +		ceph_msg_data_add_bio(msg, osd_data->bio, length);
>   #endif
>   	} else {
>   		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
> @@ -600,18 +600,18 @@ static u64 osd_req_encode_op(struct
> ceph_osd_request *req,
>   		dst->extent.truncate_seq =
>   			cpu_to_le32(src->extent.truncate_seq);
>   		if (src->op == CEPH_OSD_OP_WRITE)
> -			ceph_osdc_msg_data_set(req->r_request,
> +			ceph_osdc_msg_data_add(req->r_request,
>   						&src->extent.osd_data);
>   		else
> -			ceph_osdc_msg_data_set(req->r_reply,
> +			ceph_osdc_msg_data_add(req->r_reply,
>   						&src->extent.osd_data);
>   		break;
>   	case CEPH_OSD_OP_CALL:
>   		dst->cls.class_len = src->cls.class_len;
>   		dst->cls.method_len = src->cls.method_len;
>   		dst->cls.indata_len = cpu_to_le32(src->cls.request_data_len);
> -		ceph_osdc_msg_data_set(req->r_reply, &src->cls.response_data);
> -		ceph_osdc_msg_data_set(req->r_request, &src->cls.request_info);
> +		ceph_osdc_msg_data_add(req->r_reply, &src->cls.response_data);
> +		ceph_osdc_msg_data_add(req->r_request, &src->cls.request_info);
>   		BUG_ON(src->cls.request_info.type !=
>   					CEPH_OSD_DATA_TYPE_PAGELIST);
>   		request_data_len = src->cls.request_info.pagelist->length;
>

