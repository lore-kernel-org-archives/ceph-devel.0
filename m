From: Christian Brunner <chb@muc.de>
Subject: [PATCH] rbd: add queuing delay
Date: Sun, 20 Jun 2010 22:44:26 +0200
Message-ID: <20100620204426.GA7139@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46574 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757079Ab0FTUoa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jun 2010 16:44:30 -0400
Received: by fxm10 with SMTP id 10so1459822fxm.19
        for <ceph-devel@vger.kernel.org>; Sun, 20 Jun 2010 13:44:29 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Yehuda,

while running tests with qemu-io I've been experiencing a lot of
messages when running a large writev request (several hundred MB in
a single call):

10.06.20 22:10:07.337108 b67dcb70 client4136.objecter  pg 3.437e on [0] is laggy: 33
10.06.20 22:10:07.337708 b67dcb70 client4136.objecter  pg 3.2553 on [0] is laggy: 19
[...]

Everything is working fine, though. I think that the large number of
queued requests is the cause for this behaviour and I would propose to
delay futher requests (see attached patch).

What do you think about it?

Another question: I there a way to figure out max_osd through librados?

Christian

---
 block/rbd.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 74589cb..241b0c6 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -47,6 +47,14 @@
 
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
 
+/*
+ * For best performance MAX_RADOS_REQS should be at least as large as the 
+ * number of osds. It may be larger, but if to high you may experience lagging
+ *
+ * XXX: automatically set to 2*max_osd ???
+ */
+#define MAX_RADOS_REQS 16
+
 typedef struct RBDAIOCB {
     BlockDriverAIOCB common;
     QEMUBH *bh;
@@ -507,6 +515,11 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
         rcb->segsize = segsize;
         rcb->buf = buf;
 
+        /* delay rados aio requests when the queue is getting to large */
+        while ((segnr - last_segnr + acb->aiocnt) > MAX_RADOS_REQS) {
+		usleep(100);
+	}
+
         if (write) {
             rados_aio_create_completion(rcb, NULL,
                                         (rados_callback_t) rbd_finish_aiocb,
-- 
1.7.0.4

