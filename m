From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] osd: avoid flushing every TEMP removal to speedup startup
Date: Sun, 18 May 2014 09:47:59 -0300
Message-ID: <oriop3xngg.fsf@free.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:45690 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaERM7s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 May 2014 08:59:48 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s4IConuo030195
	for <ceph-devel@vger.kernel.org>; Sun, 18 May 2014 12:50:50 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When a btrfs OSD suicides because it couldn't keep up with others
(recovery included), it is often the case that the filesystem is in a
state in which creating and removing snapshots takes a long time.  It
is likely that there are going to be plenty of recovering PGs (with
corresponding TEMP directories), and we will create and remove a btrfs
snapshot for every such directory we remove at startup.  This is very
wasteful: there's no reason to not pile up as many removals as
possible before syncing and flushing the removal so as to force a
btrfs snapshot.

This patch introduces an optional argument to the function used to
remove PGs to control whether or not to perform the final flush.  The
flush still happens if the call does not pass that argument, but with
the patch, the startup removals skip the per-PG flush, and run a
single flush at the end.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/osd/OSD.cc |   12 +++++++++---
 src/osd/OSD.h  |    3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 4240ba8..504cb71 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -1774,7 +1774,8 @@ int OSD::read_superblock()
 
 
 
-void OSD::recursive_remove_collection(ObjectStore *store, coll_t tmp)
+void OSD::recursive_remove_collection(ObjectStore *store, coll_t tmp,
+				      bool flush)
 {
   OSDriver driver(
     store,
@@ -1810,7 +1811,8 @@ void OSD::recursive_remove_collection(ObjectStore *store, coll_t tmp)
   t.remove_collection(tmp);
   int r = store->apply_transaction(t);
   assert(r == 0);
-  store->sync_and_flush();
+  if (flush)
+    store->sync_and_flush();
 }
 
 
@@ -2046,6 +2048,7 @@ void OSD::load_pgs()
 
   set<spg_t> head_pgs;
   map<spg_t, interval_set<snapid_t> > pgs;
+  bool flush = false;
   for (vector<coll_t>::iterator it = ls.begin();
        it != ls.end();
        ++it) {
@@ -2056,7 +2059,8 @@ void OSD::load_pgs()
     if (it->is_temp(pgid) ||
 	it->is_removal(&seq, &pgid)) {
       dout(10) << "load_pgs " << *it << " clearing temp" << dendl;
-      recursive_remove_collection(store, *it);
+      recursive_remove_collection(store, *it, false);
+      flush = true;
       continue;
     }
 
@@ -2074,6 +2078,8 @@ void OSD::load_pgs()
 
     dout(10) << "load_pgs ignoring unrecognized " << *it << dendl;
   }
+  if (flush)
+    store->sync_and_flush();
 
   bool has_upgraded = false;
   for (map<spg_t, interval_set<snapid_t> >::iterator i = pgs.begin();
diff --git a/src/osd/OSD.h b/src/osd/OSD.h
index ce8b74c..f599e43 100644
--- a/src/osd/OSD.h
+++ b/src/osd/OSD.h
@@ -870,7 +870,8 @@ public:
     hobject_t oid(sobject_t("infos", CEPH_NOSNAP));
     return oid;
   }
-  static void recursive_remove_collection(ObjectStore *store, coll_t tmp);
+  static void recursive_remove_collection(ObjectStore *store, coll_t tmp,
+					  bool flush = true);
 
   /**
    * get_osd_initial_compat_set()

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
