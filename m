From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: osd_request_timeout option
Date: Mon, 6 Mar 2017 19:56:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703061956150.24356@piezo.novalocal>
References: <1488567946-1696-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38547 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754105AbdCFUvi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 15:51:38 -0500
In-Reply-To: <1488567946-1696-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Artur Molchanov <artur.molchanov@synesis.ru>

On Fri, 3 Mar 2017, Ilya Dryomov wrote:
> osd_request_timeout specifies how many seconds to wait for a response
> from OSDs before returning -ETIMEDOUT from an OSD request.  0 (default)
> means no limit.
> 
> osd_request_timeout is osdkeepalive-precise -- in-flight requests are
> swept through every osdkeepalive seconds.  With ack vs commit behaviour
> gone, abort_request() is really simple.
> 
> This is based on a patch from Artur Molchanov <artur.molchanov@synesis.ru>.
> 
> Tested-by: Artur Molchanov <artur.molchanov@synesis.ru>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Sage Weil <sage@redhat.com>

I'd prefer to see us add a stronger force-unmap for this particular use 
case, but this is useful in and of itself.

sage


> ---
>  include/linux/ceph/libceph.h    |  2 ++
>  include/linux/ceph/osd_client.h |  1 +
>  net/ceph/ceph_common.c          | 15 +++++++++++++++
>  net/ceph/osd_client.c           | 36 +++++++++++++++++++++++++++++++++++-
>  4 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 1816c5e26581..88cd5dc8e238 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -48,6 +48,7 @@ struct ceph_options {
>  	unsigned long mount_timeout;		/* jiffies */
>  	unsigned long osd_idle_ttl;		/* jiffies */
>  	unsigned long osd_keepalive_timeout;	/* jiffies */
> +	unsigned long osd_request_timeout;	/* jiffies */
>  
>  	/*
>  	 * any type that can't be simply compared or doesn't need need
> @@ -68,6 +69,7 @@ struct ceph_options {
>  #define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
>  #define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
>  #define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
> +#define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
>  
>  #define CEPH_MONC_HUNT_INTERVAL		msecs_to_jiffies(3 * 1000)
>  #define CEPH_MONC_PING_INTERVAL		msecs_to_jiffies(10 * 1000)
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index e1cb5d825bc5..b04a2ca11e60 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -190,6 +190,7 @@ struct ceph_osd_request {
>  
>  	/* internal */
>  	unsigned long r_stamp;                /* jiffies, send or check time */
> +	unsigned long r_start_stamp;          /* jiffies */
>  	int r_attempts;
>  	struct ceph_eversion r_replay_version; /* aka reassert_version */
>  	u32 r_last_force_resend;
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 464e88599b9d..108533859a53 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -230,6 +230,7 @@ enum {
>  	Opt_osdkeepalivetimeout,
>  	Opt_mount_timeout,
>  	Opt_osd_idle_ttl,
> +	Opt_osd_request_timeout,
>  	Opt_last_int,
>  	/* int args above */
>  	Opt_fsid,
> @@ -256,6 +257,7 @@ static match_table_t opt_tokens = {
>  	{Opt_osdkeepalivetimeout, "osdkeepalive=%d"},
>  	{Opt_mount_timeout, "mount_timeout=%d"},
>  	{Opt_osd_idle_ttl, "osd_idle_ttl=%d"},
> +	{Opt_osd_request_timeout, "osd_request_timeout=%d"},
>  	/* int args above */
>  	{Opt_fsid, "fsid=%s"},
>  	{Opt_name, "name=%s"},
> @@ -361,6 +363,7 @@ ceph_parse_options(char *options, const char *dev_name,
>  	opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
>  	opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT;
>  	opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;
> +	opt->osd_request_timeout = CEPH_OSD_REQUEST_TIMEOUT_DEFAULT;
>  
>  	/* get mon ip(s) */
>  	/* ip1[:port1][,ip2[:port2]...] */
> @@ -473,6 +476,15 @@ ceph_parse_options(char *options, const char *dev_name,
>  			}
>  			opt->mount_timeout = msecs_to_jiffies(intval * 1000);
>  			break;
> +		case Opt_osd_request_timeout:
> +			/* 0 is "wait forever" (i.e. infinite timeout) */
> +			if (intval < 0 || intval > INT_MAX / 1000) {
> +				pr_err("osd_request_timeout out of range\n");
> +				err = -EINVAL;
> +				goto out;
> +			}
> +			opt->osd_request_timeout = msecs_to_jiffies(intval * 1000);
> +			break;
>  
>  		case Opt_share:
>  			opt->flags &= ~CEPH_OPT_NOSHARE;
> @@ -557,6 +569,9 @@ int ceph_print_client_options(struct seq_file *m, struct ceph_client *client)
>  	if (opt->osd_keepalive_timeout != CEPH_OSD_KEEPALIVE_DEFAULT)
>  		seq_printf(m, "osdkeepalivetimeout=%d,",
>  		    jiffies_to_msecs(opt->osd_keepalive_timeout) / 1000);
> +	if (opt->osd_request_timeout != CEPH_OSD_REQUEST_TIMEOUT_DEFAULT)
> +		seq_printf(m, "osd_request_timeout=%d,",
> +			   jiffies_to_msecs(opt->osd_request_timeout) / 1000);
>  
>  	/* drop redundant comma */
>  	if (m->count != pos)
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index e4f712ebcf05..534c2cd17582 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1727,6 +1727,8 @@ static void account_request(struct ceph_osd_request *req)
>  
>  	req->r_flags |= CEPH_OSD_FLAG_ONDISK;
>  	atomic_inc(&req->r_osdc->num_requests);
> +
> +	req->r_start_stamp = jiffies;
>  }
>  
>  static void submit_request(struct ceph_osd_request *req, bool wrlocked)
> @@ -1853,6 +1855,14 @@ static void cancel_request(struct ceph_osd_request *req)
>  	ceph_osdc_put_request(req);
>  }
>  
> +static void abort_request(struct ceph_osd_request *req, int err)
> +{
> +	dout("%s req %p tid %llu err %d\n", __func__, req, req->r_tid, err);
> +
> +	cancel_map_check(req);
> +	complete_request(req, err);
> +}
> +
>  static void check_pool_dne(struct ceph_osd_request *req)
>  {
>  	struct ceph_osd_client *osdc = req->r_osdc;
> @@ -2551,6 +2561,7 @@ static void handle_timeout(struct work_struct *work)
>  		container_of(work, struct ceph_osd_client, timeout_work.work);
>  	struct ceph_options *opts = osdc->client->options;
>  	unsigned long cutoff = jiffies - opts->osd_keepalive_timeout;
> +	unsigned long expiry_cutoff = jiffies - opts->osd_request_timeout;
>  	LIST_HEAD(slow_osds);
>  	struct rb_node *n, *p;
>  
> @@ -2566,15 +2577,23 @@ static void handle_timeout(struct work_struct *work)
>  		struct ceph_osd *osd = rb_entry(n, struct ceph_osd, o_node);
>  		bool found = false;
>  
> -		for (p = rb_first(&osd->o_requests); p; p = rb_next(p)) {
> +		for (p = rb_first(&osd->o_requests); p; ) {
>  			struct ceph_osd_request *req =
>  			    rb_entry(p, struct ceph_osd_request, r_node);
>  
> +			p = rb_next(p); /* abort_request() */
> +
>  			if (time_before(req->r_stamp, cutoff)) {
>  				dout(" req %p tid %llu on osd%d is laggy\n",
>  				     req, req->r_tid, osd->o_osd);
>  				found = true;
>  			}
> +			if (opts->osd_request_timeout &&
> +			    time_before(req->r_start_stamp, expiry_cutoff)) {
> +				pr_err_ratelimited("tid %llu on osd%d timeout\n",
> +				       req->r_tid, osd->o_osd);
> +				abort_request(req, -ETIMEDOUT);
> +			}
>  		}
>  		for (p = rb_first(&osd->o_linger_requests); p; p = rb_next(p)) {
>  			struct ceph_osd_linger_request *lreq =
> @@ -2594,6 +2613,21 @@ static void handle_timeout(struct work_struct *work)
>  			list_move_tail(&osd->o_keepalive_item, &slow_osds);
>  	}
>  
> +	if (opts->osd_request_timeout) {
> +		for (p = rb_first(&osdc->homeless_osd.o_requests); p; ) {
> +			struct ceph_osd_request *req =
> +			    rb_entry(p, struct ceph_osd_request, r_node);
> +
> +			p = rb_next(p); /* abort_request() */
> +
> +			if (time_before(req->r_start_stamp, expiry_cutoff)) {
> +				pr_err_ratelimited("tid %llu on osd%d timeout\n",
> +				       req->r_tid, osdc->homeless_osd.o_osd);
> +				abort_request(req, -ETIMEDOUT);
> +			}
> +		}
> +	}
> +
>  	if (atomic_read(&osdc->num_homeless) || !list_empty(&slow_osds))
>  		maybe_request_map(osdc);
>  
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
