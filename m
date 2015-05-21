From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 5/5] Doc: add temperature related stuff in documents and test scripts
Date: Thu, 21 May 2015 21:34:10 +0800
Message-ID: <9dac2127233104676c8f32ad96e7e640bfd00d0a.1432214851.git.liwang@ubuntukylin.com>
References: <cover.1432214851.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:58887 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072AbbEUNft (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 09:35:49 -0400
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
 doc/dev/cache-pool.rst         |  4 ++++
 doc/man/8/ceph.rst             | 12 +++++++++---
 doc/rados/operations/pools.rst |  7 +++++++
 qa/workunits/cephtool/test.sh  | 14 ++++++++++++++
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/doc/dev/cache-pool.rst b/doc/dev/cache-pool.rst
index f44cbd9..d3b6257 100644
--- a/doc/dev/cache-pool.rst
+++ b/doc/dev/cache-pool.rst
@@ -179,5 +179,9 @@ the cache tier::
 
  ceph osd pool set foo-hot cache_min_evict_age 1800   # 30 minutes
 
+You can specify the objects evict policy(cache-measure),when cache-measure is set as atime
+the most recent objects are hotter than others,if use temperature as measure agent will consider
+both access time and frequency::
+ ceph osd tier cache-measure foo-hot <atime|temperature>
 
 
diff --git a/doc/man/8/ceph.rst b/doc/man/8/ceph.rst
index f950221..53133d8 100644
--- a/doc/man/8/ceph.rst
+++ b/doc/man/8/ceph.rst
@@ -45,7 +45,7 @@ Synopsis
 
 | **ceph** **osd** **pool** [ *create* \| *delete* \| *get* \| *get-quota* \| *ls* \| *mksnap* \| *rename* \| *rmsnap* \| *set* \| *set-quota* \| *stats* ] ...
 
-| **ceph** **osd** **tier** [ *add* \| *add-cache* \| *cache-mode* \| *remove* \| *remove-overlay* \| *set-overlay* ] ...
+| **ceph** **osd** **tier** [ *add* \| *add-cache* \| *cache-mode* \| *cache-measure* \| *remove* \| *remove-overlay* \| *set-overlay* ] ...
 
 | **ceph** **pg** [ *debug* \| *deep-scrub* \| *dump* \| *dump_json* \| *dump_pools_json* \| *dump_stuck* \| *force_create_pg* \| *getmap* \| *ls* \| *ls-by-osd* \| *ls-by-pool* \| *ls-by-primary* \| *map* \| *repair* \| *scrub* \| *send_pg_creates* \| *set_full_ratio* \| *set_nearfull_ratio* \| *stat* ] ...
 
@@ -878,7 +878,7 @@ Only for tiered pools::
 	ceph osd pool get <poolname> hit_set_type|hit_set_period|hit_set_count|hit_set_fpp|
 	target_max_objects|target_max_bytes|cache_target_dirty_ratio|
 	cache_target_full_ratio|cache_min_flush_age|cache_min_evict_age|
-	min_read_recency_for_promote
+	min_read_recency_for_promote|hit_set_grade_decay_rate
 
 Only for erasure coded pools::
 
@@ -927,7 +927,7 @@ Usage::
 	hit_set_type|hit_set_period|hit_set_count|hit_set_fpp|debug_fake_ec_pool|
 	target_max_bytes|target_max_objects|cache_target_dirty_ratio|
 	cache_target_full_ratio|cache_min_flush_age|cache_min_evict_age|auid|
-	min_read_recency_for_promote|write_fadvise_dontneed
+	min_read_recency_for_promote|write_fadvise_dontneed|hit_set_grade_decay_rate
 	<val> {--yes-i-really-mean-it}
 
 Subcommand ``set-quota`` sets object or byte limit on pool.
@@ -1049,6 +1049,12 @@ Usage::
 	ceph osd tier cache-mode <poolname> none|writeback|forward|readonly|
 	readforward|readproxy
 
+Subcommand ``cache-measure`` specifies the caching measure for cache tier <pool>.
+
+Usage::
+
+	ceph osd tier cache-measure <poolname> atime|temperature
+
 Subcommand ``remove`` removes the tier <tierpool> (the second one) from base pool
 <pool> (the first one).
 
diff --git a/doc/rados/operations/pools.rst b/doc/rados/operations/pools.rst
index 36b9c94..2c6deab 100644
--- a/doc/rados/operations/pools.rst
+++ b/doc/rados/operations/pools.rst
@@ -374,6 +374,13 @@ You may set values for the following keys:
 :Example: ``1000000`` #1M objects
 
 
+``hit_set_grade_decay_rate``
+:Description: Temperature grade decay rate between a hit_set and the follow one
+:Type: Integer
+:Valid Range: 0 - 100
+:Default: ``50``
+
+
 ``cache_min_flush_age``
 
 :Description: The time (in seconds) before the cache tiering agent will flush 
diff --git a/qa/workunits/cephtool/test.sh b/qa/workunits/cephtool/test.sh
index 15d4e73..c51592a 100755
--- a/qa/workunits/cephtool/test.sh
+++ b/qa/workunits/cephtool/test.sh
@@ -415,6 +415,20 @@ function test_tiering()
   ceph osd pool delete cache5 cache5 --yes-i-really-really-mean-it
   ceph osd pool delete basepoolB basepoolB --yes-i-really-really-mean-it
   ceph osd pool delete basepoolA basepoolA --yes-i-really-really-mean-it
+
+  #cache-measure
+  ceph osd pool create Mbase1 2
+  ceph osd pool create Mcache1 2
+  ceph osd tier add Mbase1 Mcache1
+  ceph osd pool set Mcache1 hit_set_type bloom
+  ceph osd pool set Mcache1 hit_set_count 4
+  ceph osd pool set Mcache1 hit_set_period 1200
+  ceph osd pool set Mcache1 hit_set_grade_decay_rate 3
+  ceph osd tier cache-mode writeback
+  ceph osd tier cache-measure temperature
+  ceph osd tier set-overlay Mbase1 Mcache1
+  ceph osd tier cache-measure atime
+  ceph osd tier cache-measure temperature
 }
 
 function test_auth()
-- 
1.9.1

