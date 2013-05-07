From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH] rbd: fix leak of format 2 snapshot context
Date: Tue, 07 May 2013 07:12:01 -0700
Message-ID: <3e7468bd-dbc0-4896-b0d5-b3cda700b91f@email.android.com>
References: <518859F7.8060708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54672 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab3ELWcX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 May 2013 18:32:23 -0400
In-Reply-To: <518859F7.8060708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

Alex Elder <elder@inktank.com> wrote:

>When rbd_dev_v2_refresh() is called, the rbd device already has a
>snapshot context associated with it.  But that never gets freed,
>the pointer just gets overwritten.
>
>Fix this by dropping the rbd device's reference to the snapshot
>context before overwriting the pointer.
>
>Because ceph_put_snap_context() already handles for a null pointer
>we don't need to check for that (for the probe case, where no
>context has yet been assigned).
>
>This resolves:
>    http://tracker.ceph.com/issues/4912
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> drivers/block/rbd.c |    1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>index c2ca181..4263743 100644
>--- a/drivers/block/rbd.c
>+++ b/drivers/block/rbd.c
>@@ -4004,6 +4004,7 @@ static int rbd_dev_v2_snap_context(struct
>rbd_device *rbd_dev)
> 	for (i = 0; i < snap_count; i++)
> 		snapc->snaps[i] = ceph_decode_64(&p);
>
>+	ceph_put_snap_context(rbd_dev->header.snapc);
> 	rbd_dev->header.snapc = snapc;
>
> 	dout("  snap context seq = %llu, snap_count = %u\n",

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
