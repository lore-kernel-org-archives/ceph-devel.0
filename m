From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 5/9] libceph: resubmit linger ops when pg mapping changes
Date: Mon, 30 Jul 2012 17:40:02 -0500
Message-ID: <50170D42.5060705@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com> <1342831308-18815-6-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49412 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab2G3WkC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 18:40:02 -0400
Received: by gglu4 with SMTP id u4so5439588ggl.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 15:40:02 -0700 (PDT)
In-Reply-To: <1342831308-18815-6-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/20/2012 07:41 PM, Sage Weil wrote:
> The linger op registration (i.e., watch) modifies the object state.  As
> such, the OSD will reply with success if it has already applied without
> doing the associated side-effects (setting up the watch session state).
> If we lose the ACK and resubmit, we will see success but the watch will not
> be correctly registered and we won't get notifies.
> 
> To fix this, always resubmit the linger op with a new tid.  We accomplish
> this by re-registering as a linger (i.e., 'registered') if we are not yet
> registered.  Then the second loop will treat this just like a normal
> case of re-registering.
> 
> This mirrors a similar fix on the userland ceph.git, commit 5dd68b95, and
> ceph bug #2796.
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

I have two minor comments below.  I confess I don't enough about what's
going on conceptually here to offer a high quality review.  However the
change seems be doing what you say is needed, so I guess I'll say it
looks OK to me.  Please try to get another reviewer to sign off though.

Reviewed-by: Alex Elder <elder@inktank.com>)

> ---
>  net/ceph/osd_client.c |   26 +++++++++++++++++++++-----
>  1 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 07920ca..c605705 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -891,7 +891,9 @@ static void __register_linger_request(struct ceph_osd_client *osdc,
>  {
>  	dout("__register_linger_request %p\n", req);
>  	list_add_tail(&req->r_linger_item, &osdc->req_linger);
> -	list_add_tail(&req->r_linger_osd, &req->r_osd->o_linger_requests);
> +	if (req->r_osd)
> +		list_add_tail(&req->r_linger_osd,
> +			      &req->r_osd->o_linger_requests);
>  }
>  
>  static void __unregister_linger_request(struct ceph_osd_client *osdc,
> @@ -1305,8 +1307,9 @@ static void kick_requests(struct ceph_osd_client *osdc, int force_resend)
>  
>  	dout("kick_requests %s\n", force_resend ? " (force resend)" : "");
>  	mutex_lock(&osdc->request_mutex);
> -	for (p = rb_first(&osdc->requests); p; p = rb_next(p)) {
> +	for (p = rb_first(&osdc->requests); p; ) {
>  		req = rb_entry(p, struct ceph_osd_request, r_node);
> +		p = rb_next(p);

Why is this hunk necessary?  Can the request's rb pointer(s)
get updated somehow via __map_request() or something?

>  		err = __map_request(osdc, req, force_resend);
>  		if (err < 0)
>  			continue;  /* error */
> @@ -1314,10 +1317,23 @@ static void kick_requests(struct ceph_osd_client *osdc, int force_resend)
>  			dout("%p tid %llu maps to no osd\n", req, req->r_tid);
>  			needmap++;  /* request a newer map */
>  		} else if (err > 0) {
> -			dout("%p tid %llu requeued on osd%d\n", req, req->r_tid,
> -			     req->r_osd ? req->r_osd->o_osd : -1);
> -			if (!req->r_linger)
> +			if (!req->r_linger) {
> +				dout("%p tid %llu requeued on osd%d\n", req,
> +				     req->r_tid,
> +				     req->r_osd ? req->r_osd->o_osd : -1);
>  				req->r_flags |= CEPH_OSD_FLAG_RETRY;
> +			}
> +		}
> +		if (req->r_linger && list_empty(&req->r_linger_item)) {
> +			/*
> +			 * register as a lingkker so that we will
                                             ^^
Is this the Swedish spelling?

> +			 * re-submit below and get a new tid
> +			 */
> +			dout("%p tid %llu restart on osd%d\n",
> +			     req, req->r_tid,
> +			     req->r_osd ? req->r_osd->o_osd : -1);
> +			__register_linger_request(osdc, req);
> +			__unregister_request(osdc, req);
>  		}
>  	}
>  
> 

