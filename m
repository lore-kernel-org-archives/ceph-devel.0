From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 5/5]  rbd: kill rbd_image_header->total_snaps
Date: Fri, 07 Sep 2012 11:17:14 -0700
Message-ID: <504A3A2A.1080808@inktank.com>
References: <5049F7F5.1070609@inktank.com> <5049F925.5050001@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44325 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab2IGSRQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 14:17:16 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1949925dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 11:17:16 -0700 (PDT)
In-Reply-To: <5049F925.5050001@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 06:39 AM, Alex Elder wrote:
> The "total_snaps" field in an rbd header structure is never any
> different from the value of "num_snaps" stored within a snapshot
> context.  Avoid any confusion by just using the value held within
> the snapshot context, and get rid of the "total_snaps" field.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 774a36b..eb6b772 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -87,7 +87,6 @@ struct rbd_image_header {
>   	__u8 crypt_type;
>   	__u8 comp_type;
>   	struct ceph_snap_context *snapc;
> -	u32 total_snaps;
>
>   	char *snap_names;
>   	u64 *snap_sizes;
> @@ -588,7 +587,6 @@ static int rbd_header_from_disk(struct
> rbd_image_header *header,
>   	header->obj_order = ondisk->options.order;
>   	header->crypt_type = ondisk->options.crypt_type;
>   	header->comp_type = ondisk->options.comp_type;
> -	header->total_snaps = snap_count;
>
>   	/* Allocate and fill in the snapshot context */
>
> @@ -624,7 +622,8 @@ static int snap_by_name(struct rbd_image_header
> *header, const char *snap_name,
>   	int i;
>   	char *p = header->snap_names;
>
> -	for (i = 0; i < header->total_snaps; i++) {
> +	rbd_assert(header->snapc != NULL);
> +	for (i = 0; i < header->snapc->num_snaps; i++) {
>   		if (!strcmp(snap_name, p)) {
>
>   			/* Found it.  Pass back its id and/or size */
> @@ -1839,7 +1838,6 @@ static int __rbd_refresh_header(struct rbd_device
> *rbd_dev, u64 *hver)
>   		*hver = h.obj_version;
>   	rbd_dev->header.obj_version = h.obj_version;
>   	rbd_dev->header.image_size = h.image_size;
> -	rbd_dev->header.total_snaps = h.total_snaps;
>   	rbd_dev->header.snapc = h.snapc;
>   	rbd_dev->header.snap_names = h.snap_names;
>   	rbd_dev->header.snap_sizes = h.snap_sizes;
>

