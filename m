From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 14/30] mds: export CInode:mds_caps_wanted
Date: Mon, 27 May 2013 10:12:11 +0800
Message-ID: <51A2C0FB.5050601@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <1369296418-14871-15-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1305231103500.32642@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6941 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755779Ab3E0CMM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 May 2013 22:12:12 -0400
In-Reply-To: <alpine.DEB.2.00.1305231103500.32642@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com

updated version
---
From 2ff69c453d24404f3b4215cdd977d6fabcd5ea9b Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Mon, 6 May 2013 09:06:52 +0800
Subject: [PATCH 14/33] mds: export CInode:mds_caps_wanted

CInode:mds_caps_wanted is used to keep track of caps wanted by non-auth
MDS. The auth MDS checks it when choosing locks' states.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.h    | 4 ++--
 src/mds/Migrator.cc | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index 47973c2..727e18c 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -369,7 +369,7 @@ public:
 protected:
   // file capabilities
   map<client_t, Capability*> client_caps;         // client -> caps
-  map<int, int>         mds_caps_wanted;     // [auth] mds -> caps wanted
+  map<int32_t, int32_t>      mds_caps_wanted;     // [auth] mds -> caps wanted
   int                   replica_caps_wanted; // [replica] what i've requested from auth
 
   map<int, set<client_t> > client_snap_caps;     // [auth] [snap] dirty metadata we still need from the head
@@ -709,7 +709,7 @@ public:
   bool is_any_caps() { return !client_caps.empty(); }
   bool is_any_nonstale_caps() { return count_nonstale_caps(); }
 
-  map<int,int>& get_mds_caps_wanted() { return mds_caps_wanted; }
+  map<int32_t,int32_t>& get_mds_caps_wanted() { return mds_caps_wanted; }
 
   map<client_t,Capability*>& get_client_caps() { return client_caps; }
   Capability *get_client_cap(client_t client) {
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

