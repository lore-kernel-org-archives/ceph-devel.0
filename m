From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH 4/4] rbd: kill rbd_device->rbd_opts
Date: Wed, 24 Oct 2012 15:37:26 -0700
Message-ID: <50886DA6.4030508@inktank.com>
References: <5085791C.9010205@inktank.com> <508579A5.7070008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47593 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422652Ab2JXWh3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 18:37:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1534297pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 15:37:29 -0700 (PDT)
In-Reply-To: <508579A5.7070008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Dan Mick <dan.mick@inktank.com>

On 10/22/2012 09:51 AM, Alex Elder wrote:
> The rbd_device structure has an embedded rbd_options structure.
> Such a structure is needed to work with the generic ceph argument
> parsing code, but there's no need to keep it around once argument
> parsing is done.
>
> Use a local variable to hold the rbd options used in parsing in
> rbd_get_client(), and just transfer its content (it's just a
> read_only flag) into the field in the rbd_mapping sub-structure
> that requires that information.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4ccce4d..3c131ab 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -184,7 +184,6 @@ struct rbd_device {
>   	struct gendisk		*disk;		/* blkdev's gendisk and rq */
>
>   	u32			image_format;	/* Either 1 or 2 */
> -	struct rbd_options	rbd_opts;
>   	struct rbd_client	*rbd_client;
>
>   	char			name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */
> @@ -456,18 +455,24 @@ static int parse_rbd_opts_token(char *c, void
> *private)
>   static int rbd_get_client(struct rbd_device *rbd_dev, const char *mon_addr,
>   				size_t mon_addr_len, char *options)
>   {
> -	struct rbd_options *rbd_opts = &rbd_dev->rbd_opts;
> +	struct rbd_options rbd_opts;
>   	struct ceph_options *ceph_opts;
>   	struct rbd_client *rbdc;
>
> -	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
> +	/* Initialize all rbd options to the defaults */
> +
> +	rbd_opts.read_only = RBD_READ_ONLY_DEFAULT;
>
>   	ceph_opts = ceph_parse_options(options, mon_addr,
>   					mon_addr + mon_addr_len,
> -					parse_rbd_opts_token, rbd_opts);
> +					parse_rbd_opts_token, &rbd_opts);
>   	if (IS_ERR(ceph_opts))
>   		return PTR_ERR(ceph_opts);
>
> +	/* Record the parsed rbd options */
> +
> +	rbd_dev->mapping.read_only = rbd_opts.read_only;
> +
>   	rbdc = rbd_client_find(ceph_opts);
>   	if (rbdc) {
>   		/* using an existing client */
> @@ -685,7 +690,6 @@ static int rbd_dev_set_mapping(struct rbd_device
> *rbd_dev, char *snap_name)
>   		rbd_dev->mapping.size = rbd_dev->header.image_size;
>   		rbd_dev->mapping.features = rbd_dev->header.features;
>   		rbd_dev->mapping.snap_exists = false;
> -		rbd_dev->mapping.read_only = rbd_dev->rbd_opts.read_only;
>   		ret = 0;
>   	} else {
>   		ret = snap_by_name(rbd_dev, snap_name);
>
