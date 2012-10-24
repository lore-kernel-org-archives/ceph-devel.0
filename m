From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/4] rbd: increase maximum snapshot name length
Date: Wed, 24 Oct 2012 12:01:13 -0700
Message-ID: <50883AF9.3080705@inktank.com>
References: <5085791C.9010205@inktank.com> <50857996.70502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45664 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934308Ab2JXTBR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 15:01:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1417456pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 12:01:16 -0700 (PDT)
In-Reply-To: <50857996.70502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is a better limit than before. We still need to
do some clean up of these limits across projects:

http://www.tracker.newdream.net/issues/1701

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/22/2012 09:51 AM, Alex Elder wrote:
> Change RBD_MAX_SNAP_NAME_LEN to be based on NAME_MAX.  That is a
> practical limit for the length of a snapshot name (based on the
> presence of a directory using the name under /sys/bus/rbd to
> represent the snapshot).
>
> The /sys entry is created by prefixing it with "snap_"; define that
> prefix symbolically, and take its length into account in defining
> the snapshot name length limit.
>
> Enforce the limit in rbd_add_parse_args().  Also delete a dout()
> call in that function that was not meant to be committed.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4734446..4858d92 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -61,7 +61,10 @@
>
>   #define RBD_MINORS_PER_MAJOR	256		/* max minors per blkdev */
>
> -#define RBD_MAX_SNAP_NAME_LEN	32
> +#define RBD_SNAP_DEV_NAME_PREFIX	"snap_"
> +#define RBD_MAX_SNAP_NAME_LEN	\
> +			(NAME_MAX - (sizeof (RBD_SNAP_DEV_NAME_PREFIX) - 1))
> +
>   #define RBD_MAX_SNAP_COUNT	510	/* allows max snapc to fit in 4KB */
>   #define RBD_MAX_OPT_LEN		1024
>
> @@ -2063,7 +2066,7 @@ static int rbd_register_snap_dev(struct rbd_snap
> *snap,
>   	dev->type = &rbd_snap_device_type;
>   	dev->parent = parent;
>   	dev->release = rbd_snap_dev_release;
> -	dev_set_name(dev, "snap_%s", snap->name);
> +	dev_set_name(dev, "%s%s", RBD_SNAP_DEV_NAME_PREFIX, snap->name);
>   	dout("%s: registering device for snapshot %s\n", __func__, snap->name);
>
>   	ret = device_register(dev);
> @@ -2797,8 +2800,13 @@ static char *rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>   	if (!rbd_dev->image_name)
>   		goto out_err;
>
> -	/* Snapshot name is optional */
> +	/* Snapshot name is optional; default is to use "head" */
> +
>   	len = next_token(&buf);
> +	if (len > RBD_MAX_SNAP_NAME_LEN) {
> +		err_ptr = ERR_PTR(-ENAMETOOLONG);
> +		goto out_err;
> +	}
>   	if (!len) {
>   		buf = RBD_SNAP_HEAD_NAME; /* No snapshot supplied */
>   		len = sizeof (RBD_SNAP_HEAD_NAME) - 1;
> @@ -2809,8 +2817,6 @@ static char *rbd_add_parse_args(struct rbd_device
> *rbd_dev,
>   	memcpy(snap_name, buf, len);
>   	*(snap_name + len) = '\0';
>
> -dout("    SNAP_NAME is <%s>, len is %zd\n", snap_name, len);
> -
>   	return snap_name;
>
>   out_err:
>

