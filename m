From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 11/16] mds: consider revoking caps in imported caps as issued
Date: Mon, 19 Nov 2012 10:43:43 +0800
Message-ID: <1353293028-15238-12-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23714 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929Ab2KSCoD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:44:03 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The clients may already send caps release message to the exporting
MDS, so the importing MDS waits for the release message forever.
consider revoking caps as issued can avoid this issue.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Capability.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/mds/Capability.h b/src/mds/Capability.h
index f374328..6fe67f4 100644
--- a/src/mds/Capability.h
+++ b/src/mds/Capability.h
@@ -297,7 +297,8 @@ public:
     int newpending = other.pending | pending();
     if (other.issued & ~newpending)
       issue(other.issued | newpending);
-    issue(newpending);
+    else
+      issue(newpending);
     last_issue_stamp = other.last_issue_stamp;
 
     client_follows = other.client_follows;
@@ -311,7 +312,8 @@ public:
     int newpending = pending();
     if (otherissued & ~newpending)
       issue(otherissued | newpending);
-    issue(newpending);
+    else
+      issue(newpending);
 
     // wanted
     _wanted = _wanted | otherwanted;
-- 
1.7.11.7

