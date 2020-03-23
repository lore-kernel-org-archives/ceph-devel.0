From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6/8] ceph: document what protects i_dirty_item and i_flushing_item
Date: Mon, 23 Mar 2020 12:07:06 -0400
Message-ID: <20200323160708.104152-7-jlayton@kernel.org>
References: <20200323160708.104152-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgCWQHP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:07:15 -0400
In-Reply-To: <20200323160708.104152-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/super.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 47cfd8935b9c..bb372859c0ad 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -351,7 +351,9 @@ struct ceph_inode_info {
 	struct rb_root i_caps;           /* cap list */
 	struct ceph_cap *i_auth_cap;     /* authoritative cap, if any */
 	unsigned i_dirty_caps, i_flushing_caps;     /* mask of dirtied fields */
-	struct list_head i_dirty_item, i_flushing_item;
+	struct list_head i_dirty_item, i_flushing_item; /* protected by
+							 * mdsc->cap_dirty_lock
+							 */
 	/* we need to track cap writeback on a per-cap-bit basis, to allow
 	 * overlapping, pipelined cap flushes to the mds.  we can probably
 	 * reduce the tid to 8 bits if we're concerned about inode size. */
-- 
2.25.1
