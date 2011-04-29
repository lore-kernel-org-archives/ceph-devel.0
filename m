From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] hadoop: cleanups for libceph type update
Date: Fri, 29 Apr 2011 09:13:59 -0600
Message-ID: <1304090039-14246-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:44041 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab1D2POg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2011 11:14:36 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1DC961895ED
	for <ceph-devel@vger.kernel.org>; Fri, 29 Apr 2011 09:14:33 -0600 (MDT)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Fri, 29 Apr 2011 09:09:32 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>


Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/client/hadoop/CephFSInterface.cc |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/client/hadoop/CephFSInterface.cc b/src/client/hadoop/CephFSInterface.cc
index 38c9be9..dea082b 100644
--- a/src/client/hadoop/CephFSInterface.cc
+++ b/src/client/hadoop/CephFSInterface.cc
@@ -13,7 +13,7 @@ union ceph_mount_union_t {
   jlong cjlong;
 };
 
-static void set_struct ceph_mount_info(JNIEnv *env, jobject obj, struct ceph_mount_info *cmount)
+static void set_ceph_mount_info(JNIEnv *env, jobject obj, struct ceph_mount_info *cmount)
 {
   jclass cls = env->GetObjectClass(obj);
   jfieldID fid = env->GetFieldID(cls, "cmount", "Ljava/lang/Long;");
@@ -105,7 +105,7 @@ JNIEXPORT jboolean JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1initi
     ceph_set_default_preferred_pg(cmount, ceph_get_local_osd(cmount));
   }
 
-  set_ceph_mount_t(env, obj, cmount);
+  set_ceph_mount_info(env, obj, cmount);
   return true;
 }
 
@@ -609,7 +609,7 @@ JNIEXPORT jboolean JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1kill_
   if (!cmount)
     return true;
   ceph_shutdown(cmount);
-  set_ceph_mount_t(env, obj, NULL);
+  set_ceph_mount_info(env, obj, NULL);
   return true;
 }
 
-- 
1.6.6


