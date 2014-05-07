From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 3/3] rbd: make sure we have latest osdmap on 'rbd map'
Date: Wed, 7 May 2014 09:03:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405070901310.31818@cobra.newdream.net>
References: <1398356607-10666-1-git-send-email-ilya.dryomov@inktank.com> <1398356607-10666-4-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50753 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823AbaEGQD0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 12:03:26 -0400
In-Reply-To: <1398356607-10666-4-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 24 Apr 2014, Ilya Dryomov wrote:
> Given an existing idle mapping (img1), mapping an image (img2) in
> a newly created pool (pool2) fails:
> 
>     $ ceph osd pool create pool1 8 8
>     $ rbd create --size 1000 pool1/img1
>     $ sudo rbd map pool1/img1
>     $ ceph osd pool create pool2 8 8
>     $ rbd create --size 1000 pool2/img2
>     $ sudo rbd map pool2/img2
>     rbd: sysfs write failed
>     rbd: map failed: (2) No such file or directory
> 
> This is because client instances are shared by default and we don't
> request an osdmap update when bumping a ref on an existing client.  The
> fix is to use the mon_get_version request to see if the osdmap we have
> is the latest, and block until the requested update is received if it's
> not.

This is slightly more heavyweight than the userspace client's approach.  
There, we only check for a newer osdmap if we find that the pool doesn't 
exist.  That shouldn't be too difficult to mirror here... probably just 
expose a wait_for_latest_map() function, and call that + retry from the 
rbd map code?

sage

> 
> Fixes: http://tracker.ceph.com/issues/8184
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |   27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 552a2edcaa74..a3734726eef9 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -723,15 +723,34 @@ static int parse_rbd_opts_token(char *c, void *private)
>  static struct rbd_client *rbd_get_client(struct ceph_options *ceph_opts)
>  {
>  	struct rbd_client *rbdc;
> +	u64 newest_epoch;
>  
>  	mutex_lock_nested(&client_mutex, SINGLE_DEPTH_NESTING);
>  	rbdc = rbd_client_find(ceph_opts);
> -	if (rbdc)	/* using an existing client */
> -		ceph_destroy_options(ceph_opts);
> -	else
> +	if (!rbdc) {
>  		rbdc = rbd_client_create(ceph_opts);
> -	mutex_unlock(&client_mutex);
> +		mutex_unlock(&client_mutex);
> +		return rbdc;
> +	}
> +
> +	/*
> +	 * Using an existing client, make sure we've got the latest
> +	 * osdmap.  Ignore the errors though, as failing to get it
> +	 * doesn't necessarily prevent from working.
> +	 */
> +	if (ceph_monc_do_get_version(&rbdc->client->monc, "osdmap",
> +				     &newest_epoch) < 0)
> +		goto out;
> +
> +	if (rbdc->client->osdc.osdmap->epoch < newest_epoch) {
> +		ceph_monc_request_next_osdmap(&rbdc->client->monc);
> +		(void) ceph_monc_wait_osdmap(&rbdc->client->monc, newest_epoch,
> +				    rbdc->client->options->mount_timeout * HZ);
> +	}
>  
> +out:
> +	mutex_unlock(&client_mutex);
> +	ceph_destroy_options(ceph_opts);
>  	return rbdc;
>  }
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
