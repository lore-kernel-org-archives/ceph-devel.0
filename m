From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/5] ceph: make ceph file layout helpers take a pointer
Date: Mon, 12 Mar 2012 17:57:45 -0500
Message-ID: <4F5E7F69.5090502@dreamhost.com>
References: <4F5E7DA5.4040802@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44861 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757436Ab2CLW5m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:57:42 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id A2A21243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:58:16 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 77A6A2439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:58:16 -0700 (PDT)
In-Reply-To: <4F5E7DA5.4040802@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Make the helpers for accessing the fields of an on-disk ceph file
layout structure take the address of a layout structure rather than
the structure itself.  It's more useful (and to my eye a bit more
normal).

Use the result in ceph_file_layout_stripe_width() and
ceph_file_layout_period(), since it's now possible.

Rename ceph_file_layout_su() to be ceph_file_layout_stripe_unit().

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/ioctl.c              |   16 ++++++++--------
  fs/ceph/xattr.c              |   10 +++++-----
  include/linux/ceph/ceph_fs.h |   28 +++++++++++++++-------------
  3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 790914a59..23cb78b 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -22,9 +22,9 @@ static long ceph_ioctl_get_layout(struct file *file, 
void __user *arg)

  	err = ceph_do_getattr(file->f_dentry->d_inode, CEPH_STAT_CAP_LAYOUT);
  	if (!err) {
-		l.stripe_unit = ceph_file_layout_su(ci->i_layout);
-		l.stripe_count = ceph_file_layout_stripe_count(ci->i_layout);
-		l.object_size = ceph_file_layout_object_size(ci->i_layout);
+		l.stripe_unit = ceph_file_layout_stripe_unit(&ci->i_layout);
+		l.stripe_count = ceph_file_layout_stripe_count(&ci->i_layout);
+		l.object_size = ceph_file_layout_object_size(&ci->i_layout);
  		l.data_pool = le32_to_cpu(ci->i_layout.fl_pg_pool);
  		l.preferred_osd =
  			(s32)le32_to_cpu(ci->i_layout.fl_pg_preferred);
@@ -52,9 +52,9 @@ static long ceph_ioctl_set_layout(struct file *file, 
void __user *arg)
  	/* validate changed params against current layout */
  	err = ceph_do_getattr(file->f_dentry->d_inode, CEPH_STAT_CAP_LAYOUT);
  	if (!err) {
-		nl.stripe_unit = ceph_file_layout_su(ci->i_layout);
-		nl.stripe_count = ceph_file_layout_stripe_count(ci->i_layout);
-		nl.object_size = ceph_file_layout_object_size(ci->i_layout);
+		nl.stripe_unit = ceph_file_layout_stripe_unit(&ci->i_layout);
+		nl.stripe_count = ceph_file_layout_stripe_count(&ci->i_layout);
+		nl.object_size = ceph_file_layout_object_size(&ci->i_layout);
  		nl.data_pool = le32_to_cpu(ci->i_layout.fl_pg_pool);
  		nl.preferred_osd =
  				(s32)le32_to_cpu(ci->i_layout.fl_pg_preferred);
@@ -203,8 +203,8 @@ static long ceph_ioctl_get_dataloc(struct file 
*file, void __user *arg)
  	ceph_calc_file_object_mapping(&ci->i_layout, dl.file_offset, &len,
  				      &dl.object_no, &dl.object_offset, &olen);
  	dl.file_offset -= dl.object_offset;
-	dl.object_size = ceph_file_layout_object_size(ci->i_layout);
-	dl.block_size = ceph_file_layout_su(ci->i_layout);
+	dl.object_size = ceph_file_layout_object_size(&ci->i_layout);
+	dl.block_size = ceph_file_layout_stripe_unit(&ci->i_layout);

  	/* block_offset = object_offset % block_size */
  	tmp = dl.object_offset;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 715cfc6..75960b1 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -115,16 +115,16 @@ static size_t ceph_vxattrcb_file_layout(struct 
ceph_inode_info *ci, char *val,

  	ret = snprintf(val, size,
  		"chunk_bytes=%lld\nstripe_count=%lld\nobject_size=%lld\n",
-		(unsigned long long)ceph_file_layout_su(ci->i_layout),
-		(unsigned long long)ceph_file_layout_stripe_count(ci->i_layout),
-		(unsigned long long)ceph_file_layout_object_size(ci->i_layout));
+		(unsigned long long)ceph_file_layout_su(&ci->i_layout),
+		(unsigned long long)ceph_file_layout_stripe_count(&ci->i_layout),
+		(unsigned long long)ceph_file_layout_object_size(&ci->i_layout));

-	if (ceph_file_layout_pg_preferred(ci->i_layout) >= 0) {
+	if (ceph_file_layout_pg_preferred(&ci->i_layout) >= 0) {
  		val += ret;
  		size -= ret;
  		ret += snprintf(val, size, "preferred_osd=%lld\n",
  			    (unsigned long long)ceph_file_layout_pg_preferred(
-				    ci->i_layout));
+				    &ci->i_layout));
  	}

  	return ret;
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 62e3bb3..2645704 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -74,32 +74,34 @@ struct ceph_file_layout {
   */

  #define CEPH_MIN_STRIPE_UNIT 65536
-#define ceph_file_layout_su(l) ((__s32)le32_to_cpu((l).fl_stripe_unit))
+#define ceph_file_layout_stripe_unit(l) \
+		((__s32) le32_to_cpu((l)->fl_stripe_unit))
  #define ceph_file_layout_stripe_count(l) \
-	((__s32)le32_to_cpu((l).fl_stripe_count))
-#define ceph_file_layout_object_size(l) 
((__s32)le32_to_cpu((l).fl_object_size))
-#define ceph_file_layout_cas_hash(l) ((__s32)le32_to_cpu((l).fl_cas_hash))
-#define ceph_file_layout_object_su(l) \
-	((__s32)le32_to_cpu((l).fl_object_stripe_unit))
+		((__s32) le32_to_cpu((l)->fl_stripe_count))
+#define ceph_file_layout_object_size(l) \
+		((__s32) le32_to_cpu((l)->fl_object_size))
+#define ceph_file_layout_cas_hash(l) \
+		((__s32) le32_to_cpu((l)->fl_cas_hash))
+#define ceph_file_layout_object_stripe_unit(l) \
+		((__s32) le32_to_cpu((l)->fl_object_stripe_unit))
  #define ceph_file_layout_pg_preferred(l) \
-	((__s32)le32_to_cpu((l).fl_pg_preferred))
+		((__s32) le32_to_cpu((l)->fl_pg_preferred))
  #define ceph_file_layout_pg_pool(l) \
-	((__s32)le32_to_cpu((l).fl_pg_pool))
+		((__s32) le32_to_cpu((l)->fl_pg_pool))

  static inline unsigned ceph_file_layout_stripe_width(struct 
ceph_file_layout *l)
  {
-	return le32_to_cpu(l->fl_stripe_unit) *
-		le32_to_cpu(l->fl_stripe_count);
+	return (unsigned) (ceph_file_layout_stripe_unit(l) *
+				ceph_file_layout_stripe_count(l));
  }

  /* "period" == bytes before i start on a new set of objects */
  static inline unsigned ceph_file_layout_period(struct ceph_file_layout *l)
  {
-	return le32_to_cpu(l->fl_object_size) *
-		le32_to_cpu(l->fl_stripe_count);
+	return (unsigned) (ceph_file_layout_object_size(l) *
+				ceph_file_layout_stripe_count(l));
  }

-
  int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);

  struct ceph_dir_layout {
-- 
1.7.5.4

