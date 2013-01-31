From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/2] rbd: don't take extra bio reference for osd client
Date: Wed, 30 Jan 2013 16:33:18 -0800
Message-ID: <5109BBCE.9050206@inktank.com>
References: <510986E4.7050901@inktank.com> <51098748.7080601@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36287 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109Ab3AaAdc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 19:33:32 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so1388418pad.4
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 16:33:31 -0800 (PST)
In-Reply-To: <51098748.7080601@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It'd be nice to have a log message when libceph_compatible fails.
It could be a future patch though.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/30/2013 12:49 PM, Alex Elder wrote:
> Currently, if the OSD client finds an osd request has had a bio list
> attached to it, it drops a reference to it (or rather, to the first
> entry on that list) when the request is released.
>
> The code that added that reference (i.e., the rbd client) is
> therefore required to take an extra reference to that first bio
> structure.
>
> The osd client doesn't really do anything with the bio pointer other
> than transfer it from the osd request structure to outgoing (for
> writes) and ingoing (for reads) messages.  So it really isn't the
> right place to be taking or dropping references.
>
> Furthermore, the rbd client already holds references to all bio
> structures it passes to the osd client, and holds them until the
> request is completed.  So there's no need for this extra reference
> whatsoever.
>
> So remove the bio_put() call in ceph_osdc_release_request(), as
> well as its matching bio_get() call in rbd_osd_req_create().
>
> This change could lead to a crash if old libceph.ko was used with
> new rbd.ko.  Add a compatibility check at rbd initialization time to
> avoid this possibilty.
>
> This resolves:
>      http://tracker.ceph.com/issues/3798    and
>      http://tracker.ceph.com/issues/3799
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c    |    3 ++-
>   net/ceph/ceph_common.c |    2 +-
>   net/ceph/osd_client.c  |    4 ----
>   3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index a9ce58c..6586800 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1342,7 +1342,6 @@ static struct ceph_osd_request *rbd_osd_req_create(
>   	case OBJ_REQUEST_BIO:
>   		rbd_assert(obj_request->bio_list != NULL);
>   		osd_req->r_bio = obj_request->bio_list;
> -		bio_get(osd_req->r_bio);
>   		/* osd client requires "num pages" even for bio */
>   		osd_req->r_num_pages = calc_pages_for(offset, length);
>   		break;
> @@ -4150,6 +4149,8 @@ int __init rbd_init(void)
>   {
>   	int rc;
>
> +	if (!libceph_compatible(NULL))
> +		return -EINVAL;
>   	rc = rbd_sysfs_init();
>   	if (rc)
>   		return rc;
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index a98c03f..c236c235 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -39,7 +39,7 @@
>    */
>   bool libceph_compatible(void *data)
>   {
> -	return false;
> +	return true;
>   }
>   EXPORT_SYMBOL(libceph_compatible);
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 500ae8b..ba03648 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -147,10 +147,6 @@ void ceph_osdc_release_request(struct kref *kref)
>   	if (req->r_own_pages)
>   		ceph_release_page_vector(req->r_pages,
>   					 req->r_num_pages);
> -#ifdef CONFIG_BLOCK
> -	if (req->r_bio)
> -		bio_put(req->r_bio);
> -#endif
>   	ceph_put_snap_context(req->r_snapc);
>   	ceph_pagelist_release(&req->r_trail);
>   	if (req->r_mempool)
>

