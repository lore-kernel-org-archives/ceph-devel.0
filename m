From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 25/33] libceph: ceph_can_shift_osds(pool) and pool type defines
Date: Thu, 27 Mar 2014 20:18:11 +0200
Message-ID: <1395944299-21970-26-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:40211 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757157AbaC0STW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:22 -0400
Received: by mail-ee0-f48.google.com with SMTP id b57so3191520eek.7
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:21 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id o4sm5973134eef.20.2014.03.27.11.19.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:21 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Bring in pg_pool_t::can_shift_osds() counterpart along with pool type
defines.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osdmap.h |   12 ++++++++++++
 include/linux/ceph/rados.h  |    5 +++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 0895797b9e28..4e28c1e5d62f 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -41,6 +41,18 @@ struct ceph_pg_pool_info {
 	char *name;
 };
 
+static inline bool ceph_can_shift_osds(struct ceph_pg_pool_info *pool)
+{
+	switch (pool->type) {
+	case CEPH_POOL_TYPE_REP:
+		return true;
+	case CEPH_POOL_TYPE_EC:
+		return false;
+	default:
+		BUG_ON(1);
+	}
+}
+
 struct ceph_object_locator {
 	s64 pool;
 };
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index bb6f40c9cb0f..f20e0d8a2155 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -81,8 +81,9 @@ struct ceph_pg_v1 {
  */
 #define CEPH_NOPOOL  ((__u64) (-1))  /* pool id not defined */
 
-#define CEPH_PG_TYPE_REP     1
-#define CEPH_PG_TYPE_RAID4   2
+#define CEPH_POOL_TYPE_REP     1
+#define CEPH_POOL_TYPE_RAID4   2 /* never implemented */
+#define CEPH_POOL_TYPE_EC      3
 
 /*
  * stable_mod func is used to control number of placement groups.
-- 
1.7.10.4

