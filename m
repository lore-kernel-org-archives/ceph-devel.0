From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/2] libceph: Remap notarget requests in
 handle_timeout.
Date: Tue, 16 Jul 2013 17:47:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307161744050.21178@cobra.newdream.net>
References: <2013071615454946640410@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45902 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab3GQAr3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 20:47:29 -0400
In-Reply-To: <2013071615454946640410@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 16 Jul 2013, majianpeng wrote:
> If __map_request failed ,the request can't send and in list req_notarget.
> For those, they only remaped in func ceph_osdc_handle_map which update
> the epoch of osdmap.There are some reasons like ENOMEM which can't cause
> update epoch of osdmap.So the notarget requested can't remap for ever.
> 
> Add a chance in handle_timeout to remap those.

Is this a scenario you have actually seen in practice?

What to do when we get map updates and run into ENOMEM is a general 
problem for us, and not one that is handled well.  I'm unsure that this 
will end up helping us becuase I'm not sure that our osdmap update code 
when we get an incremental map and try to apply it is careful about 
falling back to our previous map if we run into ENOMEM partway through.  
We really might be better off reserving a pool of memory for maps (under 
the assumption that they will never more than 10x in size, say) and 
avoiding these sorts of complex workarounds...

I'm open to other opinions, but would rather form some sort of overall 
strategy before chipping away at symptoms.

Thanks!
sage


> 
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  net/ceph/osd_client.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 7d40a61..f0deed0 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1355,6 +1355,41 @@ static void __send_queued(struct ceph_osd_client *osdc)
>  }
>  
>  /*
> + * Resend any requests in the queue(req_notarget)
> + * After this function,it should call __send_queued to do
> + * real send operation
> + */
> +static void __send_notarget(struct ceph_osd_client *osdc)
> +{
> +	struct ceph_osd_request *req, *tmp;
> +	int rc, needmap = 0;
> +
> +	dout("__send_notarget\n");
> +	list_for_each_entry_safe(req, tmp, &osdc->req_notarget,
> +		r_req_lru_item) {
> +		rc = __map_request(osdc, req, 0);
> +		if (rc < 0)
> +			dout("__send_notarget failed map, "
> +				" will retry %lld\n", req->r_tid);
> +		if (req->r_osd == NULL) {
> +			dout("__send_notarget %p no up osds in pg\n", req);
> +			needmap++;
> +		} else if (rc > 0) {
> +			if (!req->r_linger) {
> +				dout("%p tid %llu requeued on osd%d\n", req,
> +				     req->r_tid,
> +				     req->r_osd ? req->r_osd->o_osd : -1);
> +				req->r_flags |= CEPH_OSD_FLAG_RETRY;
> +			}
> +		}
> +
> +	}
> +
> +	if (needmap)
> +		ceph_monc_request_next_osdmap(&osdc->client->monc);
> +}
> +
> +/*
>   * Timeout callback, called every N seconds when 1 or more osd
>   * requests has been active for more than N seconds.  When this
>   * happens, we ping all OSDs with requests who have timed out to
> @@ -1403,6 +1438,7 @@ static void handle_timeout(struct work_struct *work)
>  	}
>  
>  	__schedule_osd_timeout(osdc);
> +	__send_notarget(osdc);
>  	__send_queued(osdc);
>  	mutex_unlock(&osdc->request_mutex);
>  	up_read(&osdc->map_sem);
> -- 
> 1.8.1.2
> 
