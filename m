From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] rbd: don't hold spinlock during messenger flush
Date: Thu, 5 Apr 2012 13:27:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204051326420.1289@cobra.newdream.net>
References: <4F7DB02D.7060807@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51780 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab2DEU1U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 16:27:20 -0400
In-Reply-To: <4F7DB02D.7060807@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 5 Apr 2012, Alex Elder wrote:
> A recent change made changes to the rbd_client_list be protected by
> a spinlock.  Unfortunately in rbd_put_client(), the lock is taken
> before possibly dropping the last reference to an rbd_client, and on
> the last reference that eventually calls flush_workqueue() which can
> sleep.
> 
> The problem was flagged by a debug spinlock warning:
>     BUG: spinlock wrong CPU on CPU#3, rbd/27814
> 
> The solution is to move the spinlock acquisition and release inside
> rbd_client_release(), which is the spot where it's really needed for
> protecting the removal of the rbd_client from the client list.
> 
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
>  drivers/block/rbd.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 013c7a5..c1f7701 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -450,7 +450,9 @@ static void rbd_client_release(struct kref *kref)
>  	struct rbd_client *rbdc = container_of(kref, struct rbd_client, kref);
> 
>  	dout("rbd_release_client %p\n", rbdc);
> +	spin_lock(&rbd_client_list_lock);
>  	list_del(&rbdc->node);
> +	spin_unlock(&rbd_client_list_lock);
> 
>  	ceph_destroy_client(rbdc->client);
>  	kfree(rbdc->rbd_opts);
> @@ -463,9 +465,7 @@ static void rbd_client_release(struct kref *kref)
>   */
>  static void rbd_put_client(struct rbd_device *rbd_dev)
>  {
> -	spin_lock(&rbd_client_list_lock);
>  	kref_put(&rbd_dev->rbd_client->kref, rbd_client_release);
> -	spin_unlock(&rbd_client_list_lock);
>  	rbd_dev->rbd_client = NULL;
>  }

This looks right to me.  Let's get it into testing...

Reviewed-by: Sage Weil <sage@newdream.net>

> 
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
