From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: ceph: Check PagePrivate(page) before dereference, page->private
Date: Fri, 25 May 2012 17:15:35 +0800
Message-ID: <4FBF4DB7.9050707@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54594 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996Ab2EYJPg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 May 2012 05:15:36 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I got lots of NULL pointer dereference Oops when compiling kernel on ceph.
The bug is because the kernel page migration routine replaces some pages
in the page cache with new pages, these new pages' private can be non-zero.

Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
---
 fs/ceph/addr.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 173b1d2..1f180b1 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -984,7 +984,10 @@ retry_locked:
 	BUG_ON(!ci->i_snap_realm);
 	down_read(&mdsc->snap_rwsem);
 	BUG_ON(!ci->i_snap_realm->cached_context);
-	snapc = (void *)page->private;
+	if (PagePrivate(page))
+		snapc = (void *)page->private;
+	else
+		snapc = NULL;
 	if (snapc && snapc != ci->i_head_snapc) {
 		/*
 		 * this page is already dirty in another (older) snap
-- 
1.7.6.5
