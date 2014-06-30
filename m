From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 09/14] libceph: introduce ceph_osdc_cancel_request()
Date: Mon, 30 Jun 2014 08:39:19 -0500
Message-ID: <53B16887.2090309@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-10-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:50499 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbaF3NjM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 09:39:12 -0400
Received: by mail-ig0-f179.google.com with SMTP id uq10so4276522igb.0
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 06:39:11 -0700 (PDT)
In-Reply-To: <1403716607-13535-10-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> Introduce ceph_osdc_cancel_request() intended for canceling requests
> from the higher layers (rbd and cephfs).  Because higher layers are in
> charge and are supposed to know what and when they are canceling, the
> request is not completed, only unref'ed and removed from the libceph
> data structures.

This seems reasonable.

But you make two changes here that I'd like to see a little
more explanation on.  They seem significant enough to warrant
a little more attention in the commit description.

- __cancel_request() is no longer called when
  ceph_osdc_wait_request() fails due to an
  an interrupt.  This is my main concern, and I
  plan to work through it but I'm in a small hurry
  right now.
- __unregister_linger_request() is now called when
  a request is canceled, but it wasn't before.  (Since
  we're consistent about setting the r_linger flag
  this should be fine, but it *is* a behavior change.)

I'm going to keep looking at this; I have about
20 minutes before I have to leave for a while.

					-Alex

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/osd_client.h |    1 +
>  net/ceph/osd_client.c           |   31 +++++++++++++++++++++++++------
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index a8d5652f589d..de09cad7b7c7 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -334,6 +334,7 @@ extern void ceph_osdc_put_request(struct ceph_osd_request *req);
>  extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
>  				   struct ceph_osd_request *req,
>  				   bool nofail);
> +extern void ceph_osdc_cancel_request(struct ceph_osd_request *req);
>  extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
>  				  struct ceph_osd_request *req);
>  extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 8104db24bc09..ef44cc0bbc6a 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -2470,6 +2470,25 @@ int ceph_osdc_start_request(struct ceph_osd_client *osdc,
>  EXPORT_SYMBOL(ceph_osdc_start_request);
>  
>  /*
> + * Unregister a registered request.  The request is not completed (i.e.
> + * no callbacks or wakeups) - higher layers are supposed to know what
> + * they are canceling.
> + */
> +void ceph_osdc_cancel_request(struct ceph_osd_request *req)
> +{
> +	struct ceph_osd_client *osdc = req->r_osdc;
> +
> +	mutex_lock(&osdc->request_mutex);
> +	if (req->r_linger)
> +		__unregister_linger_request(osdc, req);
> +	__unregister_request(osdc, req);
> +	mutex_unlock(&osdc->request_mutex);
> +
> +	dout("%s %p tid %llu canceled\n", __func__, req, req->r_tid);
> +}
> +EXPORT_SYMBOL(ceph_osdc_cancel_request);
> +
> +/*
>   * wait for a request to complete
>   */
>  int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
> @@ -2477,18 +2496,18 @@ int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
>  {
>  	int rc;
>  
> +	dout("%s %p tid %llu\n", __func__, req, req->r_tid);
> +
>  	rc = wait_for_completion_interruptible(&req->r_completion);
>  	if (rc < 0) {
> -		mutex_lock(&osdc->request_mutex);
> -		__cancel_request(req);
> -		__unregister_request(osdc, req);
> -		mutex_unlock(&osdc->request_mutex);
> +		dout("%s %p tid %llu interrupted\n", __func__, req, req->r_tid);
> +		ceph_osdc_cancel_request(req);
>  		complete_request(req);
> -		dout("wait_request tid %llu canceled/timed out\n", req->r_tid);
>  		return rc;
>  	}
>  
> -	dout("wait_request tid %llu result %d\n", req->r_tid, req->r_result);
> +	dout("%s %p tid %llu result %d\n", __func__, req, req->r_tid,
> +	     req->r_result);
>  	return req->r_result;
>  }
>  EXPORT_SYMBOL(ceph_osdc_wait_request);
> 

