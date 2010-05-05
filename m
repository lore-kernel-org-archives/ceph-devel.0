From: Christian Brunner <chb@muc.de>
Subject: [PATCH] ceph: re-enable rados_aio_set_callback
Date: Wed, 5 May 2010 21:50:53 +0200
Message-ID: <20100505195053.GA50246@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:62933 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510Ab0EETuy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 May 2010 15:50:54 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

While implementing the AIO parts of the qemu-kvm driver I realized that
for every call to rados_aio_write the callback is called twice. The fir=
st
time, when the write is complete (committed to journal?) and the second
time, when the write is safe (committed to the object store?).

Usually I would think that a complete call is sufficient in most use
cases. However when I call rados_aio_release on the first callback, I g=
et
an error message (on the second callback):

common/Mutex.h: In function 'void Mutex::Lock(bool)':
common/Mutex.h:97: FAILED assert(r =3D=3D 0)
 1: (RadosClient::C_aio_Safe::finish(int)+0x7f) [0x3ea0262e0f]
 2: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0x5cb) [0x3ea027fc2b]
 3: (RadosClient::_dispatch(Message*)+0x7c) [0x3ea0250bac]
 4: (RadosClient::ms_dispatch(Message*)+0x33) [0x3ea0250ee3]
 5: (SimpleMessenger::dispatch_entry()+0x6a2) [0x3ea0268aa2]
 6: (SimpleMessenger::DispatchThread::entry()+0x51) [0x3ea025db41]
 7: (Thread::_entry_func(void*)+0xc) [0x3ea027645c]
 8: /lib64/libpthread.so.0() [0x3293406a3a]
 9: (clone()+0x6d) [0x3292cde67d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.
common/Mutex.h: In function 'void Mutex::Lock(bool)':
common/Mutex.h:97: FAILED assert(r =3D=3D 0)
 1: (RadosClient::C_aio_Safe::finish(int)+0x7f) [0x3ea0262e0f]
 2: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0x5cb) [0x3ea027fc2b]
 3: (RadosClient::_dispatch(Message*)+0x7c) [0x3ea0250bac]
 4: (RadosClient::ms_dispatch(Message*)+0x33) [0x3ea0250ee3]
 5: (SimpleMessenger::dispatch_entry()+0x6a2) [0x3ea0268aa2]
 6: (SimpleMessenger::DispatchThread::entry()+0x51) [0x3ea025db41]
 7: (Thread::_entry_func(void*)+0xc) [0x3ea027645c]
 8: /lib64/libpthread.so.0() [0x3293406a3a]
 9: (clone()+0x6d) [0x3292cde67d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion*'
Aborted (core dumped)

To work around this, I=E2=80=99d suggest to re-enable rados_aio_set_cal=
lback.
This way it would possible to clear (cb=3DNULL) or change the callback
handler.

Regards,
Christian
---
 src/librados.cc |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/librados.cc b/src/librados.cc
index 76d4a53..c3a34d7 100644
--- a/src/librados.cc
+++ b/src/librados.cc
@@ -1811,6 +1811,11 @@ extern "C" int rados_aio_create_completion(rados=
_callback_t cb, void *cba, rados
   return 0;
 }
=20
+extern "C" int rados_aio_set_callback(rados_completion_t c, rados_call=
back_t cb, void *cba)
+{
+  return ((RadosClient::AioCompletion *)c)->set_callback(cb, cba);
+}
+
 extern "C" int rados_aio_wait_for_complete(rados_completion_t c)
 {
   return ((RadosClient::AioCompletion *)c)->wait_for_complete();
--=20
1.6.6.1


--=20
Christian Brunner                              MUC.DE e.V.
                                               Joseph-Dollinger-Bogen 1=
4
                                               D-80807 Muenchen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
