From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: use GFP_NOIO consistently for request allocations
Date: Tue, 5 Apr 2016 11:41:47 +0200
Message-ID: <CAOi1vP82HraoD5PGcCBdwY-2UJtX0fUsDhU5oyChEPrVKvKF=w@mail.gmail.com>
References: <1459847619-27819-1-git-send-email-ddiss@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34799 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757916AbcDEJlt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 05:41:49 -0400
Received: by mail-lf0-f46.google.com with SMTP id j11so6138240lfb.1
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2016 02:41:48 -0700 (PDT)
In-Reply-To: <1459847619-27819-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Apr 5, 2016 at 11:13 AM, David Disseldorp <ddiss@suse.de> wrote:
> As of 5a60e87603c4c533492c515b7f62578189b03c9c, RBD object request
> allocations are made via rbd_obj_request_create() with GFP_NOIO.
> However, subsequent OSD request allocations in rbd_osd_req_create*()
> use GFP_ATOMIC.
>
> With heavy page cache usage (e.g. OSDs running on same host as krbd
> client), rbd_osd_req_create() order-1 GFP_ATOMIC allocations have been
> observed to fail, where direct reclaim would have allowed GFP_NOIO
> allocations to succeed.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Suggested-by: Neil Brown <neilb@suse.com>
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  drivers/block/rbd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 9c62344..94a1843 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1953,7 +1953,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
>
>         osdc = &rbd_dev->rbd_client->client->osdc;
>         osd_req = ceph_osdc_alloc_request(osdc, snapc, num_ops, false,
> -                                         GFP_ATOMIC);
> +                                         GFP_NOIO);
>         if (!osd_req)
>                 return NULL;    /* ENOMEM */
>
> @@ -2002,7 +2002,7 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
>         rbd_dev = img_request->rbd_dev;
>         osdc = &rbd_dev->rbd_client->client->osdc;
>         osd_req = ceph_osdc_alloc_request(osdc, snapc, num_osd_ops,
> -                                               false, GFP_ATOMIC);
> +                                               false, GFP_NOIO);
>         if (!osd_req)
>                 return NULL;    /* ENOMEM */
>
> @@ -2504,7 +2504,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>                                         bio_chain_clone_range(&bio_list,
>                                                                 &bio_offset,
>                                                                 clone_size,
> -                                                               GFP_ATOMIC);
> +                                                               GFP_NOIO);
>                         if (!obj_request->bio_list)
>                                 goto out_unwind;
>                 } else if (type == OBJ_REQUEST_PAGES) {

I've got the first two fixed in one of my wip branches but it's tied to
ceph_osdc_alloc_request() changes.  Given that allocation failures were
observed, I guess it's worth sending this one to stable right away.
I'll queue it up, thanks David.

                Ilya
