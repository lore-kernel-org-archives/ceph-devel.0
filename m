From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 5/5] ceph: fix up the types of the file layout helpers
Date: Mon, 12 Mar 2012 17:57:53 -0500
Message-ID: <4F5E7F71.5050605@dreamhost.com>
References: <4F5E7DA5.4040802@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44882 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757715Ab2CLW5u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:57:50 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 68291243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:58:24 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 27EDA2439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:58:24 -0700 (PDT)
In-Reply-To: <4F5E7DA5.4040802@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The helper macros for accessing file layout fields of an on-disk
ceph file layout structure cast their results to type (__s32).  This
is a bit strange, since (with one exception--fl_pg_preferred):
     - there is no need for negative values; and
     - all users of these macros are assigning their result to
       64-bit variables.
So just make these macros return a 64-bit unsigned type.

The exception is the preferred placement group, which remains a
signed 32-bit value.  A placement group id encodes the preferred
primary OSD in a 16-bit value, and there's no sense at this point
getting too far away from that.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/inode.c              |    6 +++++-
  fs/ceph/ioctl.c              |   22 +++++++++++-----------
  fs/ceph/xattr.c              |   16 ++++++++--------
  include/linux/ceph/ceph_fs.h |   26 ++++++++++++--------------
  net/ceph/ceph_fs.c           |    6 +++---
  net/ceph/osdmap.c            |   25 +++++++++++++------------
  6 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d291928..1828fb9 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -568,6 +568,7 @@ static int fill_inode(struct inode *inode,
  	struct ceph_buffer *xattr_blob = NULL;
  	int err = 0;
  	int queue_trunc = 0;
+	__u64 stripe_unit;

  	dout("fill_inode %p ino %llx.%llx v %llu had %llu\n",
  	     inode, ceph_vinop(inode), le64_to_cpu(info->version),
@@ -643,7 +644,10 @@ static int fill_inode(struct inode *inode,
  	}

  	ci->i_layout = info->layout;
-	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
+
+	stripe_unit = ceph_file_layout_stripe_unit(&info->layout);
+	BUG_ON(stripe_unit > (__u64) INT_MAX);
+	inode->i_blkbits = fls((int) stripe_unit) - 1;

  	/* xattrs */
  	/* note that if i_xattrs.len <= 4, i_xattrs.data will still be NULL. */
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 75cff03..2fde342 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -22,10 +22,10 @@ static long ceph_ioctl_get_layout(struct file *file, 
void __user *arg)

  	err = ceph_do_getattr(file->f_dentry->d_inode, CEPH_STAT_CAP_LAYOUT);
  	if (!err) {
-		l.stripe_unit = (__u64) ceph_file_layout_stripe_unit(&ci->i_layout);
-		l.stripe_count = (__u64) ceph_file_layout_stripe_count(&ci->i_layout);
-		l.object_size = (__u64) ceph_file_layout_object_size(&ci->i_layout);
-		l.data_pool = (__u64) ceph_file_layout_pg_pool(&ci->i_layout);
+		l.stripe_unit = ceph_file_layout_stripe_unit(&ci->i_layout);
+		l.stripe_count = ceph_file_layout_stripe_count(&ci->i_layout);
+		l.object_size = ceph_file_layout_object_size(&ci->i_layout);
+		l.data_pool = ceph_file_layout_pg_pool(&ci->i_layout);
  		l.preferred_osd =
  			(__s64) ceph_file_layout_pg_preferred(&ci->i_layout);
  		if (copy_to_user(arg, &l, sizeof(l)))
@@ -52,12 +52,12 @@ static long ceph_ioctl_set_layout(struct file *file, 
void __user *arg)
  	/* validate changed params against current layout */
  	err = ceph_do_getattr(file->f_dentry->d_inode, CEPH_STAT_CAP_LAYOUT);
  	if (!err) {
-		nl.stripe_unit = (__u64) ceph_file_layout_stripe_unit(&ci->i_layout);
-		nl.stripe_count = (__u64) ceph_file_layout_stripe_count(&ci->i_layout);
-		nl.object_size = (__u64) ceph_file_layout_object_size(&ci->i_layout);
-		nl.data_pool = (__u64) ceph_file_layout_pg_pool(&ci->i_layout);
+		nl.stripe_unit = ceph_file_layout_stripe_unit(&ci->i_layout);
+		nl.stripe_count = ceph_file_layout_stripe_count(&ci->i_layout);
+		nl.object_size = ceph_file_layout_object_size(&ci->i_layout);
+		nl.data_pool = ceph_file_layout_pg_pool(&ci->i_layout);
  		nl.preferred_osd =
-				(__s64) ceph_file_layout_pg_preferred(&ci->i_layout);
+			(__s64) ceph_file_layout_pg_preferred(&ci->i_layout);
  	} else
  		return err;

@@ -203,8 +203,8 @@ static long ceph_ioctl_get_dataloc(struct file 
*file, void __user *arg)
  	ceph_calc_file_object_mapping(&ci->i_layout, dl.file_offset, &len,
  				      &dl.object_no, &dl.object_offset, &olen);
  	dl.file_offset -= dl.object_offset;
-	dl.object_size = (__u64) ceph_file_layout_object_size(&ci->i_layout);
-	dl.block_size = (__u64) ceph_file_layout_stripe_unit(&ci->i_layout);
+	dl.object_size = ceph_file_layout_object_size(&ci->i_layout);
+	dl.block_size = ceph_file_layout_stripe_unit(&ci->i_layout);

  	/* block_offset = object_offset % block_size */
  	tmp = dl.object_offset;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index bfd5b93..0652aa4 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -112,20 +112,20 @@ static size_t ceph_vxattrcb_file_layout(struct 
ceph_inode_info *ci, char *val,
  				   size_t size)
  {
  	int ret;
+	__s32 preferred;

  	ret = snprintf(val, size,
  		"chunk_bytes=%lld\nstripe_count=%lld\nobject_size=%lld\n",
-		(unsigned long long)ceph_file_layout_stripe_unit(&ci->i_layout),
-		(unsigned long long)ceph_file_layout_stripe_count(&ci->i_layout),
-		(unsigned long long)ceph_file_layout_object_size(&ci->i_layout));
+		ceph_file_layout_stripe_unit(&ci->i_layout),
+		ceph_file_layout_stripe_count(&ci->i_layout),
+		ceph_file_layout_object_size(&ci->i_layout));

-	if (ceph_file_layout_pg_preferred(&ci->i_layout) !=
-			CEPH_FILE_LAYOUT_PG_PREFERRED_NONE) {
+	preferred = ceph_file_layout_pg_preferred(&ci->i_layout);
+	if (preferred != CEPH_FILE_LAYOUT_PG_PREFERRED_NONE) {
  		val += ret;
  		size -= ret;
-		ret += snprintf(val, size, "preferred_osd=%lld\n",
-			    (unsigned long long)ceph_file_layout_pg_preferred(
-				    &ci->i_layout));
+		ret += snprintf(val, size, "preferred_osd=%d\n",
+				(int) preferred);
  	}

  	return ret;
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index cf86032..698d395 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -75,32 +75,30 @@ struct ceph_file_layout {

  #define CEPH_MIN_STRIPE_UNIT			65536
  #define CEPH_FILE_LAYOUT_PG_PREFERRED_NONE	((__s32) cpu_to_le32(-1))
+
  #define ceph_file_layout_stripe_unit(l) \
-		((__s32) le32_to_cpu((l)->fl_stripe_unit))
+		((__u64) le32_to_cpu((l)->fl_stripe_unit))
  #define ceph_file_layout_stripe_count(l) \
-		((__s32) le32_to_cpu((l)->fl_stripe_count))
+		((__u64) le32_to_cpu((l)->fl_stripe_count))
  #define ceph_file_layout_object_size(l) \
-		((__s32) le32_to_cpu((l)->fl_object_size))
-#define ceph_file_layout_cas_hash(l) \
-		((__s32) le32_to_cpu((l)->fl_cas_hash))
-#define ceph_file_layout_object_stripe_unit(l) \
-		((__s32) le32_to_cpu((l)->fl_object_stripe_unit))
+		((__u64) le32_to_cpu((l)->fl_object_size))
+#define ceph_file_layout_cas_hash(l) le32_to_cpu((l)->fl_cas_hash)
+#define ceph_file_layout_object_stripe_unit(l) 
le32_to_cpu((l)->fl_object_stripe_unit)
  #define ceph_file_layout_pg_preferred(l) \
  		((__s32) le32_to_cpu((l)->fl_pg_preferred))
  #define ceph_file_layout_pg_pool(l) \
-		((__s32) le32_to_cpu((l)->fl_pg_pool))
+		((__u64) le32_to_cpu((l)->fl_pg_pool))

-static inline unsigned ceph_file_layout_stripe_width(struct 
ceph_file_layout *l)
+static inline __u64 ceph_file_layout_stripe_width(struct 
ceph_file_layout *l)
  {
-	return (unsigned) (ceph_file_layout_stripe_unit(l) *
-				ceph_file_layout_stripe_count(l));
+	return ceph_file_layout_stripe_unit(l) * ceph_file_layout_stripe_count(l);
  }

  /* "period" == bytes before i start on a new set of objects */
-static inline unsigned ceph_file_layout_period(struct ceph_file_layout *l)
+static inline __u64 ceph_file_layout_period(struct ceph_file_layout *l)
  {
-	return (unsigned) (ceph_file_layout_object_size(l) *
-				ceph_file_layout_stripe_count(l));
+	return ceph_file_layout_object_size(l) *
+				ceph_file_layout_stripe_count(l);
  }

  int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
diff --git a/net/ceph/ceph_fs.c b/net/ceph/ceph_fs.c
index c3197b9..97f7c50 100644
--- a/net/ceph/ceph_fs.c
+++ b/net/ceph/ceph_fs.c
@@ -9,9 +9,9 @@
   */
  int ceph_file_layout_is_valid(const struct ceph_file_layout *layout)
  {
-	__u32 su = (__u32) ceph_file_layout_stripe_unit(layout);
-	__u32 sc = (__u32) ceph_file_layout_stripe_count(layout);
-	__u32 os = (__u32) ceph_file_layout_object_size(layout);
+	__u64 su = ceph_file_layout_stripe_unit(layout);
+	__u64 sc = ceph_file_layout_stripe_count(layout);
+	__u64 os = ceph_file_layout_object_size(layout);

  	/* stripe unit, object size must be non-zero, 64k increment */
  	if (!su || (su & (CEPH_MIN_STRIPE_UNIT-1)))
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 26c30e7..bc2d807 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -946,9 +946,9 @@ void ceph_calc_file_object_mapping(struct 
ceph_file_layout *layout,
  				   u64 *object_ext_off,
  				   u64 *object_ext_len)
  {
-	u64 object_size = (u64) ceph_file_layout_object_size(layout);
-	u64 stripe_unit = (u64) ceph_file_layout_stripe_unit(layout);
-	u64 stripe_count = (u64) ceph_file_layout_stripe_count(layout);
+	u64 object_size = ceph_file_layout_object_size(layout);
+	u64 stripe_unit = ceph_file_layout_stripe_unit(layout);
+	u64 stripe_count = ceph_file_layout_stripe_count(layout);
  	u64 stripe_unit_per_object;
  	u64 stripe_unit_num;
  	u64 stripe_unit_offset;
@@ -1028,29 +1028,30 @@ int ceph_calc_object_layout(struct 
ceph_object_layout *ol,
  {
  	unsigned num, num_mask;
  	struct ceph_pg pgid;
-	s32 preferred = (s32) ceph_file_layout_pg_preferred(fl);
+	s32 preferred = ceph_file_layout_pg_preferred(fl);
  	int poolid = (int) ceph_file_layout_pg_pool(fl);
  	struct ceph_pg_pool_info *pool;
  	unsigned ps;

  	BUG_ON(!osdmap);
+	BUG_ON(preferred > (s32) SHRT_MAX);
+	BUG_ON(preferred < (s32) SHRT_MIN);

  	pool = __lookup_pg_pool(&osdmap->pg_pools, poolid);
  	if (!pool)
  		return -EIO;
-	ps = ceph_str_hash(pool->v.object_hash, oid, strlen(oid));

-	if (preferred == CEPH_FILE_LAYOUT_PG_PREFERRED_NONE) {
-		num = le32_to_cpu(pool->v.pg_num);
-		num_mask = pool->pg_num_mask;
-	} else {
+	ps = ceph_str_hash(pool->v.object_hash, oid, strlen(oid));
+	if (preferred != CEPH_FILE_LAYOUT_PG_PREFERRED_NONE) {
+		BUG_ON(preferred < 0);
  		ps += preferred;
-		num = le32_to_cpu(pool->v.lpg_num);
-		num_mask = pool->lpg_num_mask;
  	}

+	num = le32_to_cpu(pool->v.lpg_num);
+	num_mask = pool->lpg_num_mask;
+
  	pgid.ps = cpu_to_le16(ps);
-	pgid.preferred = cpu_to_le16(preferred);
+	pgid.preferred = cpu_to_le16((s16) preferred);
  	pgid.pool = fl->fl_pg_pool;
  	if (preferred == CEPH_FILE_LAYOUT_PG_PREFERRED_NONE)
  		dout("calc_object_layout '%s' pgid %d.%x\n", oid, poolid, ps);
-- 
1.7.5.4

