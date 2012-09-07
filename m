From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH, v2 03/11] rbd: kill incore snap_names_len
Date: Fri, 7 Sep 2012 14:22:41 -0700
Message-ID: <CAC-hyiFSk_no8WDU3Ob5dFZ_=4B4L4DZksafPHW0z=Mrc4npyQ@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037ACC0.1000108@inktank.com>
	<5048C2F6.8090102@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55814 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758119Ab2IGVWn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 17:22:43 -0400
Received: by eekc1 with SMTP id c1so15783eek.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 14:22:42 -0700 (PDT)
In-Reply-To: <5048C2F6.8090102@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Thu, Sep 6, 2012 at 8:36 AM, Alex Elder <elder@inktank.com> wrote:
> The only thing the on-disk snap_names_len field is needed is to
> size the buffer allocated to hold a copy of the snapshot names
> for an rbd image.
>
> So don't bother saving it in the in-core rbd_image_header structure.
> Just use a local variable to hold the required buffer size while
> it's needed.
>
> Move the code that actually copies the snapshot names up closer
> to where the required length is saved.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> v2: - Return -EIO rather than BUG_ON() as suggested by Yehuda.
>     - Added a comment explaining why a memcpy() will not exceed
>       the length of the on-disk buffer, in response to Yehuda's
>       concern.
>
>  drivers/block/rbd.c |   26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> Index: b/drivers/block/rbd.c
> ===================================================================
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
> @@ -534,12 +533,21 @@ static int rbd_header_from_disk(struct r
>         header->object_prefix[len] = '\0';
>
>         if (snap_count) {
> -               header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
> -               BUG_ON(header->snap_names_len > (u64) SIZE_MAX);
> -               header->snap_names = kmalloc(header->snap_names_len,
> -                                            GFP_KERNEL);
> +               u64 snap_names_len = le64_to_cpu(ondisk->snap_names_len);
> +
> +               if (snap_names_len > (u64) SIZE_MAX)
> +                       return -EIO;
> +               header->snap_names = kmalloc(snap_names_len, GFP_KERNEL);
>                 if (!header->snap_names)
>                         goto out_err;
> +               /*
> +                * Note that rbd_dev_v1_header_read() guarantees
> +                * the ondisk buffer we're working with has
> +                * snap_names_len bytes beyond the end of the
> +                * snapshot id array, this memcpy() is safe.
> +                */
> +               memcpy(header->snap_names, &ondisk->snaps[snap_count],
> +                       snap_names_len);
>
>                 size = snap_count * sizeof (*header->snap_sizes);
>                 header->snap_sizes = kmalloc(size, GFP_KERNEL);
> @@ -547,7 +555,6 @@ static int rbd_header_from_disk(struct r
>                         goto out_err;
>         } else {
>                 WARN_ON(ondisk->snap_names_len);
> -               header->snap_names_len = 0;
>                 header->snap_names = NULL;
>                 header->snap_sizes = NULL;
>         }
> @@ -579,10 +586,6 @@ static int rbd_header_from_disk(struct r
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
> @@ -592,7 +595,6 @@ out_err:
>         header->snap_sizes = NULL;
>         kfree(header->snap_names);
>         header->snap_names = NULL;
> -       header->snap_names_len = 0;
>         kfree(header->object_prefix);
>         header->object_prefix = NULL;
>
> @@ -660,7 +662,6 @@ static void rbd_header_free(struct rbd_i
>         header->snap_sizes = NULL;
>         kfree(header->snap_names);
>         header->snap_names = NULL;
> -       header->snap_names_len = 0;
>         ceph_put_snap_context(header->snapc);
>         header->snapc = NULL;
>  }
> @@ -1800,7 +1801,6 @@ static int __rbd_refresh_header(struct r
>         rbd_dev->header.total_snaps = h.total_snaps;
>         rbd_dev->header.snapc = h.snapc;
>         rbd_dev->header.snap_names = h.snap_names;
> -       rbd_dev->header.snap_names_len = h.snap_names_len;
>         rbd_dev->header.snap_sizes = h.snap_sizes;
>         /* Free the extra copy of the object prefix */
>         WARN_ON(strcmp(rbd_dev->header.object_prefix, h.object_prefix));
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
