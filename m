From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 05/14] libceph: harden ceph_osdc_request_release() a bit
Date: Mon, 30 Jun 2014 07:36:32 -0500
Message-ID: <53B159D0.7050408@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-6-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:65507 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748AbaF3Mg0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 08:36:26 -0400
Received: by mail-ig0-f174.google.com with SMTP id l13so4241838iga.13
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 05:36:24 -0700 (PDT)
In-Reply-To: <1403716607-13535-6-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> Add some WARN_ONs to alert us when we try to destroy requests that are
> still registered.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

Good idea.  Especially the RB_CLEAR_NODE() call.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/osd_client.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 7406046212dc..052eb8bfcc74 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -305,6 +305,12 @@ static void ceph_osdc_release_request(struct kref *kref)
>  
>  	dout("%s %p (r_request %p r_reply %p)\n", __func__, req,
>  	     req->r_request, req->r_reply);
> +	WARN_ON(!RB_EMPTY_NODE(&req->r_node));
> +	WARN_ON(!list_empty(&req->r_req_lru_item));
> +	WARN_ON(!list_empty(&req->r_osd_item));
> +	WARN_ON(!list_empty(&req->r_linger_item));
> +	WARN_ON(!list_empty(&req->r_linger_osd_item));
> +	WARN_ON(req->r_osd);
>  
>  	if (req->r_request)
>  		ceph_msg_put(req->r_request);
> @@ -1204,6 +1210,7 @@ static void __unregister_request(struct ceph_osd_client *osdc,
>  
>  	dout("__unregister_request %p tid %lld\n", req, req->r_tid);
>  	rb_erase(&req->r_node, &osdc->requests);
> +	RB_CLEAR_NODE(&req->r_node);
>  	osdc->num_requests--;
>  
>  	if (req->r_osd) {
> 

