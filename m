From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: change how "safe" callback is used
Date: Tue, 16 Apr 2013 20:26:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304162018590.23771@cobra.newdream.net>
References: <516C28DA.5000702@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56030 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965667Ab3DQD0X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 23:26:23 -0400
In-Reply-To: <516C28DA.5000702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org, "Yan, Zheng" <zheng.z.yan@intel.com>

On Mon, 15 Apr 2013, Alex Elder wrote:
> (This is an alternative to another patch that Zheng Yan
> posted, "ceph: add osd request to inode unsafe list in
> advance".  As noted, he's reviewed this one and I think
> it can therefore take the place of his.)
> 
> An osd request currently has two callbacks.  They inform the
> initiator of the request when we've received confirmation for the
> target osd that a request was received, and when the osd indicates
> all changes described by the request are durable.
> 
> The only time the second callback is used is in the ceph file system
> for a synchronous write.  There's a race that makes some handling of
> this case unsafe.  This patch addresses this problem.  The error
> handling for this callback is also kind of gross, and this patch
> changes that as well.
> 
> 
> In ceph_sync_write(), if a safe callback is requested we want to add
> the request on the ceph inode's unsafe items list.  Because items on
> this list must have their tid set (by ceph_osd_start_request()), the
> request added *after* the call to that function returns.  The
> problem with this is that there's a race between starting the
> request and adding it to the unsafe items list; the request may
> already be complete before ceph_sync_write() even begins to put it
> on the list.
> 
> 
> To address this, we change the way the "safe" callback is used.
> Rather than just calling it when the request is "safe", we use it to
> notify the initiator the bounds (start and end) of the period during
> which the request is *unsafe*.  So the initiator gets notified just
> before the request gets sent to the osd (when it is "unsafe"), and
> again when it's known the results are durable (it's no longer
> unsafe).  The first call will get made just before the request
> message gets sent to the messenger for the first time, *before* the
> osd client's request mutex gets dropped.
> 
> We then have this callback function insert the request on the ceph
> inode's unsafe list when we're told the request is unsafe.  This
> will avoid the race because this call will be made under protection
> of the osd client's request mutex.  It also nicely groups the setup
> and cleanup of the state associated with managing unsafe requests.
> 
> The name of the "safe" callback field is changed to "unsafe" rather
> to better reflect its new purpose.  It has a Boolean "unsafe"
> parameter to indicate whether the request is becoming unsafe or is
> now safe.  Because the "msg" parameter wasn't used, we drop that.
> 
> This resolves the original problem reportedin:
>     http://tracker.ceph.com/issues/4706
> 
> Reported-by: Yan, Zheng <zheng.z.yan@intel.com>
> Signed-off-by: Alex Elder <elder@inktank.com>
> Reviewed-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/file.c                  |   52
> +++++++++++++++++++++------------------
>  include/linux/ceph/osd_client.h |    4 ++-
>  net/ceph/osd_client.c           |    6 +++--
>  3 files changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 1d8d430..044f3bf 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -446,19 +446,35 @@ done:
>  }
> 
>  /*
> - * Write commit callback, called if we requested both an ACK and
> - * ONDISK commit reply from the OSD.
> + * Write commit request unsafe callback, called to tell us when a
> + * request is unsafe (that is, in flight--has been handed to the
> + * messenger to send to its target osd).  It is called again when
> + * we've received a response message indicating the request is
> + * "safe" (its CEPH_OSD_FLAG_ONDISK flag is set), or when a request
> + * is completed early (and unsuccessfully) due to a timeout or
> + * interrupt.
> + *
> + * This is used if we requested both an ACK and ONDISK commit reply
> + * from the OSD.
>   */
> -static void sync_write_commit(struct ceph_osd_request *req,
> -			      struct ceph_msg *msg)
> +static void ceph_sync_write_unsafe(struct ceph_osd_request *req, bool
> unsafe)
>  {
>  	struct ceph_inode_info *ci = ceph_inode(req->r_inode);
> 
> -	dout("sync_write_commit %p tid %llu\n", req, req->r_tid);
> -	spin_lock(&ci->i_unsafe_lock);
> -	list_del_init(&req->r_unsafe_item);
> -	spin_unlock(&ci->i_unsafe_lock);
> -	ceph_put_cap_refs(ci, CEPH_CAP_FILE_WR);
> +	dout("%s %p tid %llu %ssafe\n", __func__, req, req->r_tid,
> +		unsafe ? "un" : "");
> +	if (unsafe) {
> +		ceph_get_cap_refs(ci, CEPH_CAP_FILE_WR);
> +		spin_lock(&ci->i_unsafe_lock);
> +		list_add_tail(&req->r_unsafe_item,
> +			      &ci->i_unsafe_writes);
> +		spin_unlock(&ci->i_unsafe_lock);
> +	} else {
> +		spin_lock(&ci->i_unsafe_lock);
> +		list_del_init(&req->r_unsafe_item);
> +		spin_unlock(&ci->i_unsafe_lock);
> +		ceph_put_cap_refs(ci, CEPH_CAP_FILE_WR);
> +	}
>  }

This now has to be called *exactly once* with unsafe = true and again 
with unsafe = false (and then may repeat).  But:

> 
>  /*
> @@ -570,7 +586,8 @@ more:
> 
>  		if ((file->f_flags & O_SYNC) == 0) {
>  			/* get a second commit callback */
> -			req->r_safe_callback = sync_write_commit;
> +			req->r_unsafe_callback = ceph_sync_write_unsafe;
> +			req->r_inode = inode;
>  			own_pages = true;
>  		}
>  	}
> @@ -581,21 +598,8 @@ more:
>  	ceph_osdc_build_request(req, pos, snapc, vino.snap, &mtime);
> 
>  	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> -	if (!ret) {
> -		if (req->r_safe_callback) {
> -			/*
> -			 * Add to inode unsafe list only after we
> -			 * start_request so that a tid has been assigned.
> -			 */
> -			spin_lock(&ci->i_unsafe_lock);
> -			list_add_tail(&req->r_unsafe_item,
> -				      &ci->i_unsafe_writes);
> -			spin_unlock(&ci->i_unsafe_lock);
> -			ceph_get_cap_refs(ci, CEPH_CAP_FILE_WR);
> -		}
> -		
> +	if (!ret)
>  		ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
> -	}
> 
>  	if (file->f_flags & O_DIRECT)
>  		ceph_put_page_vector(pages, num_pages, false);
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index 2a68a74..0d3358e 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -29,6 +29,7 @@ struct ceph_authorizer;
>   */
>  typedef void (*ceph_osdc_callback_t)(struct ceph_osd_request *,
>  				     struct ceph_msg *);
> +typedef void (*ceph_osdc_unsafe_callback_t)(struct ceph_osd_request *,
> bool);
> 
>  /* a given osd we're communicating with */
>  struct ceph_osd {
> @@ -149,7 +150,8 @@ struct ceph_osd_request {
>  	struct kref       r_kref;
>  	bool              r_mempool;
>  	struct completion r_completion, r_safe_completion;
> -	ceph_osdc_callback_t r_callback, r_safe_callback;
> +	ceph_osdc_callback_t r_callback;
> +	ceph_osdc_unsafe_callback_t r_unsafe_callback;
>  	struct ceph_eversion r_reassert_version;
>  	struct list_head  r_unsafe_item;
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 939be67..5b7ce57 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1403,8 +1403,8 @@ static void handle_osds_timeout(struct work_struct
> *work)
> 
>  static void complete_request(struct ceph_osd_request *req)
>  {
> -	if (req->r_safe_callback)
> -		req->r_safe_callback(req, NULL);
> +	if (req->r_unsafe_callback)
> +		req->r_unsafe_callback(req, false);
>  	complete_all(&req->r_safe_completion);  /* fsync waiter */
>  }
> 
> @@ -2105,6 +2105,8 @@ int ceph_osdc_start_request(struct ceph_osd_client
> *osdc,
>  		dout("send_request %p no up osds in pg\n", req);
>  		ceph_monc_request_next_osdmap(&osdc->client->monc);
>  	} else {
> +		if (req->r_unsafe_callback)
> +			req->r_unsafe_callback(req, true);

This might not get called if we initially map to no osd... and later, if 
the request gets kicked, it isn't called then.

I also worry that the WR cap ref isn't taken immediately.  If the osd 
target is initially not there, we may not take that ref for who knows how 
long.. at which point we may have erroneously allowed the cap to be 
revoked by the MDS.

I think the right solution here is to still take the WR cap synchronously 
from within the write method.  Perhaps making it so (1) the unsafe=true 
case can be called multiple times (list_add_tail or something) and (2) 
doesn't do the cap get will work?

sage

>  		__send_queued(osdc);
>  	}
>  	rc = 0;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
