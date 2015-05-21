From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 3/5] Osd: add a temperature based object eviction policy for cache tiering
Date: Thu, 21 May 2015 21:34:08 +0800
Message-ID: <385339e04bb5fedc4758c67d5547730d61362586.1432214851.git.liwang@ubuntukylin.com>
References: <cover.1432214851.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:58879 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928AbbEUNfs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 09:35:48 -0400
In-Reply-To: <cover.1432214851.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1432214851.git.liwang@ubuntukylin.com>
References: <cover.1432214851.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, MingXin Liu <mingxinliu@ubuntukylin.com>

From: MingXin Liu <mingxinliu@ubuntukylin.com>

Signed-off-by: MingXin Liu <mingxinliu@ubuntukylin.com>
Reviewed-by: Li Wang <liwang@ubuntukylin.com>
---
 src/osd/ReplicatedPG.cc | 110 +++++++++++++++++++++++++-----------------------
 1 file changed, 58 insertions(+), 52 deletions(-)

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 4c549a5..b2d49c6 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -10822,44 +10822,45 @@ bool ReplicatedPG::agent_maybe_evict(ObjectContextRef& obc)
     }
   }
 
+  int atime = -1, temp = 0;
+  uint64_t atime_upper = 0, atime_lower = 0;
+  uint64_t temp_upper = 0, temp_lower = 0;
+
   if (agent_state->evict_mode != TierAgentState::EVICT_MODE_FULL) {
     // is this object old and/or cold enough?
-    int atime = -1, temp = 0;
-    if (hit_set)
-      agent_estimate_atime_temp(soid, &atime, NULL /*FIXME &temp*/);
-
-    uint64_t atime_upper = 0, atime_lower = 0;
-    if (atime < 0 && obc->obs.oi.mtime != utime_t()) {
-      if (obc->obs.oi.local_mtime != utime_t()) {
-        atime = ceph_clock_now(NULL).sec() - obc->obs.oi.local_mtime;
-      } else {
-        atime = ceph_clock_now(NULL).sec() - obc->obs.oi.mtime;
+    if (pool.info.cache_measure == pg_pool_t::CACHEMEASURE_ATIME) {
+      agent_estimate_atime_temp(soid, &atime, NULL);
+
+      if (atime < 0 && obc->obs.oi.mtime != utime_t()) {
+        if (obc->obs.oi.local_mtime != utime_t()) {
+          atime = ceph_clock_now(NULL).sec() - obc->obs.oi.local_mtime;
+        } else {
+          atime = ceph_clock_now(NULL).sec() - obc->obs.oi.mtime;
+        }
       }
-    }
-    if (atime < 0) {
-      if (hit_set) {
-        atime = pool.info.hit_set_period * pool.info.hit_set_count; // "infinite"
-      } else {
-	atime_upper = 1000000;
+      if (atime < 0) {
+        if (hit_set) {
+          atime = pool.info.hit_set_period * pool.info.hit_set_count; // "infinite"
+        } else {
+	      atime_upper = 1000000;
+        }
       }
-    }
-    if (atime >= 0) {
-      agent_state->atime_hist.add(atime);
-      agent_state->atime_hist.get_position_micro(atime, &atime_lower,
+      if (atime >= 0) {
+        agent_state->atime_hist.add(atime);
+        agent_state->atime_hist.get_position_micro(atime, &atime_lower,
 						 &atime_upper);
-    }
+      }
+    } else {
+      agent_estimate_atime_temp(soid, NULL, &temp);
 
-    unsigned temp_upper = 0, temp_lower = 0;
-    /*
-    // FIXME: bound atime based on creation time?
-    agent_state->temp_hist.add(atime);
-    agent_state->temp_hist.get_position_micro(temp, &temp_lower, &temp_upper);
-    */
+      agent_state->temp_hist.add(temp);
+      agent_state->temp_hist.get_position_micro(temp, &temp_lower, &temp_upper);
+    }
 
     dout(20) << __func__
-	     << " atime " << atime
+         << " atime " << atime
 	     << " pos " << atime_lower << "-" << atime_upper
-	     << ", temp " << temp
+         <<" temp " << temp
 	     << " pos " << temp_lower << "-" << temp_upper
 	     << ", evict_effort " << agent_state->evict_effort
 	     << dendl;
@@ -10872,9 +10873,10 @@ bool ReplicatedPG::agent_maybe_evict(ObjectContextRef& obc)
     delete f;
     *_dout << dendl;
 
-    // FIXME: ignore temperature for now.
-
-    if (1000000 - atime_upper >= agent_state->evict_effort)
+    if (pool.info.cache_measure == pg_pool_t::CACHEMEASURE_ATIME) {
+      if(1000000 - atime_upper >= agent_state->evict_effort)
+        return false;
+    } else if (temp_lower >= agent_state->evict_effort)
       return false;
   }
 
@@ -11124,29 +11126,33 @@ void ReplicatedPG::agent_estimate_atime_temp(const hobject_t& oid,
 					     int *atime, int *temp)
 {
   assert(hit_set);
-  *atime = -1;
-  if (temp)
-    *temp = 0;
-  if (hit_set->contains(oid)) {
-    *atime = 0;
-    if (temp)
-      ++(*temp);
-    else
+  if (atime) {
+    *atime = -1;
+    if (hit_set->contains(oid)) {
+      *atime = 0;
       return;
-  }
-  time_t now = ceph_clock_now(NULL).sec();
-  for (map<time_t,HitSetRef>::reverse_iterator p =
-	 agent_state->hit_set_map.rbegin();
-       p != agent_state->hit_set_map.rend();
-       ++p) {
-    if (p->second->contains(oid)) {
-      if (*atime < 0)
-	*atime = now - p->first;
-      if (temp)
-	++(*temp);
-      else
+    }
+	time_t now = ceph_clock_now(NULL).sec();
+    for (map<time_t,HitSetRef>::reverse_iterator p =
+         agent_state->hit_set_map.rbegin();
+         p != agent_state->hit_set_map.rend(); ++p) {
+      if (p->second->contains(oid))
+        *atime = now - p->first;
+      if (*atime >= 0)
 	return;
     }
+  } else if (temp) {
+    *temp = 0;
+    unsigned i = 0;
+    if (hit_set->contains(oid))
+      *temp += pool.info.get_grade(0);
+    for (map<time_t,HitSetRef>::reverse_iterator p =
+         agent_state->hit_set_map.rbegin();
+         p != agent_state->hit_set_map.rend(); ++p) {
+      ++i;
+      if (p->second->contains(oid))
+        *temp += pool.info.get_grade(i);
+    }
   }
 }
 
-- 
1.9.1

