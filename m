From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] mds: sort dentries in CDdir in the same order as the tmap
Date: Fri, 23 Nov 2012 16:06:39 +0800
Message-ID: <1353657999-14182-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58090 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964804Ab2KWIGm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 23 Nov 2012 03:06:42 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

CDir::_commit_partial() uses tmap update operation to write dirty
dentries to object store. tmap update requires that tmap command
keys are provides in ascending order. But the code compares
dentry_key_t and tmap key in different ways and may get different
results. For example:

  dentry_key_t "f1" > dentry_key_t "f"
  string "f1_head" < string "f_head"

The fix is comparing CDentries in the same way as comparing the
tmap keys.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/mdstypes.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
index 22e754e..dcd23f3 100644
--- a/src/mds/mdstypes.h
+++ b/src/mds/mdstypes.h
@@ -709,12 +709,17 @@ inline ostream& operator<<(ostream& out, const dentry_key_t &k)
 
 inline bool operator<(const dentry_key_t& k1, const dentry_key_t& k2)
 {
-  /*
-   * order by name, then snap
-   */
-  int c = strcmp(k1.name, k2.name);
-  return 
-    c < 0 || (c == 0 && k1.snapid < k2.snapid);
+  bufferlist bl;
+  k1.encode(bl);
+  k2.encode(bl);
+
+  string str1;
+  string str2;
+  bufferlist::iterator ip = bl.begin();
+  ::decode(str1, ip);
+  ::decode(str2, ip);
+
+  return str1 < str2;
 }
 
 
-- 
1.7.11.7

