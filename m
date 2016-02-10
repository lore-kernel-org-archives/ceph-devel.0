From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 1/4] libceph: rename ceph_osd_req_op::payload_len to indata_len
Date: Wed, 10 Feb 2016 20:12:53 +0800
Message-ID: <ECB21F3B-8AFE-4C00-A4C4-08C90D51ED4D@redhat.com>
References: <1455103447-23559-1-git-send-email-idryomov@gmail.com> <1455103447-23559-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42968 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbcBJMNA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 07:13:00 -0500
In-Reply-To: <1455103447-23559-2-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org


> On Feb 10, 2016, at 19:24, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> Follow userspace nomenclature on this - the next commit adds
> outdata_len.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
> include/linux/ceph/osd_client.h |  2 +-
> net/ceph/osd_client.c           | 12 ++++++------
> 2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 7506b485bb6d..35c8b006916f 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -77,7 +77,7 @@ struct ceph_osd_data {
> struct ceph_osd_req_op {
> 	u16 op;           /* CEPH_OSD_OP_* */
> 	u32 flags;        /* CEPH_OSD_OP_FLAG_* */
> -	u32 payload_len;
> +	u32 indata_len;   /* request */
> 	union {
> 		struct ceph_osd_data raw_data_in;
> 		struct {
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index a1babb77b813..38bdfafe9dd6 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -498,7 +498,7 @@ void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
> 	if (opcode == CEPH_OSD_OP_WRITE || opcode == CEPH_OSD_OP_WRITEFULL)
> 		payload_len += length;
> 
> -	op->payload_len = payload_len;
> +	op->indata_len = payload_len;
> }
> EXPORT_SYMBOL(osd_req_op_extent_init);
> 
> @@ -517,7 +517,7 @@ void osd_req_op_extent_update(struct ceph_osd_request *osd_req,
> 	BUG_ON(length > previous);
> 
> 	op->extent.length = length;
> -	op->payload_len -= previous - length;
> +	op->indata_len -= previous - length;
> }
> EXPORT_SYMBOL(os_req_op_extent_update);

this does not seem correct. os_req_op_extent_update() is used for both read and write.

 
> 
> @@ -554,7 +554,7 @@ void osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
> 
> 	op->cls.argc = 0;	/* currently unused */
> 
> -	op->payload_len = payload_len;
> +	op->indata_len = payload_len;
> }
> EXPORT_SYMBOL(osd_req_op_cls_init);
> 
> @@ -587,7 +587,7 @@ int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
> 	op->xattr.cmp_mode = cmp_mode;
> 
> 	ceph_osd_data_pagelist_init(&op->xattr.osd_data, pagelist);
> -	op->payload_len = payload_len;
> +	op->indata_len = payload_len;
> 	return 0;
> }
> EXPORT_SYMBOL(osd_req_op_xattr_init);
> @@ -707,7 +707,7 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
> 			BUG_ON(osd_data->type == CEPH_OSD_DATA_TYPE_NONE);
> 			dst->cls.indata_len = cpu_to_le32(data_length);
> 			ceph_osdc_msg_data_add(req->r_request, osd_data);
> -			src->payload_len += data_length;
> +			src->indata_len += data_length;
> 			request_data_len += data_length;
> 		}
> 		osd_data = &src->cls.response_data;
> @@ -750,7 +750,7 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
> 
> 	dst->op = cpu_to_le16(src->op);
> 	dst->flags = cpu_to_le32(src->flags);
> -	dst->payload_len = cpu_to_le32(src->payload_len);
> +	dst->payload_len = cpu_to_le32(src->indata_len);
> 
> 	return request_data_len;
> }
> -- 
> 2.4.3
> 

