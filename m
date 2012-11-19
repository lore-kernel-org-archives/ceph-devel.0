From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 01/16] mds: don't expire log segment before it's fully flushed
Date: Mon, 19 Nov 2012 10:43:33 +0800
Message-ID: <1353293028-15238-2-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27822 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab2KSCny (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:43:54 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Expiring log segment before it's fully flushed may cause various
issues during log replay.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDLog.cc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

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

