From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/3] rbd: do not treat standalone as flatten
Date: Mon, 26 Jan 2015 21:55:19 -0600
Message-ID: <54C70C27.6000301@ieee.org>
References: <1421757669-38796-1-git-send-email-idryomov@redhat.com> <1421757669-38796-4-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63618 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbA0DzV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jan 2015 22:55:21 -0500
Received: by mail-ie0-f172.google.com with SMTP id rd18so12882383iec.3
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2015 19:55:20 -0800 (PST)
In-Reply-To: <1421757669-38796-4-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@redhat.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 01/20/2015 06:41 AM, Ilya Dryomov wrote:
> If the clone is resized down to 0, it becomes standalone.  If such
> resize is carried over while an image is mapped we would detect this
> and call rbd_dev_parent_put() which means "let go of all parent state,
> including the spec(s) of parent images(s)".  This leads to a mismatch
> between "rbd info" and sysfs parent fields, so a fix is in order.
> 
>     # rbd create --image-format 2 --size 1 foo
>     # rbd snap create foo@snap
>     # rbd snap protect foo@snap
>     # rbd clone foo@snap bar
>     # DEV=$(rbd map bar)
>     # rbd resize --allow-shrink --size 0 bar
>     # rbd resize --size 1 bar
>     # rbd info bar | grep parent
>             parent: rbd/foo@snap
> 
> Before:
> 
>     # cat /sys/bus/rbd/devices/0/parent
>     (no parent image)
> 
> After:
> 
>     # cat /sys/bus/rbd/devices/0/parent
>     pool_id 0
>     pool_name rbd
>     image_id 10056b8b4567
>     image_name foo
>     snap_id 2
>     snap_name snap
>     overlap 0
> 
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>

Hmm.  Interesting.

I think that a parent with an overlap of 0 is of no
real use.  So in the last patch I was suggesting it
should just go away.

But now, looking at it from this perspective, the fact
that an image *came from* a particular parent, but which
has no more overlap, could be useful information.  The
parent shouldn't simply go away without the user requesting
that.

I haven't completely followed through the logic of keeping
the reference around but I understand what you're doing and
it looks OK to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b85d52005a21..e818c2a6ffb1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4273,32 +4273,22 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
>  	}
>  
>  	/*
> -	 * We always update the parent overlap.  If it's zero we
> -	 * treat it specially.
> +	 * We always update the parent overlap.  If it's zero we issue
> +	 * a warning, as we will proceed as if there was no parent.
>  	 */
> -	rbd_dev->parent_overlap = overlap;
>  	if (!overlap) {
> -
> -		/* A null parent_spec indicates it's the initial probe */
> -
>  		if (parent_spec) {
> -			/*
> -			 * The overlap has become zero, so the clone
> -			 * must have been resized down to 0 at some
> -			 * point.  Treat this the same as a flatten.
> -			 */
> -			rbd_dev_parent_put(rbd_dev);
> -			pr_info("%s: clone image now standalone\n",
> -				rbd_dev->disk->disk_name);
> +			/* refresh, careful to warn just once */
> +			if (rbd_dev->parent_overlap)
> +				rbd_warn(rbd_dev,
> +				    "clone now standalone (overlap became 0)");
>  		} else {
> -			/*
> -			 * For the initial probe, if we find the
> -			 * overlap is zero we just pretend there was
> -			 * no parent image.
> -			 */
> -			rbd_warn(rbd_dev, "ignoring parent with overlap 0");
> +			/* initial probe */
> +			rbd_warn(rbd_dev, "clone is standalone (overlap 0)");
>  		}
>  	}
> +	rbd_dev->parent_overlap = overlap;
> +
>  out:
>  	ret = 0;
>  out_err:
> 

