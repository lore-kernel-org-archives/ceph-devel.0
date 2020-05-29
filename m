From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 5/5] libceph: read_policy option
Date: Fri, 29 May 2020 13:19:42 -0400
Message-ID: <fbbfce8d4f9d12916c63f68573af500db7840958.camel@kernel.org>
References: <20200529151952.15184-1-idryomov@gmail.com>
         <20200529151952.15184-6-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2RTo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 29 May 2020 13:19:44 -0400
In-Reply-To: <20200529151952.15184-6-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Fri, 2020-05-29 at 17:19 +0200, Ilya Dryomov wrote:
> Expose balanced and localized reads through read_policy=balance
> and read_policy=localize.  The default is to read from primary.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  include/linux/ceph/libceph.h |  2 ++
>  net/ceph/ceph_common.c       | 26 ++++++++++++++++++++++++++
>  net/ceph/osd_client.c        |  5 ++++-
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 4733959f1ec7..0a9f807ceda6 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -52,6 +52,8 @@ struct ceph_options {
>  	unsigned long osd_idle_ttl;		/* jiffies */
>  	unsigned long osd_keepalive_timeout;	/* jiffies */
>  	unsigned long osd_request_timeout;	/* jiffies */
> +	unsigned int osd_req_flags;  /* CEPH_OSD_FLAG_*, applied to
> +					each OSD request */
>  
>  	/*
>  	 * any type that can't be simply compared or doesn't need
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 6d495685ee03..1a834cb0d04d 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -265,6 +265,7 @@ enum {
>  	Opt_key,
>  	Opt_ip,
>  	Opt_crush_location,
> +	Opt_read_policy,
>  	/* string args above */
>  	Opt_share,
>  	Opt_crc,
> @@ -274,6 +275,17 @@ enum {
>  	Opt_abort_on_full,
>  };
>  
> +enum {
> +	Opt_read_policy_balance,
> +	Opt_read_policy_localize,
> +};
> +
> +static const struct constant_table ceph_param_read_policy[] = {
> +	{"balance",	Opt_read_policy_balance},
> +	{"localize",	Opt_read_policy_localize},
> +	{}
> +};
> +
>  static const struct fs_parameter_spec ceph_parameters[] = {
>  	fsparam_flag	("abort_on_full",		Opt_abort_on_full),
>  	fsparam_flag_no ("cephx_require_signatures",	Opt_cephx_require_signatures),
> @@ -290,6 +302,8 @@ static const struct fs_parameter_spec ceph_parameters[] = {
>  	fsparam_u32	("osdkeepalive",		Opt_osdkeepalivetimeout),
>  	__fsparam	(fs_param_is_s32, "osdtimeout", Opt_osdtimeout,
>  			 fs_param_deprecated, NULL),
> +	fsparam_enum	("read_policy",			Opt_read_policy,
> +			 ceph_param_read_policy),
>  	fsparam_string	("secret",			Opt_secret),
>  	fsparam_flag_no ("share",			Opt_share),
>  	fsparam_flag_no ("tcp_nodelay",			Opt_tcp_nodelay),
> @@ -470,6 +484,18 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
>  			return err;
>  		}
>  		break;
> +	case Opt_read_policy:
> +		switch (result.uint_32) {
> +		case Opt_read_policy_balance:
> +			opt->osd_req_flags |= CEPH_OSD_FLAG_BALANCE_READS;
> +			break;
> +		case Opt_read_policy_localize:
> +			opt->osd_req_flags |= CEPH_OSD_FLAG_LOCALIZE_READS;
> +			break;
> +		default:
> +			BUG();
> +		}
> +		break;

Suppose I specify "-o read_policy=balance,read_policy=localize".

Principle of least surprise says "last one wins", but you'll end up with
both flags set here, and I think the final result would still be
"balance". I think it'd probably be best to rework this so that the last
option specified is what you get.

I also think you want a way to explicitly set it back to default
behavior (read_policy=primary ?), as it's not uncommon for people to
specify mount options in fstab but then append to them on the command
line. e.g.:

    # mount /mnt/cephfs -o read_policy=primary

...when fstab already has read_policy=balance.

 
>  	case Opt_osdtimeout:
>  		warn_plog(&log, "Ignoring osdtimeout");
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 15c3afa8089b..da7046db9fbe 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -2425,11 +2425,14 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
>  
>  static void account_request(struct ceph_osd_request *req)
>  {
> +	struct ceph_osd_client *osdc = req->r_osdc;
> +
>  	WARN_ON(req->r_flags & (CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK));
>  	WARN_ON(!(req->r_flags & (CEPH_OSD_FLAG_READ | CEPH_OSD_FLAG_WRITE)));
>  
>  	req->r_flags |= CEPH_OSD_FLAG_ONDISK;
> -	atomic_inc(&req->r_osdc->num_requests);
> +	req->r_flags |= osdc->client->options->osd_req_flags;
> +	atomic_inc(&osdc->num_requests);
>  
>  	req->r_start_stamp = jiffies;
>  	req->r_start_latency = ktime_get();

-- 
Jeff Layton <jlayton@kernel.org>
