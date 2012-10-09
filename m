From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/4] rbd: define rbd_update_size()
Date: Tue, 09 Oct 2012 16:27:44 -0700
Message-ID: <5074B2F0.50008@inktank.com>
References: <50748FA5.4030508@inktank.com> <50749074.5030603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52516 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756946Ab2JIX1s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 19:27:48 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5741988pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 16:27:48 -0700 (PDT)
In-Reply-To: <50749074.5030603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/09/2012 02:00 PM, Alex Elder wrote:
> Encapsulate the code that handles the case where an image's size has
> been found to have changed.  This is done in anticipation of the
> next patch, which will make this common code for format 1 and 2
> images.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bb3d9be..d36e6d7 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1716,6 +1716,16 @@ static void __rbd_remove_all_snaps(struct
> rbd_device *rbd_dev)
>           __rbd_remove_snap_dev(snap);
>   }
>
> +static void rbd_update_size(struct rbd_device *rbd_dev)
> +{
> +    sector_t size = (sector_t) rbd_dev->header.image_size / SECTOR_SIZE;
> +
> +    rbd_assert(rbd_dev->mapping.snap_id == CEPH_NOSNAP);

I might be confused since it's been a while since I looked at these
refactorings, but I think this should still be a conditional block
instead of an assert.

Even if we've only mapped a snapshot, the non-snapshot version could
still be resized.

> +    dout("setting size to %llu sectors", (unsigned long long) size);
> +    rbd_dev->mapping.size = (u64) size;
> +    set_capacity(rbd_dev->disk, size);
> +}
> +
>   /*
>    * only read the first part of the ondisk header, without the snaps info
>    */
> @@ -1731,15 +1741,9 @@ static int __rbd_refresh_header(struct rbd_device
> *rbd_dev, u64 *hver)
>       down_write(&rbd_dev->header_rwsem);
>
>       /* resized? */
> -    if (rbd_dev->mapping.snap_id == CEPH_NOSNAP) {
> -        sector_t size = (sector_t) h.image_size / SECTOR_SIZE;
> -
> -        if (size != (sector_t) rbd_dev->mapping.size) {
> -            dout("setting size to %llu sectors",
> -                (unsigned long long) size);
> -            rbd_dev->mapping.size = (u64) size;
> -            set_capacity(rbd_dev->disk, size);
> -        }
> +    if (rbd_dev->header.image_size != h.image_size) {
> +        rbd_dev->header.image_size = h.image_size;
> +        rbd_update_size(rbd_dev);
>       }
>
>       /* rbd_dev->header.object_prefix shouldn't change */

