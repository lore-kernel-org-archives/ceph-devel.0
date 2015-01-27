From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/3] rbd: fix rbd_dev_parent_get() when parent_overlap
 == 0
Date: Mon, 26 Jan 2015 21:14:44 -0600
Message-ID: <54C702A4.9030900@ieee.org>
References: <1421757669-38796-1-git-send-email-idryomov@redhat.com> <1421757669-38796-2-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33155 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583AbbA0DOr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jan 2015 22:14:47 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so12818238ieb.2
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2015 19:14:46 -0800 (PST)
In-Reply-To: <1421757669-38796-2-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@redhat.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 01/20/2015 06:41 AM, Ilya Dryomov wrote:
> The comment for rbd_dev_parent_get() said
> 
>     * We must get the reference before checking for the overlap to
>     * coordinate properly with zeroing the parent overlap in
>     * rbd_dev_v2_parent_info() when an image gets flattened.  We
>     * drop it again if there is no overlap.
> 
> but the "drop it again if there is no overlap" part was missing from
> the implementation.  This lead to absurd parent_ref values for images
> with parent_overlap == 0, as parent_ref was incremented for each
> img_request and virtually never decremented.

You're right about this.  If the image had a parent with no
overlap this would leak a reference to the parent image.  The
code should have said:

	counter = atomic_inc_return_safe(&rbd_dev->parent_ref);
	if (counter > 0) {
		if (rbd_dev->parent_overlap)
			return true;
		atomic_dec(&rbd_dev->parent_ref);
	} else if (counter < 0) {
 		rbd_warn(rbd_dev, "parent reference overflow");
	}

> Fix this by leveraging the fact that refresh path calls
> rbd_dev_v2_parent_info() under header_rwsem and use it for read in
> rbd_dev_parent_get(), instead of messing around with atomics.  Get rid
> of barriers in rbd_dev_v2_parent_info() while at it - I don't see what
> they'd pair with now and I suspect we are in a pretty miserable
> situation as far as proper locking goes regardless.

The point of the memory barrier was to ensure that when parent_overlap
gets zeroed, this code sees the zero rather than the old non-zero
value.  The atomic_inc_return_safe() call has an implicit memory
barrier to match the smp_mb() call.  It allowed the synchronization
to occur without the use of a lock.

We're trying to atomically determine whether an image request needs
to be marked as layered, to know how to handle ENOENT on parent reads.
If it is a write to an image with a parent having a non-zero overlap,
it's layered, otherwise we can treat it as a simple request.

I think in this particular case, this is just an optimization,
trying very hard to avoid having to do layered image handling
if the parent has become flattened.  I think that even if it
got old information (suggesting non-zero overlap) things would
behave correctly, just less efficiently.

Using the semaphore adds a lock to this path and therefore
implements whatever barriers are being removed.  I'm not
sure how often this is hit--maybe the optimization isn't
buying much after all.

I am getting a little rusty on some of details of what
precisely happens when a layered image gets flattened.
But I think this looks OK.  Maybe just watch for small
(perhaps insignificant) performance regressions with
this change in place...

Reviewed-by: Alex Elder <elder@linaro.org>

> Cc: stable@vger.kernel.org # 3.11+
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
> ---
>  drivers/block/rbd.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 31fa00f0d707..2990a1c75159 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2098,32 +2098,26 @@ static void rbd_dev_parent_put(struct rbd_device *rbd_dev)
>   * If an image has a non-zero parent overlap, get a reference to its
>   * parent.
>   *
> - * We must get the reference before checking for the overlap to
> - * coordinate properly with zeroing the parent overlap in
> - * rbd_dev_v2_parent_info() when an image gets flattened.  We
> - * drop it again if there is no overlap.
> - *
>   * Returns true if the rbd device has a parent with a non-zero
>   * overlap and a reference for it was successfully taken, or
>   * false otherwise.
>   */
>  static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
>  {
> -	int counter;
> +	int counter = 0;
>  
>  	if (!rbd_dev->parent_spec)
>  		return false;
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
>  	if (counter < 0)
>  		rbd_warn(rbd_dev, "parent reference overflow");
>  
> -	return false;
> +	return counter > 0;
>  }
>  
>  /*
> @@ -4238,7 +4232,6 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
>  		 */
>  		if (rbd_dev->parent_overlap) {
>  			rbd_dev->parent_overlap = 0;
> -			smp_mb();
>  			rbd_dev_parent_put(rbd_dev);
>  			pr_info("%s: clone image has been flattened\n",
>  				rbd_dev->disk->disk_name);
> @@ -4284,7 +4277,6 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
>  	 * treat it specially.
>  	 */
>  	rbd_dev->parent_overlap = overlap;
> -	smp_mb();
>  	if (!overlap) {
>  
>  		/* A null parent_spec indicates it's the initial probe */
> 

