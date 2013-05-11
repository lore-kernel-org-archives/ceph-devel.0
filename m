From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: ignore zero-overlap parent
Date: Sat, 11 May 2013 12:29:28 -0700
Message-ID: <518E9C18.5050205@inktank.com>
References: <518E8203.6050308@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:33590 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab3EKT3T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 15:29:19 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro8so999722pbb.41
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 12:29:18 -0700 (PDT)
In-Reply-To: <518E8203.6050308@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/11/2013 10:38 AM, Alex Elder wrote:
> An rbd clone image that has an overlap with its parent of 0 is
> effectively not a layered image at all.  Detect this case and treat
> such an image as non-layered.  Issue a warning to be sure the user
> knows what's going on.
>
> This resolves:
>      http://tracker.ceph.com/issues/5028
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b9221a0..3a8135f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3655,9 +3655,13 @@ static int rbd_dev_v2_parent_info(struct
> rbd_device *rbd_dev)
>   	ceph_decode_64_safe(&p, end, parent_spec->snap_id, out_err);
>   	ceph_decode_64_safe(&p, end, overlap, out_err);
>
> -	rbd_dev->parent_overlap = overlap;
> -	rbd_dev->parent_spec = parent_spec;
> -	parent_spec = NULL;	/* rbd_dev now owns this */
> +	if (overlap) {
> +		rbd_dev->parent_spec = parent_spec;
> +		parent_spec = NULL;	/* rbd_dev now owns this */
> +		rbd_dev->parent_overlap = overlap;
> +	} else {
> +		rbd_warn(rbd_dev, "ignoring parent of clone with overlap 0\n");
> +	}
>   out:
>   	ret = 0;
>   out_err:
>

