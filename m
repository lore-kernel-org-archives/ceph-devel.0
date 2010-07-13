From: Christian Brunner <chb@muc.de>
Subject: Re: [Qemu-devel] Re: [PATCH] ceph/rbd block driver for qemu-kvm (v3)
Date: Tue, 13 Jul 2010 21:23:38 +0200
Message-ID: <20100713192338.GA25126@sir.home>
References: <20100531193140.GA13993@chb-desktop>
 <4C1293B7.1060307@gmail.com>
 <AANLkTimQ8voPJC6krCAsvlzoOZOZ-1LDXXI6_asbO9xT@mail.gmail.com>
 <4C1B45DB.4000502@redhat.com>
 <AANLkTilSXVV6JzLXGBZ0OvVuut9wad7TLkZtxEmXmrEy@mail.gmail.com>
 <AANLkTilnN7SXDXIulNICT5kjdgYJuVJIWYhKr6RVP_7K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39445 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab0GMTXn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jul 2010 15:23:43 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilnN7SXDXIulNICT5kjdgYJuVJIWYhKr6RVP_7K@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Simone Gotti <simone.gotti@gmail.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2010 at 11:27:03AM -0700, Yehuda Sadeh Weinraub wrote:
> >
> > There is another problem with very large i/o requests. I suspect that
> > this can be triggered only
> > with qemu-io and not in kvm, but I'll try to get a proper solution it anyway.
> >
> 
> Have you made any progress with this issue? Just note that there were
> a few changes we introduced recently (a format change that allows
> renaming of rbd images, and some snapshots support), so everything
> will needed to be reposted once we figure out the aio issue.

Attached is a patch where I'm trying to solve the issue
with pthreads locking. It works well with qemu-io, but I'm
not sure if there are interferences with other threads in
qemu/kvm (I didn't have time to test this, yet).

Another thing I'm not sure about is the fact, that these
large I/O requests only happen with qemu-io. I've never seen
this happen inside a virtual machine. So do we really have
to fix this, as it is only a warning message (laggy).

Regards,

Christian


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0027-add-queueing-delay-based-on-queuesize.patch"

From fcef3d897e0357b252a189ed59e43bfd5c24d229 Mon Sep 17 00:00:00 2001
From: Christian Brunner <chb@muc.de>
Date: Tue, 22 Jun 2010 21:51:09 +0200
Subject: [PATCH 27/27] add queueing delay based on queuesize

---
 block/rbd.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 10daf20..c6693d7 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -24,7 +24,7 @@
 #include <rados/librados.h>
 
 #include <signal.h>
-
+#include <pthread.h>
 
 int eventfd(unsigned int initval, int flags);
 
@@ -50,6 +50,7 @@ int eventfd(unsigned int initval, int flags);
  */
 
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
+#define MAX_QUEUE_SIZE 33554432 // 32MB
 
 typedef struct RBDAIOCB {
     BlockDriverAIOCB common;
@@ -79,6 +80,9 @@ typedef struct BDRVRBDState {
     uint64_t size;
     uint64_t objsize;
     int qemu_aio_count;
+    uint64_t queuesize;
+    pthread_mutex_t *queue_mutex;
+    pthread_cond_t *queue_threshold;
 } BDRVRBDState;
 
 typedef struct rbd_obj_header_ondisk RbdHeader1;
@@ -334,6 +338,12 @@ static int rbd_open(BlockDriverState *bs, const char *filename, int flags)
     le64_to_cpus((uint64_t *) & header->image_size);
     s->size = header->image_size;
     s->objsize = 1 << header->options.order;
+    s->queuesize = 0;
+
+    s->queue_mutex = qemu_malloc(sizeof(pthread_mutex_t));
+    pthread_mutex_init(s->queue_mutex, NULL);
+    s->queue_threshold = qemu_malloc(sizeof(pthread_cond_t));
+    pthread_cond_init (s->queue_threshold, NULL);
 
     s->efd = eventfd(0, 0);
     if (s->efd < 0) {
@@ -356,6 +366,11 @@ static void rbd_close(BlockDriverState *bs)
 {
     BDRVRBDState *s = bs->opaque;
 
+    pthread_cond_destroy(s->queue_threshold);
+    qemu_free(s->queue_threshold);
+    pthread_mutex_destroy(s->queue_mutex);
+    qemu_free(s->queue_mutex);
+
     rados_close_pool(s->pool);
     rados_deinitialize();
 }
@@ -443,6 +458,12 @@ static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
     int i;
 
     acb->aiocnt--;
+    acb->s->queuesize -= rcb->segsize;
+    if (acb->s->queuesize+rcb->segsize > MAX_QUEUE_SIZE && acb->s->queuesize <= MAX_QUEUE_SIZE) {
+        pthread_mutex_lock(acb->s->queue_mutex);
+        pthread_cond_signal(acb->s->queue_threshold);
+        pthread_mutex_unlock(acb->s->queue_mutex);
+    }
     r = rados_aio_get_return_value(c);
     rados_aio_release(c);
     if (acb->write) {
@@ -560,6 +581,14 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
         rcb->segsize = segsize;
         rcb->buf = buf;
 
+        while  (s->queuesize > MAX_QUEUE_SIZE) {
+            pthread_mutex_lock(s->queue_mutex);
+            pthread_cond_wait(s->queue_threshold, s->queue_mutex);
+            pthread_mutex_unlock(s->queue_mutex);
+        }
+
+        s->queuesize += segsize;
+
         if (write) {
             rados_aio_create_completion(rcb, NULL,
                                         (rados_callback_t) rbd_finish_aiocb,
-- 
1.7.0.4


--SUOF0GtieIMvvwua--
