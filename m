From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] mds: Don't expire log segment before it's fully flushed
Date: Thu,  8 Nov 2012 20:54:14 +0800
Message-ID: <1352379255-5621-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:2159 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497Ab2KHMyW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Nov 2012 07:54:22 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Expiring log segment before it's fully flushed may cause various
issues during log replay.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/leveldb      | 2 +-
 src/mds/MDLog.cc | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/mds/MDLog.cc b/src/mds/MDLog.cc
index cac5615..b02c181 100644
--- a/src/mds/MDLog.cc
+++ b/src/mds/MDLog.cc
@@ -330,6 +330,11 @@ void MDLog::trim(int m)
     assert(ls);
     p++;
     
+    if (ls->end > journaler->get_write_safe_pos()) {
+      dout(5) << "trim segment " << ls->offset << ", not fully flushed yet, safe "
+	      << journaler->get_write_safe_pos() << " < end " << ls->end << dendl;
+      break;
+    }
     if (expiring_segments.count(ls)) {
       dout(5) << "trim already expiring segment " << ls->offset << ", " << ls->num_events << " events" << dendl;
     } else if (expired_segments.count(ls)) {
@@ -412,9 +417,6 @@ void MDLog::_expired(LogSegment *ls)
 
   if (!capped && ls == get_current_segment()) {
     dout(5) << "_expired not expiring " << ls->offset << ", last one and !capped" << dendl;
-  } else if (ls->end > journaler->get_write_safe_pos()) {
-    dout(5) << "_expired not expiring " << ls->offset << ", not fully flushed yet, safe "
-	    << journaler->get_write_safe_pos() << " < end " << ls->end << dendl;
   } else {
     // expired.
     expired_segments.insert(ls);
-- 
1.7.11.7

