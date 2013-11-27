From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 15/18] client: Add inline data migration helper
Date: Wed, 27 Nov 2013 21:40:54 +0800
Message-ID: <e778e086f813617bcad7c70e483e9290b0be0574.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48506 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab3K0NlZ (ORCPT
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
 src/client/Client.cc |   41 +++++++++++++++++++++++++++++++++++++++++
 src/client/Client.h  |    3 +++
 2 files changed, 44 insertions(+)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 3beab8f..bbd56f2 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -5767,6 +5767,47 @@ void Client::unlock_fh_pos(Fh *f)
   f->pos_locked = false;
 }
 
+int Client::uninline_data(Inode *in, Context *onfinish)
+{
+  char oid_buf[32];
+  snprintf(oid_buf, sizeof(oid_buf), "%llx.00000000", (long long unsigned)in->ino);
+  object_t oid = oid_buf;
+
+  ObjectOperation create_ops;
+  create_ops.create(false);
+
+  objecter->mutate(oid,
+                   OSDMap::file_to_object_locator(in->layout),
+                   create_ops,
+                   in->snaprealm->get_snap_context(),
+                   ceph_clock_now(cct),
+                   0,
+                   NULL,
+                   NULL);
+
+  bufferlist inline_version_bl;
+  ::encode(in->inline_version, inline_version_bl);
+
+  ObjectOperation uninline_ops;
+  uninline_ops.cmpxattr("inline_version",
+                        CEPH_OSD_CMPXATTR_OP_GT,
+                        CEPH_OSD_CMPXATTR_MODE_U64,
+                        inline_version_bl);
+  bufferlist inline_data = in->inline_data;
+  uninline_ops.write(0, inline_data, in->truncate_size, in->truncate_seq);
+  uninline_ops.setxattr("inline_version", inline_version_bl);
+
+  objecter->mutate(oid,
+                   OSDMap::file_to_object_locator(in->layout),
+                   uninline_ops,
+                   in->snaprealm->get_snap_context(),
+                   ceph_clock_now(cct),
+                   0,
+                   NULL,
+                   onfinish);
+
+  return 0;
+}
 
 // 
 
diff --git a/src/client/Client.h b/src/client/Client.h
index 48f1fea..63f0c41 100644
--- a/src/client/Client.h
+++ b/src/client/Client.h
@@ -429,6 +429,9 @@ protected:
 
   void handle_lease(MClientLease *m);
 
+  // inline data
+  int uninline_data(Inode *in, Context *onfinish);
+
   // file caps
   void check_cap_issue(Inode *in, Cap *cap, unsigned issued);
   void add_update_cap(Inode *in, MetaSession *session, uint64_t cap_id,
-- 
1.7.9.5

