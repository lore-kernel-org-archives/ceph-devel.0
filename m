From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 6/6] ceph: rados pool namesapce support
Date: Fri,  5 Feb 2016 22:31:37 +0800
Message-ID: <1454682697-84638-7-git-send-email-zyan@redhat.com>
References: <1454682697-84638-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbcBEOcX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Feb 2016 09:32:23 -0500
In-Reply-To: <1454682697-84638-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sweil@redhat.com, idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/addr.c                     | 68 ++++++++++++++++++++++++++++++--------
 fs/ceph/caps.c                     | 43 +++++++++++++++++-------
 fs/ceph/file.c                     |  4 ++-
 fs/ceph/inode.c                    |  9 ++++-
 fs/ceph/mds_client.c               | 11 ++++++
 fs/ceph/mds_client.h               |  4 +++
 fs/ceph/xattr.c                    | 66 ++++++++++++++++++++++++++----------
 include/linux/ceph/ceph_features.h |  1 +
 include/linux/ceph/ceph_fs.h       |  3 +-
 net/ceph/ceph_fs.c                 |  6 ++--
 10 files changed, 167 insertions(+), 48 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index d5ea244..961c380 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1701,7 +1701,8 @@ enum {
 	POOL_WRITE	= 2,
 };
 
-static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
+static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
+				s64 pool, struct ceph_pool_ns *pool_ns)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_client(&ci->vfs_inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -1709,6 +1710,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 	struct rb_node **p, *parent;
 	struct ceph_pool_perm *perm;
 	struct page **pages;
+	size_t pool_ns_len;
 	int err = 0, err2 = 0, have = 0;
 
 	down_read(&mdsc->pool_perm_rwsem);
@@ -1720,17 +1722,28 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 		else if (pool > perm->pool)
 			p = &(*p)->rb_right;
 		else {
-			have = perm->perm;
-			break;
+			int ret = ceph_compare_pool_ns(pool_ns,
+						perm->pool_ns,
+						perm->pool_ns_len);
+			if (ret < 0)
+				p = &(*p)->rb_left;
+			else if (ret > 0)
+				p = &(*p)->rb_right;
+			else {
+				have = perm->perm;
+				break;
+			}
 		}
 	}
 	up_read(&mdsc->pool_perm_rwsem);
 	if (*p)
 		goto out;
 
-	dout("__ceph_pool_perm_get pool %lld no perm cached\n", pool);
+	dout("__ceph_pool_perm_get pool %lld ns %.*s no perm cached\n",
+	     pool, (int)pool_ns->name_len, pool_ns->name);
 
 	down_write(&mdsc->pool_perm_rwsem);
+	p = &mdsc->pool_perm_tree.rb_node;
 	parent = NULL;
 	while (*p) {
 		parent = *p;
@@ -1740,8 +1753,17 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 		else if (pool > perm->pool)
 			p = &(*p)->rb_right;
 		else {
-			have = perm->perm;
-			break;
+			int ret = ceph_compare_pool_ns(pool_ns,
+						perm->pool_ns,
+						perm->pool_ns_len);
+			if (ret < 0)
+				p = &(*p)->rb_left;
+			else if (ret > 0)
+				p = &(*p)->rb_right;
+			else {
+				have = perm->perm;
+				break;
+			}
 		}
 	}
 	if (*p) {
@@ -1750,7 +1772,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 	}
 
 	rd_req = ceph_osdc_alloc_request(&fsc->client->osdc,
-					 ceph_empty_snapc, NULL,
+					 ceph_empty_snapc, pool_ns,
 					 1, false, GFP_NOFS);
 	if (!rd_req) {
 		err = -ENOMEM;
@@ -1760,12 +1782,15 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 	rd_req->r_flags = CEPH_OSD_FLAG_READ;
 	osd_req_op_init(rd_req, 0, CEPH_OSD_OP_STAT, 0);
 	rd_req->r_base_oloc.pool = pool;
+	rd_req->r_base_oloc.pool_ns = pool_ns;
+	if (pool_ns)
+		ceph_get_pool_ns(pool_ns);
 	snprintf(rd_req->r_base_oid.name, sizeof(rd_req->r_base_oid.name),
 		 "%llx.00000000", ci->i_vino.ino);
 	rd_req->r_base_oid.name_len = strlen(rd_req->r_base_oid.name);
 
 	wr_req = ceph_osdc_alloc_request(&fsc->client->osdc,
-					 ceph_empty_snapc, NULL,
+					 ceph_empty_snapc, pool_ns,
 					 1, false, GFP_NOFS);
 	if (!wr_req) {
 		err = -ENOMEM;
@@ -1776,6 +1801,9 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 			  CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK;
 	osd_req_op_init(wr_req, 0, CEPH_OSD_OP_CREATE, CEPH_OSD_OP_FLAG_EXCL);
 	wr_req->r_base_oloc.pool = pool;
+	wr_req->r_base_oloc.pool_ns = pool_ns;
+	if (pool_ns)
+		ceph_get_pool_ns(pool_ns);
 	wr_req->r_base_oid = rd_req->r_base_oid;
 
 	/* one page should be large enough for STAT data */
@@ -1812,7 +1840,8 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 		goto out_unlock;
 	}
 
-	perm = kmalloc(sizeof(*perm), GFP_NOFS);
+	pool_ns_len = pool_ns ? pool_ns->name_len : 0;
+	perm = kmalloc(sizeof(*perm) + pool_ns_len + 1, GFP_NOFS);
 	if (!perm) {
 		err = -ENOMEM;
 		goto out_unlock;
@@ -1820,6 +1849,11 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, s64 pool)
 
 	perm->pool = pool;
 	perm->perm = have;
+	perm->pool_ns_len = pool_ns_len;
+	if (pool_ns_len > 0)
+		memcpy(perm->pool_ns, pool_ns->name, pool_ns_len);
+	perm->pool_ns[pool_ns_len] = 0;
+
 	rb_link_node(&perm->node, parent, p);
 	rb_insert_color(&perm->node, &mdsc->pool_perm_tree);
 	err = 0;
@@ -1833,13 +1867,18 @@ out_unlock:
 out:
 	if (!err)
 		err = have;
-	dout("__ceph_pool_perm_get pool %lld result = %d\n", pool, err);
+	if (pool_ns)
+		dout("__ceph_pool_perm_get pool %lld ns %.*s result = %d\n",
+		     pool, (int)pool_ns->name_len, pool_ns->name, err);
+	else
+		dout("__ceph_pool_perm_get pool %lld result = %d\n", pool, err);
 	return err;
 }
 
 int ceph_pool_perm_check(struct ceph_inode_info *ci, int need)
 {
 	s64 pool;
+	struct ceph_pool_ns *pool_ns;
 	int ret, flags;
 
 	if (ceph_test_mount_opt(ceph_inode_to_client(&ci->vfs_inode),
@@ -1865,7 +1904,9 @@ check:
 		return 0;
 	}
 
-	ret = __ceph_pool_perm_get(ci, pool);
+	pool_ns = ceph_try_get_pool_ns(&ci->i_layout.pool_ns);
+	ret = __ceph_pool_perm_get(ci, pool, pool_ns);
+	ceph_put_pool_ns(pool_ns);
 	if (ret < 0)
 		return ret;
 
@@ -1876,8 +1917,9 @@ check:
 		flags |= CEPH_I_POOL_WR;
 
 	spin_lock(&ci->i_ceph_lock);
-	if (pool == ci->i_layout.pool_id) {
-		ci->i_ceph_flags = flags;
+	if (pool == ci->i_layout.pool_id &&
+	    pool_ns == ci->i_layout.pool_ns) {
+		ci->i_ceph_flags |= flags;
         } else {
 		pool = ci->i_layout.pool_id;
 		flags = ci->i_ceph_flags;
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b68be57..4bc21a0 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2752,8 +2752,8 @@ static void invalidate_aliases(struct inode *inode)
  */
 static void handle_cap_grant(struct ceph_mds_client *mdsc,
 			     struct inode *inode, struct ceph_mds_caps *grant,
-			     u64 inline_version,
-			     void *inline_data, int inline_len,
+			     struct ceph_pool_ns **pns, u64 inline_version,
+			     void *inline_data, u32 inline_len,
 			     struct ceph_buffer *xattr_buf,
 			     struct ceph_mds_session *session,
 			     struct ceph_cap *cap, int issued)
@@ -2876,7 +2876,8 @@ static void handle_cap_grant(struct ceph_mds_client *mdsc,
 	if (newcaps & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR)) {
 		/* file layout may have changed */
 		s64 old_pool = ci->i_layout.pool_id;
-		ceph_file_layout_from_legacy(&ci->i_layout, &grant->layout);
+		ceph_file_layout_from_legacy(&ci->i_layout,
+					     &grant->layout, pns);
 		if (ci->i_layout.pool_id != old_pool)
 			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
 
@@ -3405,13 +3406,12 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	struct ceph_cap *cap;
 	struct ceph_mds_caps *h;
 	struct ceph_mds_cap_peer *peer = NULL;
-	struct ceph_snap_realm *realm;
+	struct ceph_snap_realm *realm = NULL;
+	struct ceph_pool_ns *pool_ns = NULL;
 	int mds = session->s_mds;
 	int op, issued;
 	u32 seq, mseq;
 	struct ceph_vino vino;
-	u64 cap_id;
-	u64 size, max_size;
 	u64 tid;
 	u64 inline_version = 0;
 	void *inline_data = NULL;
@@ -3431,11 +3431,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	op = le32_to_cpu(h->op);
 	vino.ino = le64_to_cpu(h->ino);
 	vino.snap = CEPH_NOSNAP;
-	cap_id = le64_to_cpu(h->cap_id);
 	seq = le32_to_cpu(h->seq);
 	mseq = le32_to_cpu(h->migrate_seq);
-	size = le64_to_cpu(h->size);
-	max_size = le64_to_cpu(h->max_size);
 
 	snaptrace = h + 1;
 	snaptrace_len = le32_to_cpu(h->snap_trace_len);
@@ -3470,6 +3467,27 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		p += inline_len;
 	}
 
+	if (le16_to_cpu(msg->hdr.version) >= 8) {
+		u64 flush_tid;
+		u32 caller_uid, caller_gid;
+		u32 osd_epoch_barrier;
+		u32 pool_ns_len;
+		/* version >= 5 */
+		ceph_decode_32_safe(&p, end, osd_epoch_barrier, bad);
+		/* version >= 6 */
+		ceph_decode_64_safe(&p, end, flush_tid, bad);
+		/* version >= 7 */
+		ceph_decode_32_safe(&p, end, caller_uid, bad);
+		ceph_decode_32_safe(&p, end, caller_gid, bad);
+		/* version >= 8 */
+		ceph_decode_32_safe(&p, end, pool_ns_len, bad);
+		if (pool_ns_len > 0) {
+			ceph_decode_need(&p, end, pool_ns_len, bad);
+			pool_ns = ceph_find_or_create_pool_ns(p, pool_ns_len);
+			p += pool_ns_len;
+		}
+	}
+
 	/* lookup ino */
 	inode = ceph_find_inode(sb, vino);
 	ci = ceph_inode(inode);
@@ -3488,7 +3506,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 			cap = ceph_get_cap(mdsc, NULL);
 			cap->cap_ino = vino.ino;
 			cap->queue_release = 1;
-			cap->cap_id = cap_id;
+			cap->cap_id = le64_to_cpu(h->cap_id);
 			cap->mseq = mseq;
 			cap->seq = seq;
 			spin_lock(&session->s_cap_lock);
@@ -3523,7 +3541,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		}
 		handle_cap_import(mdsc, inode, h, peer, session,
 				  &cap, &issued);
-		handle_cap_grant(mdsc, inode, h,
+		handle_cap_grant(mdsc, inode, h, &pool_ns,
 				 inline_version, inline_data, inline_len,
 				 msg->middle, session, cap, issued);
 		if (realm)
@@ -3547,7 +3565,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	case CEPH_CAP_OP_GRANT:
 		__ceph_caps_issued(ci, &issued);
 		issued |= __ceph_caps_dirty(ci);
-		handle_cap_grant(mdsc, inode, h,
+		handle_cap_grant(mdsc, inode, h, &pool_ns,
 				 inline_version, inline_data, inline_len,
 				 msg->middle, session, cap, issued);
 		goto done_unlocked;
@@ -3580,6 +3598,7 @@ done:
 	mutex_unlock(&session->s_mutex);
 done_unlocked:
 	iput(inode);
+	ceph_put_pool_ns(pool_ns);
 	return;
 
 bad:
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a5565f7..f2c50d8 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -708,8 +708,10 @@ static void ceph_aio_retry_work(struct work_struct *work)
 	req->r_flags =	CEPH_OSD_FLAG_ORDERSNAP |
 			CEPH_OSD_FLAG_ONDISK |
 			CEPH_OSD_FLAG_WRITE;
-	req->r_base_oloc = orig_req->r_base_oloc;
 	req->r_base_oid = orig_req->r_base_oid;
+	req->r_base_oloc = orig_req->r_base_oloc;
+	if (req->r_base_oloc.pool_ns)
+		ceph_get_pool_ns(req->r_base_oloc.pool_ns);
 
 	req->r_ops[0] = orig_req->r_ops[0];
 	osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC, 0);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 009a917..8d7a578 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -675,6 +675,7 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 	int issued = 0, implemented, new_issued;
 	struct timespec mtime, atime, ctime;
 	struct ceph_buffer *xattr_blob = NULL;
+	struct ceph_pool_ns *pool_ns = NULL;
 	struct ceph_cap *new_cap = NULL;
 	int err = 0;
 	bool wake = false;
@@ -702,6 +703,10 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 			       iinfo->xattr_len);
 	}
 
+	if (iinfo->pool_ns_len > 0)
+		pool_ns = ceph_find_or_create_pool_ns(iinfo->pool_ns_data,
+						      iinfo->pool_ns_len);
+
 	spin_lock(&ci->i_ceph_lock);
 
 	/*
@@ -757,7 +762,8 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 	if (new_version ||
 	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
 		s64 old_pool = ci->i_layout.pool_id;
-		ceph_file_layout_from_legacy(&ci->i_layout, &info->layout);
+		ceph_file_layout_from_legacy(&ci->i_layout, &info->layout,
+					     &pool_ns);
 		if (ci->i_layout.pool_id != old_pool)
 			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
 
@@ -923,6 +929,7 @@ out:
 		ceph_put_cap(mdsc, new_cap);
 	if (xattr_blob)
 		ceph_buffer_put(xattr_blob);
+	ceph_put_pool_ns(pool_ns);
 	return err;
 }
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b6bec29..d60601a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -100,6 +100,17 @@ static int parse_reply_info_in(void **p, void *end,
 	} else
 		info->inline_version = CEPH_INLINE_NONE;
 
+	info->pool_ns_len = 0;
+	info->pool_ns_data = NULL;
+	if (features & CEPH_FEATURE_FS_FILE_LAYOUT_V2) {
+		ceph_decode_32_safe(p, end, info->pool_ns_len, bad);
+		if (info->pool_ns_len > 0) {
+			ceph_decode_need(p, end, info->pool_ns_len, bad);
+			info->pool_ns_data = *p;
+			*p += info->pool_ns_len;
+		}
+	}
+
 	return 0;
 bad:
 	return err;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 6eb331c..3e04a4f 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -44,6 +44,8 @@ struct ceph_mds_reply_info_in {
 	u64 inline_version;
 	u32 inline_len;
 	char *inline_data;
+	u32 pool_ns_len;
+	char *pool_ns_data;
 };
 
 /*
@@ -269,6 +271,8 @@ struct ceph_pool_perm {
 	struct rb_node node;
 	int perm;
 	s64 pool;
+	size_t pool_ns_len;
+	char pool_ns[];
 };
 
 /*
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index c431f4c..821f19a 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -67,44 +67,60 @@ static bool ceph_vxattrcb_layout_exists(struct ceph_inode_info *ci)
 static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 				   size_t size)
 {
-	int ret;
 	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
+	struct ceph_pool_ns *pool_ns;
 	s64 pool = ci->i_layout.pool_id;
 	const char *pool_name;
+	const char *ns_field = " pool_namespace=";
 	char buf[128];
+	size_t len, total_len = 0;
+	int ret;
+
+	pool_ns = ceph_try_get_pool_ns(&ci->i_layout.pool_ns);
 
 	dout("ceph_vxattrcb_layout %p\n", &ci->vfs_inode);
 	down_read(&osdc->map_sem);
 	pool_name = ceph_pg_pool_name_by_id(osdc->osdmap, pool);
 	if (pool_name) {
-		size_t len = strlen(pool_name);
-		ret = snprintf(buf, sizeof(buf),
+		len = snprintf(buf, sizeof(buf),
 		"stripe_unit=%u stripe_count=%u object_size=%u pool=",
 		ci->i_layout.stripe_unit, ci->i_layout.stripe_count,
 	        ci->i_layout.object_size);
-		if (!size) {
-			ret += len;
-		} else if (ret + len > size) {
-			ret = -ERANGE;
-		} else {
-			memcpy(val, buf, ret);
-			memcpy(val + ret, pool_name, len);
-			ret += len;
-		}
+		total_len = len + strlen(pool_name);
 	} else {
-		ret = snprintf(buf, sizeof(buf),
+		len = snprintf(buf, sizeof(buf),
 		"stripe_unit=%u stripe_count=%u object_size=%u pool=%lld",
 		ci->i_layout.stripe_unit, ci->i_layout.stripe_count,
 	        ci->i_layout.object_size, (unsigned long long)pool);
-		if (size) {
-			if (ret <= size)
-				memcpy(val, buf, ret);
-			else
-				ret = -ERANGE;
+		total_len = len;
+	}
+
+	if (pool_ns)
+		total_len += strlen(ns_field) + pool_ns->name_len;
+
+	if (!size) {
+		ret = total_len;
+	} else if (total_len > size) {
+		ret = -ERANGE;
+	} else {
+		memcpy(val, buf, len);
+		ret = len;
+		if (pool_name) {
+			len = strlen(pool_name);
+			memcpy(val + ret, pool_name, len);
+			ret += len;
+		}
+		if (pool_ns) {
+			len = strlen(ns_field);
+			memcpy(val + ret, ns_field, len);
+			ret += len;
+			memcpy(val + ret, pool_ns->name, pool_ns->name_len);
+			ret += pool_ns->name_len;
 		}
 	}
 	up_read(&osdc->map_sem);
+	ceph_put_pool_ns(pool_ns);
 	return ret;
 }
 
@@ -145,6 +161,18 @@ static size_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
 	return ret;
 }
 
+static size_t ceph_vxattrcb_layout_pool_namespace(struct ceph_inode_info *ci,
+						  char *val, size_t size)
+{
+	int ret = 0;
+	struct ceph_pool_ns *ns = ceph_try_get_pool_ns(&ci->i_layout.pool_ns);
+	if (ns) {
+		ret = snprintf(val, size, "%.*s", (int)ns->name_len, ns->name);
+		ceph_put_pool_ns(ns);
+	}
+	return ret;
+}
+
 /* directories */
 
 static size_t ceph_vxattrcb_dir_entries(struct ceph_inode_info *ci, char *val,
@@ -233,6 +261,7 @@ static struct ceph_vxattr ceph_dir_vxattrs[] = {
 	XATTR_LAYOUT_FIELD(dir, layout, stripe_count),
 	XATTR_LAYOUT_FIELD(dir, layout, object_size),
 	XATTR_LAYOUT_FIELD(dir, layout, pool),
+	XATTR_LAYOUT_FIELD(dir, layout, pool_namespace),
 	XATTR_NAME_CEPH(dir, entries),
 	XATTR_NAME_CEPH(dir, files),
 	XATTR_NAME_CEPH(dir, subdirs),
@@ -260,6 +289,7 @@ static struct ceph_vxattr ceph_file_vxattrs[] = {
 	XATTR_LAYOUT_FIELD(file, layout, stripe_count),
 	XATTR_LAYOUT_FIELD(file, layout, object_size),
 	XATTR_LAYOUT_FIELD(file, layout, pool),
+	XATTR_LAYOUT_FIELD(file, layout, pool_namespace),
 	{ .name = NULL, 0 }	/* Required table terminator */
 };
 static size_t ceph_file_vxattrs_name_size;	/* total size of all names */
diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index d2d7886..9cddad3 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -75,6 +75,7 @@
 #define CEPH_FEATURE_CRUSH_TUNABLES5	(1ULL<<58) /* chooseleaf stable mode */
 // duplicated since it was introduced at the same time as CEPH_FEATURE_CRUSH_TUNABLES5
 #define CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING   (1ULL<<58) /* New, v7 encoding */
+#define CEPH_FEATURE_FS_FILE_LAYOUT_V2  (1ULL<<58) /* overlap with tunables5 */
 
 /*
  * The introduction of CEPH_FEATURE_OSD_SNAPMAPPER caused the feature
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index c5675bc..ec5cfc9 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -68,7 +68,8 @@ struct ceph_file_layout {
 
 extern int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
 extern void ceph_file_layout_from_legacy(struct ceph_file_layout *fl,
-				struct ceph_file_layout_legacy *legacy);
+				struct ceph_file_layout_legacy *legacy,
+				struct ceph_pool_ns **pns);
 extern void ceph_file_layout_to_legacy(struct ceph_file_layout *fl,
 				struct ceph_file_layout_legacy *legacy);
 
diff --git a/net/ceph/ceph_fs.c b/net/ceph/ceph_fs.c
index 47175de..a950fae 100644
--- a/net/ceph/ceph_fs.c
+++ b/net/ceph/ceph_fs.c
@@ -3,6 +3,7 @@
  */
 #include <linux/module.h>
 #include <linux/ceph/types.h>
+#include <linux/ceph/pool_ns.h>
 
 /*
  * return true if @layout appears to be valid
@@ -28,7 +29,8 @@ int ceph_file_layout_is_valid(const struct ceph_file_layout *layout)
 }
 
 void ceph_file_layout_from_legacy(struct ceph_file_layout *fl,
-				  struct ceph_file_layout_legacy *legacy)
+				  struct ceph_file_layout_legacy *legacy,
+				  struct ceph_pool_ns **pns)
 {       
 	fl->stripe_unit = le32_to_cpu(legacy->fl_stripe_unit);
 	fl->stripe_count = le32_to_cpu(legacy->fl_stripe_count);
@@ -36,7 +38,7 @@ void ceph_file_layout_from_legacy(struct ceph_file_layout *fl,
 	fl->pool_id = le64_to_cpu(legacy->fl_pg_pool);
 	if (fl->pool_id == 0) 
 		fl->pool_id = -1;
-	fl->pool_ns = NULL;
+	*pns = xchg(&fl->pool_ns, *pns);
 }
 EXPORT_SYMBOL(ceph_file_layout_from_legacy);
 
-- 
2.5.0

