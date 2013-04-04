From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] os/LevelDBStore: tune LevelDB data blocking options to
 be more suitable for PGStat values
Date: Thu,  4 Apr 2013 16:37:59 -0600
Message-ID: <1365115079-158190-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:44121 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765337Ab3DDWig (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 18:38:36 -0400
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1EDADD2D2AB
	for <ceph-devel@vger.kernel.org>; Thu,  4 Apr 2013 16:38:32 -0600 (MDT)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Thu, 4 Apr 2013 16:38:16 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

As reported in this thread
   http://www.spinics.net/lists/ceph-devel/msg13777.html
starting in v0.59 a new filesystem with ~55,000 PGs would not start after
a period of ~30 minutes.  By comparison, the same filesystem configuration
would start in ~1 minute for v0.58.

The issue is that starting in v0.59, LevelDB is used for the monitor
data store.  For moderate to large numbers of PGs, the length of a PGStat value
stored via LevelDB is best measured in megabytes.  The default tunings for
LevelDB data blocking seem tuned for values with lengths measured in tens or
hundreds of bytes.

With the data blocking tuning provided by this patch, here's a comparison
of filesystem startup times for v0.57, v0.58, and v0.59:

      55,392 PGs   221,568 PGs
v0.57   1m 07s        9m 42s
v0.58   1m 04s       11m 44s
v0.59      45s        4m 17s

Note that this patch turns off LevelDB's compression.  The block
tuning from this patch with compression enabled made no improvement
in the new filesystem startup time for v0.59, for either PG count
tested.  I'll note that at 55,392 PGs the PGStat length is ~20 MB;
perhaps that value length interacts pooly with LevelDB's compression
at this block size.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/os/LevelDBStore.cc |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/os/LevelDBStore.cc b/src/os/LevelDBStore.cc
index 3d94096..1b6ae7d 100644
--- a/src/os/LevelDBStore.cc
+++ b/src/os/LevelDBStore.cc
@@ -16,6 +16,9 @@ int LevelDBStore::init(ostream &out, bool create_if_missing)
 {
   leveldb::Options options;
   options.create_if_missing = create_if_missing;
+  options.write_buffer_size = 32 * 1024 * 1024;
+  options.block_size = 4 * 1024 * 1024;
+  options.compression = leveldb::kNoCompression;
   leveldb::DB *_db;
   leveldb::Status status = leveldb::DB::Open(options, path, &_db);
   db.reset(_db);
-- 
1.7.8.2


