From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: add lingering request reference when registered
Date: Thu, 23 May 2013 11:53:52 -0700
Message-ID: <519E65C0.7060709@inktank.com>
References: <519E077B.9030804@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38928 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758454Ab3EWSzS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 14:55:18 -0400
Received: by mail-pd0-f180.google.com with SMTP id 14so813983pdc.39
        for <ceph-devel@vger.kernel.org>; Thu, 23 May 2013 11:55:18 -0700 (PDT)
In-Reply-To: <519E077B.9030804@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/23/2013 05:11 AM, Alex Elder wrote:
> When an osd request is set to linger, the osd client holds onto the
> request so it can be re-submitted following certain osd map changes.
> The osd client holds a reference to the request until it is
> unregistered.  This is used by rbd for watch requests.
>
> Currently, the reference is taken when the request is marked with
> the linger flag.  This means that if an error occurs after that
> time but before the the request completes successfully, that
> reference is leaked.
>
> There's really no reason to hold the reference until the request is
> registered in the the osd client's list of lingering requests, and
> that only happens when the lingering (watch) request completes
> successfully.
>
> So take that reference only when it gets registered following
> succesful completion, and drop it (as before) when the request
> gets unregistered.  This avoids the reference problem on error
> in rbd.
>
> Rearrange ceph_osdc_unregister_linger_request() to avoid using
> the request pointer after it may have been freed.
>
> And hold an extra reference in kick_requests() while handling
> a linger request that has not yet been registered, to ensure
> it doesn't go away.
>
> This resolves:
>      http://tracker.ceph.com/issues/3859
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/osd_client.c |   12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 3a246a6..e0abb83 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1174,6 +1174,7 @@ static void __register_linger_request(struct
> ceph_osd_client *osdc,
>   				    struct ceph_osd_request *req)
>   {
>   	dout("__register_linger_request %p\n", req);
> +	ceph_osdc_get_request(req);
>   	list_add_tail(&req->r_linger_item, &osdc->req_linger);
>   	if (req->r_osd)
>   		list_add_tail(&req->r_linger_osd,
> @@ -1196,6 +1197,7 @@ static void __unregister_linger_request(struct
> ceph_osd_client *osdc,
>   		if (list_empty(&req->r_osd_item))
>   			req->r_osd = NULL;
>   	}
> +	ceph_osdc_put_request(req);
>   }
>
>   void ceph_osdc_unregister_linger_request(struct ceph_osd_client *osdc,
> @@ -1203,9 +1205,8 @@ void ceph_osdc_unregister_linger_request(struct
> ceph_osd_client *osdc,
>   {
>   	mutex_lock(&osdc->request_mutex);
>   	if (req->r_linger) {
> -		__unregister_linger_request(osdc, req);
>   		req->r_linger = 0;
> -		ceph_osdc_put_request(req);
> +		__unregister_linger_request(osdc, req);
>   	}
>   	mutex_unlock(&osdc->request_mutex);
>   }
> @@ -1217,11 +1218,6 @@ void ceph_osdc_set_request_linger(struct
> ceph_osd_client *osdc,
>   	if (!req->r_linger) {
>   		dout("set_request_linger %p\n", req);
>   		req->r_linger = 1;
> -		/*
> -		 * caller is now responsible for calling
> -		 * unregister_linger_request
> -		 */
> -		ceph_osdc_get_request(req);
>   	}
>   }
>   EXPORT_SYMBOL(ceph_osdc_set_request_linger);
> @@ -1633,8 +1629,10 @@ static void kick_requests(struct ceph_osd_client
> *osdc, int force_resend)
>   			dout("%p tid %llu restart on osd%d\n",
>   			     req, req->r_tid,
>   			     req->r_osd ? req->r_osd->o_osd : -1);
> +			ceph_osdc_get_request(req);
>   			__unregister_request(osdc, req);
>   			__register_linger_request(osdc, req);
> +			ceph_osdc_put_request(req);
>   			continue;
>   		}
>

