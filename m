From: Christian Brunner <chb@muc.de>
Subject: Re: [PATCH] rbd: add queuing delay
Date: Tue, 22 Jun 2010 22:27:05 +0200
Message-ID: <20100622202705.GA17975@chb-desktop>
References: <AANLkTikMSExF8V783S_wOsfCK7mRQT24g5SV4qaYUlrv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40486 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab0FVU1K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jun 2010 16:27:10 -0400
Received: by bwz9 with SMTP id 9so198577bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jun 2010 13:27:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikMSExF8V783S_wOsfCK7mRQT24g5SV4qaYUlrv@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Tue, Jun 22, 2010 at 09:50:24PM +0200, Christian Brunner wrote:
> > while running tests with qemu-io I've been experiencing a lot of
> > messages when running a large writev request (several hundred MB in
> > a single call):
> >
> > 10.06.20 22:10:07.337108 b67dcb70 client4136.objecter =A0pg 3.437e =
on [0] is laggy: 33
> > 10.06.20 22:10:07.337708 b67dcb70 client4136.objecter =A0pg 3.2553 =
on [0] is laggy: 19
> > [...]
> >
> > Everything is working fine, though. I think that the large number o=
f
> > queued requests is the cause for this behaviour and I would propose=
 to
> > delay futher requests (see attached patch).
> >
> > What do you think about it?
>=20
> It seems that the osd is lagging behind. The usleep might work for yo=
u
> as you avoid the pressure, but it's also somewhat random and will
> probably hurt performance on other setups. I'd rather see a
> configurable solution that lets you specify a total in-flight bytes o=
r
> some other resizable window scheme.

I'm not sure if I understand what "lagging behind" means. If the in-fli=
ght
bytes are the sum of all requests in the queue, a solution could look l=
ike=20
this (although it isn't configurable yet).

Christian

---
 block/rbd.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 10daf20..f87e84c 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -50,6 +50,7 @@ int eventfd(unsigned int initval, int flags);
  */
=20
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
+#define MAX_QUEUE_SIZE 33554432 // 32MB
=20
 typedef struct RBDAIOCB {
     BlockDriverAIOCB common;
@@ -79,6 +80,7 @@ typedef struct BDRVRBDState {
     uint64_t size;
     uint64_t objsize;
     int qemu_aio_count;
+    uint64_t queuesize;
 } BDRVRBDState;
=20
 typedef struct rbd_obj_header_ondisk RbdHeader1;
@@ -334,6 +336,7 @@ static int rbd_open(BlockDriverState *bs, const cha=
r *filename, int flags)
     le64_to_cpus((uint64_t *) & header->image_size);
     s->size =3D header->image_size;
     s->objsize =3D 1 << header->options.order;
+    s->queuesize =3D 0;
=20
     s->efd =3D eventfd(0, 0);
     if (s->efd < 0) {
@@ -443,6 +446,7 @@ static void rbd_finish_aiocb(rados_completion_t c, =
RADOSCB *rcb)
     int i;
=20
     acb->aiocnt--;
+    acb->s->queuesize -=3D rcb->segsize;
     r =3D rados_aio_get_return_value(c);
     rados_aio_release(c);
     if (acb->write) {
@@ -560,6 +564,12 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDr=
iverState *bs,
         rcb->segsize =3D segsize;
         rcb->buf =3D buf;
=20
+        while  (s->queuesize > MAX_QUEUE_SIZE) {
+            usleep(100);
+        }
+
+        s->queuesize +=3D segsize;
+
         if (write) {
             rados_aio_create_completion(rcb, NULL,
                                         (rados_callback_t) rbd_finish_=
aiocb,
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
