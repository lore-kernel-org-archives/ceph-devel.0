From: Josh Pieper <jjp@pobox.com>
Subject: [PATCH 2/2] Resolve gcc warnings.
Date: Sun, 13 Nov 2011 09:04:14 -0500
Message-ID: <20111113140414.GB19557@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:40872 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab1KMONl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Nov 2011 09:13:41 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From e4b9ae75724022cd1a557fde967b130888a35870 Mon Sep 17 00:00:00 2001
From: Josh Pieper <jjp@pobox.com>
Date: Fri, 11 Nov 2011 08:19:55 -0500
Subject: [PATCH 2/2] rgw: Fix some merge problems uncovered by gcc warnings:

 * a refactor in e2100bce left the mod_ptr and unmod_ptr members set
   incorrectly in RGWCopyObj::init_common
 * a fix in 6752babd aggregated error returns, but then failed to do
   anything with them

Signed-off-by: Josh Pieper <jjp@pobox.com>
---
 src/rgw/rgw_op.cc    |    4 ----
 src/rgw/rgw_op.h     |    2 ++
 src/rgw/rgw_rados.cc |    2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/rgw/rgw_op.cc b/src/rgw/rgw_op.cc
index 802734e..42b4c25 100644
--- a/src/rgw/rgw_op.cc
+++ b/src/rgw/rgw_op.cc
@@ -1004,10 +1004,6 @@ int RGWCopyObj::verify_permission()
 
 int RGWCopyObj::init_common()
 {
-  time_t mod_time;
-  time_t unmod_time;
-  time_t *mod_ptr = NULL;
-  time_t *unmod_ptr = NULL;
   if (if_mod) {
     if (parse_time(if_mod, &mod_time) < 0) {
       ret = -EINVAL;
diff --git a/src/rgw/rgw_op.h b/src/rgw/rgw_op.h
index d9c19dd..6557c38 100644
--- a/src/rgw/rgw_op.h
+++ b/src/rgw/rgw_op.h
@@ -309,6 +309,8 @@ protected:
   off_t ofs;
   off_t len;
   off_t end;
+  time_t mod_time;
+  time_t unmod_time;
   time_t *mod_ptr;
   time_t *unmod_ptr;
   int ret;
diff --git a/src/rgw/rgw_rados.cc b/src/rgw/rgw_rados.cc
index 147763d..146050b 100644
--- a/src/rgw/rgw_rados.cc
+++ b/src/rgw/rgw_rados.cc
@@ -915,7 +915,7 @@ int RGWRados::set_buckets_enabled(vector<rgw_bucket>& buckets, bool enabled)
       continue;
     }
   }
-  return 0;
+  return ret;
 }
 
 int RGWRados::bucket_suspended(rgw_bucket& bucket, bool *suspended)
-- 
1.7.5.4

