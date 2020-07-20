From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ceph: super.h: delete a duplicated word
Date: Sun, 19 Jul 2020 17:12:59 -0700
Message-ID: <20200720001259.21668-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/super.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/fs/ceph/super.h
+++ linux-next-20200717/fs/ceph/super.h
@@ -353,7 +353,7 @@ struct ceph_inode_info {
 	unsigned i_dirty_caps, i_flushing_caps;     /* mask of dirtied fields */
 
 	/*
-	 * Link to the the auth cap's session's s_cap_dirty list. s_cap_dirty
+	 * Link to the auth cap's session's s_cap_dirty list. s_cap_dirty
 	 * is protected by the mdsc->cap_dirty_lock, but each individual item
 	 * is also protected by the inode's i_ceph_lock. Walking s_cap_dirty
 	 * requires the mdsc->cap_dirty_lock. List presence for an item can
