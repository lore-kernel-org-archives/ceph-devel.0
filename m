From: Jan Engelhardt <jengelh@inai.de>
Subject: [PATCH 3/6] build: remove redundant leading ./ from file lists
Date: Wed, 12 Sep 2012 04:22:04 +0200
Message-ID: <1347416527-19752-4-git-send-email-jengelh@inai.de>
References: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ares07.inai.de ([5.9.24.206]:48870 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758296Ab2ILCWQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Sep 2012 22:22:16 -0400
In-Reply-To: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 Makefile.am |  176 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 88 insertions(+), 88 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 25a24de..b428afb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -32,96 +32,96 @@ TESTS =
 
 noinst_LIBRARIES = libleveldb.a
 noinst_HEADERS = \
-  ./util/random.h \
-	./util/coding.h \
-	./util/logging.h \
-	./util/posix_logger.h \
-	./util/hash.h \
-	./util/crc32c.h \
-	./util/histogram.h \
-	./util/mutexlock.h \
-	./util/testutil.h \
-	./util/testharness.h \
-	./util/arena.h \
-	./port/win/stdint.h \
-	./port/port_example.h \
-	./port/port_posix.h \
-	./port/port.h \
-	./port/atomic_pointer.h \
-	./port/port_android.h \
-	./table/format.h \
-	./table/two_level_iterator.h \
-	./table/iterator_wrapper.h \
-	./table/block.h \
-	./table/block_builder.h \
-	./table/merger.h \
-	./doc/bench \
-	./include/leveldb/options.h \
-	./include/leveldb/cache.h \
-	./include/leveldb/table.h \
-	./include/leveldb/status.h \
-	./include/leveldb/c.h \
-	./include/leveldb/comparator.h \
-	./include/leveldb/env.h \
-	./include/leveldb/write_batch.h \
-	./include/leveldb/db.h \
-	./include/leveldb/slice.h \
-	./include/leveldb/iterator.h \
-	./include/leveldb/table_builder.h \
-	./config.h \
-	./helpers/memenv/memenv.h \
-	./db/db_iter.h \
-	./db/table_cache.h \
-	./db/builder.h \
-	./db/memtable.h \
-	./db/snapshot.h \
-	./db/dbformat.h \
-	./db/log_writer.h \
-	./db/version_set.h \
-	./db/skiplist.h \
-	./db/write_batch_internal.h \
-	./db/log_format.h \
-	./db/filename.h \
-	./db/db_impl.h \
-	./db/log_reader.h \
-	./db/version_edit.h
+	util/random.h \
+	util/coding.h \
+	util/logging.h \
+	util/posix_logger.h \
+	util/hash.h \
+	util/crc32c.h \
+	util/histogram.h \
+	util/mutexlock.h \
+	util/testutil.h \
+	util/testharness.h \
+	util/arena.h \
+	port/win/stdint.h \
+	port/port_example.h \
+	port/port_posix.h \
+	port/port.h \
+	port/atomic_pointer.h \
+	port/port_android.h \
+	table/format.h \
+	table/two_level_iterator.h \
+	table/iterator_wrapper.h \
+	table/block.h \
+	table/block_builder.h \
+	table/merger.h \
+	doc/bench \
+	include/leveldb/options.h \
+	include/leveldb/cache.h \
+	include/leveldb/table.h \
+	include/leveldb/status.h \
+	include/leveldb/c.h \
+	include/leveldb/comparator.h \
+	include/leveldb/env.h \
+	include/leveldb/write_batch.h \
+	include/leveldb/db.h \
+	include/leveldb/slice.h \
+	include/leveldb/iterator.h \
+	include/leveldb/table_builder.h \
+	config.h \
+	helpers/memenv/memenv.h \
+	db/db_iter.h \
+	db/table_cache.h \
+	db/builder.h \
+	db/memtable.h \
+	db/snapshot.h \
+	db/dbformat.h \
+	db/log_writer.h \
+	db/version_set.h \
+	db/skiplist.h \
+	db/write_batch_internal.h \
+	db/log_format.h \
+	db/filename.h \
+	db/db_impl.h \
+	db/log_reader.h \
+	db/version_edit.h
 
 libleveldb_a_SOURCES = \
-	./db/builder.cc \
-	./db/c.cc \
-	./db/db_impl.cc \
-	./db/db_iter.cc \
-	./db/filename.cc \
-	./db/dbformat.cc \
-	./db/log_reader.cc \
-	./db/log_writer.cc \
-	./db/memtable.cc \
-	./db/repair.cc \
-	./db/table_cache.cc \
-	./db/version_edit.cc \
-	./db/version_set.cc \
-	./db/write_batch.cc \
-	./port/port_posix.cc \
-	./table/block.cc \
-	./table/block_builder.cc \
-	./table/format.cc \
-	./table/iterator.cc \
-	./table/merger.cc \
-	./table/table.cc \
-	./table/table_builder.cc \
-	./table/two_level_iterator.cc \
-	./util/arena.cc \
-	./util/cache.cc \
-	./util/coding.cc \
-	./util/comparator.cc \
-	./util/crc32c.cc \
-	./util/env.cc \
-	./util/env_posix.cc \
-	./util/hash.cc \
-	./util/histogram.cc \
-	./util/logging.cc \
-	./util/options.cc \
-	./util/status.cc
+	db/builder.cc \
+	db/c.cc \
+	db/db_impl.cc \
+	db/db_iter.cc \
+	db/filename.cc \
+	db/dbformat.cc \
+	db/log_reader.cc \
+	db/log_writer.cc \
+	db/memtable.cc \
+	db/repair.cc \
+	db/table_cache.cc \
+	db/version_edit.cc \
+	db/version_set.cc \
+	db/write_batch.cc \
+	port/port_posix.cc \
+	table/block.cc \
+	table/block_builder.cc \
+	table/format.cc \
+	table/iterator.cc \
+	table/merger.cc \
+	table/table.cc \
+	table/table_builder.cc \
+	table/two_level_iterator.cc \
+	util/arena.cc \
+	util/cache.cc \
+	util/coding.cc \
+	util/comparator.cc \
+	util/crc32c.cc \
+	util/env.cc \
+	util/env_posix.cc \
+	util/hash.cc \
+	util/histogram.cc \
+	util/logging.cc \
+	util/options.cc \
+	util/status.cc
 
 TESTUTIL = util/testutil.cc
 TESTHARNESS = util/testharness.cc $(TESTUTIL)
-- 
1.7.10.4

