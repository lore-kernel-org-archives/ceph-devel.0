From: Jan Engelhardt <jengelh@inai.de>
Subject: [PATCH 5/6] build: consolidate LDADD
Date: Wed, 12 Sep 2012 04:22:06 +0200
Message-ID: <1347416527-19752-6-git-send-email-jengelh@inai.de>
References: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ares07.inai.de ([5.9.24.206]:48875 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759365Ab2ILCWR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Sep 2012 22:22:17 -0400
In-Reply-To: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org

Since this repository has no programs without libleveldb.a, we can put
libleveldb.a in LDADD.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 Makefile.am |   21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b428afb..19b52a8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -17,7 +17,7 @@ AM_CXXFLAGS += -DLEVELDB_CSTDATOMIC_PRESENT -std=c++0x
 endif
 AM_LDFLAGS = -pthread
 
-LDADD =
+LDADD = libleveldb.a
 if WITH_TCMALLOC
 LDADD += -ltcmalloc
 endif
@@ -127,77 +127,58 @@ TESTUTIL = util/testutil.cc
 TESTHARNESS = util/testharness.cc $(TESTUTIL)
 
 c_test_SOURCES = db/c_test.c $(TESTHARNESS)
-c_test_LDADD = libleveldb.a
 TESTS += c_test
 
 coding_test_SOURCES = util/coding_test.cc $(TESTHARNESS)
-coding_test_LDADD = libleveldb.a
 TESTS += coding_test
 
 db_bench_SOURCES = db/db_bench.cc $(TESTUTIL)
-db_bench_LDADD = libleveldb.a
 check_PROGRAMS += db_bench
 
 #db_bench_sqlite3_SOURCES = doc/bench/db_bench_sqlite3.cc $(TESTUTIL)
-#db_bench_sqlite3_LDADD = libleveldb.a
 #TESTS += db_bench_sqlite3
 
 #db_bench_tree_db_SOURCES = doc/bench/db_bench_tree_db.cc $(TESTUTIL)
-#db_bench_tree_db_LDADD = libleveldb.a
 #TESTS += db_bench_tree_db
 
 arena_test_SOURCES = util/arena_test.cc $(TESTHARNESS)
-arena_test_LDADD = libleveldb.a
 TESTS += arena_test
 
 cache_test_SOURCES = util/cache_test.cc $(TESTHARNESS)
-cache_test_LDADD = libleveldb.a
 TESTS += cache_test
 
 corruption_test_SOURCES = db/corruption_test.cc $(TESTHARNESS)
-corruption_test_LDADD = libleveldb.a
 TESTS += corruption_test
 
 crc32c_test_SOURCES = util/crc32c_test.cc $(TESTHARNESS)
-crc32c_test_LDADD = libleveldb.a
 TESTS += crc32c_test
 
 db_test_SOURCES = db/db_test.cc $(TESTHARNESS)
-db_test_LDADD = libleveldb.a
 TESTS += db_test
 
 dbformat_test_SOURCES = db/dbformat_test.cc $(TESTHARNESS)
-dbformat_test_LDADD = libleveldb.a
 TESTS += dbformat_test
 
 env_test_SOURCES = util/env_test.cc $(TESTHARNESS)
-env_test_LDADD = libleveldb.a
 TESTS += env_test
 
 filename_test_SOURCES = db/filename_test.cc $(TESTHARNESS)
-filename_test_LDADD = libleveldb.a
 TESTS += filename_test
 
 log_test_SOURCES = db/log_test.cc $(TESTHARNESS)
-log_test_LDADD = libleveldb.a
 TESTS += log_test
 
 table_test_SOURCES = table/table_test.cc $(TESTHARNESS)
-table_test_LDADD = libleveldb.a
 TESTS += table_test
 
 skiplist_test_SOURCES = db/skiplist_test.cc $(TESTHARNESS)
-skiplist_test_LDADD = libleveldb.a
 TESTS += skiplist_test
 
 version_edit_test_SOURCES = db/version_edit_test.cc $(TESTHARNESS)
-version_edit_test_LDADD = libleveldb.a
 TESTS += version_edit_test
 
 version_set_test_SOURCES = db/version_set_test.cc $(TESTHARNESS)
-version_set_test_LDADD = libleveldb.a
 TESTS += version_set_test
 
 write_batch_test_SOURCES = db/write_batch_test.cc $(TESTHARNESS)
-write_batch_test_LDADD = libleveldb.a
 TESTS += write_batch_test
-- 
1.7.10.4

