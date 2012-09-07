From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH, v2 06/11] rbd: add read_only rbd map option
Date: Fri, 7 Sep 2012 08:45:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209070844190.9861@cobra.newdream.net>
References: <5037AB20.4000103@inktank.com> <5037AD10.9010203@inktank.com> <5048C2F8.90505@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35254 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab2IGPpb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 11:45:31 -0400
In-Reply-To: <5048C2F8.90505@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 6 Sep 2012, Alex Elder wrote:
> Add the ability to map an rbd image read-only, by specifying either
> "read_only" or "ro" as an option on the rbd "command line."  Also
> allow the inverse to be explicitly specified using "read_write" or
> "rw".
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> v2: - Made the read_only/ro flag explicitly make the mapping
>       read-only rather than having it toggle.
>     - Added read_write/rw flags to allow a writable mapping to
>       be explicitly requested.  Snapshot mappings are silently
>       mapped read-only (even if read_write was requested).

If rw is the default, and rw is silently ignored if the image itself is a 
snapshot, what is the value in rw?  Would it make more sense to fail with 
EROFS if you specify rw on a snapshot (or otherwise read-only image)?

sage

> 
>  drivers/block/rbd.c |   28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> Index: b/drivers/block/rbd.c
> ===================================================================
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -69,7 +69,8 @@
>  #define DEV_NAME_LEN		32
>  #define MAX_INT_FORMAT_WIDTH	((5 * sizeof (int)) / 2 + 1)
> 
> -#define RBD_NOTIFY_TIMEOUT_DEFAULT 10
> +#define RBD_NOTIFY_TIMEOUT_DEFAULT	10
> +#define RBD_READ_ONLY_DEFAULT		false
> 
>  /*
>   * block device image metadata (in-memory version)
> @@ -91,6 +92,7 @@ struct rbd_image_header {
> 
>  struct rbd_options {
>  	int	notify_timeout;
> +	bool	read_only;
>  };
> 
>  /*
> @@ -176,7 +178,7 @@ struct rbd_device {
>  	u64                     snap_id;	/* current snapshot id */
>  	/* whether the snap_id this device reads from still exists */
>  	bool                    snap_exists;
> -	int                     read_only;
> +	bool			read_only;
> 
>  	struct list_head	node;
> 
> @@ -351,12 +353,21 @@ enum {
>  	/* int args above */
>  	Opt_last_string,
>  	/* string args above */
> +	Opt_read_only,
> +	Opt_read_write,
> +	/* Boolean args above */
> +	Opt_last_bool,
>  };
> 
>  static match_table_t rbd_opts_tokens = {
>  	{Opt_notify_timeout, "notify_timeout=%d"},
>  	/* int args above */
>  	/* string args above */
> +	{Opt_read_only, "read_only"},
> +	{Opt_read_only, "ro"},		/* Alternate spelling */
> +	{Opt_read_write, "read_write"},
> +	{Opt_read_write, "rw"},		/* Alternate spelling */
> +	/* Boolean args above */
>  	{-1, NULL}
>  };
> 
> @@ -381,6 +392,8 @@ static int parse_rbd_opts_token(char *c,
>  	} else if (token > Opt_last_int && token < Opt_last_string) {
>  		dout("got string token %d val %s\n", token,
>  		     argstr[0].from);
> +	} else if (token > Opt_last_string && token < Opt_last_bool) {
> +		dout("got Boolean token %d\n", token);
>  	} else {
>  		dout("got token %d\n", token);
>  	}
> @@ -389,6 +402,12 @@ static int parse_rbd_opts_token(char *c,
>  	case Opt_notify_timeout:
>  		rbd_opts->notify_timeout = intval;
>  		break;
> +	case Opt_read_only:
> +		rbd_opts->read_only = true;
> +		break;
> +	case Opt_read_write:
> +		rbd_opts->read_only = false;
> +		break;
>  	default:
>  		BUG_ON(token);
>  	}
> @@ -407,6 +426,7 @@ static int rbd_get_client(struct rbd_dev
>  	struct rbd_client *rbdc;
> 
>  	rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;
> +	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
> 
>  	ceph_opts = ceph_parse_options(options, mon_addr,
>  					mon_addr + mon_addr_len,
> @@ -620,7 +640,7 @@ static int rbd_header_set_snap(struct rb
>  		    sizeof (RBD_SNAP_HEAD_NAME))) {
>  		rbd_dev->snap_id = CEPH_NOSNAP;
>  		rbd_dev->snap_exists = false;
> -		rbd_dev->read_only = 0;
> +		rbd_dev->read_only = rbd_dev->rbd_opts.read_only;
>  		if (size)
>  			*size = rbd_dev->header.image_size;
>  	} else {
> @@ -632,7 +652,7 @@ static int rbd_header_set_snap(struct rb
>  			goto done;
>  		rbd_dev->snap_id = snap_id;
>  		rbd_dev->snap_exists = true;
> -		rbd_dev->read_only = 1;
> +		rbd_dev->read_only = true;	/* No choice for snapshots */
>  	}
> 
>  	ret = 0;
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
