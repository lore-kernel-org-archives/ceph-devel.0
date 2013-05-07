From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH 3/6] rbd: don't print warning if not mapping a parent
Date: Tue, 07 May 2013 07:21:27 -0700
Message-ID: <1f013a40-6a47-4e87-afe0-ee035ae7e4d5@email.android.com>
References: <51885A97.9070005@inktank.com> <51885AF1.5080609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49098 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab3EGOrz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 10:47:55 -0400
In-Reply-To: <51885AF1.5080609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

Alex Elder <elder@inktank.com> wrote:

>The presence of the LAYERING bit in an rbd image's feature mask does
>not guarantee the image actually has a parent image.  Currently that
>bit is set only when a clone (i.e., image with a parent) is created,
>but it is (currently) not cleared if that clone gets flattened back
>into a "normal" image.  A "parent_id" query will leave the
>parent_spec for the image being mapped a null pointer, but will not
>return an error.
>
>Currently, whenever an image with the LAYERED feature gets mapped, a
>warning about the use of layered images gets printed.  But we don't
>want to do this for a flattened image, so print the warning only
>if we find there is a parent spec after the probe.
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> drivers/block/rbd.c |   11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>index 0a24cdf..7d93dbd 100644
>--- a/drivers/block/rbd.c
>+++ b/drivers/block/rbd.c
>@@ -4567,13 +4567,14 @@ static int rbd_dev_v2_probe(struct rbd_device
>*rbd_dev)
> 		ret = rbd_dev_v2_parent_info(rbd_dev);
> 		if (ret)
> 			goto out_err;
>-
> 		/*
>-		 * Don't print a warning for parent images.  We can
>-		 * tell this point because we won't know its pool
>-		 * name yet (just its pool id).
>+		 * Print a warning if this image has a parent.
>+		 * Don't print it if the image now being probed
>+		 * is itself a parent.  We can tell at this point
>+		 * because we won't know its pool name yet (just its
>+		 * pool id).
> 		 */
>-		if (rbd_dev->spec->pool_name)
>+		if (rbd_dev->parent_spec && rbd_dev->spec->pool_name)
> 			rbd_warn(rbd_dev, "WARNING: kernel layering "
> 					"is EXPERIMENTAL!");
> 	}

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
