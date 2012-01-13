From: Andrey Stepachev <octo@yandex-team.ru>
Subject: [PATCH] check for valid filehandler, before using in next calls
Date: Fri, 13 Jan 2012 15:58:36 +0400
Message-ID: <1326455916-28463-1-git-send-email-octo@yandex-team.ru>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from safari.yandex.ru ([77.88.19.35]:50480 "EHLO safari.yandex.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab2AMMIu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Jan 2012 07:08:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Andrey Stepachev <octo@yandex-team.ru>

In case of nonexistent file, calling Client::replication()
triggers assert.

Signed-off-by: Andrey Stepachev <octo@yandex-team.ru>
---
 src/client/hadoop/CephFSInterface.cc |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/client/hadoop/CephFSInterface.cc b/src/client/hadoop/CephFSInterface.cc
index 4a050f2..5ffca64 100644
--- a/src/client/hadoop/CephFSInterface.cc
+++ b/src/client/hadoop/CephFSInterface.cc
@@ -750,9 +750,12 @@ JNIEXPORT jint JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1replicati
   ceph_mount_info *cmount = get_ceph_mount_t(env, obj);
   int fh = 0;
   fh = ceph_open(cmount, c_path, O_RDONLY, 0);
+  env->ReleaseStringUTFChars(j_path, c_path);
+  if (fh < 0) {
+	  return fh;
+  }
   int replication = ceph_get_file_replication(cmount, fh);
   ceph_close(cmount, fh);
-  env->ReleaseStringUTFChars(j_path, c_path);
   return replication;
 }
 
-- 
1.7.5.4

