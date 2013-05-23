From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 14/30] mds: export CInode:mds_caps_wanted
Date: Thu, 23 May 2013 16:06:42 +0800
Message-ID: <1369296418-14871-15-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51287 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390Ab3EWINM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:12 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

CInode:mds_caps_wanted is used to keep track of caps wanted by non-auth
MDS. The auth MDS checks it when choosing locks' states.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 5cc26a3..766ecf9 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -1025,6 +1025,7 @@ void Migrator::encode_export_inode_caps(CInode *in, bufferlist& bl,
   map<client_t,Capability::Export> cap_map;
   in->export_client_caps(cap_map);
   ::encode(cap_map, bl);
+  ::encode(in->get_mds_caps_wanted(), bl);
 
   in->state_set(CInode::STATE_EXPORTINGCAPS);
   in->get(CInode::PIN_EXPORTINGCAPS);
@@ -2379,7 +2380,8 @@ void Migrator::decode_import_inode_caps(CInode *in,
 {
   map<client_t,Capability::Export> cap_map;
   ::decode(cap_map, blp);
-  if (!cap_map.empty()) {
+  ::decode(in->get_mds_caps_wanted(), blp);
+  if (!cap_map.empty() || !in->get_mds_caps_wanted().empty()) {
     cap_imports[in].swap(cap_map);
     in->get(CInode::PIN_IMPORTINGCAPS);
   }
@@ -2388,8 +2390,6 @@ void Migrator::decode_import_inode_caps(CInode *in,
 void Migrator::finish_import_inode_caps(CInode *in, int from, 
 					map<client_t,Capability::Export> &cap_map)
 {
-  assert(!cap_map.empty());
-  
   for (map<client_t,Capability::Export>::iterator it = cap_map.begin();
        it != cap_map.end();
        ++it) {
@@ -2406,6 +2406,7 @@ void Migrator::finish_import_inode_caps(CInode *in, int from,
     mds->mdcache->do_cap_import(session, in, cap);
   }
 
+  in->replica_caps_wanted = 0;
   in->put(CInode::PIN_IMPORTINGCAPS);
 }
 
-- 
1.8.1.4

