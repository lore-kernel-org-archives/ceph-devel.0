From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 17/18] client: Write inline data path
Date: Wed, 27 Nov 2013 21:40:56 +0800
Message-ID: <8bc8c758bb5058a10965d422fb99d5bc29f85a71.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48455 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab3K0NlZ (ORCPT
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
 src/client/Client.cc |   55 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 6b08155..c913e35 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -6215,6 +6215,41 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
 
   ldout(cct, 10) << " snaprealm " << *in->snaprealm << dendl;
 
+  Mutex uninline_flock("Clinet::_write_uninline_data flock");
+  Cond uninline_cond;
+  bool uninline_done = false;
+  int uninline_ret = 0;
+  Context *onuninline = NULL;
+
+  if (in->inline_version < CEPH_INLINE_NONE) {
+    if (endoff > CEPH_INLINE_SIZE || !(have & CEPH_CAP_FILE_BUFFER)) {
+      onuninline = new C_SafeCond(&uninline_flock,
+                                  &uninline_cond,
+                                  &uninline_done,
+                                  &uninline_ret);
+      uninline_data(in, onuninline);
+    } else {
+      get_cap_ref(in, CEPH_CAP_FILE_BUFFER);
+
+      uint32_t len = in->inline_data.length();
+
+      if (endoff < len)
+        in->inline_data.copy(endoff, len - endoff, bl);
+
+      if (offset < len)
+        in->inline_data.splice(offset, len - offset);
+      else if (offset > len)
+        in->inline_data.append_zero(offset - len);
+
+      in->inline_data.append(bl);
+      in->inline_version++;
+
+      put_cap_ref(in, CEPH_CAP_FILE_BUFFER);
+
+      goto success;
+    }
+  }
+
   if (cct->_conf->client_oc && (have & CEPH_CAP_FILE_BUFFER)) {
     // do buffered write
     if (!in->oset.dirty_or_tx)
@@ -6265,7 +6300,7 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
   }
 
   // if we get here, write was successful, update client metadata
-
+success:
   // time
   lat = ceph_clock_now(cct);
   lat -= start;
@@ -6293,6 +6328,24 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
   mark_caps_dirty(in, CEPH_CAP_FILE_WR);
 
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

