From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [PATCH] rbd: prevent kernel stack blow up on rbd map
Date: Wed, 14 Oct 2015 19:03:34 -0700
Message-ID: <561F0976.6030201@redhat.com>
References: <1444586747-24268-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48717 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbbJOCC2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Oct 2015 22:02:28 -0400
In-Reply-To: <1444586747-24268-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Xudong Cao <cao.xudong@h3c.com>

On 10/11/2015 11:05 AM, Ilya Dryomov wrote:
> Mapping an image with a long parent chain (e.g. image foo, whose parent
> is bar, whose parent is baz, etc) currently leads to a kernel stack
> overflow, due to the following recursion in the reply path:
>
>    rbd_osd_req_callback()
>      rbd_obj_request_complete()
>        rbd_img_obj_callback()
>          rbd_img_parent_read_callback()
>            rbd_obj_request_complete()
>              ...
>
> Limit the parent chain to 8 images, which is ~3K worth of stack.  It's
> probably a good thing to do regardless - performance with more than
> a few images long parent chain is likely to be pretty bad.

Long term I don't think a limit is necessary. With object map, there's
no real performance penalty for long chains. Once the recursion is
removed, we can get rid of the limit.

This is a simple backportable fix for now though, and it looks good to
me.

Reviewed-by: Josh Durgin <jdurgin@redhat.com>

> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>   drivers/block/rbd.c | 33 +++++++++++++++++++++++----------
>   1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index ccbc3cbbf24e..07f666f4ca18 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -96,6 +96,8 @@ static int atomic_dec_return_safe(atomic_t *v)
>   #define RBD_MINORS_PER_MAJOR		256
>   #define RBD_SINGLE_MAJOR_PART_SHIFT	4
>
> +#define RBD_MAX_PARENT_CHAIN_LEN	8
> +
>   #define RBD_SNAP_DEV_NAME_PREFIX	"snap_"
>   #define RBD_MAX_SNAP_NAME_LEN	\
>   			(NAME_MAX - (sizeof (RBD_SNAP_DEV_NAME_PREFIX) - 1))
> @@ -426,7 +428,7 @@ static ssize_t rbd_add_single_major(struct bus_type *bus, const char *buf,
>   				    size_t count);
>   static ssize_t rbd_remove_single_major(struct bus_type *bus, const char *buf,
>   				       size_t count);
> -static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping);
> +static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth);
>   static void rbd_spec_put(struct rbd_spec *spec);
>
>   static int rbd_dev_id_to_minor(int dev_id)
> @@ -5131,7 +5133,12 @@ out_err:
>   	return ret;
>   }
>
> -static int rbd_dev_probe_parent(struct rbd_device *rbd_dev)
> +/*
> + * @depth is rbd_dev_image_probe() -> rbd_dev_probe_parent() ->
> + * rbd_dev_image_probe() recursion depth, which means it's also the
> + * length of the already discovered part of the parent chain.
> + */
> +static int rbd_dev_probe_parent(struct rbd_device *rbd_dev, int depth)
>   {
>   	struct rbd_device *parent = NULL;
>   	int ret;
> @@ -5139,6 +5146,12 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev)
>   	if (!rbd_dev->parent_spec)
>   		return 0;
>
> +	if (++depth > RBD_MAX_PARENT_CHAIN_LEN) {
> +		pr_info("parent chain is too long (%d)\n", depth);
> +		ret = -EINVAL;
> +		goto out_err;
> +	}
> +
>   	parent = rbd_dev_create(rbd_dev->rbd_client, rbd_dev->parent_spec,
>   				NULL);
>   	if (!parent) {
> @@ -5153,7 +5166,7 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev)
>   	__rbd_get_client(rbd_dev->rbd_client);
>   	rbd_spec_get(rbd_dev->parent_spec);
>
> -	ret = rbd_dev_image_probe(parent, false);
> +	ret = rbd_dev_image_probe(parent, depth);
>   	if (ret < 0)
>   		goto out_err;
>
> @@ -5282,7 +5295,7 @@ static void rbd_dev_image_release(struct rbd_device *rbd_dev)
>    * parent), initiate a watch on its header object before using that
>    * object to get detailed information about the rbd image.
>    */
> -static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
> +static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
>   {
>   	int ret;
>
> @@ -5300,7 +5313,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
>   	if (ret)
>   		goto err_out_format;
>
> -	if (mapping) {
> +	if (!depth) {
>   		ret = rbd_dev_header_watch_sync(rbd_dev);
>   		if (ret) {
>   			if (ret == -ENOENT)
> @@ -5321,7 +5334,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
>   	 * Otherwise this is a parent image, identified by pool, image
>   	 * and snap ids - need to fill in names for those ids.
>   	 */
> -	if (mapping)
> +	if (!depth)
>   		ret = rbd_spec_fill_snap_id(rbd_dev);
>   	else
>   		ret = rbd_spec_fill_names(rbd_dev);
> @@ -5343,12 +5356,12 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
>   		 * Need to warn users if this image is the one being
>   		 * mapped and has a parent.
>   		 */
> -		if (mapping && rbd_dev->parent_spec)
> +		if (!depth && rbd_dev->parent_spec)
>   			rbd_warn(rbd_dev,
>   				 "WARNING: kernel layering is EXPERIMENTAL!");
>   	}
>
> -	ret = rbd_dev_probe_parent(rbd_dev);
> +	ret = rbd_dev_probe_parent(rbd_dev, depth);
>   	if (ret)
>   		goto err_out_probe;
>
> @@ -5359,7 +5372,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
>   err_out_probe:
>   	rbd_dev_unprobe(rbd_dev);
>   err_out_watch:
> -	if (mapping)
> +	if (!depth)
>   		rbd_dev_header_unwatch_sync(rbd_dev);
>   out_header_name:
>   	kfree(rbd_dev->header_name);
> @@ -5422,7 +5435,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
>   	spec = NULL;		/* rbd_dev now owns this */
>   	rbd_opts = NULL;	/* rbd_dev now owns this */
>
> -	rc = rbd_dev_image_probe(rbd_dev, true);
> +	rc = rbd_dev_image_probe(rbd_dev, 0);
>   	if (rc < 0)
>   		goto err_out_rbd_dev;
>
>

