From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 02/20] libceph: compute incoming bytes once
Date: Fri, 05 Apr 2013 11:14:10 -0700
Message-ID: <515F1472.8030804@inktank.com>
References: <515ED849.9060901@inktank.com> <515ED937.5080509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34265 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162306Ab3DESOb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 14:14:31 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so2173466pab.10
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 11:14:31 -0700 (PDT)
In-Reply-To: <515ED937.5080509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 07:01 AM, Alex Elder wrote:
> This is a simple change, extracting the number of incoming data
> bytes just once in handle_reply().
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/osd_client.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 426ca1f..1379b33 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1293,6 +1293,7 @@ static void handle_reply(struct ceph_osd_client
> *osdc, struct ceph_msg *msg,
>   	u64 reassert_version;
>   	u32 osdmap_epoch;
>   	int already_completed;
> +	u32 bytes;
>   	int i;
>
>   	tid = le64_to_cpu(msg->hdr.tid);
> @@ -1347,9 +1348,10 @@ static void handle_reply(struct ceph_osd_client
> *osdc, struct ceph_msg *msg,
>   		payload_len += len;
>   		p += sizeof(*op);
>   	}
> -	if (payload_len != le32_to_cpu(msg->hdr.data_len)) {
> +	bytes = le32_to_cpu(msg->hdr.data_len);
> +	if (payload_len != bytes) {
>   		pr_warning("sum of op payload lens %d != data_len %d",
> -			   payload_len, le32_to_cpu(msg->hdr.data_len));
> +			   payload_len, bytes);
>   		goto bad_put;
>   	}
>
> @@ -1359,10 +1361,8 @@ static void handle_reply(struct ceph_osd_client
> *osdc, struct ceph_msg *msg,
>   		req->r_reply_op_result[i] = ceph_decode_32(&p);
>
>   	if (!req->r_got_reply) {
> -		unsigned int bytes;
>
>   		req->r_result = result;
> -		bytes = le32_to_cpu(msg->hdr.data_len);
>   		dout("handle_reply result %d bytes %d\n", req->r_result,
>   		     bytes);
>   		if (req->r_result == 0)
>

