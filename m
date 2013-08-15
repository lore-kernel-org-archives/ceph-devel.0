From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Ceph: Remove useless variable revoked_rdcache
Date: Thu, 15 Aug 2013 15:54:38 +0800
Message-ID: <1376553278-8153-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:39428 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab3HOHys (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Aug 2013 03:54:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>

Cleanup in handle_cap_grant()

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/ceph/caps.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 25442b4..8c90cae 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2361,7 +2361,6 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	int check_caps = 0;
 	int wake = 0;
 	int writeback = 0;
-	int revoked_rdcache = 0;
 	int queue_invalidate = 0;
 
 	dout("handle_cap_grant inode %p cap %p mds%d seq %d %s\n",
@@ -2377,9 +2376,7 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	if (((cap->issued & ~newcaps) & CEPH_CAP_FILE_CACHE) &&
 	    (newcaps & CEPH_CAP_FILE_LAZYIO) == 0 &&
 	    !ci->i_wrbuffer_ref) {
-		if (try_nonblocking_invalidate(inode) == 0) {
-			revoked_rdcache = 1;
-		} else {
+		if (try_nonblocking_invalidate(inode)) {
 			/* there were locked pages.. invalidate later
 			   in a separate thread. */
 			if (ci->i_rdcache_revoking != ci->i_rdcache_gen) {
-- 
1.7.9.5

