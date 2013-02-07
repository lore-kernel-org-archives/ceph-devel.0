From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 01/15] kv_flat_btree_async.cc: use vector instead of VLA's
Date: Thu,  7 Feb 2013 20:41:49 +0100
Message-ID: <1360266123-28972-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33794 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932196Ab3BGTmJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 14:42:09 -0500
In-Reply-To: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix "variable length array of non-POD element type" errors caused by
using librados::ObjectWriteOperation VLAs. (-Wvla)

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/key_value_store/kv_flat_btree_async.cc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/key_value_store/kv_flat_btree_async.cc b/src/key_value_store/kv_flat_btree_async.cc
index 96c6cb0..4342e70 100644
--- a/src/key_value_store/kv_flat_btree_async.cc
+++ b/src/key_value_store/kv_flat_btree_async.cc
@@ -1119,9 +1119,9 @@ int KvFlatBtreeAsync::cleanup(const index_data &idata, const int &errno) {
     //all changes were created except for updating the index and possibly
     //deleting the objects. roll forward.
     vector<pair<pair<int, string>, librados::ObjectWriteOperation*> > ops;
-    librados::ObjectWriteOperation owos[idata.to_delete.size() + 1];
+    vector<librados::ObjectWriteOperation*> owos(idata.to_delete.size() + 1);
     for (int i = 0; i <= (int)idata.to_delete.size(); ++i) {
-      ops.push_back(make_pair(pair<int, string>(0, ""), &owos[i]));
+      ops.push_back(make_pair(pair<int, string>(0, ""), owos[i]));
     }
     set_up_ops(vector<object_data>(),
 	vector<object_data>(), &ops, idata, &err);
@@ -1883,23 +1883,23 @@ int KvFlatBtreeAsync::set_many(const map<string, bufferlist> &in_map) {
   to_create[to_create.size() - 1].max_kdata =
       to_delete[to_delete.size() - 1].max_kdata;
 
-  librados::ObjectWriteOperation owos[2 + 2 * to_delete.size()
-                                      + to_create.size()];
+  vector<librados::ObjectWriteOperation*> owos(2 + 2 * to_delete.size()
+                                      + to_create.size());
   vector<pair<pair<int, string>, librados::ObjectWriteOperation*> > ops;
 
 
   index_data idata;
-  set_up_prefix_index(to_create, to_delete, &owos[0], &idata, &err);
+  set_up_prefix_index(to_create, to_delete, owos[0], &idata, &err);
 
   if (verbose) cout << "finished making to_create and to_delete. "
       << std::endl;
 
   ops.push_back(make_pair(
       pair<int, string>(ADD_PREFIX, index_name),
-      &owos[0]));
+      owos[0]));
   for (int i = 1; i < 2 + 2 * (int)to_delete.size() + (int)to_create.size();
       i++) {
-    ops.push_back(make_pair(make_pair(0,""), &owos[i]));
+    ops.push_back(make_pair(make_pair(0,""), owos[i]));
   }
 
   set_up_ops(to_create, to_delete, &ops, idata, &err);
-- 
1.8.1.2

