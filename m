From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH 1/3] libceph: call r_unsafe_callback when unsafe reply
 is received
Date: Tue, 02 Jul 2013 08:07:41 -0500
Message-ID: <51D2D09D.8070808@linaro.org>
References: <1372056089-11603-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44022 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab3GBNHm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jul 2013 09:07:42 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so12387018iea.32
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jul 2013 06:07:41 -0700 (PDT)
In-Reply-To: <1372056089-11603-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On 06/24/2013 01:41 AM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>

Sorry it took so long, I intended to take a look at this
for you sooner.

I would also like to thank you for this nice clear
description.  It made it very easy to understand
why you were proposing the change, and to focus in
on exactly which parts of the design it's affecting.

> We can't use !req->r_sent to check if OSD request is sent for the
> first time, this is because __cancel_request() zeros req->r_sent
> when OSD map changes. Rather than adding a new variable to struct

You're right.

> ceph_osd_request to indicate if it's sent for the first time, We
> can call the unsafe callback only when unsafe OSD reply is received.
> If OSD's first reply is safe, just skip calling the unsafe callback.

This seems reasonable, but it's different from the way I
thought about what constituted "unsafe."  But I may be
wrong, and the way this is used by the file system might
do something that addresses my concern.

The way I interpreted "unsafe" was simply that it was possible
a write *could* have been made persistent, even if the client
doesn't know about it.  A request could have made it to its
target osd, been written, and the response could be in flight
at the point something (maybe a router?) crashes and the response
gets lost.  During that time window, the stored data may not be
in a state that's consistent with the client's view of it.

So I thought of "unsafe" as meaning that a write is in flight,
and until we get a successful response, the storage might
contain the old data or it might contain the new data; the
client has no way of knowing which.

With that interpretation, a request becomes unsafe the
instant it leaves the client, and becomes safe again
the instant a response arrives.

If my interpretation is correct, this change is wrong.

But I may be wrong, and there may really be no need to
worry about a possible modification of data until after
an acknowledgement response is received.  In that case,
I've looked at your patch and it looks good.

Can you explain why I'm wrong about what is "unsafe?"

					-Alex

> The purpose of unsafe callback is adding unsafe request to a list,
> so that fsync(2) can wait for the safe reply. fsync(2) doesn't need
> to wait for a write(2) that hasn't returned yet. So it's OK to add
> request to the unsafe list when the first OSD reply is received.
> (ceph_sync_write() returns after receiving the first OSD reply)
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  net/ceph/osd_client.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 540dd29..dd47889 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1337,10 +1337,6 @@ static void __send_request(struct ceph_osd_client *osdc,
>  
>  	ceph_msg_get(req->r_request); /* send consumes a ref */
>  
> -	/* Mark the request unsafe if this is the first timet's being sent. */
> -
> -	if (!req->r_sent && req->r_unsafe_callback)
> -		req->r_unsafe_callback(req, true);
>  	req->r_sent = req->r_osd->o_incarnation;
>  
>  	ceph_con_send(&req->r_osd->o_con, req->r_request);
> @@ -1431,8 +1427,6 @@ static void handle_osds_timeout(struct work_struct *work)
>  
>  static void complete_request(struct ceph_osd_request *req)
>  {
> -	if (req->r_unsafe_callback)
> -		req->r_unsafe_callback(req, false);
>  	complete_all(&req->r_safe_completion);  /* fsync waiter */
>  }
>  
> @@ -1559,14 +1553,20 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
>  	mutex_unlock(&osdc->request_mutex);
>  
>  	if (!already_completed) {
> +		if (req->r_unsafe_callback &&
> +		    result >= 0 && !(flags & CEPH_OSD_FLAG_ONDISK))
> +			req->r_unsafe_callback(req, true);
>  		if (req->r_callback)
>  			req->r_callback(req, msg);
>  		else
>  			complete_all(&req->r_completion);
>  	}
>  
> -	if (flags & CEPH_OSD_FLAG_ONDISK)
> +	if (flags & CEPH_OSD_FLAG_ONDISK) {
> +		if (req->r_unsafe_callback && already_completed)
> +			req->r_unsafe_callback(req, false);
>  		complete_request(req);
> +	}
>  
>  done:
>  	dout("req=%p req->r_linger=%d\n", req, req->r_linger);
> 

