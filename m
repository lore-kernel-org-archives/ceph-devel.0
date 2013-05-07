From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH 4/6] rbd: don't look up snapshot id in rbd_dev_mapping_set()
Date: Tue, 07 May 2013 07:26:20 -0700
Message-ID: <ad96461f-a1fc-4210-81a5-b02cf97f50ae@email.android.com>
References: <51885A97.9070005@inktank.com> <51885AFC.3050908@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49096 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab3EGOry convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 10:47:54 -0400
In-Reply-To: <51885AFC.3050908@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

Alex Elder <elder@inktank.com> wrote:

>Currently rbd_dev_mapping_set() looks up the snapshot id for the
>snapshot whose name is found in the rbd device's spec structure.
>
>That function gets called by rbd_dev_device_setup(), which is
>called by rbd_add() *after* rbd_dev_image_probe().  If the
>image probe succeeds, the rbd device's spec will already have
>been updated to include names and ids for all fields.
>
>Therefore there's no need to look up the snapshot id in
>rbd_dev_mapping_set().
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> drivers/block/rbd.c |   11 +----------
> 1 file changed, 1 insertion(+), 10 deletions(-)
>
>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>index 7d93dbd..5eebf6d 100644
>--- a/drivers/block/rbd.c
>+++ b/drivers/block/rbd.c
>@@ -936,20 +936,11 @@ static int rbd_snap_features(struct rbd_device
>*rbd_dev, u64 snap_id,
>
> static int rbd_dev_mapping_set(struct rbd_device *rbd_dev)
> {
>-	const char *snap_name = rbd_dev->spec->snap_name;
>-	u64 snap_id;
>+	u64 snap_id = rbd_dev->spec->snap_id;
> 	u64 size = 0;
> 	u64 features = 0;
> 	int ret;
>
>-	if (strcmp(snap_name, RBD_SNAP_HEAD_NAME)) {
>-		snap_id = rbd_snap_id_by_name(rbd_dev, snap_name);
>-		if (snap_id == CEPH_NOSNAP)
>-			return -ENOENT;
>-	} else {
>-		snap_id = CEPH_NOSNAP;
>-	}
>-
> 	ret = rbd_snap_size(rbd_dev, snap_id, &size);
> 	if (ret)
> 		return ret;

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
