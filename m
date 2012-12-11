From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 14/14] mds: compare sessionmap version before replaying imported sessions
Date: Tue, 11 Dec 2012 16:31:00 +0800
Message-ID: <1355214660-26354-15-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16602 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562Ab2LKIbS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:18 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Otherwise we may wrongly increase mds->sessionmap.version, which
will confuse future journal replays that involving sessionmap.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc        |  2 ++
 src/mds/events/EUpdate.h |  8 ++++++--
 src/mds/journal.cc       | 24 +++++++++++++++++-------
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 60d3793..2b0f22f 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5441,6 +5441,8 @@ void Server::handle_client_rename(MDRequest *mdr)
   }
   
   _rename_prepare(mdr, &le->metablob, &le->client_map, srcdn, destdn, straydn);
+  if (le->client_map.length())
+    le->cmapv = mds->sessionmap.projected;
 
   // -- commit locally --
   C_MDS_rename_finish *fin = new C_MDS_rename_finish(mds, mdr, srcdn, destdn, straydn);
diff --git a/src/mds/events/EUpdate.h b/src/mds/events/EUpdate.h
index 6ce18fe..a302a5a 100644
--- a/src/mds/events/EUpdate.h
+++ b/src/mds/events/EUpdate.h
@@ -23,13 +23,14 @@ public:
   EMetaBlob metablob;
   string type;
   bufferlist client_map;
+  version_t cmapv;
   metareqid_t reqid;
   bool had_slaves;
 
   EUpdate() : LogEvent(EVENT_UPDATE) { }
   EUpdate(MDLog *mdlog, const char *s) : 
     LogEvent(EVENT_UPDATE), metablob(mdlog),
-    type(s), had_slaves(false) { }
+    type(s), cmapv(0), had_slaves(false) { }
   
   void print(ostream& out) {
     if (type.length())
@@ -38,12 +39,13 @@ public:
   }
 
   void encode(bufferlist &bl) const {
-    __u8 struct_v = 2;
+    __u8 struct_v = 3;
     ::encode(struct_v, bl);
     ::encode(stamp, bl);
     ::encode(type, bl);
     ::encode(metablob, bl);
     ::encode(client_map, bl);
+    ::encode(cmapv, bl);
     ::encode(reqid, bl);
     ::encode(had_slaves, bl);
   } 
@@ -55,6 +57,8 @@ public:
     ::decode(type, bl);
     ::decode(metablob, bl);
     ::decode(client_map, bl);
+    if (struct_v >= 3)
+      ::decode(cmapv, bl);
     ::decode(reqid, bl);
     ::decode(had_slaves, bl);
   }
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index 46adbf2..b25096c 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -996,14 +996,24 @@ void EUpdate::replay(MDS *mds)
     mds->mdcache->add_uncommitted_master(reqid, _segment, slaves);
   }
   
-  // open client sessions?
-  map<client_t,entity_inst_t> cm;
-  map<client_t, uint64_t> seqm;
   if (client_map.length()) {
-    bufferlist::iterator blp = client_map.begin();
-    ::decode(cm, blp);
-    mds->server->prepare_force_open_sessions(cm, seqm);
-    mds->server->finish_force_open_sessions(cm, seqm);
+    if (mds->sessionmap.version >= cmapv) {
+      dout(10) << "EUpdate.replay sessionmap v " << cmapv
+	       << " <= table " << mds->sessionmap.version << dendl;
+    } else {
+      dout(10) << "EUpdate.replay sessionmap " << mds->sessionmap.version
+	       << " < " << cmapv << dendl;
+      // open client sessions?
+      map<client_t,entity_inst_t> cm;
+      map<client_t, uint64_t> seqm;
+      bufferlist::iterator blp = client_map.begin();
+      ::decode(cm, blp);
+      mds->server->prepare_force_open_sessions(cm, seqm);
+      mds->server->finish_force_open_sessions(cm, seqm);
+
+      assert(mds->sessionmap.version = cmapv);
+      mds->sessionmap.projected = mds->sessionmap.version;
+    }
   }
 }
 
-- 
1.7.11.7

