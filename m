From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 07/11] libceph: add ceph_pg_pool_by_id()
Date: Mon, 27 Jan 2014 17:58:49 +0200
Message-ID: <1390838333-32266-8-git-send-email-ilya.dryomov@inktank.com>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:59578 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbaA0QAH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 11:00:07 -0500
Received: by mail-lb0-f171.google.com with SMTP id c11so4603026lbj.16
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 08:00:06 -0800 (PST)
In-Reply-To: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

"Lookup pool info by ID" function is hidden in osdmap.c.  Expose it to
the rest of libceph.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osdmap.h |    3 +++
 net/ceph/osdmap.c           |    5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index ebb8ec285de6..7f894a64c6c7 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -174,6 +174,9 @@ extern int ceph_calc_pg_acting(struct ceph_osdmap *osdmap,
 extern int ceph_calc_pg_primary(struct ceph_osdmap *osdmap,
 				struct ceph_pg pgid);
 
+extern struct ceph_pg_pool_info *ceph_pg_pool_by_id(struct ceph_osdmap *map,
+						    u64 id);
+
 extern const char *ceph_pg_pool_name_by_id(struct ceph_osdmap *map, u64 id);
 extern int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char *name);
 
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 768dd04eb9b1..d69d23556f0c 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -464,6 +464,11 @@ static struct ceph_pg_pool_info *__lookup_pg_pool(struct rb_root *root, u64 id)
 	return NULL;
 }
 
+struct ceph_pg_pool_info *ceph_pg_pool_by_id(struct ceph_osdmap *map, u64 id)
+{
+	return __lookup_pg_pool(&map->pg_pools, id);
+}
+
 const char *ceph_pg_pool_name_by_id(struct ceph_osdmap *map, u64 id)
 {
 	struct ceph_pg_pool_info *pi;
-- 
1.7.10.4

