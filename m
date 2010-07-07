From: Yehuda Sadeh <yehuda@hq.newdream.net>
Subject: [PATCH v3 01/10] ceph-rbd: lookup pool in osdmap by name
Date: Wed,  7 Jul 2010 15:11:23 -0700
Message-ID: <9e565a8e094a7a59730adcece64d1b4a12adf39f.1278539315.git.yehuda@hq.newdream.net>
References: <cover.1278539315.git.yehuda@hq.newdream.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1278539315.git.yehuda@hq.newdream.net>
In-Reply-To: <cover.1278539315.git.yehuda@hq.newdream.net>
References: <cover.1278539315.git.yehuda@hq.newdream.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, sage@newdream.net, Yehuda Sadeh <yehuda@hq.newdream.net>
List-Id: ceph-devel.vger.kernel.org

Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/osdmap.c |   13 +++++++++++++
 fs/ceph/osdmap.h |    2 ++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/fs/ceph/osdmap.c b/fs/ceph/osdmap.c
index ddc656f..11aac1c 100644
--- a/fs/ceph/osdmap.c
+++ b/fs/ceph/osdmap.c
@@ -417,6 +417,19 @@ static struct ceph_pg_pool_info *__lookup_pg_pool(struct rb_root *root, int id)
 	return NULL;
 }
 
+int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char *name)
+{
+	struct rb_node *rbp;
+
+	for (rbp = rb_first(&map->pg_pools); rbp; rbp = rb_next(rbp)) {
+		struct ceph_pg_pool_info *pi =
+			rb_entry(rbp, struct ceph_pg_pool_info, node);
+		if (pi->name && strcmp(pi->name, name) == 0)
+			return pi->id;
+	}
+	return -ENOENT;
+}
+
 static void __remove_pg_pool(struct rb_root *root, struct ceph_pg_pool_info *pi)
 {
 	rb_erase(&pi->node, root);
diff --git a/fs/ceph/osdmap.h b/fs/ceph/osdmap.h
index 970b547..a592b21 100644
--- a/fs/ceph/osdmap.h
+++ b/fs/ceph/osdmap.h
@@ -125,4 +125,6 @@ extern int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 extern int ceph_calc_pg_primary(struct ceph_osdmap *osdmap,
 				struct ceph_pg pgid);
 
+extern int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char *name);
+
 #endif
-- 
1.5.6.5
