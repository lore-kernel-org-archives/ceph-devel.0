From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 04/11] rbd: more cleanup in rbd_header_from_disk()
Date: Thu, 30 Aug 2012 09:48:52 -0700
Message-ID: <CAC-hyiG0qrb7TxxopW36DeQ_3HSU=mcKS9VvQ32S2CU2tY9hNQ@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037ACDA.3010004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45982 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab2H3Qsx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 12:48:53 -0400
Received: by bkwj10 with SMTP id j10so909337bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 09:48:52 -0700 (PDT)
In-Reply-To: <5037ACDA.3010004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Aug 24, 2012 at 9:33 AM, Alex Elder <elder@inktank.com> wrote:
> This just rearranges things a bit more in rbd_header_from_disk()
> so that the snapshot sizes are initialized right after the buffer
> to hold them is allocated, and doing a little further consolidation
> that follows from that.  It also adds a few simple comments.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |   26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 7b3d861..130dbc2 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -520,6 +520,7 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>         u32 snap_count;
>         size_t len;
>         size_t size;
> +       u32 i;
>
>         memset(header, 0, sizeof (*header));
>
> @@ -535,6 +536,8 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>         if (snap_count) {
>                 u64 snap_names_len = le64_to_cpu(ondisk->snap_names_len);
>
> +               /* Save a copy of the snapshot names */
> +
>                 BUG_ON(snap_names_len > (u64) SIZE_MAX);
>                 header->snap_names = kmalloc(snap_names_len, GFP_KERNEL);
>                 if (!header->snap_names)
> @@ -542,10 +545,15 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>                 memcpy(header->snap_names, &ondisk->snaps[snap_count],
>                         snap_names_len);
>
> +               /* Record each snapshot's size */
> +
>                 size = snap_count * sizeof (*header->snap_sizes);
>                 header->snap_sizes = kmalloc(size, GFP_KERNEL);
>                 if (!header->snap_sizes)
>                         goto out_err;
> +               for (i = 0; i < snap_count; i++)
> +                       header->snap_sizes[i] =
> +                               le64_to_cpu(ondisk->snaps[i].image_size);
>         } else {
>                 WARN_ON(ondisk->snap_names_len);
>                 header->snap_names = NULL;
> @@ -558,6 +566,8 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>         header->comp_type = ondisk->options.comp_type;
>         header->total_snaps = snap_count;
>
> +       /* Allocate and fill in the snapshot context */
> +
>         size = sizeof (struct ceph_snap_context);
>         size += snap_count * sizeof (header->snapc->snaps[0]);
>         header->snapc = kzalloc(size, GFP_KERNEL);
> @@ -567,19 +577,9 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>         atomic_set(&header->snapc->nref, 1);
>         header->snapc->seq = le64_to_cpu(ondisk->snap_seq);
>         header->snapc->num_snaps = snap_count;
> -
> -       /* Fill in the snapshot information */
> -
> -       if (snap_count) {
> -               u32 i;
> -
> -               for (i = 0; i < snap_count; i++) {
> -                       header->snapc->snaps[i] =
> -                               le64_to_cpu(ondisk->snaps[i].id);
> -                       header->snap_sizes[i] =
> -                               le64_to_cpu(ondisk->snaps[i].image_size);
> -               }
> -       }
> +       for (i = 0; i < snap_count; i++)
> +               header->snapc->snaps[i] =
> +                       le64_to_cpu(ondisk->snaps[i].id);
>
>         return 0;
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
