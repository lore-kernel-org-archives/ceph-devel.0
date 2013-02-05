From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 3/8] obj_bencher.cc: use vector instead of VLA's
Date: Tue,  5 Feb 2013 23:52:25 +0100
Message-ID: <1360104750-16098-4-git-send-email-danny.al-gaaf@bisect.de>
References: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:50829 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754365Ab3BEWwe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 17:52:34 -0500
In-Reply-To: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix "variable length array of non-POD element type" error. (-Wvla)

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/obj_bencher.cc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/common/obj_bencher.cc b/src/common/obj_bencher.cc
index 74d54e1..d756123 100644
--- a/src/common/obj_bencher.cc
+++ b/src/common/obj_bencher.cc
@@ -25,6 +25,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <sstream>
+#include <vector>
 
 
 const std::string BENCH_LASTRUN_METADATA = "benchmark_last_metadata";
@@ -305,11 +306,11 @@ int ObjBencher::write_bench(int secondsToRun, int concurrentios) {
   std::string prefix = generate_object_prefix();
   out(cout) << "Object prefix: " << prefix << std::endl;
 
-  std::string name[concurrentios];
+  std::vector<string> name(concurrentios);
   std::string newName;
   bufferlist* contents[concurrentios];
   double total_latency = 0;
-  utime_t start_times[concurrentios];
+  std::vector<utime_t> start_times(concurrentios);
   utime_t stopTime;
   int r = 0;
   bufferlist b_write;
@@ -493,13 +494,13 @@ int ObjBencher::write_bench(int secondsToRun, int concurrentios) {
 
 int ObjBencher::seq_read_bench(int seconds_to_run, int num_objects, int concurrentios, int pid) {
   lock_cond lc(&lock);
-  std::string name[concurrentios];
+  std::vector<string> name(concurrentios);
   std::string newName;
   bufferlist* contents[concurrentios];
   int index[concurrentios];
   int errors = 0;
   utime_t start_time;
-  utime_t start_times[concurrentios];
+  std::vector<utime_t> start_times(concurrentios);
   utime_t time_to_run;
   time_to_run.set_from_double(seconds_to_run);
   double total_latency = 0;
@@ -705,7 +706,7 @@ int ObjBencher::clean_up(const std::string& prefix, int concurrentios) {
 
 int ObjBencher::clean_up(int num_objects, int prevPid, int concurrentios) {
   lock_cond lc(&lock);
-  std::string name[concurrentios];
+  std::vector<string> name(concurrentios);
   std::string newName;
   int r = 0;
   utime_t runtime;
@@ -865,7 +866,7 @@ bool ObjBencher::more_objects_matching_prefix(const std::string& prefix, std::li
 
 int ObjBencher::clean_up_slow(const std::string& prefix, int concurrentios) {
   lock_cond lc(&lock);
-  std::string name[concurrentios];
+  std::vector<string> name(concurrentios);
   std::string newName;
   int r = 0;
   utime_t runtime;
-- 
1.8.1.2

