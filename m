From: Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH 02/11] ceph: don't call ceph_update_writeable_page from page_mkwrite
Date: Wed, 22 Jul 2020 06:55:02 -0400
Message-ID: <20200722105511.11187-3-jlayton@kernel.org>
References: <20200722105511.11187-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVKzP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:55:15 -0400
In-Reply-To: <20200722105511.11187-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, dwysocha@redhat.com, smfrench@gmail.com

page_mkwrite should only be called with Uptodate pages, so we should
only need to flush incompatible snap contexts.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4057725e1864..4f017d552196 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1693,6 +1693,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	inode_inc_iversion_raw(inode);
 
 	do {
+		struct ceph_snap_context *snapc;
+
 		lock_page(page);
 
 		if (page_mkwrite_check_truncate(page, inode) < 0) {
@@ -1701,13 +1703,26 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 			break;
 		}
 
-		err = ceph_update_writeable_page(vma->vm_file, off, len, page);
-		if (err >= 0) {
+		snapc = ceph_find_incompatible(inode, page);
+		if (!snapc) {
 			/* success.  we'll keep the page locked. */
 			set_page_dirty(page);
 			ret = VM_FAULT_LOCKED;
+			break;
 		}
-	} while (err == -EAGAIN);
+
+		unlock_page(page);
+
+		if (IS_ERR(snapc)) {
+			ret = VM_FAULT_SIGBUS;
+			break;
+		}
+
+		ceph_queue_writeback(inode);
+		err = wait_event_killable(ci->i_cap_wq,
+				context_is_writeable_or_written(inode, snapc));
+		ceph_put_snap_context(snapc);
+	} while (err == 0);
 
 	if (ret == VM_FAULT_LOCKED ||
 	    ci->i_inline_version != CEPH_INLINE_NONE) {
-- 
2.26.2
