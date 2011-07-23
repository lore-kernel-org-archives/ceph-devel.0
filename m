From: Sage Weil <sage@newdream.net>
Subject: [PATCH 06/23] ceph: report f_bfree based on kb_avail rather than diffing.
Date: Fri, 22 Jul 2011 17:02:45 -0700
Message-ID: <1311379382-9218-7-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44313 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab1GWAFx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:53 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Greg Farnum <gregory.farnum@dreamhost.com>

From: Greg Farnum <gregory.farnum@dreamhost.com>

Signed-off-by: Greg Farnum <gregory.farnum@dreamhost.com>
---
 fs/ceph/super.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index f2f77fd..d4757c9 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -73,8 +73,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 */
 	buf->f_bsize = 1 << CEPH_BLOCK_SHIFT;
 	buf->f_blocks = le64_to_cpu(st.kb) >> (CEPH_BLOCK_SHIFT-10);
-	buf->f_bfree = (le64_to_cpu(st.kb) - le64_to_cpu(st.kb_used)) >>
-		(CEPH_BLOCK_SHIFT-10);
+	buf->f_bfree = le64_to_cpu(st.kb_avail) >> (CEPH_BLOCK_SHIFT-10);
 	buf->f_bavail = le64_to_cpu(st.kb_avail) >> (CEPH_BLOCK_SHIFT-10);
 
 	buf->f_files = le64_to_cpu(st.num_objects);
-- 
1.7.0

