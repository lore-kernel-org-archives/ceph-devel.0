From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: add new snapshots at the tail
Date: Tue, 04 Sep 2012 13:08:16 -0500
Message-ID: <50464390.3010107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42150 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425Ab2IDSIT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 14:08:19 -0400
Received: by ieje11 with SMTP id e11so5580327iej.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Sep 2012 11:08:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This fixes a bug that went in with this commit:

    commit f6e0c99092cca7be00fca4080cfc7081739ca544
    Author: Alex Elder <elder@inktank.com>
    Date:   Thu Aug 2 11:29:46 2012 -0500
    rbd: simplify __rbd_init_snaps_header()

The problem is that a new rbd snapshot needs to go either after an
existing snapshot entry, or at the *end* of an rbd device's snapshot
list.  As originally coded, it is placed at the beginning.  This was
based on the assumption the list would be empty (so it wouldn't
matter), but in fact if multiple new snapshots are added to an empty
list in one shot the list will be non-empty after the first one is
added.

This addresses http://tracker.newdream.net/issues/3063

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8e6e29e..fd51f9d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2187,7 +2187,7 @@ static int __rbd_init_snaps_header(struct
rbd_device *rbd_dev)
 			if (snap)
 				list_add_tail(&new_snap->node, &snap->node);
 			else
-				list_add(&new_snap->node, head);
+				list_add_tail(&new_snap->node, head);
 		} else {
 			/* Already have this one */

-- 
1.7.9.5

