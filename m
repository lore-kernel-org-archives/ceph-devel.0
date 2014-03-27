From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 18/33] libceph: generalize ceph_pg_mapping
Date: Thu, 27 Mar 2014 20:18:04 +0200
Message-ID: <1395944299-21970-19-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:57919 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757121AbaC0STG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:06 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so3220389eek.38
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:04 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id a42sm5981895ees.10.2014.03.27.11.19.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:04 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In preparation for adding support for primary_temp mappings, generalize
struct ceph_pg_mapping so it can hold mappings other than pg_temp.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osdmap.h |    9 +++++++--
 net/ceph/debugfs.c          |    4 ++--
 net/ceph/osdmap.c           |    8 ++++----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 46c3e304c3d8..4837e58e3203 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -60,8 +60,13 @@ struct ceph_object_id {
 struct ceph_pg_mapping {
 	struct rb_node node;
 	struct ceph_pg pgid;
-	int len;
-	int osds[];
+
+	union {
+		struct {
+			int len;
+			int osds[];
+		} pg_temp;
+	};
 };
 
 struct ceph_osdmap {
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index c45d235e774e..5865f2c9580a 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -88,9 +88,9 @@ static int osdmap_show(struct seq_file *s, void *p)
 
 		seq_printf(s, "pg_temp %llu.%x [", pg->pgid.pool,
 			   pg->pgid.seed);
-		for (i = 0; i < pg->len; i++)
+		for (i = 0; i < pg->pg_temp.len; i++)
 			seq_printf(s, "%s%d", (i == 0 ? "" : ","),
-				   pg->osds[i]);
+				   pg->pg_temp.osds[i]);
 		seq_printf(s, "]\n");
 	}
 
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index ae96c73aff71..401af78ad741 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -822,9 +822,9 @@ static int __decode_pg_temp(void **p, void *end, struct ceph_osdmap *map,
 				return -ENOMEM;
 
 			pg->pgid = pgid;
-			pg->len = len;
+			pg->pg_temp.len = len;
 			for (i = 0; i < len; i++)
-				pg->osds[i] = ceph_decode_32(p);
+				pg->pg_temp.osds[i] = ceph_decode_32(p);
 
 			ret = __insert_pg_mapping(pg, &map->pg_temp);
 			if (ret) {
@@ -1275,8 +1275,8 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 				    pool->pg_num_mask);
 	pg = __lookup_pg_mapping(&osdmap->pg_temp, pgid);
 	if (pg) {
-		*num = pg->len;
-		return pg->osds;
+		*num = pg->pg_temp.len;
+		return pg->pg_temp.osds;
 	}
 
 	/* crush */
-- 
1.7.10.4

