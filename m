From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/5] libceph: store timeouts in jiffies, verify user input
Date: Thu, 21 May 2015 07:58:41 -0500
Message-ID: <555DD681.4030805@ieee.org>
References: <1432211706-10473-1-git-send-email-idryomov@gmail.com> <1432211706-10473-3-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34625 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbEUM6o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 08:58:44 -0400
Received: by ieczm2 with SMTP id zm2so7378306iec.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 05:58:44 -0700 (PDT)
In-Reply-To: <1432211706-10473-3-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

On 05/21/2015 07:35 AM, Ilya Dryomov wrote:
> There are currently three libceph-level timeouts that the user can
> specify on mount: mount_timeout, osd_idle_ttl and osdkeepalive.  All of
> these are in seconds and no checking is done on user input: negative
> values are accepted, we multiply them all by HZ which may or may not
> overflow, arbitrarily large jiffies then get added together, etc.
> 
> There is also a bug in the way mount_timeout=0 is handled.  It's
> supposed to mean "infinite timeout", but that's not how wait.h APIs
> treat it and so __ceph_open_session() for example will busy loop
> without much chance of being interrupted if none of ceph-mons are
> there.
> 
> Fix all this by verifying user input, storing timeouts capped by
> msecs_to_jiffies() in jiffies and using the new ceph_timeout_jiffies()
> helper for all user-specified waits to handle infinite timeouts
> correctly.

This looks good.  I like your use of local variables for
the options pointer; it makes it easy to see in the code
where the timeout values come from.

You could have handled timeout option checking and
error reporting generically, but I'm not sure that
would be better.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c          |  5 +++--
>  fs/ceph/dir.c                |  4 ++--
>  fs/ceph/mds_client.c         | 12 ++++++------
>  fs/ceph/mds_client.h         |  2 +-
>  fs/ceph/super.c              |  2 +-
>  include/linux/ceph/libceph.h | 17 +++++++++++------
>  net/ceph/ceph_common.c       | 41 +++++++++++++++++++++++++++++++----------
>  net/ceph/mon_client.c        | 11 +++++++++--
>  net/ceph/osd_client.c        | 15 +++++++--------
>  9 files changed, 71 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 349115ae3bc2..992683b6b299 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4963,8 +4963,8 @@ out_err:
>   */
>  static int rbd_add_get_pool_id(struct rbd_client *rbdc, const char *pool_name)
>  {
> +	struct ceph_options *opts = rbdc->client->options;
>  	u64 newest_epoch;
> -	unsigned long timeout = rbdc->client->options->mount_timeout * HZ;
>  	int tries = 0;
>  	int ret;
>  
> @@ -4979,7 +4979,8 @@ again:
>  		if (rbdc->client->osdc.osdmap->epoch < newest_epoch) {
>  			ceph_monc_request_next_osdmap(&rbdc->client->monc);
>  			(void) ceph_monc_wait_osdmap(&rbdc->client->monc,
> -						     newest_epoch, timeout);
> +						     newest_epoch,
> +						     opts->mount_timeout);
>  			goto again;
>  		} else {
>  			/* the osdmap we have is new enough */
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 4248307fea90..173dd4b58c71 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1259,8 +1259,8 @@ static int ceph_dir_fsync(struct file *file, loff_t start, loff_t end,
>  		     inode, req->r_tid, last_tid);
>  		if (req->r_timeout) {
>  			unsigned long time_left = wait_for_completion_timeout(
> -							&req->r_safe_completion,
> -							req->r_timeout);
> +					&req->r_safe_completion,
> +					ceph_timeout_jiffies(req->r_timeout));
>  			if (time_left > 0)
>  				ret = 0;
>  			else
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 69a36f40517f..0b0e0a9a81c0 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2268,7 +2268,8 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
>  	dout("do_request waiting\n");
>  	if (req->r_timeout) {
>  		err = (long)wait_for_completion_killable_timeout(
> -			&req->r_completion, req->r_timeout);
> +					&req->r_completion,
> +					ceph_timeout_jiffies(req->r_timeout));
>  		if (err == 0)
>  			err = -EIO;
>  	} else if (req->r_wait_for_completion) {
> @@ -3424,8 +3425,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>   */
>  static void wait_requests(struct ceph_mds_client *mdsc)
>  {
> +	struct ceph_options *opts = mdsc->fsc->client->options;
>  	struct ceph_mds_request *req;
> -	struct ceph_fs_client *fsc = mdsc->fsc;
>  
>  	mutex_lock(&mdsc->mutex);
>  	if (__get_oldest_req(mdsc)) {
> @@ -3433,7 +3434,7 @@ static void wait_requests(struct ceph_mds_client *mdsc)
>  
>  		dout("wait_requests waiting for requests\n");
>  		wait_for_completion_timeout(&mdsc->safe_umount_waiters,
> -				    fsc->client->options->mount_timeout * HZ);
> +				    ceph_timeout_jiffies(opts->mount_timeout));
>  
>  		/* tear down remaining requests */
>  		mutex_lock(&mdsc->mutex);
> @@ -3556,10 +3557,9 @@ static bool done_closing_sessions(struct ceph_mds_client *mdsc)
>   */
>  void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
>  {
> +	struct ceph_options *opts = mdsc->fsc->client->options;
>  	struct ceph_mds_session *session;
>  	int i;
> -	struct ceph_fs_client *fsc = mdsc->fsc;
> -	unsigned long timeout = fsc->client->options->mount_timeout * HZ;
>  
>  	dout("close_sessions\n");
>  
> @@ -3580,7 +3580,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
>  
>  	dout("waiting for sessions to close\n");
>  	wait_event_timeout(mdsc->session_close_wq, done_closing_sessions(mdsc),
> -			   timeout);
> +			   ceph_timeout_jiffies(opts->mount_timeout));
>  
>  	/* tear down remaining sessions */
>  	mutex_lock(&mdsc->mutex);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 2ef799961ebb..509d6822e9b1 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -227,7 +227,7 @@ struct ceph_mds_request {
>  	int r_err;
>  	bool r_aborted;
>  
> -	unsigned long r_timeout;  /* optional.  jiffies */
> +	unsigned long r_timeout;  /* optional.  jiffies, 0 is "wait forever" */
>  	unsigned long r_started;  /* start time to measure timeout against */
>  	unsigned long r_request_started; /* start time for mds request only,
>  					    used to measure lease durations */
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 9a5350030af8..edeb83c43112 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -742,7 +742,7 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
>  	req->r_ino1.ino = CEPH_INO_ROOT;
>  	req->r_ino1.snap = CEPH_NOSNAP;
>  	req->r_started = started;
> -	req->r_timeout = fsc->client->options->mount_timeout * HZ;
> +	req->r_timeout = fsc->client->options->mount_timeout;
>  	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INODE);
>  	req->r_num_caps = 2;
>  	err = ceph_mdsc_do_request(mdsc, NULL, req);
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 85ae9a889a3f..d73a569f9bf5 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -43,9 +43,9 @@ struct ceph_options {
>  	int flags;
>  	struct ceph_fsid fsid;
>  	struct ceph_entity_addr my_addr;
> -	int mount_timeout;
> -	int osd_idle_ttl;
> -	int osd_keepalive_timeout;
> +	unsigned long mount_timeout;		/* jiffies */
> +	unsigned long osd_idle_ttl;		/* jiffies */
> +	unsigned long osd_keepalive_timeout;	/* jiffies */
>  
>  	/*
>  	 * any type that can't be simply compared or doesn't need need
> @@ -63,9 +63,9 @@ struct ceph_options {
>  /*
>   * defaults
>   */
> -#define CEPH_MOUNT_TIMEOUT_DEFAULT  60
> -#define CEPH_OSD_KEEPALIVE_DEFAULT  5
> -#define CEPH_OSD_IDLE_TTL_DEFAULT    60
> +#define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
> +#define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
> +#define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
>  
>  #define CEPH_MSG_MAX_FRONT_LEN	(16*1024*1024)
>  #define CEPH_MSG_MAX_MIDDLE_LEN	(16*1024*1024)
> @@ -93,6 +93,11 @@ enum {
>  	CEPH_MOUNT_SHUTDOWN,
>  };
>  
> +static inline unsigned long ceph_timeout_jiffies(unsigned long timeout)
> +{
> +	return timeout ?: MAX_SCHEDULE_TIMEOUT;
> +}
> +
>  struct ceph_mds_client;
>  
>  /*
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 79e8f71aef5b..a80e91c2c9a3 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -352,8 +352,8 @@ ceph_parse_options(char *options, const char *dev_name,
>  	/* start with defaults */
>  	opt->flags = CEPH_OPT_DEFAULT;
>  	opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
> -	opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT; /* seconds */
> -	opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;   /* seconds */
> +	opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT;
> +	opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;
>  
>  	/* get mon ip(s) */
>  	/* ip1[:port1][,ip2[:port2]...] */
> @@ -439,13 +439,32 @@ ceph_parse_options(char *options, const char *dev_name,
>  			pr_warn("ignoring deprecated osdtimeout option\n");
>  			break;
>  		case Opt_osdkeepalivetimeout:
> -			opt->osd_keepalive_timeout = intval;
> +			/* 0 isn't well defined right now, reject it */
> +			if (intval < 1 || intval > INT_MAX / 1000) {
> +				pr_err("osdkeepalive out of range\n");
> +				err = -EINVAL;
> +				goto out;
> +			}
> +			opt->osd_keepalive_timeout =
> +					msecs_to_jiffies(intval * 1000);
>  			break;
>  		case Opt_osd_idle_ttl:
> -			opt->osd_idle_ttl = intval;
> +			/* 0 isn't well defined right now, reject it */
> +			if (intval < 1 || intval > INT_MAX / 1000) {
> +				pr_err("osd_idle_ttl out of range\n");
> +				err = -EINVAL;
> +				goto out;
> +			}
> +			opt->osd_idle_ttl = msecs_to_jiffies(intval * 1000);
>  			break;
>  		case Opt_mount_timeout:
> -			opt->mount_timeout = intval;
> +			/* 0 is "wait forever" (i.e. infinite timeout) */
> +			if (intval < 0 || intval > INT_MAX / 1000) {
> +				pr_err("mount_timeout out of range\n");
> +				err = -EINVAL;
> +				goto out;
> +			}
> +			opt->mount_timeout = msecs_to_jiffies(intval * 1000);
>  			break;
>  
>  		case Opt_share:
> @@ -512,12 +531,14 @@ int ceph_print_client_options(struct seq_file *m, struct ceph_client *client)
>  		seq_puts(m, "notcp_nodelay,");
>  
>  	if (opt->mount_timeout != CEPH_MOUNT_TIMEOUT_DEFAULT)
> -		seq_printf(m, "mount_timeout=%d,", opt->mount_timeout);
> +		seq_printf(m, "mount_timeout=%d,",
> +			   jiffies_to_msecs(opt->mount_timeout) / 1000);
>  	if (opt->osd_idle_ttl != CEPH_OSD_IDLE_TTL_DEFAULT)
> -		seq_printf(m, "osd_idle_ttl=%d,", opt->osd_idle_ttl);
> +		seq_printf(m, "osd_idle_ttl=%d,",
> +			   jiffies_to_msecs(opt->osd_idle_ttl) / 1000);
>  	if (opt->osd_keepalive_timeout != CEPH_OSD_KEEPALIVE_DEFAULT)
>  		seq_printf(m, "osdkeepalivetimeout=%d,",
> -			   opt->osd_keepalive_timeout);
> +		    jiffies_to_msecs(opt->osd_keepalive_timeout) / 1000);
>  
>  	/* drop redundant comma */
>  	if (m->count != pos)
> @@ -627,7 +648,7 @@ static int have_mon_and_osd_map(struct ceph_client *client)
>  int __ceph_open_session(struct ceph_client *client, unsigned long started)
>  {
>  	int err;
> -	unsigned long timeout = client->options->mount_timeout * HZ;
> +	unsigned long timeout = client->options->mount_timeout;
>  
>  	/* open session, and wait for mon and osd maps */
>  	err = ceph_monc_open_session(&client->monc);
> @@ -643,7 +664,7 @@ int __ceph_open_session(struct ceph_client *client, unsigned long started)
>  		dout("mount waiting for mon_map\n");
>  		err = wait_event_interruptible_timeout(client->auth_wq,
>  			have_mon_and_osd_map(client) || (client->auth_err < 0),
> -			timeout);
> +			ceph_timeout_jiffies(timeout));
>  		if (err == -EINTR || err == -ERESTARTSYS)
>  			return err;
>  		if (client->auth_err < 0)
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 2b3cf05e87b0..0da3bdc116f7 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -298,6 +298,12 @@ void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc)
>  }
>  EXPORT_SYMBOL(ceph_monc_request_next_osdmap);
>  
> +/*
> + * Wait for an osdmap with a given epoch.
> + *
> + * @epoch: epoch to wait for
> + * @timeout: in jiffies, 0 means "wait forever"
> + */
>  int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
>  			  unsigned long timeout)
>  {
> @@ -308,11 +314,12 @@ int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
>  	while (monc->have_osdmap < epoch) {
>  		mutex_unlock(&monc->mutex);
>  
> -		if (timeout != 0 && time_after_eq(jiffies, started + timeout))
> +		if (timeout && time_after_eq(jiffies, started + timeout))
>  			return -ETIMEDOUT;
>  
>  		ret = wait_event_interruptible_timeout(monc->client->auth_wq,
> -					 monc->have_osdmap >= epoch, timeout);
> +						monc->have_osdmap >= epoch,
> +						ceph_timeout_jiffies(timeout));
>  		if (ret < 0)
>  			return ret;
>  
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 4cb4fab46e4f..50033677c0fa 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1097,7 +1097,7 @@ static void __move_osd_to_lru(struct ceph_osd_client *osdc,
>  	BUG_ON(!list_empty(&osd->o_osd_lru));
>  
>  	list_add_tail(&osd->o_osd_lru, &osdc->osd_lru);
> -	osd->lru_ttl = jiffies + osdc->client->options->osd_idle_ttl * HZ;
> +	osd->lru_ttl = jiffies + osdc->client->options->osd_idle_ttl;
>  }
>  
>  static void maybe_move_osd_to_lru(struct ceph_osd_client *osdc,
> @@ -1208,7 +1208,7 @@ static struct ceph_osd *__lookup_osd(struct ceph_osd_client *osdc, int o)
>  static void __schedule_osd_timeout(struct ceph_osd_client *osdc)
>  {
>  	schedule_delayed_work(&osdc->timeout_work,
> -			osdc->client->options->osd_keepalive_timeout * HZ);
> +			      osdc->client->options->osd_keepalive_timeout);
>  }
>  
>  static void __cancel_osd_timeout(struct ceph_osd_client *osdc)
> @@ -1576,10 +1576,9 @@ static void handle_timeout(struct work_struct *work)
>  {
>  	struct ceph_osd_client *osdc =
>  		container_of(work, struct ceph_osd_client, timeout_work.work);
> +	struct ceph_options *opts = osdc->client->options;
>  	struct ceph_osd_request *req;
>  	struct ceph_osd *osd;
> -	unsigned long keepalive =
> -		osdc->client->options->osd_keepalive_timeout * HZ;
>  	struct list_head slow_osds;
>  	dout("timeout\n");
>  	down_read(&osdc->map_sem);
> @@ -1595,7 +1594,8 @@ static void handle_timeout(struct work_struct *work)
>  	 */
>  	INIT_LIST_HEAD(&slow_osds);
>  	list_for_each_entry(req, &osdc->req_lru, r_req_lru_item) {
> -		if (time_before(jiffies, req->r_stamp + keepalive))
> +		if (time_before(jiffies,
> +				req->r_stamp + opts->osd_keepalive_timeout))
>  			break;
>  
>  		osd = req->r_osd;
> @@ -1622,8 +1622,7 @@ static void handle_osds_timeout(struct work_struct *work)
>  	struct ceph_osd_client *osdc =
>  		container_of(work, struct ceph_osd_client,
>  			     osds_timeout_work.work);
> -	unsigned long delay =
> -		osdc->client->options->osd_idle_ttl * HZ >> 2;
> +	unsigned long delay = osdc->client->options->osd_idle_ttl / 4;
>  
>  	dout("osds timeout\n");
>  	down_read(&osdc->map_sem);
> @@ -2628,7 +2627,7 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
>  	osdc->event_count = 0;
>  
>  	schedule_delayed_work(&osdc->osds_timeout_work,
> -	   round_jiffies_relative(osdc->client->options->osd_idle_ttl * HZ));
> +	    round_jiffies_relative(osdc->client->options->osd_idle_ttl));
>  
>  	err = -ENOMEM;
>  	osdc->req_mempool = mempool_create_kmalloc_pool(10,
> 

