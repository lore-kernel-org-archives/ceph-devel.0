From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 7/8] rbd: do not read in parent info before snap context
Date: Fri, 25 Jul 2014 03:14:44 -0500
Message-ID: <53D211F4.7060006@ieee.org>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com> <1406191369-6746-8-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:62525 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758946AbaGYIOo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 04:14:44 -0400
Received: by mail-ie0-f178.google.com with SMTP id rd18so3200379iec.23
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 01:14:43 -0700 (PDT)
In-Reply-To: <1406191369-6746-8-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
> Currently rbd_dev_v2_header_info() reads in parent info before the snap
> context is read in.  This is wrong, because we may need to look at the
> the parent_overlap value of the snapshot instead of that of the base

I had some trouble understanding this.

The parent image, snapshot id and overlap, are together a property
of a particular image (and associated with its header object).
Nothing about that is dependent on the child image snapshots
or snapshot id.

However...

> image, for example when mapping a snapshot - see next commit.  (When
> mapping a snapshot, all we got is its name and we need the snap context
> to translate that name into an id to know which parent info to look
> for).

I finally figured out what path through the code you
were talking about.  Here's what I see.

On the initial probe (previously), we have:
  rbd_add()
    do_rbd_add()
      rbd_dev_image_probe()
       |rbd_dev_header_info()
       | |rbd_dev_v2_header_info()
       | | |rbd_dev_v2_parent_info()
       | | | --> expects rbd_dev->spec->snap_id to be valid
       | | |rbd_dev_v2_snap_context()
       | | | --> this fills in the snapshot context
       |rbd_spec_fill_snap_id()
       | | --> fills rbd_dev->spec->snap_id
       |rbd_dev_probe_parent()

So clearly, at least when mapping a snapshot, we would not
get the desired result.  We'll be unable to look up the id
for the named snapshot, so would get ENOENT.

Now you've pulled getting the parent info back out
into rbd_dev_image_probe():
  rbd_add()
    do_rbd_add()
      rbd_dev_image_probe()
       |rbd_dev_header_info()
       | |rbd_dev_v2_header_info()
       | | |rbd_dev_v2_snap_context()
       | | | --> this fills in the snapshot context
       |rbd_spec_fill_snap_id()
       | | --> fills rbd_dev->spec->snap_id
       |rbd_dev_v2_parent_info()
       | | --> rbd_dev->spec->snap_id will be valid
       |rbd_dev_probe_parent()

In the refresh path it's similar.  You move the
rbd_dev_v2_parent_info() call into rbd_dev_refresh()
instead of it happening in rbd_dev_v2_header_info().
Missing the ordering problem here might have caused
even more subtle problems (due to using an apparently
valid but possibly out-of-date snapshot context).

Given this understanding I'd say your change looks
good.

> The approach taken here is to make sure rbd_dev_v2_parent_info() is
> called after the snap context has been read in.  The other approach
> would be to add a parent_overlap field to struct rbd_mapping and
> maintain it the same way rbd_mapping::size is maintained.  The reason
> I chose the first approach is that the value of keeping around both
> base image values and the actual mapping values is unclear to me.

I'll think about this and respond to your followup e-mail.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |   64 ++++++++++++++++++++++++---------------------------
>  1 file changed, 30 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 16f388f2960b..c4606987e9d1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -515,6 +515,7 @@ static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
>  static int rbd_dev_refresh(struct rbd_device *rbd_dev);
>  static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
>  static int rbd_dev_header_info(struct rbd_device *rbd_dev);
> +static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev);
>  static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
>  					u64 snap_id);
>  static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
> @@ -3513,6 +3514,18 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>  	mapping_size = rbd_dev->mapping.size;
>  
>  	ret = rbd_dev_header_info(rbd_dev);

This looked odd.  But I guess I didn't notice you
didn't check the return value when you first added
this line a few patches ago...

> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If there is a parent, see if it has disappeared due to the
> +	 * mapped image getting flattened.
> +	 */
> +	if (rbd_dev->parent) {
> +		ret = rbd_dev_v2_parent_info(rbd_dev);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (rbd_dev->spec->snap_id == CEPH_NOSNAP) {
>  		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
> @@ -3524,11 +3537,10 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>  
>  	up_write(&rbd_dev->header_rwsem);
>  
> -	if (mapping_size != rbd_dev->mapping.size) {
> +	if (mapping_size != rbd_dev->mapping.size)
>  		rbd_dev_update_size(rbd_dev);
> -	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int rbd_init_disk(struct rbd_device *rbd_dev)
> @@ -4477,33 +4489,6 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
>  			return ret;
>  	}
>  
> -	/*
> -	 * If the image supports layering, get the parent info.  We
> -	 * need to probe the first time regardless.  Thereafter we
> -	 * only need to if there's a parent, to see if it has
> -	 * disappeared due to the mapped image getting flattened.
> -	 */
> -	if (rbd_dev->header.features & RBD_FEATURE_LAYERING &&
> -			(first_time || rbd_dev->parent_spec)) {
> -		bool warn;
> -
> -		ret = rbd_dev_v2_parent_info(rbd_dev);
> -		if (ret)
> -			return ret;
> -
> -		/*
> -		 * Print a warning if this is the initial probe and
> -		 * the image has a parent.  Don't print it if the
> -		 * image now being probed is itself a parent.  We
> -		 * can tell at this point because we won't know its
> -		 * pool name yet (just its pool id).
> -		 */
> -		warn = rbd_dev->parent_spec && rbd_dev->spec->pool_name;
> -		if (first_time && warn)
> -			rbd_warn(rbd_dev, "WARNING: kernel layering "
> -					"is EXPERIMENTAL!");
> -	}
> -
>  	ret = rbd_dev_v2_snap_context(rbd_dev);
>  	dout("rbd_dev_v2_snap_context returned %d\n", ret);
>  
> @@ -5183,14 +5168,28 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
>  	if (ret)
>  		goto err_out_probe;
>  
> +	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
> +		ret = rbd_dev_v2_parent_info(rbd_dev);
> +		if (ret)
> +			goto err_out_probe;
> +
> +		/*
> +		 * Need to warn users if this image is the one being
> +		 * mapped and has a parent.
> +		 */
> +		if (mapping && rbd_dev->parent_spec)
> +			rbd_warn(rbd_dev,
> +				 "WARNING: kernel layering is EXPERIMENTAL!");
> +	}
> +
>  	ret = rbd_dev_probe_parent(rbd_dev);
>  	if (ret)
>  		goto err_out_probe;
>  
>  	dout("discovered format %u image, header name is %s\n",
>  		rbd_dev->image_format, rbd_dev->header_name);
> -
>  	return 0;
> +
>  err_out_probe:
>  	rbd_dev_unprobe(rbd_dev);
>  err_out_watch:
> @@ -5203,9 +5202,6 @@ err_out_format:
>  	rbd_dev->image_format = 0;
>  	kfree(rbd_dev->spec->image_id);
>  	rbd_dev->spec->image_id = NULL;
> -
> -	dout("probe failed, returning %d\n", ret);
> -
>  	return ret;
>  }
>  
> 

