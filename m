From: Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
Subject: [PATCH 2/2] doc/dev/logs.rst: Add performance counter writeup
Date: Fri, 16 Sep 2011 14:58:59 -0700
Message-ID: <1316210339-13659-1-git-send-email-cmccabe@alumni.cmu.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34909 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949Ab1IPWNN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2011 18:13:13 -0400
Received: by pzk1 with SMTP id 1so3159712pzk.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Sep 2011 15:13:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Colin Patrick McCabe <cmccabe@alumni.cmu.edu>, Colin McCabe <colin.mccabe@dreamhost.com>

Signed-off-by: Colin McCabe <colin.mccabe@dreamhost.com>
---
 doc/dev/logs.rst |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/doc/dev/logs.rst b/doc/dev/logs.rst
index f4bef84..9532763 100644
--- a/doc/dev/logs.rst
+++ b/doc/dev/logs.rst
@@ -29,3 +29,30 @@ the best performance.
 
 Sometimes, enabling logging can hide race conditions and other bugs by changing
 the timing of events. Keep this in mind when debugging.
+
+============
+ Performance Counters
+============
+
+Ceph daemons use performance counters to track key statistics like number of
+inodes pinned. Performance counters are essentially sets of integers and floats
+which can be set, incremented, and read using the PerfCounters api.
+
+A PerfCounters object is usually associated with a single subsystem.  It
+contains multiple counters. This object is thread-safe because it is protected
+by an internal mutex. You can create multiple PerfCounters objects.
+
+Currently, three types of performance counters are supported: u64 counters,
+float counters, and long-run floating-point average counters. These are created
+by PerfCountersBuilder::add_u64, PerfCountersBuilder::add_fl, and
+PerfCountersBuilder::add_fl_avg, respectively. u64 and float counters simply
+provide a single value which can be updated, incremented, and read atomically.
+floating-pointer average counters provide two values: the current total, and
+the number of times the total has been changed. This is intended to provide a
+long-run average value.
+
+Performance counter information can be read in JSON format from the
+administrative socket (admin_sock). This is implemented as a UNIX domain
+socket. The Ceph peformance counter plugin for collectd shows an example of how
+to access this information. Another example can be found in the unit tests for
+the administrative sockets.
-- 
1.7.2.5

