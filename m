From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/5] ceph: make use of ceph file layout helpers
Date: Mon, 12 Mar 2012 17:57:48 -0500
Message-ID: <4F5E7F6C.1040904@dreamhost.com>
References: <4F5E7DA5.4040802@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44869 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757436Ab2CLW5p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:57:45 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6C03B243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:58:19 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 2B96D2439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:58:19 -0700 (PDT)
In-Reply-To: <4F5E7DA5.4040802@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are helpers defined in "include/linux/ceph/osdmap.h" for
accessing the fields of an on-disk ceph file layout structure.
Use them--consistently--throughout the code.

Also define CEPH_FILE_LAYOUT_PG_PREFERRED_NONE, to represent
symbolically the explicit "no preferred PG" value.

Make a few casts explicit too (to make it more obvious it's
occuring).  This produces some long lines, but they go away in an
upcoming patch.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c          |    2 +-
  fs/ceph/ioctl.c              |   24 ++++++++++++------------
  fs/ceph/xattr.c              |    5 +++--
  include/linux/ceph/ceph_fs.h |    3 ++-
  net/ceph/ceph_fs.c           |    6 +++---
  net/ceph/osdmap.c            |   25 +++++++++++++------------
  6 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6bbd5af..e9521ed 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -936,7 +936,7 @@ static int rbd_do_request(struct request *rq,
  	layout->fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
  	layout->fl_stripe_count = cpu_to_le32(1);
  	layout->fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
-	layout->fl_pg_preferred = cpu_to_le32(-1);
+	layout->fl_pg_preferred = CEPH_FILE_LAYOUT_PG_PREFERRED_NONE;
  	layout->fl_pg_pool = cpu_to_le32(dev->poolid);
  	ceph_calc_raw_layout(osdc, layout, snapid, ofs, &len, &bno,
  				req, ops);
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 23cb78b..75cff03 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -22,12 +22,12 @@ static long ceph_ioctl_get_layout(struct file *file, 
void __user *arg)

  	err = ceph_do_getattr(file->f_dentry->d_inode, CEPH_STAT_CAP_LAYOUT);
  	if (!err) {
-		l.stripe_unit = ceph_file_layout_stripe_unit(&ci->i_layout);
-		l.stripe_count = ceph_file_layout_stripe_count(&ci->i_layout);
-		l.object_size = ceph_file_layout_object_size(&ci->i_layout);
-		l.data_pool = le32_to_cpu(ci->i_layout.fl_pg_pool);
+		l.stripe_unit = (__u64) ceph_file_layout_stripe_unit(&ci->i_layout);
+		l.stripe_count = (__u64) ceph_file_layout_stripe_count(&ci->i_layout);
+		l.object_size = (__u64) ceph_file_layout_object_size(&ci->i_layout);
+		l.data_pool = (__u64) ceph_file_layout_pg_pool(&ci->i_layout);
  		l.preferred_osd =
-			(s32)le32_to_cpu(ci->i_layout.fl_pg_preferred);
+			(__s64) ceph_file_layout_pg_preferred(&ci->i_layout);
  		if (copy_to_user(arg, &l, sizeof(l)))
  			return -EFAULT;
  	}
@@ -52,12 +52,12 @@ static long ceph_ioctl_set_layout(struct file *file, 
void __user *arg)
  	/* validate changed params against current layout */
  	err = ceph_do_getattr(file->f_dentry->d_inode, CEPH_STAT_CAP_LAYOUT);
  	if (!err) {
-		nl.stripe_unit = ceph_file_layout_stripe_unit(&ci->i_layout);
-		nl.stripe_count = ceph_file_layout_stripe_count(&ci->i_layout);
-		nl.object_size = ceph_file_layout_object_size(&ci->i_layout);
-		nl.data_pool = le32_to_cpu(ci->i_layout.fl_pg_pool);
+		nl.stripe_unit = (__u64) ceph_file_layout_stripe_unit(&ci->i_layout);
+		nl.stripe_count = (__u64) ceph_file_layout_stripe_count(&ci->i_layout);
+		nl.object_size = (__u64) ceph_file_layout_object_size(&ci->i_layout);
+		nl.data_pool = (__u64) ceph_file_layout_pg_pool(&ci->i_layout);
  		nl.preferred_osd =
-				(s32)le32_to_cpu(ci->i_layout.fl_pg_preferred);
+				(__s64) ceph_file_layout_pg_preferred(&ci->i_layout);
  	} else
  		return err;

@@ -203,8 +203,8 @@ static long ceph_ioctl_get_dataloc(struct file 
*file, void __user *arg)
  	ceph_calc_file_object_mapping(&ci->i_layout, dl.file_offset, &len,
  				      &dl.object_no, &dl.object_offset, &olen);
  	dl.file_offset -= dl.object_offset;
-	dl.object_size = ceph_file_layout_object_size(&ci->i_layout);
-	dl.block_size = ceph_file_layout_stripe_unit(&ci->i_layout);
+	dl.object_size = (__u64) ceph_file_layout_object_size(&ci->i_layout);
+	dl.block_size = (__u64) ceph_file_layout_stripe_unit(&ci->i_layout);

  	/* block_offset = object_offset % block_size */
  	tmp = dl.object_offset;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 75960b1..bfd5b93 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -115,11 +115,12 @@ static size_t ceph_vxattrcb_file_layout(struct 
ceph_inode_info *ci, char *val,

  	ret = snprintf(val, size,
  		"chunk_bytes=%lld\nstripe_count=%lld\nobject_size=%lld\n",
-		(unsigned long long)ceph_file_layout_su(&ci->i_layout),
+		(unsigned long long)ceph_file_layout_stripe_unit(&ci->i_layout),
  		(unsigned long long)ceph_file_layout_stripe_count(&ci->i_layout),
  		(unsigned long long)ceph_file_layout_object_size(&ci->i_layout));

-	if (ceph_file_layout_pg_preferred(&ci->i_layout) >= 0) {
+	if (ceph_file_layout_pg_preferred(&ci->i_layout) !=
+			CEPH_FILE_LAYOUT_PG_PREFERRED_NONE) {
  		val += ret;
  		size -= ret;
  		ret += snprintf(val, size, "preferred_osd=%lld\n",
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 2645704..cf86032 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -73,7 +73,8 @@ struct ceph_file_layout {
   * file layout helpers
   */

-#define CEPH_MIN_STRIPE_UNIT 65536
+#define CEPH_MIN_STRIPE_UNIT			65536
+#define CEPH_FILE_LAYOUT_PG_PREFERRED_NONE	((__s32) cpu_to_le32(-1))
  #define ceph_file_layout_stripe_unit(l) \
  		((__s32) le32_to_cpu((l)->fl_stripe_unit))
  #define ceph_file_layout_stripe_count(l) \
diff --git a/net/ceph/ceph_fs.c b/net/ceph/ceph_fs.c
index 41466cc..c3197b9 100644
--- a/net/ceph/ceph_fs.c
+++ b/net/ceph/ceph_fs.c
@@ -9,9 +9,9 @@
   */
  int ceph_file_layout_is_valid(const struct ceph_file_layout *layout)
  {
-	__u32 su = le32_to_cpu(layout->fl_stripe_unit);
-	__u32 sc = le32_to_cpu(layout->fl_stripe_count);
-	__u32 os = le32_to_cpu(layout->fl_object_size);
+	__u32 su = (__u32) ceph_file_layout_stripe_unit(layout);
+	__u32 sc = (__u32) ceph_file_layout_stripe_count(layout);
+	__u32 os = (__u32) ceph_file_layout_object_size(layout);

  	/* stripe unit, object size must be non-zero, 64k increment */
  	if (!su || (su & (CEPH_MIN_STRIPE_UNIT-1)))
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 29ad46e..f5f6e41 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -945,9 +945,9 @@ void ceph_calc_file_object_mapping(struct 
ceph_file_layout *layout,
  				   u64 *ono,
  				   u64 *oxoff, u64 *oxlen)
  {
-	u32 osize = le32_to_cpu(layout->fl_object_size);
-	u32 su = le32_to_cpu(layout->fl_stripe_unit);
-	u32 sc = le32_to_cpu(layout->fl_stripe_count);
+	u32 osize = (u32) ceph_file_layout_object_size(layout);
+	u32 su = (u32) ceph_file_layout_stripe_unit(layout);
+	u32 sc = (u32) ceph_file_layout_stripe_count(layout);
  	u32 bl, stripeno, stripepos, objsetno;
  	u32 su_per_object;
  	u64 t, su_offset;
@@ -1000,8 +1000,8 @@ int ceph_calc_object_layout(struct 
ceph_object_layout *ol,
  {
  	unsigned num, num_mask;
  	struct ceph_pg pgid;
-	s32 preferred = (s32)le32_to_cpu(fl->fl_pg_preferred);
-	int poolid = le32_to_cpu(fl->fl_pg_pool);
+	s32 preferred = (s32) ceph_file_layout_pg_preferred(fl);
+	int poolid = (int) ceph_file_layout_pg_pool(fl);
  	struct ceph_pg_pool_info *pool;
  	unsigned ps;

@@ -1011,23 +1011,24 @@ int ceph_calc_object_layout(struct 
ceph_object_layout *ol,
  	if (!pool)
  		return -EIO;
  	ps = ceph_str_hash(pool->v.object_hash, oid, strlen(oid));
-	if (preferred >= 0) {
+
+	if (preferred == CEPH_FILE_LAYOUT_PG_PREFERRED_NONE) {
+		num = le32_to_cpu(pool->v.pg_num);
+		num_mask = pool->pg_num_mask;
+	} else {
  		ps += preferred;
  		num = le32_to_cpu(pool->v.lpg_num);
  		num_mask = pool->lpg_num_mask;
-	} else {
-		num = le32_to_cpu(pool->v.pg_num);
-		num_mask = pool->pg_num_mask;
  	}

  	pgid.ps = cpu_to_le16(ps);
  	pgid.preferred = cpu_to_le16(preferred);
  	pgid.pool = fl->fl_pg_pool;
-	if (preferred >= 0)
+	if (preferred == CEPH_FILE_LAYOUT_PG_PREFERRED_NONE)
+		dout("calc_object_layout '%s' pgid %d.%x\n", oid, poolid, ps);
+	else
  		dout("calc_object_layout '%s' pgid %d.%xp%d\n", oid, poolid, ps,
  		     (int)preferred);
-	else
-		dout("calc_object_layout '%s' pgid %d.%x\n", oid, poolid, ps);

  	ol->ol_pgid = pgid;
  	ol->ol_stripe_unit = fl->fl_object_stripe_unit;
-- 
1.7.5.4

