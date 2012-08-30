From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 03/11] rbd: kill incore snap_names_len
Date: Thu, 30 Aug 2012 09:24:12 -0700
Message-ID: <CAC-hyiGmZwmnNdX=+y9BBsWuYRzXvu4Nah6pedn-_x4ZYLW3VQ@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037ACC0.1000108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58682 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab2H3QYN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 12:24:13 -0400
Received: by bkwj10 with SMTP id j10so897982bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 09:24:12 -0700 (PDT)
In-Reply-To: <5037ACC0.1000108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Aug 24, 2012 at 9:33 AM, Alex Elder <elder@inktank.com> wrote:
> The only thing the on-disk snap_names_len field is used for is to
> size the buffer allocated to hold a copy of the snapshot names for
> an rbd image.
>
> Don't bother saving it in the in-core rbd_image_header structure.
> Just use a local variable to hold the required buffer size while
> it's needed.
>
> Move the code that actually copies the snapshot names up closer
> to where the required length is saved.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |   19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index a8a4cba..7b3d861 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -81,7 +81,6 @@ struct rbd_image_header {
>         __u8 crypt_type;
>         __u8 comp_type;
>         struct ceph_snap_context *snapc;
> -       u64 snap_names_len;
>         u32 total_snaps;
>
>         char *snap_names;
> @@ -534,12 +533,14 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>         header->object_prefix[len] = '\0';
>
>         if (snap_count) {
> -               header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
> -               BUG_ON(header->snap_names_len > (u64) SIZE_MAX);
> -               header->snap_names = kmalloc(header->snap_names_len,
> -                                            GFP_KERNEL);
> +               u64 snap_names_len = le64_to_cpu(ondisk->snap_names_len);
> +
> +               BUG_ON(snap_names_len > (u64) SIZE_MAX);

Should we get rid of this BUG_ON and return -EIO instead?

> +               header->snap_names = kmalloc(snap_names_len, GFP_KERNEL);
>                 if (!header->snap_names)
>                         goto out_err;
> +               memcpy(header->snap_names, &ondisk->snaps[snap_count],
> +                       snap_names_len);

I think we're missing a check here to verify that we don't exceed the
ondisk buffer


>
>                 size = snap_count * sizeof (*header->snap_sizes);
>                 header->snap_sizes = kmalloc(size, GFP_KERNEL);
> @@ -547,7 +548,6 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>                         goto out_err;
>         } else {
>                 WARN_ON(ondisk->snap_names_len);
> -               header->snap_names_len = 0;
>                 header->snap_names = NULL;
>                 header->snap_sizes = NULL;
>         }
> @@ -579,10 +579,6 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>                         header->snap_sizes[i] =
>                                 le64_to_cpu(ondisk->snaps[i].image_size);
>                 }
> -
> -               /* copy snapshot names */
> -               memcpy(header->snap_names, &ondisk->snaps[snap_count],
> -                       header->snap_names_len);
>         }
>
>         return 0;
> @@ -592,7 +588,6 @@ out_err:
>         header->snap_sizes = NULL;
>         kfree(header->snap_names);
>         header->snap_names = NULL;
> -       header->snap_names_len = 0;
>         kfree(header->object_prefix);
>         header->object_prefix = NULL;
>
> @@ -660,7 +655,6 @@ static void rbd_header_free(struct rbd_image_header
> *header)
>         header->snap_sizes = NULL;
>         kfree(header->snap_names);
>         header->snap_names = NULL;
> -       header->snap_names_len = 0;
>         ceph_put_snap_context(header->snapc);
>         header->snapc = NULL;
>  }
> @@ -1800,7 +1794,6 @@ static int __rbd_refresh_header(struct rbd_device
> *rbd_dev, u64 *hver)
>         rbd_dev->header.total_snaps = h.total_snaps;
>         rbd_dev->header.snapc = h.snapc;
>         rbd_dev->header.snap_names = h.snap_names;
> -       rbd_dev->header.snap_names_len = h.snap_names_len;
>         rbd_dev->header.snap_sizes = h.snap_sizes;
>         /* Free the extra copy of the object prefix */
>         WARN_ON(strcmp(rbd_dev->header.object_prefix, h.object_prefix));
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
