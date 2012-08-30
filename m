From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 11/11] rbd: split up rbd_get_segment()
Date: Thu, 30 Aug 2012 11:03:12 -0700
Message-ID: <CAC-hyiEKfwcPQmSHS=8VESkQ0uD7u+UY-3k-OYFW_RDeSvPr7Q@mail.gmail.com>
References: <5037AB20.4000103@inktank.com>
	<5037AD8B.2020805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51711 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab2H3SDP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 14:03:15 -0400
Received: by bkwj10 with SMTP id j10so940818bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 11:03:13 -0700 (PDT)
In-Reply-To: <5037AD8B.2020805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Aug 24, 2012 at 9:36 AM, Alex Elder <elder@inktank.com> wrote:
> There are two places where rbd_get_segment() is called.  One, in
> rbd_rq_fn(), only needs to know the length within a segment that an
> I/O request should be.  The other, in rbd_do_op(), also needs the
> name of the object and the offset within it for the I/O request.
>
> Split out rbd_segment_name() into three dedicated functions:
>     - rbd_segment_name() allocates and formats the name of the
>       object for a segment containing a given rbd image offset
>     - rbd_segment_offset() computes the offset within a segment for
>       a given rbd image offset
>     - rbd_segment_length() computes the length to use for I/O within
>       a segment for a request, not to exceed the end of a segment
>       object.
>
> In the new functions be a bit more careful, checking for possible
> error conditions:
>     - watch for errors or overflows returned by snprintf()
>     - catch (using BUG_ON()) potential overflow conditions
>       when computing segment length
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |   66
> +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 40 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b649446..3a79e58 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -656,27 +656,47 @@ static void rbd_header_free(struct
> rbd_image_header *header)
>         header->snapc = NULL;
>  }
>
> -/*
> - * get the actual striped segment name, offset and length
> - */
> -static u64 rbd_get_segment(struct rbd_image_header *header,
> -                          const char *object_prefix,
> -                          u64 ofs, u64 len,
> -                          char *seg_name, u64 *segofs)
> +static char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
> +{
> +       char *name;
> +       u64 segment;
> +       int ret;
> +
> +       name = kmalloc(RBD_MAX_SEG_NAME_LEN + 1, GFP_NOIO);
> +       if (!name)
> +               return NULL;
> +       segment = offset >> rbd_dev->header.obj_order;
> +       ret = snprintf(name, RBD_MAX_SEG_NAME_LEN, "%s.%012llx",
> +                       rbd_dev->header.object_prefix, segment);
> +       if (ret < 0 || ret >= RBD_MAX_SEG_NAME_LEN) {
> +               pr_err("error formatting segment name for #%llu (%d)\n",
> +                       segment, ret);
> +               kfree(name);
> +               name = NULL;
> +       }
> +
> +       return name;
> +}
> +
> +static u64 rbd_segment_offset(struct rbd_device *rbd_dev, u64 offset)
>  {
> -       u64 seg = ofs >> header->obj_order;
> +       u64 segment_size = (u64) 1 << rbd_dev->header.obj_order;
>
> -       if (seg_name)
> -               snprintf(seg_name, RBD_MAX_SEG_NAME_LEN,
> -                        "%s.%012llx", object_prefix, seg);
> +       return offset & (segment_size - 1);
> +}
> +
> +static u64 rbd_segment_length(struct rbd_device *rbd_dev,
> +                               u64 offset, u64 length)
> +{
> +       u64 segment_size = (u64) 1 << rbd_dev->header.obj_order;
>
> -       ofs = ofs & ((1 << header->obj_order) - 1);
> -       len = min_t(u64, len, (1 << header->obj_order) - ofs);
> +       offset &= segment_size - 1;
>
> -       if (segofs)
> -               *segofs = ofs;
> +       BUG_ON(length > U64_MAX - offset);
> +       if (offset + length > segment_size)
> +               length = segment_size - offset;
>
> -       return len;
> +       return length;
>  }
>
>  static int rbd_get_num_segments(struct rbd_image_header *header,
> @@ -1114,14 +1134,11 @@ static int rbd_do_op(struct request *rq,
>         struct ceph_osd_req_op *ops;
>         u32 payload_len;
>
> -       seg_name = kmalloc(RBD_MAX_SEG_NAME_LEN + 1, GFP_NOIO);
> +       seg_name = rbd_segment_name(rbd_dev, ofs);
>         if (!seg_name)
>                 return -ENOMEM;
> -
> -       seg_len = rbd_get_segment(&rbd_dev->header,
> -                                 rbd_dev->header.object_prefix,
> -                                 ofs, len,
> -                                 seg_name, &seg_ofs);
> +       seg_len = rbd_segment_length(rbd_dev, ofs, len);
> +       seg_ofs = rbd_segment_offset(rbd_dev, ofs);
>
>         payload_len = (flags & CEPH_OSD_FLAG_WRITE ? seg_len : 0);
>
> @@ -1532,10 +1549,7 @@ static void rbd_rq_fn(struct request_queue *q)
>                 do {
>                         /* a bio clone to be passed down to OSD req */
>                         dout("rq->bio->bi_vcnt=%hu\n", rq->bio->bi_vcnt);
> -                       op_size = rbd_get_segment(&rbd_dev->header,
> -                                                 rbd_dev->header.object_prefix,
> -                                                 ofs, size,
> -                                                 NULL, NULL);
> +                       op_size = rbd_segment_length(rbd_dev, ofs, size);
>                         kref_get(&coll->kref);
>                         bio = bio_chain_clone(&rq_bio, &next_bio, &bp,
>                                               op_size, GFP_ATOMIC);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
