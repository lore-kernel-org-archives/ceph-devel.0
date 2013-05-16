From: Mike Kelly <pioto@pioto.org>
Subject: [PATCH] ceph df: fix si units for 'global' stats
Date: Thu, 16 May 2013 13:05:09 -0400
Message-ID: <1368723910-1261-1-git-send-email-pioto@pioto.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:39780 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab3EPRFI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 May 2013 13:05:08 -0400
Received: by mail-qc0-f177.google.com with SMTP id e1so1175409qcy.36
        for <ceph-devel@vger.kernel.org>; Thu, 16 May 2013 10:05:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Mike Kelly <pioto@pioto.org>

si_t expects bytes, but it was being given kilobytes.

Signed-off-by: Mike Kelly <pioto@pioto.org>
---
 src/mon/PGMonitor.cc |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/mon/PGMonitor.cc b/src/mon/PGMonitor.cc
index ed4833b..1717298 100644
--- a/src/mon/PGMonitor.cc
+++ b/src/mon/PGMonitor.cc
@@ -1054,9 +1054,9 @@ void PGMonitor::dump_fs_stats(stringstream &ss, Formatter *f, bool verbose)
     if (verbose) {
       tbl.define_column("OBJECTS", TextTable::LEFT, TextTable::LEFT);
     }
-    tbl << stringify(si_t(pg_map.osd_sum.kb))
-        << stringify(si_t(pg_map.osd_sum.kb_avail))
-        << stringify(si_t(pg_map.osd_sum.kb_used));
+    tbl << stringify(si_t(pg_map.osd_sum.kb*1024))
+        << stringify(si_t(pg_map.osd_sum.kb_avail*1024))
+        << stringify(si_t(pg_map.osd_sum.kb_used*1024));
     tbl << percentify(((float)pg_map.osd_sum.kb_used / pg_map.osd_sum.kb)*100);
     if (verbose) {
       tbl << stringify(si_t(pg_map.pg_sum.stats.sum.num_objects));
-- 
1.7.9.5

