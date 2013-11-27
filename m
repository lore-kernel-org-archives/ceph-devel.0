From: Rutger ter Borg <rutger@terborg.net>
Subject: Re: [PATCH] fix librados aio read buffer handling
Date: Wed, 27 Nov 2013 09:49:09 +0100
Message-ID: <l74blq$9ia$1@ger.gmane.org>
References: <l2bire$iue$1@ger.gmane.org> <alpine.DEB.2.00.1309300834080.12714@cobra.newdream.net> <524A0098.4060005@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080103000207000500030507"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46108 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab3K0ItW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Nov 2013 03:49:22 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1VlaoC-00064z-Fw
	for ceph-devel@vger.kernel.org; Wed, 27 Nov 2013 09:49:20 +0100
Received: from gl-95017.prolocation.net ([62.204.95.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 27 Nov 2013 09:49:20 +0100
Received: from rutger by gl-95017.prolocation.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 27 Nov 2013 09:49:20 +0100
In-Reply-To: <524A0098.4060005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080103000207000500030507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2013-10-01 00:52, Josh Durgin wrote:
>
> I'm fine applying this now (with one fix). It's a nice cleanup
> even if things change more soon.
>
> For the C interface, the return value stored in the AioCompletionImpl
> needs to be the length read, so the caller can tell if a short read
> occurred (this is only possible when trying to read past the end of an
> object). This was being set in C_aio_Ack::finish(), but was removed by
> this patch.

Please find attached a revised patch against 0.72.1. I've added a fix 
for setting the return value in C_aio_Ack::finish(),

if (c->bl.length() > 0) {
   c->rval = c->bl.length();
}

Cheers,

Rutger



--------------080103000207000500030507
Content-Type: text/x-patch;
 name="aio_read_patch_2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="aio_read_patch_2.diff"

diff -u -p ceph-0.72.1/src/librados/AioCompletionImpl.h ceph-0.72.1-patched/src/librados/AioCompletionImpl.h
--- ceph-0.72.1/src/librados/AioCompletionImpl.h	2013-11-22 10:15:58.000000000 +0100
+++ ceph-0.72.1-patched/src/librados/AioCompletionImpl.h	2013-11-25 11:32:06.178467454 +0100
@@ -39,8 +39,7 @@ struct librados::AioCompletionImpl {
 
   // for read
   bool is_read;
-  bufferlist bl, *pbl;
-  char *buf;
+  bufferlist bl;
   unsigned maxlen;
 
   IoCtxImpl *io;
@@ -54,7 +53,7 @@ struct librados::AioCompletionImpl {
 			callback_safe(0),
 			callback_complete_arg(0),
 			callback_safe_arg(0),
-			is_read(false), pbl(0), buf(0), maxlen(0),
+			is_read(false), maxlen(0),
 			io(NULL), aio_write_seq(0), aio_write_list_item(this) { }
 
   int set_complete_callback(void *cb_arg, rados_callback_t cb) {
diff -u -p ceph-0.72.1/src/librados/IoCtxImpl.cc ceph-0.72.1-patched/src/librados/IoCtxImpl.cc
--- ceph-0.72.1/src/librados/IoCtxImpl.cc	2013-11-22 10:15:58.000000000 +0100
+++ ceph-0.72.1-patched/src/librados/IoCtxImpl.cc	2013-11-25 11:40:41.952777192 +0100
@@ -570,7 +570,6 @@ int librados::IoCtxImpl::aio_operate_rea
 
   c->is_read = true;
   c->io = this;
-  c->pbl = pbl;
 
   Mutex::Locker l(*lock);
   objecter->read(oid, oloc,
@@ -612,11 +611,10 @@ int librados::IoCtxImpl::aio_read(const
 
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
@@ -632,8 +630,9 @@ int librados::IoCtxImpl::aio_read(const
 
   c->is_read = true;
   c->io = this;
-  c->buf = buf;
   c->maxlen = len;
+  c->bl.clear();
+  c->bl.push_back( buffer::create_static( len, buf ) );
 
   Mutex::Locker l(*lock);
   objecter->read(oid, oloc,
@@ -668,7 +667,6 @@ int librados::IoCtxImpl::aio_sparse_read
 
   c->is_read = true;
   c->io = this;
-  c->pbl = NULL;
 
   onack->m_ops.sparse_read(off, len, m, data_bl, NULL);
 
@@ -1179,14 +1177,9 @@ void librados::IoCtxImpl::C_aio_Ack::fin
     c->safe = true;
   c->cond.Signal();
 
-  if (c->buf && c->bl.length() > 0) {
-    unsigned l = MIN(c->bl.length(), c->maxlen);
-    c->bl.copy(0, l, c->buf);
+  if (c->bl.length() > 0) {
     c->rval = c->bl.length();
   }
-  if (c->pbl) {
-    *c->pbl = c->bl;
-  }
 
   if (c->callback_complete) {
     c->io->client->finisher.queue(new C_AioComplete(c));

--------------080103000207000500030507--

