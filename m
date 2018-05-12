From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 3/6] ceph: make inode time prints to be long long
Date: Fri, 11 May 2018 21:59:18 -0700
Message-ID: <20180512045921.18311-4-deepa.kernel@gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180512045921.18311-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk, tglx@linutronix.de
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, zyan@redhat.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Subsequent patches in the series convert inode timestamps
to use struct timespec64 instead of struct timespec as
part of solving the y2038 problem.

Convert these print formats to use long long types to
avoid warnings and errors on conversion.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: zyan@redhat.com
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/inode.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index ae056927080d..676065a1ea62 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -671,18 +671,18 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		      CEPH_CAP_XATTR_EXCL)) {
 		if (ci->i_version == 0 ||
 		    timespec_compare(ctime, &inode->i_ctime) > 0) {
-			dout("ctime %ld.%09ld -> %ld.%09ld inc w/ cap\n",
-			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
-			     ctime->tv_sec, ctime->tv_nsec);
+			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
+			     (long long)inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+			     (long long)ctime->tv_sec, ctime->tv_nsec);
 			inode->i_ctime = *ctime;
 		}
 		if (ci->i_version == 0 ||
 		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
 			/* the MDS did a utimes() */
-			dout("mtime %ld.%09ld -> %ld.%09ld "
+			dout("mtime %lld.%09ld -> %lld.%09ld "
 			     "tw %d -> %d\n",
-			     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
-			     mtime->tv_sec, mtime->tv_nsec,
+			     (long long)inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+			     (long long)mtime->tv_sec, mtime->tv_nsec,
 			     ci->i_time_warp_seq, (int)time_warp_seq);
 
 			inode->i_mtime = *mtime;
@@ -691,17 +691,17 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		} else if (time_warp_seq == ci->i_time_warp_seq) {
 			/* nobody did utimes(); take the max */
 			if (timespec_compare(mtime, &inode->i_mtime) > 0) {
-				dout("mtime %ld.%09ld -> %ld.%09ld inc\n",
-				     inode->i_mtime.tv_sec,
+				dout("mtime %lld.%09ld -> %lld.%09ld inc\n",
+				     (long long)inode->i_mtime.tv_sec,
 				     inode->i_mtime.tv_nsec,
-				     mtime->tv_sec, mtime->tv_nsec);
+				     (long long)mtime->tv_sec, mtime->tv_nsec);
 				inode->i_mtime = *mtime;
 			}
 			if (timespec_compare(atime, &inode->i_atime) > 0) {
-				dout("atime %ld.%09ld -> %ld.%09ld inc\n",
-				     inode->i_atime.tv_sec,
+				dout("atime %lld.%09ld -> %lld.%09ld inc\n",
+				     (long long)inode->i_atime.tv_sec,
 				     inode->i_atime.tv_nsec,
-				     atime->tv_sec, atime->tv_nsec);
+				     (long long)atime->tv_sec, atime->tv_nsec);
 				inode->i_atime = *atime;
 			}
 		} else if (issued & CEPH_CAP_FILE_EXCL) {
@@ -2015,9 +2015,9 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	}
 
 	if (ia_valid & ATTR_ATIME) {
-		dout("setattr %p atime %ld.%ld -> %ld.%ld\n", inode,
-		     inode->i_atime.tv_sec, inode->i_atime.tv_nsec,
-		     attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
+		dout("setattr %p atime %lld.%ld -> %lld.%ld\n", inode,
+		     (long long)inode->i_atime.tv_sec, inode->i_atime.tv_nsec,
+		     (long long)attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
 			inode->i_atime = attr->ia_atime;
@@ -2037,9 +2037,9 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		}
 	}
 	if (ia_valid & ATTR_MTIME) {
-		dout("setattr %p mtime %ld.%ld -> %ld.%ld\n", inode,
-		     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
-		     attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
+		dout("setattr %p mtime %lld.%ld -> %lld.%ld\n", inode,
+		     (long long)inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+		     (long long)attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
 			inode->i_mtime = attr->ia_mtime;
@@ -2082,9 +2082,9 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	if (ia_valid & ATTR_CTIME) {
 		bool only = (ia_valid & (ATTR_SIZE|ATTR_MTIME|ATTR_ATIME|
 					 ATTR_MODE|ATTR_UID|ATTR_GID)) == 0;
-		dout("setattr %p ctime %ld.%ld -> %ld.%ld (%s)\n", inode,
-		     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
-		     attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
+		dout("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n", inode,
+		     (long long)inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+		     (long long)attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
 		     only ? "ctime only" : "ignored");
 		if (only) {
 			/*
-- 
2.17.0
