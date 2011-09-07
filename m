From: Sage Weil <sage@newdream.net>
Subject: [PATCH 2/3] rbd: clean up, fix style
Date: Wed,  7 Sep 2011 09:28:05 -0700
Message-ID: <1315412886-21092-2-git-send-email-sage@newdream.net>
References: <1315412886-21092-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38875 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab1IGQzz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2011 12:55:55 -0400
In-Reply-To: <1315412886-21092-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org, kwolf@redhat.com
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

No assignment in condition.  Remove duplicate ret > 0 check.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 block/rbd.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 6135fc1..2763092 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -391,15 +391,14 @@ static void qemu_rbd_aio_event_reader(void *opaque)
         char *p = (char *)&s->event_rcb;
 
         /* now read the rcb pointer that was sent from a non qemu thread */
-        if ((ret = read(s->fds[RBD_FD_READ], p + s->event_reader_pos,
-                        sizeof(s->event_rcb) - s->event_reader_pos)) > 0) {
-            if (ret > 0) {
-                s->event_reader_pos += ret;
-                if (s->event_reader_pos == sizeof(s->event_rcb)) {
-                    s->event_reader_pos = 0;
-                    qemu_rbd_complete_aio(s->event_rcb);
-                    s->qemu_aio_count--;
-                }
+        ret = read(s->fds[RBD_FD_READ], p + s->event_reader_pos,
+                   sizeof(s->event_rcb) - s->event_reader_pos);
+        if (ret > 0) {
+            s->event_reader_pos += ret;
+            if (s->event_reader_pos == sizeof(s->event_rcb)) {
+                s->event_reader_pos = 0;
+                qemu_rbd_complete_aio(s->event_rcb);
+                s->qemu_aio_count--;
             }
         }
     } while (ret < 0 && errno == EINTR);
-- 
1.7.2.5

