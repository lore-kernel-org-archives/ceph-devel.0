From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ceph: delete repeated words in fs/ceph/
Date: Thu, 23 Jul 2020 17:26:34 -0700
Message-ID: <20200724002634.2545-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgGXA0l (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jul 2020 20:26:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org

Drop duplicated words "down" and "the" in fs/ceph/super.[ch].

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org
---
Jeff, this is last of the duplicate words patches for ceph.

 fs/ceph/super.c |    2 +-
 fs/ceph/super.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200723.orig/fs/ceph/super.c
+++ linux-next-20200723/fs/ceph/super.c
@@ -828,7 +828,7 @@ static void destroy_caches(void)
 }
 
 /*
- * ceph_umount_begin - initiate forced umount.  Tear down down the
+ * ceph_umount_begin - initiate forced umount.  Tear down the
  * mount, skipping steps that may hang while waiting for server(s).
  */
 static void ceph_umount_begin(struct super_block *sb)
--- linux-next-20200723.orig/fs/ceph/super.h
+++ linux-next-20200723/fs/ceph/super.h
@@ -353,7 +353,7 @@ struct ceph_inode_info {
 	unsigned i_dirty_caps, i_flushing_caps;     /* mask of dirtied fields */
 
 	/*
-	 * Link to the the auth cap's session's s_cap_dirty list. s_cap_dirty
+	 * Link to the auth cap's session's s_cap_dirty list. s_cap_dirty
 	 * is protected by the mdsc->cap_dirty_lock, but each individual item
 	 * is also protected by the inode's i_ceph_lock. Walking s_cap_dirty
 	 * requires the mdsc->cap_dirty_lock. List presence for an item can
