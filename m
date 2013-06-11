From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH 1/9] libceph: fix safe completion
Date: Mon, 10 Jun 2013 23:04:02 -0500
Message-ID: <51B6A1B2.40106@linaro.org>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com> <1370315998-10418-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:44682 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab3FKEEF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jun 2013 00:04:05 -0400
Received: by mail-qe0-f54.google.com with SMTP id ne12so4534887qeb.13
        for <ceph-devel@vger.kernel.org>; Mon, 10 Jun 2013 21:04:04 -0700 (PDT)
In-Reply-To: <1370315998-10418-2-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com, elder@inktank.com

On 06/03/2013 10:19 PM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> handle_reply() calls complete_request() only if the first OSD reply
> has ONDISK flag.

I believe that you're trying to fix a simple problem here, but
you are changing the logic around in several ways at the same
time and it makes it very difficult to see.

Let me see if I can explain what you've done:
- There's no reason to defer setting already_completed; it can
  set earlier.
- req->r_completed will be 0 until the first time a reply for
  req is received, at which point it will be set to 1.  That
  is exactly the same as what happens for req->r_got_reply,
  so already_completed can be equivalently set from that.
- That makes req->r_completed unnecessary, so it can be
  removed.
- The test near the end can be inverted, and a block can
  be executed rather than jumping over it with "goto done;"

Now, given those changes...
- This leaves the call to complete_request() happening *only*
  when the request had not already been completed *and* the
  current completion supplied the ONDISK flag.

And therein lies the problem you're trying to solve--it's
possible that a completion for the request arrived before,
but did not have the ONDISK flag set, and because of that a
later request with ONDISK set will not call complete_request()
as required.

The fix for that is to move the complete_request() call out
so it's called only when ONDISK is set, but regardless of
the value of already_completed.

Is that correct?

If my understanding is correct, I guess I'll say I've reviewed
this change, and in that case:

    Reviewed-by: Alex Elder <elder@kernel.org>

It would have been a lot easier to review this with a
better explanation, and with fewer logic changes rolled
into the patch.

					-Alex


> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  include/linux/ceph/osd_client.h |  1 -
>  net/ceph/osd_client.c           | 16 ++++++++--------
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 186db0b..ce6df39 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -145,7 +145,6 @@ struct ceph_osd_request {
>  	s32               r_reply_op_result[CEPH_OSD_MAX_OP];
>  	int               r_got_reply;
>  	int		  r_linger;
> -	int		  r_completed;
>  
>  	struct ceph_osd_client *r_osdc;
>  	struct kref       r_kref;
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index a3395fd..536c0e5 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1525,6 +1525,8 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
>  	for (i = 0; i < numops; i++)
>  		req->r_reply_op_result[i] = ceph_decode_32(&p);
>  
> +	already_completed = req->r_got_reply;
> +
>  	if (!req->r_got_reply) {
>  
>  		req->r_result = result;
> @@ -1555,16 +1557,14 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
>  	    ((flags & CEPH_OSD_FLAG_WRITE) == 0))
>  		__unregister_request(osdc, req);
>  
> -	already_completed = req->r_completed;
> -	req->r_completed = 1;
>  	mutex_unlock(&osdc->request_mutex);
> -	if (already_completed)
> -		goto done;
>  
> -	if (req->r_callback)
> -		req->r_callback(req, msg);
> -	else
> -		complete_all(&req->r_completion);
> +	if (!already_completed) {
> +		if (req->r_callback)
> +			req->r_callback(req, msg);
> +		else
> +			complete_all(&req->r_completion);
> +	}
>  
>  	if (flags & CEPH_OSD_FLAG_ONDISK)
>  		complete_request(req);
> 

