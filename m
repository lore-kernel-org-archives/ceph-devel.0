From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] osd: speedup startup by finishing pending removals in background
Date: Mon, 19 May 2014 08:32:43 -0300
Message-ID: <or61l2xauc.fsf@free.home>
References: <oregzrxn56.fsf@free.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:48132 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbaESLdq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 May 2014 07:33:46 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s4JBXher009199
	for <ceph-devel@vger.kernel.org>; Mon, 19 May 2014 11:33:44 GMT
In-Reply-To: <oregzrxn56.fsf@free.home> (Alexandre Oliva's message of "Sun, 18
	May 2014 09:54:45 -0300")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On May 18, 2014, Alexandre Oliva <oliva@gnu.org> wrote:

> In hindsight, I suppose it might have been wiser to add a data member to
> DeletingStateRef to hold the coll_t, instead of having to search for it
> again, but this patch is what I tested, and it's likely good enough for
> now.

I've now implemented this, and verified that it works.

I've also arranged for attempts to resurrect a pending removal from an
earlier session to be delayed rather than to cause an abort.  I haven't
tested this scenario, though; it might be the case that the osd would
timeout and suicide or somesuch.

---

When PG removals are underway and the OSD is restarted, or when
multiple removals are scheduled manually with ceph_filestore_dump
premove, the OSD may take a long time to process all pending removals
before it will join the cluster.

This patch introduces an option that enables the OSD to join the
cluster first, performing the removals in background while actively
participating in the cluster, as the OSD would if it hadn't been
restarted.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/common/config_opts.h |   10 +++++++++
 src/osd/OSD.cc           |   52 +++++++++++++++++++++++++++++++++++++++++++---
 src/osd/OSD.h            |   17 +++++++++++++--
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index 2c65e6c..9baa356 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -583,6 +583,16 @@ OPTION(osd_client_op_priority, OPT_U32, 63)
 OPTION(osd_recovery_op_priority, OPT_U32, 10)
 OPTION(osd_recovery_op_warn_multiple, OPT_U32, 16)
 
+// Removal of PGs is done in background, but if the osd is restarted,
+// it will finish all pending removals before joining the cluster.
+// This can take a while.  If this option is set to true, then pending
+// removals will be performed in background, while the osd runs
+// normally.  This is a bit dangerous if the OSD gets a new copy of
+// the PG before the pending removal is completed: attributes stored
+// in the leveldb may be lost when removal cleans up an object's
+// attributes AFTER the new object is backfilled.
+OPTION(osd_startup_finish_remove_in_background, OPT_BOOL, false)
+
 // Max time to wait between notifying mon of shutdown and shutting down
 OPTION(osd_mon_shutdown_timeout, OPT_DOUBLE, 5)
 
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 504cb71..a1e3b6f 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -2048,6 +2048,8 @@ void OSD::load_pgs()
 
   set<spg_t> head_pgs;
   map<spg_t, interval_set<snapid_t> > pgs;
+  typedef map<uint64_t, pair<spg_t, coll_t> > bgremove_t;
+  bgremove_t *bgremove = NULL;
   bool flush = false;
   for (vector<coll_t>::iterator it = ls.begin();
        it != ls.end();
@@ -2056,14 +2058,30 @@ void OSD::load_pgs()
     snapid_t snap;
     uint64_t seq;
 
-    if (it->is_temp(pgid) ||
-	it->is_removal(&seq, &pgid)) {
-      dout(10) << "load_pgs " << *it << " clearing temp" << dendl;
+    if (it->is_temp(pgid)) {
+      dout(10) << "load_pgs " << *it << " clearing temp " << dendl;
       recursive_remove_collection(store, *it, false);
       flush = true;
       continue;
     }
 
+    if (it->is_removal(&seq, &pgid)) {
+      if (cct->_conf->osd_startup_finish_remove_in_background) {
+	dout(10) << "load_pgs " << *it
+		 << " delaying pending removal" << dendl;
+	if (seq >= next_removal_seq)
+	  next_removal_seq = seq + 1;
+	if (!bgremove)
+	  bgremove = new bgremove_t();
+	(*bgremove)[seq] = make_pair(pgid, *it);
+      } else {
+	dout(10) << "load_pgs " << *it << " clearing pending removal " << dendl;
+	recursive_remove_collection(store, *it, false);
+	flush = true;
+      }
+      continue;
+    }
+
     if (it->is_pg(pgid, snap)) {
       if (snap != CEPH_NOSNAP) {
 	dout(10) << "load_pgs skipping snapped dir " << *it
@@ -2081,6 +2099,18 @@ void OSD::load_pgs()
   if (flush)
     store->sync_and_flush();
 
+  if (bgremove) {
+    for (bgremove_t::iterator it = bgremove->begin();
+	 it != bgremove->end(); it++) {
+      dout(10) << "load_pgs FORREMOVAL_" << it->first << "_" << it->second
+	       << " scheduling background removal " << dendl;
+      DeletingStateRef deleting = service.deleting_pgs.lookup_or_create
+	(it->second.first, make_pair(it->second.first, it->second.second));
+      remove_wq.queue(make_pair(PGRef(0), deleting));
+    }
+    delete bgremove;
+  }
+
   bool has_upgraded = false;
   for (map<spg_t, interval_set<snapid_t> >::iterator i = pgs.begin();
        i != pgs.end();
@@ -3519,6 +3549,22 @@ void OSD::RemoveWQ::_process(
   pair<PGRef, DeletingStateRef> item,
   ThreadPool::TPHandle &handle)
 {
+  if (!item.second->resurrectable_p()) {
+    // this is for background live removal of pending FORREMOVAL pgs,
+    // remaining from earlier OSD sessions.  This only happens if
+    // osd_startup_finish_remove_in_background is enabled.
+    if (!item.second->start_clearing())
+      return;
+
+    if (!item.second->start_deleting())
+      return;
+
+    recursive_remove_collection(store, item.second->get_coll (), false);
+
+    item.second->finish_deleting();
+    return;
+  }
+
   PGRef pg(item.first);
   SnapMapper &mapper = pg->snap_mapper;
   OSDriver &driver = pg->osdriver;
diff --git a/src/osd/OSD.h b/src/osd/OSD.h
index f599e43..e81fbe2b 100644
--- a/src/osd/OSD.h
+++ b/src/osd/OSD.h
@@ -217,9 +217,21 @@ class DeletingState {
 public:
   const spg_t pgid;
   const PGRef old_pg_state;
+  const coll_t old_coll; // iff old_pg_state is NULL
   DeletingState(const pair<spg_t, PGRef> &in) :
     lock("DeletingState::lock"), status(QUEUED), stop_deleting(false),
-    pgid(in.first), old_pg_state(in.second) {}
+    pgid(in.first), old_pg_state(in.second), old_coll() {}
+  DeletingState(const pair<spg_t, coll_t> &in) :
+    lock("DeletingState::lock"), status(QUEUED), stop_deleting(false),
+    pgid(in.first), old_pg_state(NULL), old_coll(in.second) {}
+
+  bool resurrectable_p() const {
+    return !!old_pg_state;
+  }
+  coll_t get_coll() const {
+    assert(!resurrectable_p());
+    return old_coll;
+  }
 
   /// transition status to clearing
   bool start_clearing() {
@@ -286,7 +298,8 @@ public:
   /// try to halt the deletion
   bool try_stop_deletion() {
     Mutex::Locker l(lock);
-    stop_deleting = true;
+    if (resurrectable_p())
+      stop_deleting = true;
     /**
      * If we are in DELETING_DIR or CLEARING_DIR, there are in progress
      * operations we have to wait for before continuing on.  States


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
