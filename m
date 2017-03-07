From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH 1/1] EC backfill retries
Date: Tue, 07 Mar 2017 14:33:15 -0300
Message-ID: <ormvcx2dr8.fsf@lxoliva.fsfla.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:58079 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755020AbdCGSDI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Mar 2017 13:03:08 -0500
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id v27HXoMZ021110
        for <ceph-devel@vger.kernel.org>; Tue, 7 Mar 2017 17:33:51 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Having applied David Zafman's patch for 13937 and Kefu Chai's for 17857,
I still hit the problem described in issue 18162.  This mostly fixes it.
There are still remaining known problems:

- given config osd recovery max single start > 1, if the same 'single
start' involves retries that would require reading from different OSDs,
they may fail repeatedly, because we will, for some reason I couldn't
identify, perform all reads from the same set of OSDs.

- in some cases I couldn't narrow down, backfill will complete with
pending retries, and that will take up a backfill slot from the OSD
until it PG goes through peering.

Having said that, I think getting errors during EC backfill fixed up
rather than having the primary crash over and over is much improvement,
and since I don't envision having time to investigate the remaining
issues in the near future, I figured I'd post this patch anyway.


ReplicatedPG::failed_push: implement EC backfill retries

ECBackend::get_min_avail_to_read_shards: use only locations from the
missing_loc if there is any missing_loc set for the object.

ReplicatedPG::get_snapset_context: fix some misindented code.

ReplicatedPG::failed_push: create missing_loc if it's not there,
before clearing the failed location and clearing recovering.

ReplicatedPG::_clear_recovery_state: tolerate backfills_in_flight
without corresponding recovering entries without crashing: they're
pending retries.

ReplicatedPG::start_recovery_ops: if recovery ends with missing
replicas, log what they are.

ReplicatedPG::recover_replicas: do not reject retry-pending backfills.

ReplicatedPG::recover_backfill: don't trim backfill_info.objects past
pending retries.  Clean up unused sets of backfill_pos.  Detect
retries and be more verbose about them.

Fixes: http://tracker.ceph.com/issues/18162
Fixes: http://tracker.ceph.com/issues/13937
Fixes: http://tracker.ceph.com/issues/17857
Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/osd/ECBackend.cc    |   23 +++++++--
 src/osd/ReplicatedPG.cc |  114 ++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 108 insertions(+), 29 deletions(-)

diff --git a/src/osd/ECBackend.cc b/src/osd/ECBackend.cc
index e3eb1fd..27b31fe 100644
--- a/src/osd/ECBackend.cc
+++ b/src/osd/ECBackend.cc
@@ -1450,9 +1450,6 @@ int ECBackend::get_min_avail_to_read_shards(
   // Make sure we don't do redundant reads for recovery
   assert(!for_recovery || !do_redundant_reads);
 
-  map<hobject_t, set<pg_shard_t>, hobject_t::BitwiseComparator>::const_iterator miter =
-    get_parent()->get_missing_loc_shards().find(hoid);
-
   set<int> have;
   map<shard_id_t, pg_shard_t> shards;
 
@@ -1490,16 +1487,28 @@ int ECBackend::get_min_avail_to_read_shards(
       }
     }
 
-    if (miter != get_parent()->get_missing_loc_shards().end()) {
+    bool miter_first = true;
+    for (map<hobject_t, set<pg_shard_t>, hobject_t::BitwiseComparator>::const_iterator miter =
+	   get_parent()->get_missing_loc_shards().find(hoid);
+	 miter != get_parent()->get_missing_loc_shards().end();
+	 miter++) {
+      if (miter_first) {
+	dout(20) << __func__ << hoid
+		 << " has missing_loc, resetting have" << dendl;
+	miter_first = false;
+	have.clear();
+      }
+      dout(20) << __func__ << hoid
+	       << " presumed available at " << miter->second
+	       << dendl;
       for (set<pg_shard_t>::iterator i = miter->second.begin();
 	   i != miter->second.end();
 	   ++i) {
 	dout(10) << __func__ << ": checking missing_loc " << *i << dendl;
 	boost::optional<const pg_missing_t &> m =
 	  get_parent()->maybe_get_shard_missing(*i);
-	if (m) {
-	  assert(!(*m).is_missing(hoid));
-	}
+	if (m && (*m).is_missing(hoid))
+	  continue;
 	have.insert(i->shard);
 	shards.insert(make_pair(i->shard, *i));
       }
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 4c490a4..afed733 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -9334,8 +9334,8 @@ SnapSetContext *ReplicatedPG::get_snapset_context(
 	r = pgbackend->objects_get_attr(oid.get_head(), SS_ATTR, &bv);
       if (r < 0) {
 	// try _snapset
-      if (!(oid.is_snapdir() && !oid_existed))
-	r = pgbackend->objects_get_attr(oid.get_snapdir(), SS_ATTR, &bv);
+	if (!(oid.is_snapdir() && !oid_existed))
+	  r = pgbackend->objects_get_attr(oid.get_snapdir(), SS_ATTR, &bv);
 	if (r < 0 && !can_create)
 	  return NULL;
       }
@@ -9598,9 +9598,31 @@ void ReplicatedPG::failed_push(const list<pg_shard_t> &from, const hobject_t &so
     obc->drop_recovery_read(&blocked_ops);
     requeue_ops(blocked_ops);
   }
-  recovering.erase(soid);
-  for (list<pg_shard_t>::const_iterator i = from.begin(); i != from.end(); i++)
+  if (missing_loc.get_locations(soid).empty()) {
+    dout(20) << __func__ << ": " << soid
+	     << " had an empty location list, reconstructing" << dendl;
+    assert(!actingbackfill.empty());
+    for (set<pg_shard_t>::iterator i = actingbackfill.begin();
+	 i != actingbackfill.end(); ++i) {
+      pg_shard_t peer = *i;
+      if (!peer_missing[peer].is_missing(soid)) {
+	missing_loc.add_location(soid, peer);
+	dout(20) << __func__ << ": " << soid
+		 << " assumed to be available in " << peer << dendl;
+      }
+    }
+  }
+  for (list<pg_shard_t>::const_iterator i = from.begin();
+       i != from.end(); i++) {
+    dout(20) << __func__ << ": " << soid
+	     << " marked as not available in " << *i
+	     << dendl;
     missing_loc.remove_location(soid, *i);
+  }
+  /* If we were backfilling, we will retry the push from
+     recover_backfill, and its backfills_in_flight entry will only be
+     cleared when we succeed.  */
+  recovering.erase(soid);
   dout(0) << "_failed_push " << soid << " from shard " << from
 	  << ", reps on " << missing_loc.get_locations(soid)
 	  << " unfound? " << missing_loc.is_unfound(soid) << dendl;
@@ -10225,7 +10247,9 @@ void ReplicatedPG::_clear_recovery_state()
   last_backfill_started = hobject_t();
   set<hobject_t, hobject_t::Comparator>::iterator i = backfills_in_flight.begin();
   while (i != backfills_in_flight.end()) {
-    assert(recovering.count(*i));
+    if(!recovering.count(*i))
+      dout(10) << __func__ << ": " << *i
+	       << " is still pending backfill retry" << dendl;
     backfills_in_flight.erase(i++);
   }
 
@@ -10450,6 +10474,21 @@ bool ReplicatedPG::start_recovery_ops(
     // this shouldn't happen!
     // We already checked num_missing() so we must have missing replicas
     osd->clog->error() << info.pgid << " recovery ending with missing replicas\n";
+    set<pg_shard_t>::const_iterator end = actingbackfill.end();
+    set<pg_shard_t>::const_iterator a = actingbackfill.begin();
+    for (; a != end; ++a) {
+      if (*a == get_primary()) continue;
+      pg_shard_t peer = *a;
+      map<pg_shard_t, pg_missing_t>::const_iterator pm = peer_missing.find(peer);
+      if (pm == peer_missing.end()) {
+	continue;
+      }
+      if (pm->second.num_missing()) {
+	dout(10) << __func__ << " osd." << peer << " has "
+		 << pm->second.num_missing() << " missing: "
+		 << pm->second << dendl;
+      }
+    }
     return work_in_progress;
   }
 
@@ -10740,7 +10779,7 @@ int ReplicatedPG::recover_replicas(int max, ThreadPool::TPHandle &handle)
       const hobject_t soid(p->second);
 
       if (cmp(soid, pi->second.last_backfill, get_sort_bitwise()) > 0) {
-	if (!recovering.count(soid)) {
+	if (!recovering.count(soid) && !backfills_in_flight.count(soid)) {
 	  derr << __func__ << ": object added to missing set for backfill, but "
 	       << "is not in recovering, error!" << dendl;
 	  assert(0);
@@ -10908,6 +10947,29 @@ int ReplicatedPG::recover_backfill(
 	   << dendl;
   }
 
+  bool trim = true;
+  bool retrying = !backfills_in_flight.empty();
+  if (retrying) {
+    /* If we had any errors, arrange for us to retain the information
+       about the range before the first failed object, and to retry
+       it.  */
+    map<hobject_t,eversion_t,hobject_t::Comparator>::iterator p;
+    p = backfill_info.objects.find(*backfills_in_flight.begin());
+    if (p-- == backfill_info.objects.end() ||
+	p == backfill_info.objects.end()) {
+      last_backfill_started = *backfills_in_flight.begin();
+      trim = false;
+      dout(20) << "backfill retry: adjusting last_backfill_started to "
+	       << last_backfill_started
+	       << " and disabling trimming" << dendl;
+    } else {
+      last_backfill_started = MIN_HOBJ(last_backfill_started, p->first,
+				       get_sort_bitwise());
+      dout(20) << "backfill retry: adjusting last_backfill_started to "
+	       << last_backfill_started << dendl;
+    }
+  }
+
   // update our local interval to cope with recent changes
   backfill_info.begin = last_backfill_started;
   update_range(&backfill_info, handle);
@@ -10918,18 +10980,19 @@ int ReplicatedPG::recover_backfill(
   vector<boost::tuple<hobject_t, eversion_t, pg_shard_t> > to_remove;
   set<hobject_t, hobject_t::BitwiseComparator> add_to_stat;
 
-  for (set<pg_shard_t>::iterator i = backfill_targets.begin();
-       i != backfill_targets.end();
-       ++i) {
-    peer_backfill_info[*i].trim_to(
-      MAX_HOBJ(peer_info[*i].last_backfill, last_backfill_started,
-	       get_sort_bitwise()));
+  if (trim) {
+    dout(20) << "trimming backfill interval up to "
+	     << last_backfill_started << dendl;
+    for (set<pg_shard_t>::iterator i = backfill_targets.begin();
+         i != backfill_targets.end();
+	 ++i) {
+      peer_backfill_info[*i].trim_to(
+        MAX_HOBJ(peer_info[*i].last_backfill, last_backfill_started,
+		 get_sort_bitwise()));
+    }
+    backfill_info.trim_to(last_backfill_started);
   }
-  backfill_info.trim_to(last_backfill_started);
 
-  hobject_t backfill_pos = MIN_HOBJ(backfill_info.begin,
-				    earliest_peer_backfill(),
-				    get_sort_bitwise());
   while (ops < max) {
     if (cmp(backfill_info.begin, earliest_peer_backfill(),
 	    get_sort_bitwise()) <= 0 &&
@@ -10939,9 +11002,8 @@ int ReplicatedPG::recover_backfill(
       backfill_info.end = hobject_t::get_max();
       update_range(&backfill_info, handle);
       backfill_info.trim();
+      dout(20) << "resetting and trimming backfill interval" << dendl;
     }
-    backfill_pos = MIN_HOBJ(backfill_info.begin, earliest_peer_backfill(),
-			    get_sort_bitwise());
 
     dout(20) << "   my backfill interval " << backfill_info << dendl;
 
@@ -10983,9 +11045,7 @@ int ReplicatedPG::recover_backfill(
     // Get object within set of peers to operate on and
     // the set of targets for which that object applies.
     hobject_t check = earliest_peer_backfill();
-
     if (cmp(check, backfill_info.begin, get_sort_bitwise()) < 0) {
-
       set<pg_shard_t> check_targets;
       for (set<pg_shard_t>::iterator i = backfill_targets.begin();
 	   i != backfill_targets.end();
@@ -11071,6 +11131,11 @@ int ReplicatedPG::recover_backfill(
 	  to_push.push_back(
 	    boost::tuple<hobject_t, eversion_t, ObjectContextRef, vector<pg_shard_t> >
 	    (backfill_info.begin, obj_v, obc, all_push));
+	  if (retrying && backfills_in_flight.count(backfill_info.begin))
+	    dout(20) << " BACKFILL retrying " << backfill_info.begin
+		     << " with locations "
+		     << missing_loc.get_locations(backfill_info.begin)
+		     << dendl;
 	  // Count all simultaneous pushes of the same object as a single op
 	  ops++;
 	} else {
@@ -11100,8 +11165,9 @@ int ReplicatedPG::recover_backfill(
       }
     }
   }
-  backfill_pos = MIN_HOBJ(backfill_info.begin, earliest_peer_backfill(),
-			  get_sort_bitwise());
+  hobject_t backfill_pos = MIN_HOBJ(backfill_info.begin,
+				    earliest_peer_backfill(),
+				    get_sort_bitwise());
 
   for (set<hobject_t, hobject_t::BitwiseComparator>::iterator i = add_to_stat.begin();
        i != add_to_stat.end();
@@ -11124,6 +11190,10 @@ int ReplicatedPG::recover_backfill(
   PGBackend::RecoveryHandle *h = pgbackend->open_recovery_op();
   for (unsigned i = 0; i < to_push.size(); ++i) {
     handle.reset_tp_timeout();
+    if (retrying && backfills_in_flight.count(to_push[i].get<0>()))
+      dout(0) << "retrying backfill of " << to_push[i].get<0>()
+	      << " with locations "
+	      << missing_loc.get_locations(to_push[i].get<0>()) << dendl;
     prep_backfill_object_push(to_push[i].get<0>(), to_push[i].get<1>(),
 	    to_push[i].get<2>(), to_push[i].get<3>(), h);
   }


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
