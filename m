From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/2] libceph: resend lingering requests with a new tid
Date: Mon, 22 Sep 2014 08:01:17 -0500
Message-ID: <54201D9D.2040909@ieee.org>
References: <1409906566-5662-1-git-send-email-ilya.dryomov@inktank.com> <1409906566-5662-3-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36795 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbaIVNBE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Sep 2014 09:01:04 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so1969210ieb.41
        for <ceph-devel@vger.kernel.org>; Mon, 22 Sep 2014 06:01:04 -0700 (PDT)
In-Reply-To: <1409906566-5662-3-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 09/05/2014 03:42 AM, Ilya Dryomov wrote:
> Both not yet registered (r_linger && list_empty(&r_linger_item)) and
> registered linger requests should use the new tid on resend to avoid
> the dup op detection logic on the OSDs, yet we were doing this only for
> "registered" case.  Factor out and simplify the "registered" logic and
> use the new helper for "not registered" case as well.
> 
> Fixes: http://tracker.ceph.com/issues/8806

The issue description describes the failure scenario nicely.
These linger requests are a nice service to provide but they
sure have proved tricky to get right...

After reviewing almost everything I came up with one "big"
question and I don't have time right now to investigate the
answer so I hope you will.  See below for the question in
context.

With that exception, the logic looks correct to me.  I have
some suggestions below for you to consider.  Let me know
what you intend to do, and if you are sure my big question
is not an issue you can go ahead and add this:

    Reviewed-by: Alex Elder <elder@linaro.org>

If not, please update and give me a chance to look at it
again.  Thanks.

					-Alex

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osd_client.c |   75 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 20 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 8db10b4a6553..81ee046b24d0 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -30,8 +30,11 @@ static void __send_queued(struct ceph_osd_client *osdc);
>  static int __reset_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd);
>  static void __register_request(struct ceph_osd_client *osdc,
>  			       struct ceph_osd_request *req);
> +static void __unregister_request(struct ceph_osd_client *osdc,
> +				 struct ceph_osd_request *req);
>  static void __unregister_linger_request(struct ceph_osd_client *osdc,
>  					struct ceph_osd_request *req);
> +static void __enqueue_request(struct ceph_osd_request *req);
>  static void __send_request(struct ceph_osd_client *osdc,
>  			   struct ceph_osd_request *req);
>  
> @@ -892,6 +895,39 @@ __lookup_request_ge(struct ceph_osd_client *osdc,
>  	return NULL;
>  }
>  
> +static void __kick_linger_request(struct ceph_osd_request *req,
> +				  bool lingering)

I think "committed" or maybe "acknowledged" might be a better
name than "lingering".  All of them are marked to linger, so
something other than "lingering" might be a little clearer.

> +{
> +	struct ceph_osd_client *osdc = req->r_osdc;
> +	struct ceph_osd *osd = req->r_osd;
> +
> +	/*
> +	 * Linger requests need to be resent with a new tid to avoid
> +	 * the dup op detection logic on the OSDs.  Achieve this with
> +	 * a re-register dance instead of open-coding.

This comment is more oriented toward this particular commit
rather than what's really going on in the code.  I.e., you
should instead say"Re-register each request--whether or not
we know it's been committed to disk on the OSD.  If we ever
sent a linger request we must assume it's been committed, so
even un-acknowledged linger requests need a new TID." or
something like that (or maybe something simpler).

> +	 */
> +	ceph_osdc_get_request(req);

As a rule, when there's an if-else, I prefer to avoid
negating the condition.  It's a subtle style thing, but
to me it makes it slightly easier to mentally parse
(occasionally avoiding a double negative).  There's
another instance of this a little further down.

> +	if (!lingering)
> +		__unregister_request(osdc, req);
> +	else
> +		__unregister_linger_request(osdc, req);
> +	__register_request(osdc, req);
> +	ceph_osdc_put_request(req);
> +
> +	/*
> +	 * Unless request has been registered as both normal and
> +	 * lingering, __unregister{,_linger}_request clears r_osd.
> +	 * However, here we need to preserve r_osd to make sure we
> +	 * requeue on the same OSD.
> +	 */
> +	WARN_ON(req->r_osd || !osd);
> +	req->r_osd = osd;
> +
> +	dout("requeueing %p tid %llu osd%d lingering=%d\n", req, req->r_tid,
> +	     osd->o_osd, lingering);
> +	__enqueue_request(req);
> +}
> +
>  /*
>   * Resubmit requests pending on the given osd.
>   */
> @@ -900,12 +936,14 @@ static void __kick_osd_requests(struct ceph_osd_client *osdc,
>  {
>  	struct ceph_osd_request *req, *nreq;
>  	LIST_HEAD(resend);
> +	LIST_HEAD(resend_linger);
>  	int err;
>  
>  	dout("__kick_osd_requests osd%d\n", osd->o_osd);
>  	err = __reset_osd(osdc, osd);
>  	if (err)
>  		return;
> +
>  	/*
>  	 * Build up a list of requests to resend by traversing the
>  	 * osd's list of requests.  Requests for a given object are

This block of comments (starting with the above but not shown
here) should be updated to reflect the modified logic.  Linger
requests are re-sent separate from (and before) non-linger
requests.  In both cases, only in-flight requests are re-sent,
and within each type, their original order is preserved.  The
comment only describes one list of requests to be re-sent, but
there are now two.

> @@ -926,33 +964,30 @@ static void __kick_osd_requests(struct ceph_osd_client *osdc,
>  	list_for_each_entry(req, &osd->o_requests, r_osd_item) {
>  		if (!req->r_sent)
>  			break;
> -		list_move_tail(&req->r_req_lru_item, &resend);
> -		dout("requeueing %p tid %llu osd%d\n", req, req->r_tid,
> -		     osd->o_osd);
> -		if (!req->r_linger)
> +
> +		if (!req->r_linger) {
> +			dout("requeueing %p tid %llu osd%d\n", req, req->r_tid,
> +			     osd->o_osd);
> +			list_move_tail(&req->r_req_lru_item, &resend);
>  			req->r_flags |= CEPH_OSD_FLAG_RETRY;
> +		} else {
> +			list_move_tail(&req->r_req_lru_item, &resend_linger);
> +		}
>  	}
>  	list_splice(&resend, &osdc->req_unsent);
>  
>  	/*
> -	 * Linger requests are re-registered before sending, which
> -	 * sets up a new tid for each.  We add them to the unsent
> -	 * list at the end to keep things in tid order.
> +	 * Both not yet registered and registered linger requests are
> +	 * enqueued with a new tid on the same OSD.  We add/move them
> +	 * to req_unsent/o_requests at the end to keep things in tid
> +	 * order.
>  	 */

OK, here's my big question.  By re-sending all linger requests
before all non-lingering ones, the re-sent messages can get done
in an order different from their original order.  For example,
suppose at the time of a reset we have

    non-linger tid 1
    linger tid 2
    non-linger tid 3
    linger tid 4

When they're re-sent, it might be:

    linger tid 10 (was 2)
    linger tid 11 (was 4)
    non-linger tid 12 (was 1)
    non-linger tid 13 (was 3)

Is that OK?

> +	list_for_each_entry_safe(req, nreq, &resend_linger, r_req_lru_item)
> +		__kick_linger_request(req, false);
> +
>  	list_for_each_entry_safe(req, nreq, &osd->o_linger_requests,
> -				 r_linger_osd_item) {
> -		/*
> -		 * reregister request prior to unregistering linger so
> -		 * that r_osd is preserved.
> -		 */
> -		BUG_ON(!list_empty(&req->r_req_lru_item));
> -		__register_request(osdc, req);
> -		list_add_tail(&req->r_req_lru_item, &osdc->req_unsent);
> -		list_add_tail(&req->r_osd_item, &req->r_osd->o_requests);
> -		__unregister_linger_request(osdc, req);
> -		dout("requeued lingering %p tid %llu osd%d\n", req, req->r_tid,
> -		     osd->o_osd);
> -	}
> +				 r_linger_osd_item)
> +		__kick_linger_request(req, true);
>  }
>  
>  /*
> 

