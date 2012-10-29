From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/8] rbd: get rid of snap_name_len
Date: Mon, 29 Oct 2012 14:14:28 -0700
Message-ID: <508EF1B4.8080107@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com> <508B15FA.7040008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33767 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760972Ab2J2VOj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 17:14:39 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3712671pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 14:14:39 -0700 (PDT)
In-Reply-To: <508B15FA.7040008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/26/2012 04:00 PM, Alex Elder wrote:
> The value returned in the "snap_name_len" argument to
> rbd_add_parse_args() is never actually used, so get rid of it.
>
> The snap_name_len recorded in *rbd_dev_v2_snap_name() is not
> useful either, so get rid of that too.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4fe14ff..cae7423 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2408,7 +2408,6 @@ static char *rbd_dev_v2_snap_name(struct
> rbd_device *rbd_dev, u32 which)
>   	int ret;
>   	void *p;
>   	void *end;
> -	size_t snap_name_len;
>   	char *snap_name;
>
>   	size = sizeof (__le32) + RBD_MAX_SNAP_NAME_LEN;
> @@ -2428,9 +2427,7 @@ static char *rbd_dev_v2_snap_name(struct
> rbd_device *rbd_dev, u32 which)
>
>   	p = reply_buf;
>   	end = (char *) reply_buf + size;
> -	snap_name_len = 0;
> -	snap_name = ceph_extract_encoded_string(&p, end, &snap_name_len,
> -				GFP_KERNEL);
> +	snap_name = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
>   	if (IS_ERR(snap_name)) {
>   		ret = PTR_ERR(snap_name);
>   		goto out;
> @@ -2849,8 +2846,7 @@ static struct ceph_options
> *rbd_add_parse_args(struct rbd_device *rbd_dev,
>   						const char *buf,
>   						char *options,
>   						size_t options_size,
> -						char **snap_name,
> -						size_t *snap_name_len)
> +						char **snap_name)
>   {
>   	size_t len;
>   	const char *mon_addrs;
> @@ -2898,7 +2894,7 @@ static struct ceph_options
> *rbd_add_parse_args(struct rbd_device *rbd_dev,
>   		goto out_err;
>   	memcpy(*snap_name, buf, len);
>   	*(*snap_name + len) = '\0';
> -	*snap_name_len = len;
> +
>   	/* Initialize all rbd options to the defaults */
>
>   	rbd_opts.read_only = RBD_READ_ONLY_DEFAULT;
> @@ -3131,7 +3127,6 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	char *options;
>   	struct rbd_device *rbd_dev = NULL;
>   	char *snap_name;
> -	size_t snap_name_len = 0;
>   	struct ceph_options *ceph_opts;
>   	struct ceph_osd_client *osdc;
>   	int rc = -ENOMEM;
> @@ -3154,7 +3149,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>
>   	/* parse add command */
>   	ceph_opts = rbd_add_parse_args(rbd_dev, buf, options, count,
> -				&snap_name, &snap_name_len);
> +				&snap_name);
>   	if (IS_ERR(ceph_opts)) {
>   		rc = PTR_ERR(ceph_opts);
>   		goto err_out_mem;
>

