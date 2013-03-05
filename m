From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: complete lingering requests only once
Date: Mon, 04 Mar 2013 17:36:51 -0800
Message-ID: <51354C33.8000206@inktank.com>
References: <512F6C7F.4030805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:45272 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694Ab3CEBhX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 20:37:23 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so3671454pbc.26
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 17:37:23 -0800 (PST)
In-Reply-To: <512F6C7F.4030805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 02/28/2013 06:41 AM, Alex Elder wrote:
> An osd request marked to linger will be re-submitted in the event
> a connection to the target osd gets dropped.  Currently, if there
> is a callback function associated with a request it will be called
> each time a request is submitted--which for lingering requests can
> be more than once.
>
> Change it so a request--including lingering ones--will get completed
> (from the perspective of the user of the osd client) exactly once.
>
> This resolves:
>      http://tracker.ceph.com/issues/3967
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/osd_client.h |    1 +
>   net/ceph/osd_client.c           |    5 +++++
>   2 files changed, 6 insertions(+)
>
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index 1dd5d46..a79f833 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -85,6 +85,7 @@ struct ceph_osd_request {
>   	s32               r_reply_op_result[CEPH_OSD_MAX_OP];
>   	int               r_got_reply;
>   	int		  r_linger;
> +	int		  r_completed;
>
>   	struct ceph_osd_client *r_osdc;
>   	struct kref       r_kref;
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 1d9ebf9..a28c976a 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1174,6 +1174,7 @@ static void handle_reply(struct ceph_osd_client
> *osdc, struct ceph_msg *msg,
>   	u32 reassert_epoch;
>   	u64 reassert_version;
>   	u32 osdmap_epoch;
> +	int already_completed;
>   	int i;
>
>   	tid = le64_to_cpu(msg->hdr.tid);
> @@ -1282,7 +1283,11 @@ static void handle_reply(struct ceph_osd_client
> *osdc, struct ceph_msg *msg,
>   	    ((flags & CEPH_OSD_FLAG_WRITE) == 0))
>   		__unregister_request(osdc, req);
>
> +	already_completed = req->r_completed;
> +	req->r_completed = 1;
>   	mutex_unlock(&osdc->request_mutex);
> +	if (already_completed)
> +		goto done;
>
>   	if (req->r_callback)
>   		req->r_callback(req, msg);
>

