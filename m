From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 11/18] mds: Receive updated inline data from client
Date: Wed, 27 Nov 2013 21:40:50 +0800
Message-ID: <ae958eb56f5b87cc9a242c8c2f9b1f273d385820.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48482 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab3K0NlY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:24 -0500
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/mds/Locker.cc |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 63e0e08..4b02a56 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2691,6 +2691,7 @@ void Locker::_update_cap_fields(CInode *in, int dirty, MClientCaps *m, inode_t *
     utime_t mtime = m->get_mtime();
     utime_t ctime = m->get_ctime();
     uint64_t size = m->get_size();
+    uint64_t inline_version = m->inline_version;
     
     if (((dirty & CEPH_CAP_FILE_WR) && mtime > pi->mtime) ||
 	((dirty & CEPH_CAP_FILE_EXCL) && mtime != pi->mtime)) {
@@ -2710,6 +2711,12 @@ void Locker::_update_cap_fields(CInode *in, int dirty, MClientCaps *m, inode_t *
       pi->size = size;
       pi->rstat.rbytes = size;
     }
+    if (in->inode.is_file() &&
+        (dirty & CEPH_CAP_FILE_WR) &&
+        inline_version > pi->inline_version) {
+      pi->inline_version = inline_version;
+      pi->inline_data = m->inline_data;
+    }
     if ((dirty & CEPH_CAP_FILE_EXCL) && atime != pi->atime) {
       dout(7) << "  atime " << pi->atime << " -> " << atime
 	      << " for " << *in << dendl;
-- 
1.7.9.5

