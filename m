From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: let MDS adjust readdir 'frag'
Date: Mon,  3 Mar 2014 10:01:22 +0800
Message-ID: <1393812082-6056-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4829 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbaCCCBr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 2 Mar 2014 21:01:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

If readdir 'frag' is adjusted, readdir 'offset' should be reset.
Otherwise some dentries may be lost when readdir and fragmenting
directory happen at the some.

Another way to fix this issue is let MDS adjust readdir 'frag'.
The code that handles MDS reply reset the readdir 'offset' if
the readdir reply is different than the requested one.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 94b80f4..ff2864a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -322,9 +322,6 @@ more:
 			fi->last_readdir = NULL;
 		}
 
-		/* requery frag tree, as the frag topology may have changed */
-		frag = ceph_choose_frag(ceph_inode(inode), frag, NULL, NULL);
-
 		dout("readdir fetching %llx.%llx frag %x offset '%s'\n",
 		     ceph_vinop(inode), frag, fi->last_name);
 		req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
-- 
1.8.5.3

