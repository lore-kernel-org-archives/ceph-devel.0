From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/3] rbd: fix rbd_dev_parent_get() when parent_overlap
 == 0
Date: Tue, 20 Jan 2015 17:22:15 -0800
Message-ID: <54BEFF47.1050202@inktank.com>
References: <1421757669-38796-1-git-send-email-idryomov@redhat.com> <1421757669-38796-2-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:57418 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbbAUBay (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 20:30:54 -0500
In-Reply-To: <1421757669-38796-2-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@redhat.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 01/20/2015 04:41 AM, Ilya Dryomov wrote:
> The comment for rbd_dev_parent_get() said
>
>      * We must get the reference before checking for the overlap to
>      * coordinate properly with zeroing the parent overlap in
>      * rbd_dev_v2_parent_info() when an image gets flattened.  We
>      * drop it again if there is no overlap.
>
> but the "drop it again if there is no overlap" part was missing from
> the implementation.  This lead to absurd parent_ref values for images
> with parent_overlap == 0, as parent_ref was incremented for each
> img_request and virtually never decremented.
>
> Fix this by leveraging the fact that refresh path calls
> rbd_dev_v2_parent_info() under header_rwsem and use it for read in
> rbd_dev_parent_get(), instead of messing around with atomics.  Get rid
> of barriers in rbd_dev_v2_parent_info() while at it - I don't see what
> they'd pair with now and I suspect we are in a pretty miserable
> situation as far as proper locking goes regardless.

Yeah, looks like we need some refactoring to read parent_overlap safely
in the I/O path in a few places.

Reviewed-by: Josh Durgin <jdurgin@redhat.com>

> Cc: stable@vger.kernel.org # 3.11+
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
> ---
>   drivers/block/rbd.c | 20 ++++++--------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 31fa00f0d707..2990a1c75159 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2098,32 +2098,26 @@ static void rbd_dev_parent_put(struct rbd_device *rbd_dev)
>    * If an image has a non-zero parent overlap, get a reference to its
>    * parent.
>    *
> - * We must get the reference before checking for the overlap to
> - * coordinate properly with zeroing the parent overlap in
> - * rbd_dev_v2_parent_info() when an image gets flattened.  We
> - * drop it again if there is no overlap.
> - *
>    * Returns true if the rbd device has a parent with a non-zero
>    * overlap and a reference for it was successfully taken, or
>    * false otherwise.
>    */
>   static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
>   {
> -	int counter;
> +	int counter = 0;
>
>   	if (!rbd_dev->parent_spec)
>   		return false;
>
> -	counter = atomic_inc_return_safe(&rbd_dev->parent_ref);
> -	if (counter > 0 && rbd_dev->parent_overlap)
> -		return true;
> -
> -	/* Image was flattened, but parent is not yet torn down */
> +	down_read(&rbd_dev->header_rwsem);
> +	if (rbd_dev->parent_overlap)
> +		counter = atomic_inc_return_safe(&rbd_dev->parent_ref);
> +	up_read(&rbd_dev->header_rwsem);
>
>   	if (counter < 0)
>   		rbd_warn(rbd_dev, "parent reference overflow");
>
> -	return false;
> +	return counter > 0;
>   }
>
>   /*
> @@ -4238,7 +4232,6 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
>   		 */
>   		if (rbd_dev->parent_overlap) {
>   			rbd_dev->parent_overlap = 0;
> -			smp_mb();
>   			rbd_dev_parent_put(rbd_dev);
>   			pr_info("%s: clone image has been flattened\n",
>   				rbd_dev->disk->disk_name);
> @@ -4284,7 +4277,6 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
>   	 * treat it specially.
>   	 */
>   	rbd_dev->parent_overlap = overlap;
> -	smp_mb();
>   	if (!overlap) {
>
>   		/* A null parent_spec indicates it's the initial probe */
>

