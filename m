From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: drop mutex on error in handle_reply()
Date: Tue, 2 Apr 2013 09:35:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304020935330.4476@cobra.newdream.net>
References: <515ADE88.8080501@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44744 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761626Ab3DBQfi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 12:35:38 -0400
In-Reply-To: <515ADE88.8080501@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Sage Weil <sage@inktank.com>

On Tue, 2 Apr 2013, Alex Elder wrote:

> The osd client mutex is acquired just before getting a reference to
> a request in handle_reply().  However the error paths after that
> don't drop the mutex before returning as they should.
> 
> Drop the mutex after dropping the request reference.  Also add a
> bad_mutex label at that point and use it so the failed request
> lookup case can be handled with the rest.
> 
> This resolves:
>     http://tracker.ceph.com/issues/4615
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/osd_client.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 9b69f47..abbcde3 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1332,8 +1332,7 @@ static void handle_reply(struct ceph_osd_client
> *osdc, struct ceph_msg *msg,
>  	req = __lookup_request(osdc, tid);
>  	if (req == NULL) {
>  		dout("handle_reply tid %llu dne\n", tid);
> -		mutex_unlock(&osdc->request_mutex);
> -		return;
> +		goto bad_mutex;
>  	}
>  	ceph_osdc_get_request(req);
> 
> @@ -1422,6 +1421,8 @@ done:
> 
>  bad_put:
>  	ceph_osdc_put_request(req);
> +bad_mutex:
> +	mutex_unlock(&osdc->request_mutex);
>  bad:
>  	pr_err("corrupt osd_op_reply got %d %d\n",
>  	       (int)msg->front.iov_len, le32_to_cpu(msg->hdr.front_len));
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
