From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH] rbd: always set out parameter in qemu_rbd_snap_list
Date: Tue,  6 Dec 2011 17:05:10 -0800
Message-ID: <1323219910-17021-1-git-send-email-josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43666 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab1LGBFr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 20:05:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, kwolf@redhat.com, chb@muc.de

The caller expects psn_tab to be NULL when there are no snapshots or
an error occurs. This results in calling g_free on an invalid address.

Reported-by: Oliver Francke <Oliver@filoo.de>
Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block/rbd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 9088c52..54a6961 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -793,55 +793,56 @@ static int qemu_rbd_snap_create(BlockDriverState *bs,
 static int qemu_rbd_snap_list(BlockDriverState *bs,
                               QEMUSnapshotInfo **psn_tab)
 {
     BDRVRBDState *s = bs->opaque;
     QEMUSnapshotInfo *sn_info, *sn_tab = NULL;
     int i, snap_count;
     rbd_snap_info_t *snaps;
     int max_snaps = RBD_MAX_SNAPS;
 
     do {
         snaps = g_malloc(sizeof(*snaps) * max_snaps);
         snap_count = rbd_snap_list(s->image, snaps, &max_snaps);
         if (snap_count < 0) {
             g_free(snaps);
         }
     } while (snap_count == -ERANGE);
 
     if (snap_count <= 0) {
-        return snap_count;
+        goto done;
     }
 
     sn_tab = g_malloc0(snap_count * sizeof(QEMUSnapshotInfo));
 
     for (i = 0; i < snap_count; i++) {
         const char *snap_name = snaps[i].name;
 
         sn_info = sn_tab + i;
         pstrcpy(sn_info->id_str, sizeof(sn_info->id_str), snap_name);
         pstrcpy(sn_info->name, sizeof(sn_info->name), snap_name);
 
         sn_info->vm_state_size = snaps[i].size;
         sn_info->date_sec = 0;
         sn_info->date_nsec = 0;
         sn_info->vm_clock_nsec = 0;
     }
     rbd_snap_list_end(snaps);
 
+ done:
     *psn_tab = sn_tab;
     return snap_count;
 }
 
 static QEMUOptionParameter qemu_rbd_create_options[] = {
     {
      .name = BLOCK_OPT_SIZE,
      .type = OPT_SIZE,
      .help = "Virtual disk size"
     },
     {
      .name = BLOCK_OPT_CLUSTER_SIZE,
      .type = OPT_SIZE,
      .help = "RBD object size"
     },
     {NULL}
 };
 
-- 
1.7.1

