From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 1/5] Osd: add three fields to pg_pool_t
Date: Thu, 21 May 2015 21:34:06 +0800
Message-ID: <64d651c06eafb0a47a114017fefac7506f7999f9.1432214851.git.liwang@ubuntukylin.com>
References: <cover.1432214851.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:58866 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbbEUNfr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 09:35:47 -0400
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
 src/osd/osd_types.cc | 32 ++++++++++++++++++++++++++++++--
 src/osd/osd_types.h  | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/src/osd/osd_types.cc b/src/osd/osd_types.cc
index a73b46f..ba81889 100644
--- a/src/osd/osd_types.cc
+++ b/src/osd/osd_types.cc
@@ -871,7 +871,6 @@ void pool_snap_info_t::generate_test_instances(list<pool_snap_info_t*>& o)
   o.back()->name = "foo";
 }
 
-
 // -- pg_pool_t --
 
 void pg_pool_t::dump(Formatter *f) const
@@ -910,6 +909,7 @@ void pg_pool_t::dump(Formatter *f) const
   f->dump_int("read_tier", read_tier);
   f->dump_int("write_tier", write_tier);
   f->dump_string("cache_mode", get_cache_mode_name());
+  f->dump_string("cache_measure", get_cache_measure_name());
   f->dump_unsigned("target_max_bytes", target_max_bytes);
   f->dump_unsigned("target_max_objects", target_max_objects);
   f->dump_unsigned("cache_target_dirty_ratio_micro",
@@ -925,6 +925,11 @@ void pg_pool_t::dump(Formatter *f) const
   f->dump_unsigned("hit_set_period", hit_set_period);
   f->dump_unsigned("hit_set_count", hit_set_count);
   f->dump_unsigned("min_read_recency_for_promote", min_read_recency_for_promote);
+  f->dump_unsigned("hit_set_grade_decay_rate",hit_set_grade_decay_rate);
+  f->open_array_section("grade_table");
+  for (vector<uint32_t>::const_iterator p = grade_table.begin(); p != grade_table.end(); ++p)
+    f->dump_unsigned("grade", *p);
+  f->close_section();
   f->dump_unsigned("stripe_width", get_stripe_width());
   f->dump_unsigned("expected_num_objects", expected_num_objects);
 }
@@ -1226,7 +1231,7 @@ void pg_pool_t::encode(bufferlist& bl, uint64_t features) const
     return;
   }
 
-  ENCODE_START(17, 5, bl);
+  ENCODE_START(18, 5, bl);
   ::encode(type, bl);
   ::encode(size, bl);
   ::encode(crush_ruleset, bl);
@@ -1268,6 +1273,9 @@ void pg_pool_t::encode(bufferlist& bl, uint64_t features) const
   ::encode(last_force_op_resend, bl);
   ::encode(min_read_recency_for_promote, bl);
   ::encode(expected_num_objects, bl);
+  __u8 m = cache_measure;
+  ::encode(m, bl);
+  ::encode(hit_set_grade_decay_rate, bl);
   ENCODE_FINISH(bl);
 }
 
@@ -1385,6 +1393,16 @@ void pg_pool_t::decode(bufferlist::iterator& bl)
   } else {
     expected_num_objects = 0;
   }
+  if (struct_v >= 18) {
+    __u8 v;
+    ::decode(v, bl);
+    cache_measure = (cache_measure_t)v;
+    ::decode(hit_set_grade_decay_rate, bl);
+    set_grade(hit_set_grade_decay_rate, hit_set_count);
+  } else {
+    cache_measure = CACHEMEASURE_ATIME;
+    hit_set_grade_decay_rate = 0;
+  }
   DECODE_FINISH(bl);
   calc_pg_masks();
 }
@@ -1425,12 +1443,16 @@ void pg_pool_t::generate_test_instances(list<pg_pool_t*>& o)
   a.tiers.insert(1);
   a.tier_of = 2;
   a.cache_mode = CACHEMODE_WRITEBACK;
+  a.cache_measure = CACHEMEASURE_ATIME;
   a.read_tier = 1;
   a.write_tier = 1;
   a.hit_set_params = HitSet::Params(new BloomHitSet::Params);
   a.hit_set_period = 3600;
   a.hit_set_count = 8;
   a.min_read_recency_for_promote = 1;
+  a.hit_set_grade_decay_rate = 50;
+  a.grade_table.push_back(1000000);
+  a.grade_table.push_back(500000);
   a.set_stripe_width(12345);
   a.target_max_bytes = 1238132132;
   a.target_max_objects = 1232132;
@@ -1475,6 +1497,8 @@ ostream& operator<<(ostream& out, const pg_pool_t& p)
     out << " write_tier " << p.write_tier;
   if (p.cache_mode)
     out << " cache_mode " << p.get_cache_mode_name();
+  if (p.cache_mode)
+    out << " cache_measure " << p.get_cache_measure_name();
   if (p.target_max_bytes)
     out << " target_bytes " << p.target_max_bytes;
   if (p.target_max_objects)
@@ -1483,6 +1507,10 @@ ostream& operator<<(ostream& out, const pg_pool_t& p)
     out << " hit_set " << p.hit_set_params
 	<< " " << p.hit_set_period << "s"
 	<< " x" << p.hit_set_count;
+    if (p.cache_measure == pg_pool_t::CACHEMEASURE_TEMP) {
+      out << " decay_rate " << p.hit_set_grade_decay_rate
+      << " grade_table" << p.grade_table;
+    }
   }
   if (p.min_read_recency_for_promote)
     out << " min_read_recency_for_promote " << p.min_read_recency_for_promote;
diff --git a/src/osd/osd_types.h b/src/osd/osd_types.h
index 18f5402..7bea017 100644
--- a/src/osd/osd_types.h
+++ b/src/osd/osd_types.h
@@ -888,6 +888,12 @@ struct pg_pool_t {
     CACHEMODE_READFORWARD = 4,           ///< forward reads, write to cache flush later
     CACHEMODE_READPROXY = 5              ///< proxy reads, write to cache flush later
   } cache_mode_t;
+
+  typedef enum {
+    CACHEMEASURE_ATIME = 0,              ///< judge hot by atime
+    CACHEMEASURE_TEMP = 1                ///< judge hot by temperature
+  } cache_measure_t;
+
   static const char *get_cache_mode_name(cache_mode_t m) {
     switch (m) {
     case CACHEMODE_NONE: return "none";
@@ -932,6 +938,24 @@ struct pg_pool_t {
     }
   }
 
+  static const char *get_cache_measure_name(cache_measure_t m) {
+    switch (m) {
+    case CACHEMEASURE_ATIME: return "atime";
+    case CACHEMEASURE_TEMP: return "temperature";
+    default: return "unknown";
+    }
+  }
+  static cache_measure_t get_cache_measure_from_str(const string& s) {
+    if (s == "atime")
+      return CACHEMEASURE_ATIME;
+    if (s == "temperature")
+      return CACHEMEASURE_TEMP;
+    return (cache_measure_t)-1;
+  }
+  const char *get_cache_measure_name() const {
+    return get_cache_measure_name(cache_measure);
+  }
+
   uint64_t flags;           ///< FLAG_*
   __u8 type;                ///< TYPE_*
   __u8 size, min_size;      ///< number of osds in each pg
@@ -976,6 +1000,7 @@ public:
   int64_t read_tier;       ///< pool/tier for objecter to direct reads to
   int64_t write_tier;      ///< pool/tier for objecter to direct writes to
   cache_mode_t cache_mode;  ///< cache pool mode
+  cache_measure_t cache_measure;  ///< cache measure demension,atime or temperature
 
   bool is_tier() const { return tier_of >= 0; }
   bool has_tiers() const { return !tiers.empty(); }
@@ -993,6 +1018,7 @@ public:
     if (cache_mode != CACHEMODE_NONE)
       flags |= FLAG_INCOMPLETE_CLONES;
     cache_mode = CACHEMODE_NONE;
+    cache_measure = CACHEMEASURE_ATIME;
 
     target_max_bytes = 0;
     target_max_objects = 0;
@@ -1001,6 +1027,8 @@ public:
     hit_set_params = HitSet::Params();
     hit_set_period = 0;
     hit_set_count = 0;
+    hit_set_grade_decay_rate = 0;
+    grade_table.resize(0);
   }
 
   uint64_t target_max_bytes;   ///< tiering: target max pool size
@@ -1016,6 +1044,25 @@ public:
   uint32_t hit_set_period;      ///< periodicity of HitSet segments (seconds)
   uint32_t hit_set_count;       ///< number of periods to retain
   uint32_t min_read_recency_for_promote;   ///< minimum number of HitSet to check before promote
+  uint32_t hit_set_grade_decay_rate;   ///< current hit_set has highest priority on objects
+                                       ///temperature count,the follow hit_set's priority decay
+                                       ///by this params than pre hit_set
+  vector<uint32_t> grade_table;
+  void set_grade(uint32_t decay, unsigned size)
+  {
+    unsigned v = 1000000;
+    grade_table.resize(size);
+    for (unsigned i = 0; i < size; i++) {
+      grade_table[i] = v;
+      v = v * (1 - (decay / 100.0));
+    }
+  }
+  uint32_t get_grade(unsigned i)
+  {
+    if (grade_table.size() <= i)
+      return 0;
+    return grade_table[i];
+  }
 
   uint32_t stripe_width;        ///< erasure coded stripe size in bytes
 
@@ -1035,6 +1082,7 @@ public:
       pg_num_mask(0), pgp_num_mask(0),
       tier_of(-1), read_tier(-1), write_tier(-1),
       cache_mode(CACHEMODE_NONE),
+      cache_measure(CACHEMEASURE_ATIME),
       target_max_bytes(0), target_max_objects(0),
       cache_target_dirty_ratio_micro(0),
       cache_target_full_ratio_micro(0),
@@ -1044,6 +1092,7 @@ public:
       hit_set_period(0),
       hit_set_count(0),
       min_read_recency_for_promote(0),
+      hit_set_grade_decay_rate(0),
       stripe_width(0),
       expected_num_objects(0)
   { }
-- 
1.9.1

