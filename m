From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/4] rbd: expand rbd_dev_ondisk_valid() checks
Date: Tue, 07 Aug 2012 17:31:03 -0700
Message-ID: <5021B347.3060900@inktank.com>
References: <502009D1.7090005@inktank.com> <50200A4E.9050901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52177 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab2HHAbG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 20:31:06 -0400
Received: by pbbrr13 with SMTP id rr13so498542pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 17:31:06 -0700 (PDT)
In-Reply-To: <50200A4E.9050901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/06/2012 11:17 AM, Alex Elder wrote:
> Add checks on the validity of the snap_count and snap_names_len
> field values in rbd_dev_ondisk_valid().  This eliminates the
> need to do them in rbd_header_from_disk().
>
> Signed-off-by: Alex Elder <elder@inktank.com>

Just a small typo below. Looks good otherwise:

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> ---
>   drivers/block/rbd.c |   36 +++++++++++++++++++++++++++---------
>   1 file changed, 27 insertions(+), 9 deletions(-)
>
> Index: b/drivers/block/rbd.c
> ===================================================================
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -482,8 +482,31 @@ static void rbd_coll_release(struct kref
>
>   static bool rbd_dev_ondisk_valid(struct rbd_image_header_ondisk *ondisk)
>   {
> -    return !memcmp(&ondisk->text,
> -            RBD_HEADER_TEXT, sizeof (RBD_HEADER_TEXT));
> +    size_t size;
> +    u32 snap_count;
> +
> +    /* The header has to start with the magic rbd header text */
> +    if (memcmp(&ondisk->text, RBD_HEADER_TEXT, sizeof (RBD_HEADER_TEXT)))
> +        return false;
> +
> +    /*
> +     * The size of a snapshot header has to fit in a size_t, and
> +     * that valid limits the number of snapshots.

typo

> +     */
> +    snap_count = le32_to_cpu(ondisk->snap_count);
> +    size = SIZE_MAX - sizeof (struct ceph_snap_context);
> +    if (snap_count > size / sizeof (__le64))
> +        return false;
> +
> +    /*
> +     * Not only that, but the size of the entire the snapshot
> +     * header must also be representable in a size_t.
> +     */
> +    size -= snap_count * sizeof (__le64);
> +    if ((u64) size < le64_to_cpu(ondisk->snap_names_len))
> +        return false;
> +
> +    return true;
>   }
>
>   /*
> @@ -500,15 +523,10 @@ static int rbd_header_from_disk(struct r
>       if (!rbd_dev_ondisk_valid(ondisk))
>           return -ENXIO;
>
> -    snap_count = le32_to_cpu(ondisk->snap_count);
> -
> -    /* Make sure we don't overflow below */
> -    size = SIZE_MAX - sizeof (struct ceph_snap_context);
> -    if (snap_count > size / sizeof (header->snapc->snaps[0]))
> -        return -EINVAL;
> -
>       memset(header, 0, sizeof (*header));
>
> +    snap_count = le32_to_cpu(ondisk->snap_count);
> +
>       size = sizeof (ondisk->block_name) + 1;
>       header->object_prefix = kmalloc(size, GFP_KERNEL);
>       if (!header->object_prefix)

