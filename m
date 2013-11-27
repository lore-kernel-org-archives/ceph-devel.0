From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 12/18] client: Add inline fields to Inode
Date: Wed, 27 Nov 2013 21:40:51 +0800
Message-ID: <b7a2f9b079a33294d0222df48d8b681622eb2cfa.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48483 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab3K0NlY (ORCPT
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
 src/client/Inode.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/client/Inode.h b/src/client/Inode.h
index cc054a6..bb17706 100644
--- a/src/client/Inode.h
+++ b/src/client/Inode.h
@@ -111,6 +111,10 @@ class Inode {
   version_t version;           // auth only
   version_t xattr_version;
 
+  // inline data
+  uint64_t   inline_version;
+  bufferlist inline_data;
+
   bool is_symlink() const { return (mode & S_IFMT) == S_IFLNK; }
   bool is_dir()     const { return (mode & S_IFMT) == S_IFDIR; }
   bool is_file()    const { return (mode & S_IFMT) == S_IFREG; }
@@ -207,6 +211,7 @@ class Inode {
       rdev(0), mode(0), uid(0), gid(0), nlink(0),
       size(0), truncate_seq(1), truncate_size(-1),
       time_warp_seq(0), max_size(0), version(0), xattr_version(0),
+      inline_version(0),
       flags(0),
       dir_hashed(false), dir_replicated(false), auth_cap(NULL),
       dirty_caps(0), flushing_caps(0), flushing_cap_seq(0), shared_gen(0), cache_gen(0),
-- 
1.7.9.5

