From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 2/5] Mon: expose commands for temperature related setting
Date: Thu, 21 May 2015 21:34:07 +0800
Message-ID: <6826e84a012cff2bd1a2a8741a8bfddc002da8dd.1432214851.git.liwang@ubuntukylin.com>
References: <cover.1432214851.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:58912 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072AbbEUNf4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 09:35:56 -0400
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
 src/mon/MonCommands.h |  8 +++--
 src/mon/OSDMonitor.cc | 87 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/src/mon/MonCommands.h b/src/mon/MonCommands.h
index 8a36807..b26834d 100644
--- a/src/mon/MonCommands.h
+++ b/src/mon/MonCommands.h
@@ -639,11 +639,11 @@ COMMAND("osd pool rename " \
 	"rename <srcpool> to <destpool>", "osd", "rw", "cli,rest")
 COMMAND("osd pool get " \
 	"name=pool,type=CephPoolname " \
-	"name=var,type=CephChoices,strings=size|min_size|crash_replay_interval|pg_num|pgp_num|crush_ruleset|hit_set_type|hit_set_period|hit_set_count|hit_set_fpp|auid|target_max_objects|target_max_bytes|cache_target_dirty_ratio|cache_target_full_ratio|cache_min_flush_age|cache_min_evict_age|erasure_code_profile|min_read_recency_for_promote|write_fadvise_dontneed|all", \
+	"name=var,type=CephChoices,strings=size|min_size|crash_replay_interval|pg_num|pgp_num|crush_ruleset|hit_set_type|hit_set_period|hit_set_count|hit_set_fpp|auid|target_max_objects|target_max_bytes|cache_target_dirty_ratio|cache_target_full_ratio|cache_min_flush_age|cache_min_evict_age|erasure_code_profile|min_read_recency_for_promote|write_fadvise_dontneed|hit_set_grade_decay_rate|all", \
 	"get pool parameter <var>", "osd", "r", "cli,rest")
 COMMAND("osd pool set " \
 	"name=pool,type=CephPoolname " \
-	"name=var,type=CephChoices,strings=size|min_size|crash_replay_interval|pg_num|pgp_num|crush_ruleset|hashpspool|nodelete|nopgchange|nosizechange|hit_set_type|hit_set_period|hit_set_count|hit_set_fpp|debug_fake_ec_pool|target_max_bytes|target_max_objects|cache_target_dirty_ratio|cache_target_full_ratio|cache_min_flush_age|cache_min_evict_age|auid|min_read_recency_for_promote|write_fadvise_dontneed " \
+	"name=var,type=CephChoices,strings=size|min_size|crash_replay_interval|pg_num|pgp_num|crush_ruleset|hashpspool|nodelete|nopgchange|nosizechange|hit_set_type|hit_set_period|hit_set_count|hit_set_fpp|debug_fake_ec_pool|target_max_bytes|target_max_objects|cache_target_dirty_ratio|cache_target_full_ratio|cache_min_flush_age|cache_min_evict_age|auid|min_read_recency_for_promote|write_fadvise_dontneed|hit_set_grade_decay_rate " \
 	"name=val,type=CephString " \
 	"name=force,type=CephChoices,strings=--yes-i-really-mean-it,req=false", \
 	"set pool parameter <var> to <val>", "osd", "rw", "cli,rest")
@@ -695,6 +695,10 @@ COMMAND("osd tier cache-mode " \
 	"name=pool,type=CephPoolname " \
 	"name=mode,type=CephChoices,strings=none|writeback|forward|readonly|readforward|readproxy", \
 	"specify the caching mode for cache tier <pool>", "osd", "rw", "cli,rest")
+COMMAND("osd tier cache-measure " \
+        "name=pool,type=CephPoolname " \
+        "name=measure,type=CephChoices,strings=atime|temperature", \
+        "specify the caching measure to judge hot objects for cache tier <pool>", "osd", "rw", "cli,rest")
 COMMAND("osd tier set-overlay " \
 	"name=pool,type=CephPoolname " \
 	"name=overlaypool,type=CephPoolname", \
diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
index 10597d0..0374778 100644
--- a/src/mon/OSDMonitor.cc
+++ b/src/mon/OSDMonitor.cc
@@ -2803,7 +2803,7 @@ namespace {
     CACHE_TARGET_DIRTY_RATIO, CACHE_TARGET_FULL_RATIO,
     CACHE_MIN_FLUSH_AGE, CACHE_MIN_EVICT_AGE,
     ERASURE_CODE_PROFILE, MIN_READ_RECENCY_FOR_PROMOTE,
-    WRITE_FADVISE_DONTNEED};
+    WRITE_FADVISE_DONTNEED, HIT_SET_GRADE_DECAY_RATE};
 
   std::set<osd_pool_get_choices>
     subtract_second_from_first(const std::set<osd_pool_get_choices>& first,
@@ -3251,7 +3251,8 @@ bool OSDMonitor::preprocess_command(MMonCommand *m)
       ("cache_min_evict_age", CACHE_MIN_EVICT_AGE)
       ("erasure_code_profile", ERASURE_CODE_PROFILE)
       ("min_read_recency_for_promote", MIN_READ_RECENCY_FOR_PROMOTE)
-      ("write_fadvise_dontneed", WRITE_FADVISE_DONTNEED);
+      ("write_fadvise_dontneed", WRITE_FADVISE_DONTNEED)
+      ("hit_set_grade_decay_rate", HIT_SET_GRADE_DECAY_RATE);
 
     typedef std::set<osd_pool_get_choices> choices_set_t;
 
@@ -3259,7 +3260,7 @@ bool OSDMonitor::preprocess_command(MMonCommand *m)
       (HIT_SET_TYPE)(HIT_SET_PERIOD)(HIT_SET_COUNT)(HIT_SET_FPP)
       (TARGET_MAX_OBJECTS)(TARGET_MAX_BYTES)(CACHE_TARGET_FULL_RATIO)
       (CACHE_TARGET_DIRTY_RATIO)(CACHE_MIN_FLUSH_AGE)(CACHE_MIN_EVICT_AGE)
-      (MIN_READ_RECENCY_FOR_PROMOTE);
+      (MIN_READ_RECENCY_FOR_PROMOTE)(HIT_SET_GRADE_DECAY_RATE);
 
     const choices_set_t ONLY_ERASURE_CHOICES = boost::assign::list_of
       (ERASURE_CODE_PROFILE);
@@ -3389,6 +3390,10 @@ bool OSDMonitor::preprocess_command(MMonCommand *m)
 	    f->dump_int("min_read_recency_for_promote",
 			p->min_read_recency_for_promote);
 	    break;
+	  case HIT_SET_GRADE_DECAY_RATE:
+	    f->dump_int("hit_set_priority_decacy_rate",
+			p->hit_set_grade_decay_rate);
+	    break;
 	  case WRITE_FADVISE_DONTNEED:
 	    f->dump_string("write_fadvise_dontneed",
 			   p->has_flag(pg_pool_t::FLAG_WRITE_FADVISE_DONTNEED) ?
@@ -3476,6 +3481,10 @@ bool OSDMonitor::preprocess_command(MMonCommand *m)
 	    ss << "min_read_recency_for_promote: " <<
 	      p->min_read_recency_for_promote << "\n";
 	    break;
+	  case HIT_SET_GRADE_DECAY_RATE:
+	    ss << "hit_set_grade_decay_rate: " <<
+	      p->hit_set_grade_decay_rate << "\n";
+	    break;
 	  case WRITE_FADVISE_DONTNEED:
 	    ss << "write_fadvise_dontneed: " <<
 	      (p->has_flag(pg_pool_t::FLAG_WRITE_FADVISE_DONTNEED) ?
@@ -4466,7 +4475,8 @@ int OSDMonitor::prepare_command_pool_set(map<string,cmd_vartype> &cmdmap,
        var == "hit_set_count" || var == "hit_set_fpp" ||
        var == "target_max_objects" || var == "target_max_bytes" ||
        var == "cache_target_full_ratio" || var == "cache_target_dirty_ratio" ||
-       var == "cache_min_flush_age" || var == "cache_min_evict_age")) {
+       var == "cache_min_flush_age" || var == "cache_min_evict_age" ||
+       var == "hit_set_grade_decay_rate")) {
     ss << "pool '" << poolstr << "' is not a tier pool: variable not applicable";
     return -EACCES;
   }
@@ -4652,12 +4662,12 @@ int OSDMonitor::prepare_command_pool_set(map<string,cmd_vartype> &cmdmap,
     }
     p.hit_set_period = n;
   } else if (var == "hit_set_count") {
-
     if (interr.length()) {
       ss << "error parsing integer value '" << val << "': " << interr;
       return -EINVAL;
     }
     p.hit_set_count = n;
+    p.set_grade(p.hit_set_grade_decay_rate, n);
   } else if (var == "hit_set_fpp") {
     if (floaterr.length()) {
       ss << "error parsing floating point value '" << val << "': " << floaterr;
@@ -4723,6 +4733,17 @@ int OSDMonitor::prepare_command_pool_set(map<string,cmd_vartype> &cmdmap,
       return -EINVAL;
     }
     p.min_read_recency_for_promote = n;
+  } else if (var == "hit_set_grade_decay_rate") {
+    if (interr.length()) {
+      ss << "error parsing integer value '" << val << "': " << interr;
+      return -EINVAL;
+    }
+    if (n > 100 || n < 0) {
+      ss << "value out of range,valid range is 0 - 100";
+      return -EINVAL;
+    }
+    p.hit_set_grade_decay_rate = n;
+    p.set_grade(n, p.hit_set_count);
   } else if (var == "write_fadvise_dontneed") {
     if (val == "true" || (interr.empty() && n == 1)) {
       p.flags |= pg_pool_t::FLAG_WRITE_FADVISE_DONTNEED;
@@ -6744,6 +6765,62 @@ done:
     wait_for_finished_proposal(new Monitor::C_Command(mon, m, 0, ss.str(),
 					      get_last_committed() + 1));
     return true;
+  } else if (prefix == "osd tier cache-measure") {
+    err = check_cluster_features(CEPH_FEATURE_OSD_CACHEPOOL, ss);
+    if (err == -EAGAIN)
+      goto wait;
+    if (err)
+      goto reply;
+    string poolstr;
+    cmd_getval(g_ceph_context, cmdmap, "pool", poolstr);
+    int64_t pool_id = osdmap.lookup_pg_pool_name(poolstr);
+    if (pool_id < 0) {
+      ss << "unrecognized pool '" << poolstr << "'";
+      err = -ENOENT;
+      goto reply;
+    }
+    const pg_pool_t *p = osdmap.get_pg_pool(pool_id);
+    assert(p);
+    if (!p->is_tier()) {
+      ss << "pool '" << poolstr << "' is not a tier";
+      err = -EINVAL;
+      goto reply;
+    }
+    string measurestr;
+    cmd_getval(g_ceph_context, cmdmap, "measure", measurestr);
+    pg_pool_t::cache_measure_t measure = pg_pool_t::get_cache_measure_from_str(measurestr);
+    if (measure < 0) {
+      ss << "'" << measurestr << "' is not a valid cache measure";
+      err = -EINVAL;
+      goto reply;
+    }
+    if (p->grade_table.empty()) {
+      ss << "grade_table is empty,set hit_set and hit_set_decay_rate first";
+      err = -EINVAL;
+      goto reply;
+    }
+    if (p->hit_set_params.get_type() == HitSet::TYPE_NONE) {
+      ss << "hit_set_type cannot be none";
+      err = -EINVAL;
+      goto reply;
+    }
+
+    //pool already had this cache-measure set and there are no pending changes
+    if (p->cache_measure == measure &&
+    (pending_inc.new_pools.count(pool_id) == 0 ||
+     pending_inc.new_pools[pool_id].cache_measure == p->cache_measure)) {
+      ss << "set cache-measure for pool '" << poolstr << "'"
+         << " to " << pg_pool_t::get_cache_measure_name(measure);
+      err = 0;
+      goto reply;
+    }
+    pg_pool_t *np = pending_inc.get_new_pool(pool_id, p);
+    np->cache_measure = measure;
+    ss << "set cache-measure for pool '" << poolstr
+	<< "' to " << pg_pool_t::get_cache_measure_name(measure);
+    wait_for_finished_proposal(new Monitor::C_Command(mon, m, 0, ss.str(),
+					      get_last_committed() + 1));
+    return true;
   } else if (prefix == "osd tier add-cache") {
     err = check_cluster_features(CEPH_FEATURE_OSD_CACHEPOOL, ss);
     if (err == -EAGAIN)
-- 
1.9.1

