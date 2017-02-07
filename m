From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH v3 2/5] libceph: add ceph_osdc_abort_on_full
Date: Tue, 07 Feb 2017 08:01:35 -0500
Message-ID: <1486472495.2456.1.camel@poochiereds.net>
References: <20170207122828.5550-1-jlayton@redhat.com>
         <20170207122828.5550-3-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36684 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754990AbdBGNBl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2017 08:01:41 -0500
Received: by mail-qk0-f193.google.com with SMTP id i34so12973944qkh.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Feb 2017 05:01:41 -0800 (PST)
In-Reply-To: <20170207122828.5550-3-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

On Tue, 2017-02-07 at 07:28 -0500, Jeff Layton wrote:
> From: John Spray <john.spray@redhat.com>
> 
> When a Ceph volume hits capacity, a flag is set in the OSD map to
> indicate that, and a new map is sprayed around the cluster. When the
> cephfs client sees that, we want it to shut down any OSD writes that are
> in-progress with an -ENOSPC error as they'll just hang otherwise.
> 
> Add a routine that will see if there is an out-of-space condition in the
> cluster. It will then walk the tree and abort any request that has
> r_abort_on_full set with an ENOSPC error.
> 
> Also, add a callback to the osdc that gets called on map updates and a
> way for upper layers to register that callback.
> 
> [ jlayton: code style cleanup and adaptation to new osd msg handling ]
> 
> Signed-off-by: John Spray <john.spray@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  include/linux/ceph/osd_client.h |  4 ++++
>  net/ceph/osd_client.c           | 52 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 5da666cc5891..1aaf4851f180 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -21,6 +21,7 @@ struct ceph_osd_client;
>  /*
>   * completion callback for async writepages
>   */
> +typedef void (*ceph_osdc_map_callback_t)(struct ceph_osd_client *);
>  typedef void (*ceph_osdc_callback_t)(struct ceph_osd_request *);
>  typedef void (*ceph_osdc_unsafe_callback_t)(struct ceph_osd_request *, bool);
>  
> @@ -290,6 +291,8 @@ struct ceph_osd_client {
>  	struct ceph_msgpool	msgpool_op_reply;
>  
>  	struct workqueue_struct	*notify_wq;
> +
> +	ceph_osdc_map_callback_t	map_cb;
>  };
>  
>  static inline bool ceph_osdmap_flag(struct ceph_osd_client *osdc, int flag)
> @@ -392,6 +395,7 @@ extern void ceph_osdc_put_request(struct ceph_osd_request *req);
>  extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
>  				   struct ceph_osd_request *req,
>  				   bool nofail);
> +extern u32 ceph_osdc_abort_on_full(struct ceph_osd_client *osdc);
>  extern void ceph_osdc_cancel_request(struct ceph_osd_request *req);
>  extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
>  				  struct ceph_osd_request *req);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index f68bb42da240..5a4f60000a73 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -18,6 +18,7 @@
>  #include <linux/ceph/decode.h>
>  #include <linux/ceph/auth.h>
>  #include <linux/ceph/pagelist.h>
> +#include <linux/lockdep.h>
>  
>  #define OSD_OPREPLY_FRONT_LEN	512
>  
> @@ -1777,6 +1778,54 @@ static void complete_request(struct ceph_osd_request *req, int err)
>  	ceph_osdc_put_request(req);
>  }
>  
> +/*
> + * Drop all pending requests that have and complete
> + * them with the `r` as return code.
> + *
> + * Returns the highest OSD map epoch of a request that was
> + * cancelled, or 0 if none were cancelled.
> + */
> +u32 ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
> +{
> +	struct ceph_osd_request *req;
> +	struct ceph_osd *osd;
> +	struct rb_node *m, *n;
> +	u32 latest_epoch = 0;
> +	bool osdmap_full = ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL);
> +
> +	lockdep_assert_held(&osdc->lock);
> +
> +	dout("enter complete_writes r=%d\n", r);
> +

Oof. I sent out an earlier set instead of regenerating this. The above
fails to compile since "r" no longer exists in this version. Fixed in my
tree.

> +	if (!osdmap_full && !have_pool_full(osdc))
> +		goto out;
> +
> +	for (n = rb_first(&osdc->osds); n; n = rb_next(n)) {
> +		osd = rb_entry(n, struct ceph_osd, o_node);
> +		m = rb_first(&osd->o_requests);
> +		mutex_lock(&osd->lock);
> +		while (m) {
> +			req = rb_entry(m, struct ceph_osd_request, r_node);
> +			m = rb_next(m);
> +
> +			if (req->r_abort_on_full &&
> +			    (osdmap_full || pool_full(osdc, req->r_t.base_oloc.pool))) {
> +				u32 cur_epoch = le32_to_cpu(req->r_replay_version.epoch);
> +
> +				dout("%s: abort tid=%llu flags 0x%x\n", __func__, req->r_tid, req->r_flags);
> +				complete_request(req, -ENOSPC);
> +				if (cur_epoch > latest_epoch)
> +					latest_epoch = cur_epoch;
> +			}
> +		}
> +		mutex_unlock(&osd->lock);
> +	}
> +out:
> +	dout("return abort_on_full latest_epoch=%u\n", latest_epoch);
> +	return latest_epoch;
> +}
> +EXPORT_SYMBOL(ceph_osdc_abort_on_full);
> +
>  static void cancel_map_check(struct ceph_osd_request *req)
>  {
>  	struct ceph_osd_client *osdc = req->r_osdc;
> @@ -3292,6 +3341,8 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
>  
>  	ceph_monc_got_map(&osdc->client->monc, CEPH_SUB_OSDMAP,
>  			  osdc->osdmap->epoch);
> +	if (osdc->map_cb)
> +		osdc->map_cb(osdc);

I'm now wondering though whether we should eliminate the map_cb pointer,
and just call ceph_osdc_abort_on_full directly from
ceph_osdc_handle_map. That would simplify things quite a bit, with the
only downside being that when using something like rbd that doesn't set
r_abort_on_full, and you get a map update that shows it being full that
you'll end up walking the whole tree for nothing (since it doesn't set
r_abort_on_full).

I can make that change, but I'll hold off on reposting with that until
others have had a chance to review.

>  	up_write(&osdc->lock);
>  	wake_up_all(&osdc->client->auth_wq);
>  	return;
> @@ -4096,6 +4147,7 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
>  	osdc->linger_requests = RB_ROOT;
>  	osdc->map_checks = RB_ROOT;
>  	osdc->linger_map_checks = RB_ROOT;
> +	osdc->map_cb = NULL;
>  	INIT_DELAYED_WORK(&osdc->timeout_work, handle_timeout);
>  	INIT_DELAYED_WORK(&osdc->osds_timeout_work, handle_osds_timeout);
>  

-- 
Jeff Layton <jlayton@poochiereds.net>
