From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/5] ceph: use timespec64 for inode timestamp
Date: Wed, 20 Jun 2018 17:50:35 +0200
Message-ID: <20180620155101.57685-3-arnd@arndb.de>
References: <20180620155101.57685-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620155101.57685-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: y2038@lists.linaro.org, ceph-devel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@redhat.com>, David Howells <dhowells@redhat.com>, Chengguang Xu <cgxu519@gmx.com>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Since the vfs structures are all using timespec64, we can now
change the internal representation, using ceph_encode_timespec64 and
ceph_decode_timespec64.

In case of ceph_aux_inode however, we need to avoid doing a memcmp()
on uninitialized padding data, so the members of the i_mtime field get
copied individually into 64-bit integers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/cache.c      | 11 +++++---
 fs/ceph/caps.c       | 26 +++++++++---------
 fs/ceph/dir.c        |  6 ++---
 fs/ceph/inode.c      | 76 +++++++++++++++++++++++++---------------------------
 fs/ceph/mds_client.c |  7 ++---
 fs/ceph/snap.c       |  6 ++---
 fs/ceph/super.h      |  9 ++++---
 fs/ceph/xattr.c      |  4 +--
 8 files changed, 71 insertions(+), 74 deletions(-)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 362900e42424..1bf3502bdd6f 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -25,8 +25,9 @@
 #include "cache.h"
 
 struct ceph_aux_inode {
-	u64 		version;
-	struct timespec	mtime;
+	u64 	version;
+	u64	mtime_sec;
+	u64	mtime_nsec;
 };
 
 struct fscache_netfs ceph_cache_netfs = {
@@ -130,7 +131,8 @@ static enum fscache_checkaux ceph_fscache_inode_check_aux(
 
 	memset(&aux, 0, sizeof(aux));
 	aux.version = ci->i_version;
-	aux.mtime = timespec64_to_timespec(inode->i_mtime);
+	aux.mtime_sec = inode->i_mtime.tv_sec;
+	aux.mtime_nsec = inode->i_mtime.tv_nsec;
 
 	if (memcmp(data, &aux, sizeof(aux)) != 0)
 		return FSCACHE_CHECKAUX_OBSOLETE;
@@ -163,7 +165,8 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
 	if (!ci->fscache) {
 		memset(&aux, 0, sizeof(aux));
 		aux.version = ci->i_version;
-		aux.mtime = timespec64_to_timespec(inode->i_mtime);
+		aux.mtime_sec = inode->i_mtime.tv_sec;
+		aux.mtime_nsec = inode->i_mtime.tv_nsec;
 		ci->fscache = fscache_acquire_cookie(fsc->fscache,
 						     &ceph_fscache_inode_object_def,
 						     &ci->i_vino, sizeof(ci->i_vino),
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 990258cbd836..f50cc008632a 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1125,7 +1125,7 @@ struct cap_msg_args {
 	u64			flush_tid, oldest_flush_tid, size, max_size;
 	u64			xattr_version;
 	struct ceph_buffer	*xattr_buf;
-	struct timespec		atime, mtime, ctime;
+	struct timespec64	atime, mtime, ctime;
 	int			op, caps, wanted, dirty;
 	u32			seq, issue_seq, mseq, time_warp_seq;
 	u32			flags;
@@ -1146,7 +1146,7 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	struct ceph_msg *msg;
 	void *p;
 	size_t extra_len;
-	struct timespec zerotime = {0};
+	struct timespec64 zerotime = {0};
 	struct ceph_osd_client *osdc = &arg->session->s_mdsc->fsc->client->osdc;
 
 	dout("send_cap_msg %s %llx %llx caps %s wanted %s dirty %s"
@@ -1186,9 +1186,9 @@ static int send_cap_msg(struct cap_msg_args *arg)
 
 	fc->size = cpu_to_le64(arg->size);
 	fc->max_size = cpu_to_le64(arg->max_size);
-	ceph_encode_timespec(&fc->mtime, &arg->mtime);
-	ceph_encode_timespec(&fc->atime, &arg->atime);
-	ceph_encode_timespec(&fc->ctime, &arg->ctime);
+	ceph_encode_timespec64(&fc->mtime, &arg->mtime);
+	ceph_encode_timespec64(&fc->atime, &arg->atime);
+	ceph_encode_timespec64(&fc->ctime, &arg->ctime);
 	fc->time_warp_seq = cpu_to_le32(arg->time_warp_seq);
 
 	fc->uid = cpu_to_le32(from_kuid(&init_user_ns, arg->uid));
@@ -1237,7 +1237,7 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	 * We just zero these out for now, as the MDS ignores them unless
 	 * the requisite feature flags are set (which we don't do yet).
 	 */
-	ceph_encode_timespec(p, &zerotime);
+	ceph_encode_timespec64(p, &zerotime);
 	p += sizeof(struct ceph_timespec);
 	ceph_encode_64(&p, 0);
 
@@ -1360,9 +1360,9 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 		arg.xattr_buf = NULL;
 	}
 
-	arg.mtime = timespec64_to_timespec(inode->i_mtime);
-	arg.atime = timespec64_to_timespec(inode->i_atime);
-	arg.ctime = timespec64_to_timespec(inode->i_ctime);
+	arg.mtime = inode->i_mtime;
+	arg.atime = inode->i_atime;
+	arg.ctime = inode->i_ctime;
 
 	arg.op = op;
 	arg.caps = cap->implemented;
@@ -3148,11 +3148,11 @@ static void handle_cap_grant(struct inode *inode,
 	}
 
 	if (newcaps & CEPH_CAP_ANY_RD) {
-		struct timespec mtime, atime, ctime;
+		struct timespec64 mtime, atime, ctime;
 		/* ctime/mtime/atime? */
-		ceph_decode_timespec(&mtime, &grant->mtime);
-		ceph_decode_timespec(&atime, &grant->atime);
-		ceph_decode_timespec(&ctime, &grant->ctime);
+		ceph_decode_timespec64(&mtime, &grant->mtime);
+		ceph_decode_timespec64(&atime, &grant->atime);
+		ceph_decode_timespec64(&ctime, &grant->ctime);
 		ceph_fill_file_time(inode, extra_info->issued,
 				    le32_to_cpu(grant->time_warp_seq),
 				    &ctime, &mtime, &atime);
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 036ac0f3a393..4c3961717e77 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1393,7 +1393,7 @@ static ssize_t ceph_read_dir(struct file *file, char __user *buf, size_t size,
 				" rfiles:   %20lld\n"
 				" rsubdirs: %20lld\n"
 				"rbytes:    %20lld\n"
-				"rctime:    %10ld.%09ld\n",
+				"rctime:    %10lld.%09ld\n",
 				ci->i_files + ci->i_subdirs,
 				ci->i_files,
 				ci->i_subdirs,
@@ -1401,8 +1401,8 @@ static ssize_t ceph_read_dir(struct file *file, char __user *buf, size_t size,
 				ci->i_rfiles,
 				ci->i_rsubdirs,
 				ci->i_rbytes,
-				(long)ci->i_rctime.tv_sec,
-				(long)ci->i_rctime.tv_nsec);
+				ci->i_rctime.tv_sec,
+				ci->i_rctime.tv_nsec);
 	}
 
 	if (*ppos >= dfi->dir_info_len)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index ee764ac352ab..d85f72bd585d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -658,13 +658,10 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 }
 
 void ceph_fill_file_time(struct inode *inode, int issued,
-			 u64 time_warp_seq, struct timespec *ctime,
-			 struct timespec *mtime, struct timespec *atime)
+			 u64 time_warp_seq, struct timespec64 *ctime,
+			 struct timespec64 *mtime, struct timespec64 *atime)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct timespec64 ctime64 = timespec_to_timespec64(*ctime);
-	struct timespec64 mtime64 = timespec_to_timespec64(*mtime);
-	struct timespec64 atime64 = timespec_to_timespec64(*atime);
 	int warn = 0;
 
 	if (issued & (CEPH_CAP_FILE_EXCL|
@@ -673,39 +670,39 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		      CEPH_CAP_AUTH_EXCL|
 		      CEPH_CAP_XATTR_EXCL)) {
 		if (ci->i_version == 0 ||
-		    timespec64_compare(&ctime64, &inode->i_ctime) > 0) {
+		    timespec64_compare(ctime, &inode->i_ctime) > 0) {
 			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
-			     (long long)inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
-			     (long long)ctime->tv_sec, ctime->tv_nsec);
-			inode->i_ctime = ctime64;
+			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+			     ctime->tv_sec, ctime->tv_nsec);
+			inode->i_ctime = *ctime;
 		}
 		if (ci->i_version == 0 ||
 		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
 			/* the MDS did a utimes() */
 			dout("mtime %lld.%09ld -> %lld.%09ld "
 			     "tw %d -> %d\n",
-			     (long long)inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
-			     (long long)mtime->tv_sec, mtime->tv_nsec,
+			     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+			     mtime->tv_sec, mtime->tv_nsec,
 			     ci->i_time_warp_seq, (int)time_warp_seq);
 
-			inode->i_mtime = mtime64;
-			inode->i_atime = atime64;
+			inode->i_mtime = *mtime;
+			inode->i_atime = *atime;
 			ci->i_time_warp_seq = time_warp_seq;
 		} else if (time_warp_seq == ci->i_time_warp_seq) {
 			/* nobody did utimes(); take the max */
-			if (timespec64_compare(&mtime64, &inode->i_mtime) > 0) {
+			if (timespec64_compare(mtime, &inode->i_mtime) > 0) {
 				dout("mtime %lld.%09ld -> %lld.%09ld inc\n",
-				     (long long)inode->i_mtime.tv_sec,
+				     inode->i_mtime.tv_sec,
 				     inode->i_mtime.tv_nsec,
-				     (long long)mtime->tv_sec, mtime->tv_nsec);
-				inode->i_mtime = mtime64;
+				     mtime->tv_sec, mtime->tv_nsec);
+				inode->i_mtime = *mtime;
 			}
-			if (timespec64_compare(&atime64, &inode->i_atime) > 0) {
+			if (timespec64_compare(atime, &inode->i_atime) > 0) {
 				dout("atime %lld.%09ld -> %lld.%09ld inc\n",
-				     (long long)inode->i_atime.tv_sec,
+				     inode->i_atime.tv_sec,
 				     inode->i_atime.tv_nsec,
-				     (long long)atime->tv_sec, atime->tv_nsec);
-				inode->i_atime = atime64;
+				     atime->tv_sec, atime->tv_nsec);
+				inode->i_atime = *atime;
 			}
 		} else if (issued & CEPH_CAP_FILE_EXCL) {
 			/* we did a utimes(); ignore mds values */
@@ -715,9 +712,9 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 	} else {
 		/* we have no write|excl caps; whatever the MDS says is true */
 		if (ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) >= 0) {
-			inode->i_ctime = ctime64;
-			inode->i_mtime = mtime64;
-			inode->i_atime = atime64;
+			inode->i_ctime = *ctime;
+			inode->i_mtime = *mtime;
+			inode->i_atime = *atime;
 			ci->i_time_warp_seq = time_warp_seq;
 		} else {
 			warn = 1;
@@ -743,7 +740,7 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 	struct ceph_mds_reply_inode *info = iinfo->in;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int issued, new_issued, info_caps;
-	struct timespec mtime, atime, ctime;
+	struct timespec64 mtime, atime, ctime;
 	struct ceph_buffer *xattr_blob = NULL;
 	struct ceph_string *pool_ns = NULL;
 	struct ceph_cap *new_cap = NULL;
@@ -823,9 +820,9 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 
 	if (new_version || (new_issued & CEPH_CAP_ANY_RD)) {
 		/* be careful with mtime, atime, size */
-		ceph_decode_timespec(&atime, &info->atime);
-		ceph_decode_timespec(&mtime, &info->mtime);
-		ceph_decode_timespec(&ctime, &info->ctime);
+		ceph_decode_timespec64(&atime, &info->atime);
+		ceph_decode_timespec64(&mtime, &info->mtime);
+		ceph_decode_timespec64(&ctime, &info->ctime);
 		ceph_fill_file_time(inode, issued,
 				le32_to_cpu(info->time_warp_seq),
 				&ctime, &mtime, &atime);
@@ -872,7 +869,7 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 			ci->i_rbytes = le64_to_cpu(info->rbytes);
 			ci->i_rfiles = le64_to_cpu(info->rfiles);
 			ci->i_rsubdirs = le64_to_cpu(info->rsubdirs);
-			ceph_decode_timespec(&ci->i_rctime, &info->rctime);
+			ceph_decode_timespec64(&ci->i_rctime, &info->rctime);
 		}
 	}
 
@@ -1953,7 +1950,6 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	int err = 0;
 	int inode_dirty_flags = 0;
 	bool lock_snap_rwsem = false;
-	struct timespec ts;
 
 	prealloc_cf = ceph_alloc_cap_flush();
 	if (!prealloc_cf)
@@ -2029,8 +2025,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 
 	if (ia_valid & ATTR_ATIME) {
 		dout("setattr %p atime %lld.%ld -> %lld.%ld\n", inode,
-		     (long long)inode->i_atime.tv_sec, inode->i_atime.tv_nsec,
-		     (long long)attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
+		     inode->i_atime.tv_sec, inode->i_atime.tv_nsec,
+		     attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
 			inode->i_atime = attr->ia_atime;
@@ -2042,8 +2038,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 			dirtied |= CEPH_CAP_FILE_WR;
 		} else if ((issued & CEPH_CAP_FILE_SHARED) == 0 ||
 			   !timespec64_equal(&inode->i_atime, &attr->ia_atime)) {
-			ts = timespec64_to_timespec(attr->ia_atime);
-			ceph_encode_timespec(&req->r_args.setattr.atime, &ts);
+			ceph_encode_timespec64(&req->r_args.setattr.atime,
+					       &attr->ia_atime);
 			mask |= CEPH_SETATTR_ATIME;
 			release |= CEPH_CAP_FILE_SHARED |
 				   CEPH_CAP_FILE_RD | CEPH_CAP_FILE_WR;
@@ -2051,8 +2047,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	}
 	if (ia_valid & ATTR_MTIME) {
 		dout("setattr %p mtime %lld.%ld -> %lld.%ld\n", inode,
-		     (long long)inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
-		     (long long)attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
+		     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+		     attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
 			inode->i_mtime = attr->ia_mtime;
@@ -2064,8 +2060,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 			dirtied |= CEPH_CAP_FILE_WR;
 		} else if ((issued & CEPH_CAP_FILE_SHARED) == 0 ||
 			   !timespec64_equal(&inode->i_mtime, &attr->ia_mtime)) {
-			ts = timespec64_to_timespec(attr->ia_mtime);
-			ceph_encode_timespec(&req->r_args.setattr.mtime, &ts);
+			ceph_encode_timespec64(&req->r_args.setattr.mtime,
+					       &attr->ia_mtime);
 			mask |= CEPH_SETATTR_MTIME;
 			release |= CEPH_CAP_FILE_SHARED |
 				   CEPH_CAP_FILE_RD | CEPH_CAP_FILE_WR;
@@ -2096,8 +2092,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		bool only = (ia_valid & (ATTR_SIZE|ATTR_MTIME|ATTR_ATIME|
 					 ATTR_MODE|ATTR_UID|ATTR_GID)) == 0;
 		dout("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n", inode,
-		     (long long)inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
-		     (long long)attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
+		     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+		     attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
 		     only ? "ctime only" : "ignored");
 		if (only) {
 			/*
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 69c839316a7a..580644b04737 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2961,15 +2961,12 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
 		rec.v2.flock_len = (__force __le32)
 			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
 	} else {
-		struct timespec ts;
 		rec.v1.cap_id = cpu_to_le64(cap->cap_id);
 		rec.v1.wanted = cpu_to_le32(__ceph_caps_wanted(ci));
 		rec.v1.issued = cpu_to_le32(cap->issued);
 		rec.v1.size = cpu_to_le64(inode->i_size);
-		ts = timespec64_to_timespec(inode->i_mtime);
-		ceph_encode_timespec(&rec.v1.mtime, &ts);
-		ts = timespec64_to_timespec(inode->i_atime);
-		ceph_encode_timespec(&rec.v1.atime, &ts);
+		ceph_encode_timespec64(&rec.v1.mtime, &inode->i_mtime);
+		ceph_encode_timespec64(&rec.v1.atime, &inode->i_atime);
 		rec.v1.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v1.pathbase = cpu_to_le64(pathbase);
 	}
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index af81555c14fd..041c27ea8de1 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -594,9 +594,9 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 
 	BUG_ON(capsnap->writing);
 	capsnap->size = inode->i_size;
-	capsnap->mtime = timespec64_to_timespec(inode->i_mtime);
-	capsnap->atime = timespec64_to_timespec(inode->i_atime);
-	capsnap->ctime = timespec64_to_timespec(inode->i_ctime);
+	capsnap->mtime = inode->i_mtime;
+	capsnap->atime = inode->i_atime;
+	capsnap->ctime = inode->i_ctime;
 	capsnap->time_warp_seq = ci->i_time_warp_seq;
 	capsnap->truncate_size = ci->i_truncate_size;
 	capsnap->truncate_seq = ci->i_truncate_seq;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a7077a0c989f..d3eb70e2b527 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -193,7 +193,7 @@ struct ceph_cap_snap {
 	u64 xattr_version;
 
 	u64 size;
-	struct timespec mtime, atime, ctime;
+	struct timespec64 mtime, atime, ctime;
 	u64 time_warp_seq;
 	u64 truncate_size;
 	u32 truncate_seq;
@@ -307,7 +307,7 @@ struct ceph_inode_info {
 	char *i_symlink;
 
 	/* for dirs */
-	struct timespec i_rctime;
+	struct timespec64 i_rctime;
 	u64 i_rbytes, i_rfiles, i_rsubdirs;
 	u64 i_files, i_subdirs;
 
@@ -857,8 +857,9 @@ extern struct inode *ceph_get_snapdir(struct inode *parent);
 extern int ceph_fill_file_size(struct inode *inode, int issued,
 			       u32 truncate_seq, u64 truncate_size, u64 size);
 extern void ceph_fill_file_time(struct inode *inode, int issued,
-				u64 time_warp_seq, struct timespec *ctime,
-				struct timespec *mtime, struct timespec *atime);
+				u64 time_warp_seq, struct timespec64 *ctime,
+				struct timespec64 *mtime,
+				struct timespec64 *atime);
 extern int ceph_fill_trace(struct super_block *sb,
 			   struct ceph_mds_request *req);
 extern int ceph_readdir_prepopulate(struct ceph_mds_request *req,
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 5bc8edb4c2a6..5cc8b94f8206 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -224,8 +224,8 @@ static size_t ceph_vxattrcb_dir_rbytes(struct ceph_inode_info *ci, char *val,
 static size_t ceph_vxattrcb_dir_rctime(struct ceph_inode_info *ci, char *val,
 				       size_t size)
 {
-	return snprintf(val, size, "%ld.09%ld", (long)ci->i_rctime.tv_sec,
-			(long)ci->i_rctime.tv_nsec);
+	return snprintf(val, size, "%lld.09%ld", ci->i_rctime.tv_sec,
+			ci->i_rctime.tv_nsec);
 }
 
 /* quotas */
-- 
2.9.0
