From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH 5/6] rbd: kill rbd_dev_clear_mapping()
Date: Tue, 07 May 2013 07:26:46 -0700
Message-ID: <a738e35f-e2b7-4d10-8ff1-572d8a18dbb8@email.android.com>
References: <51885A97.9070005@inktank.com> <51885B08.6080907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49099 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab3EGOrz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 10:47:55 -0400
In-Reply-To: <51885B08.6080907@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

Alex Elder <elder@inktank.com> wrote:

>This function is a duplicate of rbd_dev_mapping_clear(), and was
>added by mistake.
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> drivers/block/rbd.c |    9 +--------
> 1 file changed, 1 insertion(+), 8 deletions(-)
>
>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>index 5eebf6d..530793a 100644
>--- a/drivers/block/rbd.c
>+++ b/drivers/block/rbd.c
>@@ -966,13 +966,6 @@ static void rbd_dev_mapping_clear(struct
>rbd_device
>*rbd_dev)
> 	rbd_dev->mapping.read_only = true;
> }
>
>-static void rbd_dev_clear_mapping(struct rbd_device *rbd_dev)
>-{
>-	rbd_dev->mapping.size = 0;
>-	rbd_dev->mapping.features = 0;
>-	rbd_dev->mapping.read_only = true;
>-}
>-
>static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64
>offset)
> {
> 	char *name;
>@@ -4910,7 +4903,7 @@ static void rbd_dev_device_release(struct device
>*dev)
>
> 	rbd_free_disk(rbd_dev);
> 	clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
>-	rbd_dev_clear_mapping(rbd_dev);
>+	rbd_dev_mapping_clear(rbd_dev);
> 	unregister_blkdev(rbd_dev->major, rbd_dev->name);
> 	rbd_dev->major = 0;
> 	rbd_dev_id_put(rbd_dev);

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
