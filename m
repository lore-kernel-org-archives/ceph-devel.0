From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/3] rbd: drop parent_ref in rbd_dev_unprobe() unconditionally
Date: Mon, 26 Jan 2015 21:40:36 -0600
Message-ID: <54C708B4.1070804@ieee.org>
References: <1421757669-38796-1-git-send-email-idryomov@redhat.com> <1421757669-38796-3-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:53047 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbA0Dki (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jan 2015 22:40:38 -0500
Received: by mail-ig0-f180.google.com with SMTP id b16so2487628igk.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2015 19:40:38 -0800 (PST)
In-Reply-To: <1421757669-38796-3-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@redhat.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 01/20/2015 06:41 AM, Ilya Dryomov wrote:
> This effectively reverts the last hunk of 392a9dad7e77 ("rbd: detect
> when clone image is flattened").
> 
> The problem with parent_overlap != 0 condition is that it's possible
> and completely valid to have an image with parent_overlap == 0 whose
> parent state needs to be cleaned up on unmap.  The next commit, which
> drops the "clone image now standalone" logic, opens up another window
> of opportunity to hit this, but even without it
> 
>     # cat parent-ref.sh
>     #!/bin/bash
>     rbd create --image-format 2 --size 1 foo
>     rbd snap create foo@snap
>     rbd snap protect foo@snap
>     rbd clone foo@snap bar
>     rbd resize --allow-shrink --size 0 bar
>     rbd resize --size 1 bar
>     DEV=$(rbd map bar)
>     rbd unmap $DEV
> 
> leaves rbd_device/rbd_spec/etc and rbd_client along with ceph_client
> hanging around.

I'm not sure why the last reference to the parent
doesn't get dropped (and state cleaned up) as soon
as the overlap becomes 0.  I suspect it's the original
reference taken when there's a parent, we don't get
rid of it until it's torn down.  (I think we should.)

It seems to me the test here should be for a non-null
parent_spec pointer rather than non-zero parent_overlap.
And that's done inside rbd_dev_parent_put(), so your
change looks reasonable to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> My thinking behind calling rbd_dev_parent_put() unconditionally is that
> there shouldn't be any requests in flight at that point in time as we
> are deep into unmap sequence.  Hence, even if rbd_dev_unparent() caused
> by flatten is delayed by in-flight requests, it will have finished by
> the time we reach rbd_dev_unprobe() caused by unmap, thus turning
> unconditional rbd_dev_parent_put() into a no-op.
> 
> Fixes: http://tracker.ceph.com/issues/10352
> 
> Cc: stable@vger.kernel.org # 3.11+
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
> ---
>  drivers/block/rbd.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 2990a1c75159..b85d52005a21 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5075,10 +5075,7 @@ static void rbd_dev_unprobe(struct rbd_device *rbd_dev)
>  {
>  	struct rbd_image_header	*header;
>  
> -	/* Drop parent reference unless it's already been done (or none) */
> -
> -	if (rbd_dev->parent_overlap)
> -		rbd_dev_parent_put(rbd_dev);
> +	rbd_dev_parent_put(rbd_dev);
>  
>  	/* Free dynamic fields from the header, then zero it out */
>  
> 

