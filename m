From: Rutger ter Borg <rutger@terborg.net>
Subject: [PATCH] fix librados aio read buffer handling
Date: Mon, 30 Sep 2013 12:13:11 +0200
Message-ID: <l2bire$iue$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080604010803040603060405"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47088 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755757Ab3I3KNY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Sep 2013 06:13:24 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1VQaTh-0006pI-Qp
	for ceph-devel@vger.kernel.org; Mon, 30 Sep 2013 12:13:21 +0200
Received: from gl-95017.prolocation.net ([62.204.95.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 30 Sep 2013 12:13:21 +0200
Received: from rutger by gl-95017.prolocation.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 30 Sep 2013 12:13:21 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080604010803040603060405
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Dear all,

please find attached a patch that enables a user to pass user-owned 
buffers into librados' aio_read. The patch (against dumpling) removes 
the buf and pbl data members in AioCompletionImpl.

* The 'buf' argument to read() used to be passed into AioCompletionImpl, 
and the results would be copied back after reading. This is replaced 
with the creation of a static buffer of that buf.

* The pbl argument in AioCompletionImpl is removed.

The patch is tested against an application using librados. I've assumed 
that 'pbl' in

aio_read( ...., pbl, )

is allocated by the user. It may even speed things up: a buffer copy is 
prevented.

Thanks,

Rutger


--------------080604010803040603060405
Content-Type: text/x-patch;
 name="aio_read_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="aio_read_patch.diff"

diff -u -p ceph-0.67.3/src/librados/AioCompletionImpl.h ceph-0.67.3-patched/src/librados/AioCompletionImpl.h
--- ceph-0.67.3/src/librados/AioCompletionImpl.h	2013-09-09 21:47:34.000000000 +0200
+++ ceph-0.67.3-patched/src/librados/AioCompletionImpl.h	2013-09-30 11:14:17.946802146 +0200
@@ -39,8 +39,7 @@ struct librados::AioCompletionImpl {
 
   // for read
   bool is_read;
-  bufferlist bl, *pbl;
-  char *buf;
+  bufferlist bl;
   unsigned maxlen;
 
   IoCtxImpl *io;
@@ -50,7 +49,7 @@ struct librados::AioCompletionImpl {
   AioCompletionImpl() : lock("AioCompletionImpl lock", false, false),
 			ref(1), rval(0), released(false), ack(false), safe(false),
 			callback_complete(0), callback_safe(0), callback_arg(0),
-			is_read(false), pbl(0), buf(0), maxlen(0),
+			is_read(false), maxlen(0),
 			io(NULL), aio_write_seq(0), aio_write_list_item(this) { }
 
   int set_complete_callback(void *cb_arg, rados_callback_t cb) {
diff -u -p ceph-0.67.3/src/librados/IoCtxImpl.cc ceph-0.67.3-patched/src/librados/IoCtxImpl.cc
--- ceph-0.67.3/src/librados/IoCtxImpl.cc	2013-09-09 21:47:34.000000000 +0200
+++ ceph-0.67.3-patched/src/librados/IoCtxImpl.cc	2013-09-30 11:14:23.622824966 +0200
@@ -570,7 +570,6 @@ int librados::IoCtxImpl::aio_operate_rea
 
   c->is_read = true;
   c->io = this;
-  c->pbl = pbl;
 
   Mutex::Locker l(*lock);
   objecter->read(oid, oloc,
@@ -613,11 +612,10 @@ int librados::IoCtxImpl::aio_read(const
 
   c->is_read = true;
   c->io = this;
-  c->pbl = pbl;
 
   Mutex::Locker l(*lock);
   objecter->read(oid, oloc,
-		 off, len, snapid, &c->bl, 0,
+		 off, len, snapid, pbl, 0,
 		 onack, &c->objver);
   return 0;
 }
@@ -633,8 +631,9 @@ int librados::IoCtxImpl::aio_read(const
 
   c->is_read = true;
   c->io = this;
-  c->buf = buf;
   c->maxlen = len;
+  c->bl.clear();
+  c->bl.push_back( buffer::create_static( len, buf ) );
 
   Mutex::Locker l(*lock);
   objecter->read(oid, oloc,
@@ -669,7 +668,6 @@ int librados::IoCtxImpl::aio_sparse_read
 
   c->is_read = true;
   c->io = this;
-  c->pbl = NULL;
 
   onack->m_ops.sparse_read(off, len, m, data_bl, NULL);
 
@@ -1180,15 +1178,6 @@ void librados::IoCtxImpl::C_aio_Ack::fin
     c->safe = true;
   c->cond.Signal();
 
-  if (c->buf && c->bl.length() > 0) {
-    unsigned l = MIN(c->bl.length(), c->maxlen);
-    c->bl.copy(0, l, c->buf);
-    c->rval = c->bl.length();
-  }
-  if (c->pbl) {
-    *c->pbl = c->bl;
-  }
-
   if (c->callback_complete) {
     c->io->client->finisher.queue(new C_AioComplete(c));
   }

--------------080604010803040603060405--

