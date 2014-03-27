From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 19/33] libceph: primary_temp infrastructure
Date: Thu, 27 Mar 2014 20:18:05 +0200
Message-ID: <1395944299-21970-20-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:36096 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757121AbaC0STI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:08 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so3232567eek.29
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:07 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id 48sm5965677eei.24.2014.03.27.11.19.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:06 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add primary_temp mappings infrastructure.  struct ceph_pg_mapping is
overloaded, primary_temp mappings are stored in an rb-tree, rooted at
ceph_osdmap, in a manner similar to pg_temp mappings.

Dump primary_temp mappings to /sys/kernel/debug/ceph/<client>/osdmap,
one 'primary_temp <pgid> <osd>' per line, e.g:

    primary_temp 2.6 4

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osdmap.h |    5 +++++
 net/ceph/debugfs.c          |    7 +++++++
 net/ceph/osdmap.c           |   10 +++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 4837e58e3203..db4fb6322aae 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -66,6 +66,9 @@ struct ceph_pg_mapping {
 			int len;
 			int osds[];
 		} pg_temp;
+		struct {
+			int osd;
+		} primary_temp;
 	};
 };
 
@@ -83,6 +86,8 @@ struct ceph_osdmap {
 	struct ceph_entity_addr *osd_addr;
 
 	struct rb_root pg_temp;
+	struct rb_root primary_temp;
+
 	struct rb_root pg_pools;
 	u32 pool_max;
 
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 5865f2c9580a..612bf55e6a8b 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -93,6 +93,13 @@ static int osdmap_show(struct seq_file *s, void *p)
 				   pg->pg_temp.osds[i]);
 		seq_printf(s, "]\n");
 	}
+	for (n = rb_first(&map->primary_temp); n; n = rb_next(n)) {
+		struct ceph_pg_mapping *pg =
+			rb_entry(n, struct ceph_pg_mapping, node);
+
+		seq_printf(s, "primary_temp %llu.%x %d\n", pg->pgid.pool,
+			   pg->pgid.seed, pg->primary_temp.osd);
+	}
 
 	return 0;
 }
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 401af78ad741..d78c3e5d60f7 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -343,7 +343,7 @@ bad:
 
 /*
  * rbtree of pg_mapping for handling pg_temp (explicit mapping of pgid
- * to a set of osds)
+ * to a set of osds) and primary_temp (explicit primary setting)
  */
 static int pgid_cmp(struct ceph_pg l, struct ceph_pg r)
 {
@@ -633,6 +633,13 @@ void ceph_osdmap_destroy(struct ceph_osdmap *map)
 		rb_erase(&pg->node, &map->pg_temp);
 		kfree(pg);
 	}
+	while (!RB_EMPTY_ROOT(&map->primary_temp)) {
+		struct ceph_pg_mapping *pg =
+			rb_entry(rb_first(&map->primary_temp),
+				 struct ceph_pg_mapping, node);
+		rb_erase(&pg->node, &map->primary_temp);
+		kfree(pg);
+	}
 	while (!RB_EMPTY_ROOT(&map->pg_pools)) {
 		struct ceph_pg_pool_info *pi =
 			rb_entry(rb_first(&map->pg_pools),
@@ -960,6 +967,7 @@ struct ceph_osdmap *ceph_osdmap_decode(void **p, void *end)
 		return ERR_PTR(-ENOMEM);
 
 	map->pg_temp = RB_ROOT;
+	map->primary_temp = RB_ROOT;
 	mutex_init(&map->crush_scratch_mutex);
 
 	ret = osdmap_decode(p, end, map);
-- 
1.7.10.4

