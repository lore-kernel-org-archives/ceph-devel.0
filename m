From: Sage Weil <sage@newdream.net>
Subject: [PATCH 01/23] ceph: add flags field to file_info
Date: Fri, 22 Jul 2011 17:02:40 -0700
Message-ID: <1311379382-9218-2-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44302 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab1GWAFx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:53 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/super.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index f5cabef..8febe6f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -544,7 +544,8 @@ extern void ceph_reservation_status(struct ceph_fs_client *client,
  * we keep buffered readdir results attached to file->private_data
  */
 struct ceph_file_info {
-	int fmode;     /* initialized on open */
+	short fmode;     /* initialized on open */
+	short flags;     /* CEPH_F_* */
 
 	/* readdir: position within the dir */
 	u32 frag;
-- 
1.7.0

