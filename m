From: Christian Brunner <chb@muc.de>
Subject: [PATCH] qemu-kvm/rbd: avoid opening eventfd twice and close it on
 exit
Date: Wed, 14 Jul 2010 15:38:13 +0200
Message-ID: <20100714133812.GB21617@bambus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61141 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786Ab0GNNiW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jul 2010 09:38:22 -0400
Received: by bwz1 with SMTP id 1so927519bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jul 2010 06:38:21 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch removes the second call of eventfd/qemu_aio_set_fd_handler and closes
the filediscriptor on exit.

With this patch and the thread locking I'm able to run qemu-iotest without any
problem.

Christian
---
 block/rbd.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 7a77072..9339dab 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -513,15 +513,6 @@ static int rbd_open(BlockDriverState *bs, const char *filename, int flags)
 
     qemu_free(hbuf);
 
-    s->efd = eventfd(0, 0);
-    if (s->efd < 0) {
-        error_report("error opening eventfd");
-        goto failed;
-    }
-    fcntl(s->efd, F_SETFL, O_NONBLOCK);
-    qemu_aio_set_fd_handler(s->efd, rbd_aio_completion_cb, NULL,
-        rbd_aio_flush_cb, NULL, s);
-
     return 0;
 
 failed:
@@ -538,6 +529,9 @@ static void rbd_close(BlockDriverState *bs)
 {
     BDRVRBDState *s = bs->opaque;
 
+    close(s->efd);
+    qemu_aio_set_fd_handler(s->efd, NULL , NULL, NULL, NULL, NULL);
+
     // The following do not exist in qemu:
     // qemu_cond_destroy(s->queue_threshold);
     // qemu_mutex_destroy(s->queue_mutex);
-- 
1.6.5.2

