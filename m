From: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
Subject: [PATCH]  fs/ceph: make logical calculation functions return bool
Date: Fri, 25 Mar 2016 02:19:55 -0400
Message-ID: <1458886795-10694-1-git-send-email-zhangzhuoyu@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: sage@redhat.com, zyan@redhat.com, idryomov@gmail.com, linux-kernel@vger.kernel.org, Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
List-Id: ceph-devel.vger.kernel.org

 This patch makes serverl logical caculation functions return bool to
 improve readability due to these particular functions only using 0/1 as
 their return value.

 No functional change.

Signed-off-by: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
---
 fs/ceph/cache.c                |  2 +-
 fs/ceph/dir.c                  |  2 +-
 fs/ceph/super.h                |  2 +-
 include/linux/ceph/ceph_frag.h | 12 ++++++------
 include/linux/ceph/decode.h    |  2 +-
 include/linux/ceph/osdmap.h    |  6 +++---
 include/linux/ceph/rados.h     | 16 ++++++++--------
 net/ceph/ceph_common.c         |  2 +-
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 834f9f3..1f3a3f6 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -238,7 +238,7 @@ static void ceph_vfs_readpage_complete_unlock(struct page *page, void *data, int
 	unlock_page(page);
 }
 
-static inline int cache_valid(struct ceph_inode_info *ci)
+static inline bool cache_valid(struct ceph_inode_info *ci)
 {
 	return ((ceph_caps_issued(ci) & CEPH_CAP_FILE_CACHE) &&
 		(ci->i_fscache_gen == ci->i_rdcache_gen));
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 26be849..7eed41e 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -584,7 +584,7 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 	return dentry;
 }
 
-static int is_root_ceph_dentry(struct inode *inode, struct dentry *dentry)
+static bool is_root_ceph_dentry(struct inode *inode, struct dentry *dentry)
 {
 	return ceph_ino(inode) == CEPH_INO_ROOT &&
 		strncmp(dentry->d_name.name, ".ceph", 5) == 0;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index b82f507..db88fef 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -415,7 +415,7 @@ static inline u64 ceph_snap(struct inode *inode)
 	return ceph_inode(inode)->i_vino.snap;
 }
 
-static inline int ceph_ino_compare(struct inode *inode, void *data)
+static inline bool ceph_ino_compare(struct inode *inode, void *data)
 {
 	struct ceph_vino *pvino = (struct ceph_vino *)data;
 	struct ceph_inode_info *ci = ceph_inode(inode);
diff --git a/include/linux/ceph/ceph_frag.h b/include/linux/ceph/ceph_frag.h
index 5babb8e..44e6067 100644
--- a/include/linux/ceph/ceph_frag.h
+++ b/include/linux/ceph/ceph_frag.h
@@ -40,11 +40,11 @@ static inline __u32 ceph_frag_mask_shift(__u32 f)
 	return 24 - ceph_frag_bits(f);
 }
 
-static inline int ceph_frag_contains_value(__u32 f, __u32 v)
+static inline bool ceph_frag_contains_value(__u32 f, __u32 v)
 {
 	return (v & ceph_frag_mask(f)) == ceph_frag_value(f);
 }
-static inline int ceph_frag_contains_frag(__u32 f, __u32 sub)
+static inline bool ceph_frag_contains_frag(__u32 f, __u32 sub)
 {
 	/* is sub as specific as us, and contained by us? */
 	return ceph_frag_bits(sub) >= ceph_frag_bits(f) &&
@@ -56,12 +56,12 @@ static inline __u32 ceph_frag_parent(__u32 f)
 	return ceph_frag_make(ceph_frag_bits(f) - 1,
 			 ceph_frag_value(f) & (ceph_frag_mask(f) << 1));
 }
-static inline int ceph_frag_is_left_child(__u32 f)
+static inline bool ceph_frag_is_left_child(__u32 f)
 {
 	return ceph_frag_bits(f) > 0 &&
 		(ceph_frag_value(f) & (0x1000000 >> ceph_frag_bits(f))) == 0;
 }
-static inline int ceph_frag_is_right_child(__u32 f)
+static inline bool ceph_frag_is_right_child(__u32 f)
 {
 	return ceph_frag_bits(f) > 0 &&
 		(ceph_frag_value(f) & (0x1000000 >> ceph_frag_bits(f))) == 1;
@@ -86,11 +86,11 @@ static inline __u32 ceph_frag_make_child(__u32 f, int by, int i)
 	return ceph_frag_make(newbits,
 			 ceph_frag_value(f) | (i << (24 - newbits)));
 }
-static inline int ceph_frag_is_leftmost(__u32 f)
+static inline bool ceph_frag_is_leftmost(__u32 f)
 {
 	return ceph_frag_value(f) == 0;
 }
-static inline int ceph_frag_is_rightmost(__u32 f)
+static inline bool ceph_frag_is_rightmost(__u32 f)
 {
 	return ceph_frag_value(f) == ceph_frag_mask(f);
 }
diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index a6ef9cc..19e9932 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -47,7 +47,7 @@ static inline void ceph_decode_copy(void **p, void *pv, size_t n)
 /*
  * bounds check input.
  */
-static inline int ceph_has_room(void **p, void *end, size_t n)
+static inline bool ceph_has_room(void **p, void *end, size_t n)
 {
 	return end >= *p && n <= end - *p;
 }
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 561ea89..bbf66b7 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -137,19 +137,19 @@ static inline void ceph_oid_copy(struct ceph_object_id *dest,
 	dest->name_len = src->name_len;
 }
 
-static inline int ceph_osd_exists(struct ceph_osdmap *map, int osd)
+static inline bool ceph_osd_exists(struct ceph_osdmap *map, int osd)
 {
 	return osd >= 0 && osd < map->max_osd &&
 	       (map->osd_state[osd] & CEPH_OSD_EXISTS);
 }
 
-static inline int ceph_osd_is_up(struct ceph_osdmap *map, int osd)
+static inline bool ceph_osd_is_up(struct ceph_osdmap *map, int osd)
 {
 	return ceph_osd_exists(map, osd) &&
 	       (map->osd_state[osd] & CEPH_OSD_UP);
 }
 
-static inline int ceph_osd_is_down(struct ceph_osdmap *map, int osd)
+static inline bool ceph_osd_is_down(struct ceph_osdmap *map, int osd)
 {
 	return !ceph_osd_is_up(map, osd);
 }
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 2f822dc..d6d4852 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -313,36 +313,36 @@ __CEPH_FORALL_OSD_OPS(GENERATE_ENUM_ENTRY)
 #undef GENERATE_ENUM_ENTRY
 };
 
-static inline int ceph_osd_op_type_lock(int op)
+static inline bool ceph_osd_op_type_lock(int op)
 {
 	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_LOCK;
 }
-static inline int ceph_osd_op_type_data(int op)
+static inline bool ceph_osd_op_type_data(int op)
 {
 	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_DATA;
 }
-static inline int ceph_osd_op_type_attr(int op)
+static inline bool ceph_osd_op_type_attr(int op)
 {
 	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_ATTR;
 }
-static inline int ceph_osd_op_type_exec(int op)
+static inline bool ceph_osd_op_type_exec(int op)
 {
 	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_EXEC;
 }
-static inline int ceph_osd_op_type_pg(int op)
+static inline bool ceph_osd_op_type_pg(int op)
 {
 	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_PG;
 }
-static inline int ceph_osd_op_type_multi(int op)
+static inline bool ceph_osd_op_type_multi(int op)
 {
 	return (op & CEPH_OSD_OP_TYPE) == CEPH_OSD_OP_TYPE_MULTI;
 }
 
-static inline int ceph_osd_op_mode_subop(int op)
+static inline bool ceph_osd_op_mode_subop(int op)
 {
 	return (op & CEPH_OSD_OP_MODE) == CEPH_OSD_OP_MODE_SUB;
 }
-static inline int ceph_osd_op_mode_read(int op)
+static inline bool ceph_osd_op_mode_read(int op)
 {
 	return (op & CEPH_OSD_OP_MODE_RD) &&
 		op != CEPH_OSD_OP_CALL;
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 58fbfe1..81733c0 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -559,7 +559,7 @@ EXPORT_SYMBOL(ceph_destroy_client);
 /*
  * true if we have the mon map (and have thus joined the cluster)
  */
-static int have_mon_and_osd_map(struct ceph_client *client)
+static bool have_mon_and_osd_map(struct ceph_client *client)
 {
 	return client->monc.monmap && client->monc.monmap->epoch &&
 	       client->osdc.osdmap && client->osdc.osdmap->epoch;
-- 
1.8.3.1
