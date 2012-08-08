From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/4] rbd: separate reading header from decoding it
Date: Tue, 07 Aug 2012 17:58:11 -0700
Message-ID: <5021B9A3.9060004@inktank.com>
References: <502009D1.7090005@inktank.com> <50200A56.90506@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65208 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350Ab2HHA6O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 20:58:14 -0400
Received: by pbbrr13 with SMTP id rr13so533320pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 17:58:14 -0700 (PDT)
In-Reply-To: <50200A56.90506@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/06/2012 11:17 AM, Alex Elder wrote:
> Right now rbd_read_header() both reads the header object for an rbd
> image and decodes its contents.  It does this repeatedly if needed,
> in order to ensure a complete and intact header is obtained.
>
> Separate this process into two steps--reading of the raw header
> data (in new function, rbd_dev_v1_header_read()) and separately
> decoding its contents (in rbd_header_from_disk()).  As a result,
> the latter function no longer requires its allocated_snaps argument.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |  132
> +++++++++++++++++++++++++++++-----------------------
>   1 file changed, 76 insertions(+), 56 deletions(-)
>
> Index: b/drivers/block/rbd.c
> ===================================================================
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -514,15 +514,11 @@ static bool rbd_dev_ondisk_valid(struct
>    * header.
>    */
>   static int rbd_header_from_disk(struct rbd_image_header *header,
> -                 struct rbd_image_header_ondisk *ondisk,
> -                 u32 allocated_snaps)
> +                 struct rbd_image_header_ondisk *ondisk)
>   {
>       u32 snap_count;
>       size_t size;
>
> -    if (!rbd_dev_ondisk_valid(ondisk))
> -        return -ENXIO;
> -
>       memset(header, 0, sizeof (*header));
>
>       snap_count = le32_to_cpu(ondisk->snap_count);
> @@ -559,15 +555,6 @@ static int rbd_header_from_disk(struct r
>       header->comp_type = ondisk->options.comp_type;
>       header->total_snaps = snap_count;
>
> -    /*
> -     * If the number of snapshot ids provided by the caller
> -     * doesn't match the number in the entire context there's
> -     * no point in going further.  Caller will try again after
> -     * getting an updated snapshot context from the server.
> -     */
> -    if (allocated_snaps != snap_count)
> -        return 0;
> -
>       size = sizeof (struct ceph_snap_context);
>       size += snap_count * sizeof (header->snapc->snaps[0]);
>       header->snapc = kzalloc(size, GFP_KERNEL);
> @@ -1630,61 +1617,94 @@ static void rbd_free_disk(struct rbd_dev
>   }
>
>   /*
> - * reload the ondisk the header
> + * Read the complete header for the given rbd device.
> + *
> + * Returns a pointer to a dynamically-allocated buffer containing
> + * the complete and validated header.  Caller can pass the address
> + * of a variable that will be filled in with the version of the
> + * header object at the time it was read.
> + *
> + * Returns a pointer-coded errno if a failure occurs.
>    */
> -static int rbd_read_header(struct rbd_device *rbd_dev,
> -               struct rbd_image_header *header)
> +static struct rbd_image_header_ondisk *
> +rbd_dev_v1_header_read(struct rbd_device *rbd_dev, u64 *version)
>   {
> -    ssize_t rc;
> -    struct rbd_image_header_ondisk *dh;
> +    struct rbd_image_header_ondisk *ondisk = NULL;
>       u32 snap_count = 0;
> -    u64 ver;
> -    size_t len;
> +    u64 names_size = 0;
> +    u32 want_count;
> +    int ret;
>
>       /*
> -     * First reads the fixed-size header to determine the number
> -     * of snapshots, then re-reads it, along with all snapshot
> -     * records as well as their stored names.
> +     * The complete header will include an array of its 64-bit
> +     * snapshot ids, followed by the names of those snapshots as
> +     * a contiguous block of null-terminated strings.  Note that

minor nit, but '\0' is NUL, not NULL.

> +     * the number of snapshots could change by the time we read
> +     * it in, in which case we re-read it.
>        */
> -    len = sizeof (*dh);
> -    while (1) {
> -        dh = kmalloc(len, GFP_KERNEL);
> -        if (!dh)
> -            return -ENOMEM;
> +    do {
> +        size_t size;
> +
> +        kfree(ondisk);
>
> -        rc = rbd_req_sync_read(rbd_dev,
> -                       CEPH_NOSNAP,
> +        size = sizeof (*ondisk);
> +        size += snap_count * sizeof (struct rbd_image_snap_ondisk);
> +        size += names_size;
> +        ondisk = kmalloc(size, GFP_KERNEL);
> +        if (!ondisk)
> +            return ERR_PTR(-ENOMEM);
> +
> +        ret = rbd_req_sync_read(rbd_dev, CEPH_NOSNAP,
>                          rbd_dev->header_name,
> -                       0, len,
> -                       (char *)dh, &ver);
> -        if (rc < 0)
> -            goto out_dh;
> -
> -        rc = rbd_header_from_disk(header, dh, snap_count);
> -        if (rc < 0) {
> -            if (rc == -ENXIO)
> -                pr_warning("unrecognized header format"
> -                       " for image %s\n",
> -                       rbd_dev->image_name);
> -            goto out_dh;
> +                       0, size,
> +                       (char *) ondisk, version);
> +
> +        if (ret < 0)
> +            goto out_err;
> +        if (WARN_ON(ret < size)) {
> +            ret = -ENXIO;

Maybe -EIO, or with a pr_warning so we can distinguish between this and
the next check?

> +            goto out_err;
> +        }
> +        if (!rbd_dev_ondisk_valid(ondisk)) {
> +            ret = -ENXIO;
> +            goto out_err;
>           }
>
> -        if (snap_count == header->total_snaps)
> -            break;
> +        names_size = le64_to_cpu(ondisk->snap_names_len);
> +        want_count = snap_count;
> +        snap_count = le32_to_cpu(ondisk->snap_count);
> +    } while (snap_count != want_count);
>
> -        snap_count = header->total_snaps;
> -        len = sizeof (*dh) +
> -            snap_count * sizeof(struct rbd_image_snap_ondisk) +
> -            header->snap_names_len;
> +    return ondisk;
>
> -        rbd_header_free(header);
> -        kfree(dh);
> -    }
> -    header->obj_version = ver;
> +out_err:
> +    kfree(ondisk);
> +
> +    return ERR_PTR(ret);
> +}
> +
> +/*
> + * reload the ondisk the header
> + */
> +static int rbd_read_header(struct rbd_device *rbd_dev,
> +               struct rbd_image_header *header)
> +{
> +    struct rbd_image_header_ondisk *ondisk;
> +    u64 ver = 0;
> +    int ret;
> +
> +    ondisk = rbd_dev_v1_header_read(rbd_dev, &ver);
> +    if (IS_ERR(ondisk))
> +        return PTR_ERR(ondisk);
> +    ret = rbd_header_from_disk(header, ondisk);
> +    if (ret >= 0)
> +        header->obj_version = ver;
> +    else if (ret == -ENXIO)

This isn't returned from rbd_header_from_disk anymore, since you moved
the check into rbd_dev_v1_header_read. It seems like warnings should
be printed from rbd_dev_v1_header_read so more specific messages can be
given if you want to add them back in.

> +        pr_warning("unrecognized header format for image %s\n",
> +            rbd_dev->image_name);
> +    kfree(ondisk);
>
> -out_dh:
> -    kfree(dh);
> -    return rc;
> +    return ret;
>   }
>
>   /*

