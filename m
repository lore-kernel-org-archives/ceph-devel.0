From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 16/18] client: Read inline data path
Date: Wed, 27 Nov 2013 21:40:55 +0800
Message-ID: <1aa175256e0acb20de477abe39303c9345df6939.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48451 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab3K0NlZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:25 -0500
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
 src/client/Client.cc |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index bbd56f2..6b08155 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -5853,6 +5853,41 @@ int Client::_read(Fh *f, int64_t offset, uint64_t size, bufferlist *bl)
     movepos = true;
   }
 
+  Mutex uninline_flock("Clinet::_read_uninline_data flock");
+  Cond uninline_cond;
+  bool uninline_done = false;
+  int uninline_ret = 0;
+  Context *onuninline = NULL;
+
+  if (in->inline_version < CEPH_INLINE_NONE) {
+    if (!(have & CEPH_CAP_FILE_CACHE)) {
+      onuninline = new C_SafeCond(&uninline_flock,
+                                  &uninline_cond,
+                                  &uninline_done,
+                                  &uninline_ret);
+      uninline_data(in, onuninline);
+    } else {
+      uint32_t len = in->inline_data.length();
+
+      uint64_t endoff = offset + size;
+      if (endoff > in->size)
+        endoff = in->size;
+
+      if (offset < len) {
+        if (endoff <= len) {
+          bl->substr_of(in->inline_data, offset, endoff - offset);
+        } else {
+          bl->substr_of(in->inline_data, offset, len - offset);
+          bl->append_zero(endoff - len);
+        }
+      } else if (offset < endoff) {
+        bl->append_zero(endoff - offset);
+      }
+
+      goto success;
+    }
+  }
+
   if (!conf->client_debug_force_sync_read &&
       (cct->_conf->client_oc && (have & CEPH_CAP_FILE_CACHE))) {
 
@@ -5869,6 +5904,8 @@ int Client::_read(Fh *f, int64_t offset, uint64_t size, bufferlist *bl)
     goto done;
   }
 
+success:
+
   if (movepos) {
     // adjust fd pos
     f->pos = offset+bl->length();
@@ -5890,6 +5927,24 @@ int Client::_read(Fh *f, int64_t offset, uint64_t size, bufferlist *bl)
 
 done:
   // done!
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
   put_cap_ref(in, CEPH_CAP_FILE_RD);
   return r;
 }
-- 
1.7.9.5

