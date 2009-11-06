From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: [RFC] separate otw data from host data
Date: Thu, 5 Nov 2009 18:03:16 -0800
Message-ID: <A559A761-1932-464D-8EBA-0A7DDDF14E44@soe.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: multipart/mixed; boundary=Apple-Mail-14--7077773
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
Cc: Noah Watkins <noah@noahdesu.com>
List-Id: ceph-devel.vger.kernel.org


--Apple-Mail-14--7077773
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Sage

A large number of le32_to_cpu (and the like) are used throughout the  
kernel client when referencing packed structs that are used OTW.  
However, I'd argue conversion should be done in only two places:  
before being sent or received. This allows non-packed versions of  
structs to be used only on the local machine, and use optimized  
alignment determined by gcc. Additionally it de-clutters the code of  
all the conversion routines. The patch I attached (not ready for use)  
demonstrates this for struct ceph_file_layout by introducing struct  
__ceph_file_layout for OTW, and does conversion only before sending  
or receiving over the network.

Comments, suggestions?

-n



--Apple-Mail-14--7077773
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name=use-non-packed-fl.diff
Content-Disposition: attachment;
	filename=use-non-packed-fl.diff

diff --git a/caps.c b/caps.c
index 8b863db..1c2392b 100644
--- a/caps.c
+++ b/caps.c
@@ -2272,7 +2272,7 @@ restart:
 	cap->seq = seq;
 
 	/* file layout may have changed */
-	ci->i_layout = grant->layout;
+	ceph_layout_otw_to_cpu(&ci->i_layout, &grant->layout);
 
 	/* revocation, grant, or no-op? */
 	if (cap->issued & ~newcaps) {
diff --git a/ceph_fs.c b/ceph_fs.c
index a950b40..1ee72a1 100644
--- a/ceph_fs.c
+++ b/ceph_fs.c
@@ -3,6 +3,8 @@
  */
 #include "types.h"
 
+#if 0
+UNUSED: retain for reference
 /*
  * return true if @layout appears to be valid
  */
@@ -25,7 +27,7 @@ int ceph_file_layout_is_valid(const struct ceph_file_layout *layout)
 		return 0;
 	return 1;
 }
-
+#endif
 
 int ceph_flags_to_mode(int flags)
 {
diff --git a/ceph_fs.h b/ceph_fs.h
index ae52382..2ecaf6a 100644
--- a/ceph_fs.h
+++ b/ceph_fs.h
@@ -51,31 +51,66 @@
 
 unsigned int ceph_full_name_hash(const char *name, unsigned int len);
 
-
 /*
- * ceph_file_layout - describe data layout for a file/inode
+ * struct __ceph_file_layout - file/object mapping parameters (OTW)
+ *
+ * @fl_stripe_unit:  stripe unit, in bytes. page size multiple.
+ * @fl_stripe_count: over this many objects
+ * @fl_object_size:  until objects are this big, then move to next
+                     set of objects
+ * @fl_cas_hash:     0 = none; 1 = sha256
+ * @fl_object_su:    for per-object parity, if any
+ * @fl_pg_preferred: preferred primary for pg (-1 for none)
+ * @fl_pg_pool:      namespace, crush ruleset, rep level
+ *
+ * Member sames are prefixed with underscore to emphasize their difference from
+ * struct ceph_file_layout, the non-packed, internal-use version.
  */
-struct ceph_file_layout {
+struct __ceph_file_layout {
 	/* file -> object mapping */
-	__le32 fl_stripe_unit;     /* stripe unit, in bytes.  must be multiple
-				      of page size. */
-	__le32 fl_stripe_count;    /* over this many objects */
-	__le32 fl_object_size;     /* until objects are this big, then move to
-				      new objects */
-	__le32 fl_cas_hash;        /* 0 = none; 1 = sha256 */
-
+	__le32 _fl_stripe_unit;
+	__le32 _fl_stripe_count;
+	__le32 _fl_object_size;
+	__le32 _fl_cas_hash;
 	/* pg -> disk layout */
-	__le32 fl_object_stripe_unit;  /* for per-object parity, if any */
-
+	__le32 _fl_object_stripe_unit;
 	/* object -> pg layout */
-	__le32 fl_pg_preferred; /* preferred primary for pg (-1 for none) */
-	__le32 fl_pg_pool;      /* namespace, crush ruleset, rep level */
+	__le32 _fl_pg_preferred;
+	__le32 _fl_pg_pool;
 } __attribute__ ((packed));
 
-#define CEPH_MIN_STRIPE_UNIT 65536
+/*
+ * struct ceph_file_layout - file/object mapping parameters (internal)
+ *
+ * Stores information from struct __ceph_file_layout converted to native data
+ * types, and lets gcc do optimized packing/alignment.
+ *
+ * See struct __ceph_file_layout for description of members common to both
+ * structs.
+ */
+struct ceph_file_layout {
+	u32 fl_stripe_unit;
+	u32 fl_stripe_count;
+	u32 fl_object_size;
+	u32 fl_cas_hash;
+	u32 fl_object_stripe_unit;
+	s32 fl_pg_preferred;
+	u32 fl_pg_pool;
+};
 
-int ceph_file_layout_is_valid(const struct ceph_file_layout *layout);
+static inline void ceph_layout_otw_to_cpu(struct ceph_file_layout *n,
+		struct __ceph_file_layout *o)
+{
+	n->fl_stripe_unit	  = le32_to_cpu(o->_fl_stripe_unit);
+	n->fl_stripe_count	  = le32_to_cpu(o->_fl_stripe_count);
+	n->fl_object_size	  = le32_to_cpu(o->_fl_object_size);
+	n->fl_cas_hash		  = le32_to_cpu(o->_fl_cas_hash);
+	n->fl_object_stripe_unit  = le32_to_cpu(o->_fl_object_stripe_unit);
+	n->fl_pg_preferred 	  = (s32)le32_to_cpu(o->_fl_pg_preferred);
+	n->fl_pg_pool 		  = le32_to_cpu(o->_fl_pg_pool);
+}
 
+#define CEPH_MIN_STRIPE_UNIT 65536
 
 /*********************************************
  * message layer
@@ -316,7 +351,7 @@ union ceph_mds_request_args {
 		__le32 flags;
 	} __attribute__ ((packed)) setxattr;
 	struct {
-		struct ceph_file_layout layout;
+		struct __ceph_file_layout layout;
 	} __attribute__ ((packed)) setlayout;
 } __attribute__ ((packed));
 
@@ -386,7 +421,7 @@ struct ceph_mds_reply_inode {
 	__le64 version;                /* inode version */
 	__le64 xattr_version;          /* version for xattr blob */
 	struct ceph_mds_reply_cap cap; /* caps issued for this inode */
-	struct ceph_file_layout layout;
+	struct __ceph_file_layout layout;
 	struct ceph_timespec ctime, mtime, atime;
 	__le32 time_warp_seq;
 	__le64 size, max_size, truncate_size;
@@ -549,7 +584,7 @@ struct ceph_mds_caps {
 	__le64 size, max_size, truncate_size;
 	__le32 truncate_seq;
 	struct ceph_timespec mtime, atime, ctime;
-	struct ceph_file_layout layout;
+	struct __ceph_file_layout layout;
 	__le32 time_warp_seq;
 } __attribute__ ((packed));
 
diff --git a/inode.c b/inode.c
index 036873c..de81da0 100644
--- a/inode.c
+++ b/inode.c
@@ -574,8 +574,11 @@ static int fill_inode(struct inode *inode,
 			    &ctime, &mtime, &atime);
 
 	ci->i_max_size = le64_to_cpu(info->max_size);
-	ci->i_layout = info->layout;
-	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
+
+	/* Convert OTW layout struct to internal representation */
+	ceph_layout_otw_to_cpu(&ci->i_layout, &info->layout);
+
+	inode->i_blkbits = fls(ci->i_layout.fl_stripe_unit) - 1;
 
 	/* xattrs */
 	/* note that if i_xattrs.len <= 4, i_xattrs.data will still be NULL. */
diff --git a/ioctl.c b/ioctl.c
index 4c33e19..d4848b4 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -19,16 +19,18 @@ static long ceph_ioctl_get_layout(struct file *file, void __user *arg)
 	int err;
 
 	err = ceph_do_getattr(file->f_dentry->d_inode, CEPH_STAT_CAP_LAYOUT);
-	if (!err) {
-		l.stripe_unit = ceph_file_layout_su(ci->i_layout);
-		l.stripe_count = ceph_file_layout_stripe_count(ci->i_layout);
-		l.object_size = ceph_file_layout_object_size(ci->i_layout);
-		l.data_pool = le32_to_cpu(ci->i_layout.fl_pg_pool);
-		if (copy_to_user(arg, &l, sizeof(l)))
-			return -EFAULT;
-	}
+	if (err)
+		return err;
 
-	return err;
+	l.stripe_unit = ci->i_layout.fl_stripe_unit;
+	l.stripe_count = ci->i_layout.fl_stripe_count;
+	l.object_size = ci->i_layout.fl_object_size;
+	l.data_pool = ci->i_layout.fl_pg_pool;
+
+	if (copy_to_user(arg, &l, sizeof(l)))
+		return -EFAULT;
+
+	return 0;
 }
 
 static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
@@ -38,6 +40,7 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 	struct ceph_mds_client *mdsc = &ceph_sb_to_client(inode->i_sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
+	struct __ceph_file_layout *layout;
 	int err, i;
 
 	/* copy and validate */
@@ -72,14 +75,12 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 	req->r_inode = igrab(inode);
 	req->r_inode_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_FILE_EXCL;
 
-	req->r_args.setlayout.layout.fl_stripe_unit =
-		cpu_to_le32(l.stripe_unit);
-	req->r_args.setlayout.layout.fl_stripe_count =
-		cpu_to_le32(l.stripe_count);
-	req->r_args.setlayout.layout.fl_object_size =
-		cpu_to_le32(l.object_size);
-	req->r_args.setlayout.layout.fl_pg_pool = cpu_to_le32(l.data_pool);
-	req->r_args.setlayout.layout.fl_pg_preferred = cpu_to_le32((s32)-1);
+	layout = &req->r_args.setlayout.layout;
+	layout->_fl_stripe_unit = cpu_to_le32(l.stripe_unit);
+	layout->_fl_stripe_count = cpu_to_le32(l.stripe_count);
+	layout->_fl_object_size = cpu_to_le32(l.object_size);
+	layout->_fl_pg_pool = cpu_to_le32(l.data_pool);
+	layout->_fl_pg_preferred = cpu_to_le32((s32)-1);
 
 	err = ceph_mdsc_do_request(mdsc, parent_inode, req);
 	ceph_mdsc_put_request(req);
@@ -109,8 +110,8 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 	ceph_calc_file_object_mapping(&ci->i_layout, dl.file_offset, &len,
 				      &dl.object_no, &dl.object_offset, &olen);
 	dl.file_offset -= dl.object_offset;
-	dl.object_size = ceph_file_layout_object_size(ci->i_layout);
-	dl.block_size = ceph_file_layout_su(ci->i_layout);
+	dl.object_size = ci->i_layout.fl_object_size;
+	dl.block_size = ci->i_layout.fl_stripe_unit;
 
 	/* block_offset = object_offset % block_size */
 	tmp = dl.object_offset;
diff --git a/osdmap.c b/osdmap.c
index 8b0cd11..226131d 100644
--- a/osdmap.c
+++ b/osdmap.c
@@ -746,9 +746,9 @@ void ceph_calc_file_object_mapping(struct ceph_file_layout *layout,
 				   u64 *ono,
 				   u64 *oxoff, u64 *oxlen)
 {
-	u32 osize = le32_to_cpu(layout->fl_object_size);
-	u32 su = le32_to_cpu(layout->fl_stripe_unit);
-	u32 sc = le32_to_cpu(layout->fl_stripe_count);
+	u32 osize = layout->fl_object_size;
+	u32 su = layout->fl_stripe_unit;
+	u32 sc = layout->fl_stripe_count;
 	u32 bl, stripeno, stripepos, objsetno;
 	u32 su_per_object;
 	u64 t, su_offset;
@@ -800,8 +800,8 @@ int ceph_calc_object_layout(struct ceph_object_layout *ol,
 {
 	unsigned num, num_mask;
 	struct ceph_pg pgid;
-	s32 preferred = (s32)le32_to_cpu(fl->fl_pg_preferred);
-	int poolid = le32_to_cpu(fl->fl_pg_pool);
+	s32 preferred = fl->fl_pg_preferred;
+	int poolid = fl->fl_pg_pool;
 	struct ceph_pg_pool_info *pool;
 	unsigned ps;
 
diff --git a/osdmap.h b/osdmap.h
index c4af841..05fb0cc 100644
--- a/osdmap.h
+++ b/osdmap.h
@@ -53,35 +53,6 @@ struct ceph_osdmap {
 	struct crush_map *crush;
 };
 
-/*
- * file layout helpers
- */
-#define ceph_file_layout_su(l) ((__s32)le32_to_cpu((l).fl_stripe_unit))
-#define ceph_file_layout_stripe_count(l) \
-	((__s32)le32_to_cpu((l).fl_stripe_count))
-#define ceph_file_layout_object_size(l) ((__s32)le32_to_cpu((l).fl_object_size))
-#define ceph_file_layout_cas_hash(l) ((__s32)le32_to_cpu((l).fl_cas_hash))
-#define ceph_file_layout_object_su(l) \
-	((__s32)le32_to_cpu((l).fl_object_stripe_unit))
-#define ceph_file_layout_pg_preferred(l) \
-	((__s32)le32_to_cpu((l).fl_pg_preferred))
-#define ceph_file_layout_pg_pool(l) \
-	((__s32)le32_to_cpu((l).fl_pg_pool))
-
-static inline unsigned ceph_file_layout_stripe_width(struct ceph_file_layout *l)
-{
-	return le32_to_cpu(l->fl_stripe_unit) *
-		le32_to_cpu(l->fl_stripe_count);
-}
-
-/* "period" == bytes before i start on a new set of objects */
-static inline unsigned ceph_file_layout_period(struct ceph_file_layout *l)
-{
-	return le32_to_cpu(l->fl_object_size) *
-		le32_to_cpu(l->fl_stripe_count);
-}
-
-
 static inline int ceph_osd_is_up(struct ceph_osdmap *map, int osd)
 {
 	return (osd < map->max_osd) && (map->osd_state[osd] & CEPH_OSD_UP);
diff --git a/xattr.c b/xattr.c
index 1a48a55..ba6039d 100644
--- a/xattr.c
+++ b/xattr.c
@@ -95,13 +95,12 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 
 	ret = snprintf(val, size,
 		"chunk_bytes=%lld\nstripe_count=%lld\nobject_size=%lld\n",
-		(unsigned long long)ceph_file_layout_su(ci->i_layout),
-		(unsigned long long)ceph_file_layout_stripe_count(ci->i_layout),
-		(unsigned long long)ceph_file_layout_object_size(ci->i_layout));
-	if (ceph_file_layout_pg_preferred(ci->i_layout))
+		(unsigned long long)ci->i_layout.fl_stripe_unit,
+		(unsigned long long)ci->i_layout.fl_stripe_count,
+		(unsigned long long)ci->i_layout.fl_object_size);
+	if (ci->i_layout.fl_pg_preferred)
 		ret += snprintf(val + ret, size, "preferred_osd=%lld\n",
-			    (unsigned long long)ceph_file_layout_pg_preferred(
-				    ci->i_layout));
+			    (unsigned long long)ci->i_layout.fl_pg_preferred);
 	return ret;
 }
 

--Apple-Mail-14--7077773
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--Apple-Mail-14--7077773
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--Apple-Mail-14--7077773--
