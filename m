From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/8] rbd: remove snap_name arg from rbd_add_parse_args()
Date: Mon, 29 Oct 2012 14:26:05 -0700
Message-ID: <508EF46D.3090208@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com> <508B1653.7000709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63470 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699Ab2J2V0P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 17:26:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4550410pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 14:26:14 -0700 (PDT)
In-Reply-To: <508B1653.7000709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/26/2012 04:01 PM, Alex Elder wrote:
> The snapshot name returned by rbd_add_parse_args() just gets saved
> in the rbd_dev eventually.  So just do that inside that function and
> do away with the snap_name argument, both in rbd_add_parse_args()
> and rbd_dev_set_mapping().
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f900f3b..948a084 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -665,23 +665,22 @@ static int snap_by_name(struct rbd_device
> *rbd_dev, const char *snap_name)
>   	return -ENOENT;
>   }
>
> -static int rbd_dev_set_mapping(struct rbd_device *rbd_dev, char *snap_name)
> +static int rbd_dev_set_mapping(struct rbd_device *rbd_dev)
>   {
>   	int ret;
>
> -	if (!memcmp(snap_name, RBD_SNAP_HEAD_NAME,
> +	if (!memcmp(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
>   		    sizeof (RBD_SNAP_HEAD_NAME))) {
>   		rbd_dev->snap_id = CEPH_NOSNAP;
>   		rbd_dev->mapping.size = rbd_dev->header.image_size;
>   		rbd_dev->mapping.features = rbd_dev->header.features;
>   		ret = 0;
>   	} else {
> -		ret = snap_by_name(rbd_dev, snap_name);
> +		ret = snap_by_name(rbd_dev, rbd_dev->snap_name);
>   		if (ret < 0)
>   			goto done;
>   		rbd_dev->mapping.read_only = true;
>   	}
> -	rbd_dev->snap_name = snap_name;
>   	rbd_dev->exists = true;
>   done:
>   	return ret;
> @@ -2843,8 +2842,7 @@ static inline char *dup_token(const char **buf,
> size_t *lenp)
>    * Note: rbd_dev is assumed to have been initially zero-filled.
>    */
>   static struct ceph_options *rbd_add_parse_args(struct rbd_device *rbd_dev,
> -						const char *buf,
> -						char **snap_name)
> +						const char *buf)
>   {
>   	size_t len;
>   	const char *mon_addrs;
> @@ -2893,11 +2891,11 @@ static struct ceph_options
> *rbd_add_parse_args(struct rbd_device *rbd_dev,
>   		err_ptr = ERR_PTR(-ENAMETOOLONG);
>   		goto out_err;
>   	}
> -	*snap_name = kmalloc(len + 1, GFP_KERNEL);
> -	if (!*snap_name)
> +	rbd_dev->snap_name = kmalloc(len + 1, GFP_KERNEL);
> +	if (!rbd_dev->snap_name)
>   		goto out_mem;
> -	memcpy(*snap_name, buf, len);
> -	*(*snap_name + len) = '\0';
> +	memcpy(rbd_dev->snap_name, buf, len);
> +	*(rbd_dev->snap_name + len) = '\0';
>
>   	/* Initialize all rbd options to the defaults */
>
> @@ -3132,7 +3130,6 @@ static ssize_t rbd_add(struct bus_type *bus,
>   		       size_t count)
>   {
>   	struct rbd_device *rbd_dev = NULL;
> -	char *snap_name;
>   	struct ceph_options *ceph_opts;
>   	struct ceph_osd_client *osdc;
>   	int rc = -ENOMEM;
> @@ -3151,7 +3148,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	init_rwsem(&rbd_dev->header_rwsem);
>
>   	/* parse add command */
> -	ceph_opts = rbd_add_parse_args(rbd_dev, buf, &snap_name);
> +	ceph_opts = rbd_add_parse_args(rbd_dev, buf);
>   	if (IS_ERR(ceph_opts)) {
>   		rc = PTR_ERR(ceph_opts);
>   		goto err_out_mem;
> @@ -3178,7 +3175,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	if (rc)
>   		goto err_out_probe;
>
> -	rc = rbd_dev_set_mapping(rbd_dev, snap_name);
> +	rc = rbd_dev_set_mapping(rbd_dev);
>   	if (rc)
>   		goto err_out_snaps;
>

