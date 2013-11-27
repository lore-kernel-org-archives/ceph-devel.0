From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 18/18] client: Fallocate inline data path
Date: Wed, 27 Nov 2013 21:40:57 +0800
Message-ID: <e44f915a48de9ae9a0be4f1fe0a3d8b970564710.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48514 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab3K0Nl0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:26 -0500
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/client/Client.cc |   99 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 23 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index c913e35..d77e4ce 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -8002,34 +8002,69 @@ int Client::_fallocate(Fh *fh, int mode, int64_t offset, int64_t length)
   if (r < 0)
     return r;
 
+  Mutex uninline_flock("Clinet::_fallocate_uninline_data flock");
+  Cond uninline_cond;
+  bool uninline_done = false;
+  int uninline_ret = 0;
+  Context *onuninline = NULL;
+
   if (mode & FALLOC_FL_PUNCH_HOLE) {
-    Mutex flock("Client::_punch_hole flock");
-    Cond cond;
-    bool done = false;
-    Context *onfinish = new C_SafeCond(&flock, &cond, &done);
-    Context *onsafe = new C_Client_SyncCommit(this, in);
+    if (in->inline_version < CEPH_INLINE_NONE &&
+        (have & CEPH_CAP_FILE_BUFFER)) {
+      bufferlist bl;
+      int len = in->inline_data.length();
+      if (offset < len) {
+        if (offset > 0)
+          in->inline_data.copy(0, offset, bl);
+        int size = length;
+        if (offset + size > len)
+          size = len - offset;
+        if (size > 0)
+          bl.append_zero(size);
+        if (offset + size < len)
+          in->inline_data.copy(offset + size, len - offset - size, bl);
+        in->inline_data = bl;
+        in->inline_version++;
+      }
+      in->mtime = ceph_clock_now(cct);
+      mark_caps_dirty(in, CEPH_CAP_FILE_WR);
+    } else {
+      if (in->inline_version < CEPH_INLINE_NONE) {
+        onuninline = new C_SafeCond(&uninline_flock,
+                                    &uninline_cond,
+                                    &uninline_done,
+                                    &uninline_ret);
+        uninline_data(in, onuninline);
+      }
 
-    unsafe_sync_write++;
-    get_cap_ref(in, CEPH_CAP_FILE_BUFFER);
+      Mutex flock("Client::_punch_hole flock");
+      Cond cond;
+      bool done = false;
+      Context *onfinish = new C_SafeCond(&flock, &cond, &done);
+      Context *onsafe = new C_Client_SyncCommit(this, in);
 
-    _invalidate_inode_cache(in, offset, length, true);
-    r = filer->zero(in->ino, &in->layout,
-                    in->snaprealm->get_snap_context(),
-                    offset, length,
-                    ceph_clock_now(cct),
-                    0, true, onfinish, onsafe);
-    if (r < 0)
-      goto done;
+      unsafe_sync_write++;
+      get_cap_ref(in, CEPH_CAP_FILE_BUFFER);
 
-    in->mtime = ceph_clock_now(cct);
-    mark_caps_dirty(in, CEPH_CAP_FILE_WR);
+      _invalidate_inode_cache(in, offset, length, true);
+      r = filer->zero(in->ino, &in->layout,
+                      in->snaprealm->get_snap_context(),
+                      offset, length,
+                      ceph_clock_now(cct),
+                      0, true, onfinish, onsafe);
+      if (r < 0)
+        goto done;
 
-    client_lock.Unlock();
-    flock.Lock();
-    while (!done)
-      cond.Wait(flock);
-    flock.Unlock();
-    client_lock.Lock();
+      in->mtime = ceph_clock_now(cct);
+      mark_caps_dirty(in, CEPH_CAP_FILE_WR);
+
+      client_lock.Unlock();
+      flock.Lock();
+      while (!done)
+        cond.Wait(flock);
+      flock.Unlock();
+      client_lock.Lock();
+    }
   } else if (!(mode & FALLOC_FL_KEEP_SIZE)) {
     uint64_t size = offset + length;
     if (size > in->size) {
@@ -8044,6 +8079,24 @@ int Client::_fallocate(Fh *fh, int mode, int64_t offset, int64_t length)
   }
 
 done:
+
+  if (onuninline) {
+    client_lock.Unlock();
+    uninline_flock.Lock();
+    while (!uninline_done)
+      uninline_cond.Wait(uninline_flock);
+    uninline_flock.Unlock();
+    client_lock.Lock();
+
+    if (uninline_ret >= 0 || uninline_ret == -ECANCELED) {
+      in->inline_data.clear();
+      in->inline_version = CEPH_INLINE_NONE;
+      mark_caps_dirty(in, CEPH_CAP_FILE_WR);
+      check_caps(in, false);
+    } else
+      r = uninline_ret;
+  }
+
   put_cap_ref(in, CEPH_CAP_FILE_WR);
   return r;
 }
-- 
1.7.9.5

