From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 4/5] Mon: add temperature support for existing cache related commands
Date: Thu, 21 May 2015 21:34:09 +0800
Message-ID: <09ccb9b25477f32636a07878e6922fc8feb2445c.1432214851.git.liwang@ubuntukylin.com>
References: <cover.1432214851.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:58926 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbbEUNgB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 09:36:01 -0400
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
 src/common/config_opts.h |  2 ++
 src/mon/OSDMonitor.cc    | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index e79eeaa..f661cbc 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -550,10 +550,12 @@ OPTION(osd_hit_set_max_size, OPT_INT, 100000)  // max target size for a HitSet
 OPTION(osd_hit_set_namespace, OPT_STR, ".ceph-internal") // rados namespace for hit_set tracking
 
 OPTION(osd_tier_default_cache_mode, OPT_STR, "writeback")
+OPTION(osd_tier_default_cache_measure, OPT_STR, "atime")
 OPTION(osd_tier_default_cache_hit_set_count, OPT_INT, 4)
 OPTION(osd_tier_default_cache_hit_set_period, OPT_INT, 1200)
 OPTION(osd_tier_default_cache_hit_set_type, OPT_STR, "bloom")
 OPTION(osd_tier_default_cache_min_read_recency_for_promote, OPT_INT, 1) // number of recent HitSets the object must appear in to be promoted (on read)
+OPTION(osd_tier_default_cache_hit_set_grade_decay_rate, OPT_INT, 50)
 
 OPTION(osd_map_dedup, OPT_BOOL, true)
 OPTION(osd_map_max_advance, OPT_INT, 200) // make this < cache_size!
diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
index 0374778..ac84b56 100644
--- a/src/mon/OSDMonitor.cc
+++ b/src/mon/OSDMonitor.cc
@@ -2723,13 +2723,15 @@ void OSDMonitor::get_health(list<pair<health_status_t,string> >& summary,
 	   p != osdmap.pools.end();
 	   ++p) {
 	const pg_pool_t& info = p->second;
-	if (info.cache_mode_requires_hit_set() &&
+	if ((info.cache_mode_requires_hit_set() ||
+        info.cache_measure == pg_pool_t::CACHEMEASURE_TEMP) &&
 	    info.hit_set_params.get_type() == HitSet::TYPE_NONE) {
 	  ++problem_cache_pools;
 	  if (detail) {
 	    ostringstream ss;
 	    ss << "pool '" << osdmap.get_pool_name(p->first)
 	       << "' with cache_mode " << info.get_cache_mode_name()
+           << " cache_measure " << info.get_cache_measure_name()
 	       << " needs hit_set_type to be set but it is not";
 	    detail->push_back(make_pair(HEALTH_WARN, ss.str()));
 	  }
@@ -6874,6 +6876,13 @@ done:
       err = -EINVAL;
       goto reply;
     }
+    string measurestr = g_conf->osd_tier_default_cache_measure;
+    pg_pool_t::cache_measure_t measure = pg_pool_t::get_cache_measure_from_str(measurestr);
+    if (measure < 0) {
+      ss << "osd tier cache default measure '" << measurestr << "' is not a valid cache measure";
+      err = -EINVAL;
+      goto reply;
+    }
     HitSet::Params hsp;
     if (g_conf->osd_tier_default_cache_hit_set_type == "bloom") {
       BloomHitSet::Params *bsp = new BloomHitSet::Params;
@@ -6902,11 +6911,14 @@ done:
     np->set_snap_epoch(pending_inc.epoch); // tier will update to our snap info
     ntp->tier_of = pool_id;
     ntp->cache_mode = mode;
+    ntp->cache_measure = measure;
     ntp->hit_set_count = g_conf->osd_tier_default_cache_hit_set_count;
     ntp->hit_set_period = g_conf->osd_tier_default_cache_hit_set_period;
     ntp->min_read_recency_for_promote = g_conf->osd_tier_default_cache_min_read_recency_for_promote;
+    ntp->hit_set_grade_decay_rate = g_conf->osd_tier_default_cache_hit_set_grade_decay_rate;
     ntp->hit_set_params = hsp;
     ntp->target_max_bytes = size;
+    ntp->set_grade(ntp->hit_set_grade_decay_rate, ntp->hit_set_count);
     ss << "pool '" << tierpoolstr << "' is now (or already was) a cache tier of '" << poolstr << "'";
     wait_for_finished_proposal(new Monitor::C_Command(mon, m, 0, ss.str(),
 					      get_last_committed() + 1));
-- 
1.9.1

