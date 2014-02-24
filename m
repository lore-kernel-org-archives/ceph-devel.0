From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/6] libceph: encode CEPH_OSD_OP_FLAG_* op flags
Date: Mon, 24 Feb 2014 08:58:58 -0600
Message-ID: <530B5E32.4040405@ieee.org>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com> <1393008946-7931-2-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:41160 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbaBXO64 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 09:58:56 -0500
Received: by mail-ie0-f179.google.com with SMTP id to1so3392394ieb.24
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 06:58:56 -0800 (PST)
In-Reply-To: <1393008946-7931-2-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
> Encode ceph_osd_op::flags field so that it gets sent over the wire.

This looks fine.  The flags field was never being encoded
before, so there's no change in the protocol.  And you're
just adding a flags field to the local structure.

Reviewed-by: Alex Elder <elder@linaro.org>


> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/osd_client.h |    1 +
>  include/linux/ceph/rados.h      |    2 +-
>  net/ceph/osd_client.c           |    2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index fd47e872ebcc..e94f5da251d6 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -76,6 +76,7 @@ struct ceph_osd_data {
>  
>  struct ceph_osd_req_op {
>  	u16 op;           /* CEPH_OSD_OP_* */
> +	u32 flags;        /* CEPH_OSD_OP_FLAG_* */
>  	u32 payload_len;
>  	union {
>  		struct ceph_osd_data raw_data_in;
> diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
> index 96292df4041b..8f9bf4570215 100644
> --- a/include/linux/ceph/rados.h
> +++ b/include/linux/ceph/rados.h
> @@ -382,7 +382,7 @@ enum {
>   */
>  struct ceph_osd_op {
>  	__le16 op;           /* CEPH_OSD_OP_* */
> -	__le32 flags;        /* CEPH_OSD_FLAG_* */
> +	__le32 flags;        /* CEPH_OSD_OP_FLAG_* */
>  	union {
>  		struct {
>  			__le64 offset, length;
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 0676f2b199d6..5d7fd0b8c1c8 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -688,7 +688,9 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
>  
>  		return 0;
>  	}
> +
>  	dst->op = cpu_to_le16(src->op);
> +	dst->flags = cpu_to_le32(src->flags);
>  	dst->payload_len = cpu_to_le32(src->payload_len);
>  
>  	return request_data_len;
> 

