From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v3 3/4] libceph: add ceph_monc_wait_osdmap()
Date: Tue, 3 Jun 2014 13:59:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406031359130.26887@cobra.newdream.net>
References: <1400777408-7016-1-git-send-email-ilya.dryomov@inktank.com> <1400777408-7016-4-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50305 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933057AbaFCU7S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jun 2014 16:59:18 -0400
In-Reply-To: <1400777408-7016-4-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by:

On Thu, 22 May 2014, Ilya Dryomov wrote:

> Add ceph_monc_wait_osdmap(), which will block until the osdmap with the
> specified epoch is received or timeout occurs.
> 
> Export both of these as they are going to be needed by rbd.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/mon_client.h |    2 ++
>  net/ceph/mon_client.c           |   27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
> index 585ef9450e9d..deb47e45ac7c 100644
> --- a/include/linux/ceph/mon_client.h
> +++ b/include/linux/ceph/mon_client.h
> @@ -104,6 +104,8 @@ extern int ceph_monc_got_mdsmap(struct ceph_mon_client *monc, u32 have);
>  extern int ceph_monc_got_osdmap(struct ceph_mon_client *monc, u32 have);
>  
>  extern void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc);
> +extern int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
> +				 unsigned long timeout);
>  
>  extern int ceph_monc_do_statfs(struct ceph_mon_client *monc,
>  			       struct ceph_statfs *buf);
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 6b46f1205ceb..ecfd65c05f49 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -296,6 +296,33 @@ void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc)
>  		__send_subscribe(monc);
>  	mutex_unlock(&monc->mutex);
>  }
> +EXPORT_SYMBOL(ceph_monc_request_next_osdmap);
> +
> +int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
> +			  unsigned long timeout)
> +{
> +	unsigned long started = jiffies;
> +	int ret;
> +
> +	mutex_lock(&monc->mutex);
> +	while (monc->have_osdmap < epoch) {
> +		mutex_unlock(&monc->mutex);
> +
> +		if (timeout != 0 && time_after_eq(jiffies, started + timeout))
> +			return -ETIMEDOUT;
> +
> +		ret = wait_event_interruptible_timeout(monc->client->auth_wq,
> +					 monc->have_osdmap >= epoch, timeout);
> +		if (ret < 0)
> +			return ret;
> +
> +		mutex_lock(&monc->mutex);
> +	}
> +
> +	mutex_unlock(&monc->mutex);
> +	return 0;
> +}
> +EXPORT_SYMBOL(ceph_monc_wait_osdmap);
>  
>  /*
>   *
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
