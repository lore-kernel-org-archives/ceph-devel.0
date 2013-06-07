From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH 2/5] rbd: protect against concurrent unmaps
Date: Fri, 07 Jun 2013 10:42:21 -0700
Message-ID: <178bf41c-e52e-4836-9b91-3906ac2d93c3@email.android.com>
References: <51A94BC0.4080703@inktank.com> <51A94C5A.20807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52060 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756594Ab3FGSPN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jun 2013 14:15:13 -0400
In-Reply-To: <51A94C5A.20807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com> 

Alex Elder <elder@inktank.com> wrote:
>Make sure two concurrent unmap operations on the same rbd device
>won't collide, by only proceeding with the removal and cleanup of a
>device if is not already underway.
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> drivers/block/rbd.c |    6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>index 716ef1f..380940d 100644
>--- a/drivers/block/rbd.c
>+++ b/drivers/block/rbd.c
>@@ -5153,6 +5153,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
> 	struct list_head *tmp;
> 	int dev_id;
> 	unsigned long ul;
>+	bool already = false;
> 	int ret;
>
> 	ret = strict_strtoul(buf, 10, &ul);
>@@ -5180,11 +5181,12 @@ static ssize_t rbd_remove(struct bus_type *bus,
> 		if (rbd_dev->open_count)
> 			ret = -EBUSY;
> 		else
>-			set_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
>+			already = test_and_set_bit(RBD_DEV_FLAG_REMOVING,
>+							&rbd_dev->flags);
> 		spin_unlock_irq(&rbd_dev->lock);
> 	}
> 	spin_unlock(&rbd_dev_list_lock);
>-	if (ret < 0)
>+	if (ret < 0 || already)
> 		goto done;
>
> 	rbd_bus_del_dev(rbd_dev);


