From: Andrey Stepachev <octo47@gmail.com>
Subject: [PATCH] wrong unix timestamp calculation in hadoop lib
Date: Fri, 13 Jan 2012 19:12:24 +0400
Message-ID: <1326467544-19913-1-git-send-email-octo47@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from safari.yandex.ru ([77.88.19.35]:60733 "EHLO safari.yandex.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab2AMPPy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Jan 2012 10:15:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Andrey Stepachev <octo@yandex-team.ru>

From: Andrey Stepachev <octo@yandex-team.ru>

Hadoop always see wrong dates due of wrong timestamp calculation.
Possibly fixes #1666.

Signed-off-by: Andrey Stepachev <octo@yandex-team.ru>

---
 src/client/hadoop/CephFSInterface.cc |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/client/hadoop/CephFSInterface.cc b/src/client/hadoop/CephFSInterface.cc
index 4a050f2..c8378c2 100644
--- a/src/client/hadoop/CephFSInterface.cc
+++ b/src/client/hadoop/CephFSInterface.cc
@@ -672,14 +672,14 @@ JNIEXPORT jboolean JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1stat
   env->SetBooleanField(j_stat, c_dir_id, (0 != S_ISDIR(st.st_mode)));
   env->SetLongField(j_stat, c_block_id, st.st_blksize);
 
-  long long java_mtime(st.st_mtime);
+  long long java_mtime(st.st_mtim.tv_sec);
   java_mtime *= 1000;
-  java_mtime += st.st_mtim.tv_nsec;
+  java_mtime += st.st_mtim.tv_nsec / 1000;
   env->SetLongField(j_stat, c_mod_id, java_mtime);
 
-  long long java_atime(st.st_atime);
+  long long java_atime(st.st_atim.tv_sec);
   java_atime *= 1000;
-  java_atime += st.st_atim.tv_nsec;
+  java_atime += st.st_atim.tv_nsec / 1000;
   env->SetLongField(j_stat, c_access_id, java_atime);
 
   env->SetIntField(j_stat, c_mode_id, (int)st.st_mode);
-- 
1.7.5.4

