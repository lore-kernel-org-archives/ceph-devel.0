From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v7 4/7] libceph: add an epoch_barrier field to struct
 ceph_osd_client
Date: Mon, 10 Apr 2017 06:45:50 -0400
Message-ID: <1491821150.2732.1.camel@redhat.com>
References: <20170405171417.25187-1-jlayton@redhat.com>
         <20170405171417.25187-5-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32824 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbdDJKp4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Apr 2017 06:45:56 -0400
Received: by mail-qk0-f169.google.com with SMTP id h67so105195373qke.0
        for <ceph-devel@vger.kernel.org>; Mon, 10 Apr 2017 03:45:56 -0700 (PDT)
In-Reply-To: <20170405171417.25187-5-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: jspray@redhat.com, ceph-devel@vger.kernel.org

On Wed, 2017-04-05 at 13:14 -0400, Jeff Layton wrote:
> Cephfs can get cap update requests that contain a new epoch barrier in
> them. When that happens we want to pause all OSD traffic until the right
> map epoch arrives.
> 
> Add an epoch_barrier field to ceph_osd_client that is protected by the
> osdc->lock rwsem. When the barrier is set, and the current OSD map
> epoch is below that, pause the request target when submitting the
> request or when revisiting it. Add a way for upper layers (cephfs)
> to update the epoch_barrier as well.
> 
> If we get a new map, compare the new epoch against the barrier before
> kicking requests and request another map if the map epoch is still lower
> than the one we want.
> 
> If we get a map with a full pool, or at quota condition, then set the
> barrier to the current epoch value.
> 
> Reviewed-by: "Yan, Zheng” <zyan@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  include/linux/ceph/osd_client.h |  2 ++
>  net/ceph/debugfs.c              |  3 ++-
>  net/ceph/osd_client.c           | 50 ++++++++++++++++++++++++++++++++++-------
>  3 files changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 8cf644197b1a..85650b415e73 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -267,6 +267,7 @@ struct ceph_osd_client {
>  	struct rb_root         osds;          /* osds */
>  	struct list_head       osd_lru;       /* idle osds */
>  	spinlock_t             osd_lru_lock;
> +	u32		       epoch_barrier;
>  	struct ceph_osd        homeless_osd;
>  	atomic64_t             last_tid;      /* tid of last request */
>  	u64                    last_linger_id;
> @@ -305,6 +306,7 @@ extern void ceph_osdc_handle_reply(struct ceph_osd_client *osdc,
>  				   struct ceph_msg *msg);
>  extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
>  				 struct ceph_msg *msg);
> +void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb);
>  
>  extern void osd_req_op_init(struct ceph_osd_request *osd_req,
>  			    unsigned int which, u16 opcode, u32 flags);
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index d7e63a4f5578..71ba13927b3d 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -62,7 +62,8 @@ static int osdmap_show(struct seq_file *s, void *p)
>  		return 0;
>  
>  	down_read(&osdc->lock);
> -	seq_printf(s, "epoch %d flags 0x%x\n", map->epoch, map->flags);
> +	seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
> +			osdc->epoch_barrier, map->flags);
>  
>  	for (n = rb_first(&map->pg_pools); n; n = rb_next(n)) {
>  		struct ceph_pg_pool_info *pi =
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 55b7585ccefd..fb35adae7fbf 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1298,8 +1298,9 @@ static bool target_should_be_paused(struct ceph_osd_client *osdc,
>  		       __pool_full(pi);
>  
>  	WARN_ON(pi->id != t->base_oloc.pool);
> -	return (t->flags & CEPH_OSD_FLAG_READ && pauserd) ||
> -	       (t->flags & CEPH_OSD_FLAG_WRITE && pausewr);
> +	return ((t->flags & CEPH_OSD_FLAG_READ) && pauserd) ||
> +	       ((t->flags & CEPH_OSD_FLAG_WRITE) && pausewr) ||
> +	       (osdc->osdmap->epoch < osdc->epoch_barrier);
>  }
>  
>  enum calc_target_result {
> @@ -1654,8 +1655,13 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
>  		goto promote;
>  	}
>  
> -	if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
> -	    ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
> +	if (osdc->osdmap->epoch < osdc->epoch_barrier) {
> +		dout("req %p epoch %u barrier %u\n", req, osdc->osdmap->epoch,
> +		     osdc->epoch_barrier);
> +		req->r_t.paused = true;
> +		maybe_request_map(osdc);
> +	} else if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
> +		   ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
>  		dout("req %p pausewr\n", req);
>  		req->r_t.paused = true;
>  		maybe_request_map(osdc);
> @@ -1809,11 +1815,14 @@ static void abort_request(struct ceph_osd_request *req, int err)
>  
>  /*
>   * Drop all pending requests that are stalled waiting on a full condition to
> - * clear, and complete them with ENOSPC as the return code.
> + * clear, and complete them with ENOSPC as the return code. Set the
> + * osdc->epoch_barrier to the latest map epoch that we've seen if any were
> + * cancelled.
>   */
>  static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
>  {
>  	struct rb_node *n;
> +	bool set_barrier = false;
>  
>  	dout("enter abort_on_full\n");
>  
> @@ -1832,12 +1841,18 @@ static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
>  
>  			if (req->r_abort_on_full &&
>  			    (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
> -			     pool_full(osdc, req->r_t.target_oloc.pool)))
> +			     pool_full(osdc, req->r_t.target_oloc.pool))) {
>  				abort_request(req, -ENOSPC);
> +				set_barrier = true;
> +			}
>  		}
>  	}
> +
> +	/* Update the epoch barrier to current epoch if a call was aborted */
> +	if (set_barrier)
> +		osdc->epoch_barrier = osdc->osdmap->epoch;
>  out:
> -	dout("return abort_on_full\n");
> +	dout("return abort_on_full barrier=%u\n", osdc->epoch_barrier);
>  }
>  
>  static void check_pool_dne(struct ceph_osd_request *req)
> @@ -3293,7 +3308,8 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
>  	pausewr = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
>  		  ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
>  		  have_pool_full(osdc);
> -	if (was_pauserd || was_pausewr || pauserd || pausewr)
> +	if (was_pauserd || was_pausewr || pauserd || pausewr ||
> +	    osdc->osdmap->epoch < osdc->epoch_barrier)
>  		maybe_request_map(osdc);
>  
>  	kick_requests(osdc, &need_resend, &need_resend_linger);
> @@ -3311,6 +3327,24 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
>  	up_write(&osdc->lock);
>  }
>  
> +void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb)
> +{
> +	down_read(&osdc->lock);
> +	if (unlikely(eb > osdc->epoch_barrier)) {
> +		up_read(&osdc->lock);
> +		down_write(&osdc->lock);
> +		if (likely(eb > osdc->epoch_barrier)) {
> +			dout("updating epoch_barrier from %u to %u\n",
> +					osdc->epoch_barrier, eb);
> +			osdc->epoch_barrier = eb;

As Ilya had pointed out in an earlier review, we need to call
maybe_request_map here. I'll go ahead and fix that in the testing
branch, but I'll spare us all a new posting since it's just a one-line
change.

> +		}
> +		up_write(&osdc->lock);
> +	} else {
> +		up_read(&osdc->lock);
> +	}
> +}
> +EXPORT_SYMBOL(ceph_osdc_update_epoch_barrier);
> +
>  /*
>   * Resubmit requests pending on the given osd.
>   */

-- 
Jeff Layton <jlayton@redhat.com>
