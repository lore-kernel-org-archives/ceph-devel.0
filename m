From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 6/6] rbd: always set read-only flag in rbd_add()
Date: Tue, 07 May 2013 15:51:35 -0700
Message-ID: <51898577.7040509@inktank.com>
References: <51885A97.9070005@inktank.com> <51885B13.4070900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33829 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3EGWwk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 18:52:40 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so756006pdj.40
        for <ceph-devel@vger.kernel.org>; Tue, 07 May 2013 15:52:40 -0700 (PDT)
In-Reply-To: <51885B13.4070900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/06/2013 06:38 PM, Alex Elder wrote:
> Hold off setting the read-only flag in rbd_add() for an image being
> mapped until we have successfully probed the image.  At that point
> we know whether it's a snapshot mapping or not, so we can set the
> read-only flag in that one place rather than doing so (for
> snapshots) in rbd_dev_mapping_set().  To do this, pass a flag to the
> image probe routine indicating whether we want a read-only mapping.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 530793a..0c72643 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -359,7 +359,7 @@ static ssize_t rbd_add(struct bus_type *bus, const
> char *buf,
>   		       size_t count);
>   static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
>   			  size_t count);
> -static int rbd_dev_image_probe(struct rbd_device *rbd_dev);
> +static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool read_only);
>
>   static struct bus_attribute rbd_bus_attrs[] = {
>   	__ATTR(add, S_IWUSR, NULL, rbd_add),
> @@ -951,11 +951,6 @@ static int rbd_dev_mapping_set(struct rbd_device
> *rbd_dev)
>   	rbd_dev->mapping.size = size;
>   	rbd_dev->mapping.features = features;
>
> -	/* If we are mapping a snapshot it must be marked read-only */
> -
> -	if (snap_id != CEPH_NOSNAP)
> -		rbd_dev->mapping.read_only = true;
> -
>   	return 0;
>   }
>
> @@ -963,7 +958,6 @@ static void rbd_dev_mapping_clear(struct rbd_device
> *rbd_dev)
>   {
>   	rbd_dev->mapping.size = 0;
>   	rbd_dev->mapping.features = 0;
> -	rbd_dev->mapping.read_only = true;
>   }
>
>   static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
> @@ -4620,7 +4614,7 @@ static int rbd_dev_probe_parent(struct rbd_device
> *rbd_dev)
>   	if (!parent)
>   		goto out_err;
>
> -	ret = rbd_dev_image_probe(parent);
> +	ret = rbd_dev_image_probe(parent, true);
>   	if (ret < 0)
>   		goto out_err;
>   	rbd_dev->parent = parent;
> @@ -4743,7 +4737,7 @@ static void rbd_dev_image_release(struct
> rbd_device *rbd_dev)
>    * device.  For format 2 images this includes determining the image
>    * id.
>    */
> -static int rbd_dev_image_probe(struct rbd_device *rbd_dev)
> +static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool read_only)
>   {
>   	int ret;
>   	int tmp;
> @@ -4778,6 +4772,12 @@ static int rbd_dev_image_probe(struct rbd_device
> *rbd_dev)
>   	if (ret)
>   		goto err_out_probe;
>
> +	/* If we are mapping a snapshot it must be marked read-only */
> +
> +	if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
> +		read_only = true;
> +	rbd_dev->mapping.read_only = read_only;
> +
>   	ret = rbd_dev_probe_parent(rbd_dev);
>   	if (!ret)
>   		return 0;
> @@ -4811,6 +4811,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	struct rbd_spec *spec = NULL;
>   	struct rbd_client *rbdc;
>   	struct ceph_osd_client *osdc;
> +	bool read_only;
>   	int rc = -ENOMEM;
>
>   	if (!try_module_get(THIS_MODULE))
> @@ -4820,6 +4821,9 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	rc = rbd_add_parse_args(buf, &ceph_opts, &rbd_opts, &spec);
>   	if (rc < 0)
>   		goto err_out_module;
> +	read_only = rbd_opts->read_only;
> +	kfree(rbd_opts);
> +	rbd_opts = NULL;	/* done with this */
>
>   	rbdc = rbd_get_client(ceph_opts);
>   	if (IS_ERR(rbdc)) {
> @@ -4850,11 +4854,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	rbdc = NULL;		/* rbd_dev now owns this */
>   	spec = NULL;		/* rbd_dev now owns this */
>
> -	rbd_dev->mapping.read_only = rbd_opts->read_only;
> -	kfree(rbd_opts);
> -	rbd_opts = NULL;	/* done with this */

It looks like this was moved accidentally? Maybe needed
by a later patch?

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> -
> -	rc = rbd_dev_image_probe(rbd_dev);
> +	rc = rbd_dev_image_probe(rbd_dev, read_only);
>   	if (rc < 0)
>   		goto err_out_rbd_dev;
>

