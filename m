From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v4)
Date: Fri, 8 Oct 2010 08:50:01 -0700
Message-ID: <AANLkTinim=+MebUgSkpn2d2C2vY2bREwBor4xCf27s6n@mail.gmail.com>
References: <20100802194631.GA4923@chb-desktop>
	<alpine.LNX.2.00.1008030033550.2664@linmac>
	<20100803201407.GD1475@chb-desktop>
	<4CADD567.9010606@codemonkey.ws>
	<AANLkTikuNq1ApT+2ML6s6NXXpTZaedgJDG1xq_=oBQPK@mail.gmail.com>
	<4CAE13BA.70707@codemonkey.ws>
	<AANLkTim2qfA+MncyF9Cx1oGYEzgW2TugG9sFTLP8T=J-@mail.gmail.com>
	<4CAE24C5.8030007@codemonkey.ws>
	<AANLkTimW98qPTYZ=Bct7k7XqaOXswC51QdQOW6fLsWkQ@mail.gmail.com>
	<4CAE35C5.2010809@codemonkey.ws>
	<AANLkTinzdiJZFxacD1BDCPWt44ChokNaNVU6_E=GtcTD@mail.gmail.com>
	<4CAE41BD.2070508@codemonkey.ws>
	<Pine.LNX.4.64.1010071518120.11342@cobra.newdream.net>
	<4CAF255A.1030103@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42686 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab0JHPuD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Oct 2010 11:50:03 -0400
In-Reply-To: <4CAF255A.1030103@codemonkey.ws>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Sage Weil <sage@newdream.net>, Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>

On Fri, Oct 8, 2010 at 7:06 AM, Anthony Liguori <anthony@codemonkey.ws>=
 wrote:
> On 10/07/2010 05:45 PM, Sage Weil wrote:
>>
>> I'm sorry, I'm having a hard time understanding what it is you're
>> objecting to, or what you would prefer, as there are two different t=
hings
>> we're talking about here (callbacks and fd glue/pipes). =A0(Please b=
ear with
>> me as I am not a qemu expert!)
>>
>> The first is the aio completion. =A0You said a few messages back:
>>
>>
>>>
>>> It looks like you just use the eventfd to signal aio completion
>>> callbacks. =A0A better way to do this would be to schedule a bottom=
 half.
>>>
>>
>> This is what we're doing. =A0The librados makes a callback to rbd.c'=
s
>> rbd_finish_aiocb(), which updates some internal rbd accounting and t=
hen
>> calls qemu_bh_schedule(). =A0Is that part right?
>>
>
> No. =A0You're calling qemu_bh_schedule() in a separate thread in para=
llel to
> other operations.

Oh, that makes it more clean. Considering that we did it for kvm, and
looking at the kvm qemu_bh_schedule() implementation, it does look
thread safe (there might be an issue though with canceling the bh
though, haven't looked at it, not really relevant). In any case, we
already have the completion code with the pipes (currently eventfd)
that runs in the qemu context, so just moving the bh scheduling there
would work. Something like this (still needs to add some mutex around
qemu_aio_count that was missing before):


diff --git a/block/rbd.c b/block/rbd.c
index 13db079..164e547 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -315,13 +315,16 @@ done:
 static void rbd_aio_completion_cb(void *opaque)
 {
     BDRVRBDState *s =3D opaque;
+    RBDAIOCB *acb;

-    uint64_t val;
     ssize_t ret;

     do {
-        if ((ret =3D read(s->efd, &val, sizeof(val))) > 0) {
-            s->qemu_aio_count -=3D val;
+        if ((ret =3D read(s->efd, &acb, sizeof(acb))) > 0) {
+            s->qemu_aio_count --;
+            if (!acb->aiocnt && acb->bh) {
+                qemu_bh_schedule(acb->bh);
+            }
         }
     } while (ret < 0 && errno =3D=3D EINTR);

@@ -539,7 +542,6 @@ static void rbd_finish_aiocb(rados_completion_t c,
RADOSCB *rcb)
 {
     RBDAIOCB *acb =3D rcb->acb;
     int64_t r;
-    uint64_t buf =3D 1;
     int i;

     acb->aiocnt--;
@@ -570,13 +572,10 @@ static void rbd_finish_aiocb(rados_completion_t
c, RADOSCB *rcb)
             acb->ret +=3D r;
         }
     }
-    if (write(acb->s->efd, &buf, sizeof(buf)) < 0)
+    if (write(acb->s->efd, (void *)&acb, sizeof(&acb)) < 0)
         error_report("failed writing to acb->s->efd\n");
     qemu_free(rcb);
     i =3D 0;
-    if (!acb->aiocnt && acb->bh) {
-        qemu_bh_schedule(acb->bh);
-    }
 }


 /* Callback when all queued rados_aio requests are complete */
@@ -584,7 +583,6 @@ static void rbd_finish_aiocb(rados_completion_t c,
RADOSCB *rcb)
 static void rbd_aio_bh_cb(void *opaque)
 {
     RBDAIOCB *acb =3D opaque;
-    uint64_t buf =3D 1;

     if (!acb->write) {
         qemu_iovec_from_buffer(acb->qiov, acb->bounce, acb->qiov->size=
);
@@ -594,8 +592,6 @@ static void rbd_aio_bh_cb(void *opaque)
     qemu_bh_delete(acb->bh);
     acb->bh =3D NULL;

-    if (write(acb->s->efd, &buf, sizeof(buf)) < 0)
-        error_report("failed writing to acb->s->efd\n");
     qemu_aio_release(acb);
 }

@@ -644,7 +640,7 @@ static BlockDriverAIOCB
*rbd_aio_rw_vector(BlockDriverState *bs,
     last_segnr =3D ((off + size - 1) / s->objsize);
     acb->aiocnt =3D (last_segnr - segnr) + 1;

-    s->qemu_aio_count+=3Dacb->aiocnt + 1; /* All the RADOSCB and the
related RBDAIOCB */
+    s->qemu_aio_count+=3Dacb->aiocnt; /* All the RADOSCB and the
related RBDAIOCB */

     if (write && s->read_only) {
         acb->ret =3D -EROFS;
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
