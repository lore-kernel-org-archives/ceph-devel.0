From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 13/14] libceph: nuke ceph_osdc_unregister_linger_request()
Date: Mon, 07 Jul 2014 17:36:56 -0500
Message-ID: <53BB2108.4020006@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-14-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:64444 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbaGGWg4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 18:36:56 -0400
Received: by mail-ie0-f169.google.com with SMTP id rl12so4328540iec.28
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jul 2014 15:36:55 -0700 (PDT)
In-Reply-To: <1403716607-13535-14-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> Remove now unused ceph_osdc_unregister_linger_request().
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  include/linux/ceph/osd_client.h |    2 --
>  net/ceph/osd_client.c           |   12 ------------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index de09cad7b7c7..03aeb27fcc69 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -325,8 +325,6 @@ extern struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *,
>  
>  extern void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
>  					 struct ceph_osd_request *req);
> -extern void ceph_osdc_unregister_linger_request(struct ceph_osd_client *osdc,
> -						struct ceph_osd_request *req);
>  
>  extern void ceph_osdc_get_request(struct ceph_osd_request *req);
>  extern void ceph_osdc_put_request(struct ceph_osd_request *req);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index ef44cc0bbc6a..30f6faf3584f 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1281,18 +1281,6 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
>  	ceph_osdc_put_request(req);
>  }
>  
> -void ceph_osdc_unregister_linger_request(struct ceph_osd_client *osdc,
> -					 struct ceph_osd_request *req)
> -{
> -	mutex_lock(&osdc->request_mutex);
> -	if (req->r_linger) {
> -		req->r_linger = 0;
> -		__unregister_linger_request(osdc, req);
> -	}
> -	mutex_unlock(&osdc->request_mutex);
> -}
> -EXPORT_SYMBOL(ceph_osdc_unregister_linger_request);
> -
>  void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
>  				  struct ceph_osd_request *req)
>  {
> 

