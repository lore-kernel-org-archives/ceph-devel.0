From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 03/18] mds: Add inline fields to inode_t
Date: Wed, 27 Nov 2013 21:40:42 +0800
Message-ID: <b919cfa2ecde2fc1552d7b725b2dc2fd9d063908.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48411 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab3K0NlV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:21 -0500
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
 src/mds/mdstypes.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
index bd53c85..aacc41c 100644
--- a/src/mds/mdstypes.h
+++ b/src/mds/mdstypes.h
@@ -336,6 +336,8 @@ struct inode_t {
   utime_t    mtime;   // file data modify time.
   utime_t    atime;   // file data access time.
   uint32_t   time_warp_seq;  // count of (potential) mtime/atime timewarps (i.e., utimes())
+  bufferlist inline_data;
+  uint64_t   inline_version;
 
   map<client_t,client_writeable_range_t> client_ranges;  // client(s) can write to these ranges
 
@@ -358,6 +360,7 @@ struct inode_t {
 	      truncate_seq(0), truncate_size(0), truncate_from(0),
 	      truncate_pending(0),
 	      time_warp_seq(0),
+	      inline_version(1),
 	      version(0), file_data_version(0), xattr_version(0), backtrace_version(0) {
     clear_layout();
     memset(&dir_layout, 0, sizeof(dir_layout));
-- 
1.7.9.5

