From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 03/13] ceph: handle race between vmtruncate and queuing cap snap
Date: Mon,  4 Sep 2017 17:38:58 +0800
Message-ID: <20170904093908.57316-4-zyan@redhat.com>
References: <20170904093908.57316-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16197 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753364AbdIDJjl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 05:39:41 -0400
In-Reply-To: <20170904093908.57316-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

It's possible that we create a cap snap while there is pending
vmtruncate (truncate hasn't been processed by worker thread).
We should truncate dirty pages beyond capsnap->size in that case.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/inode.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index a19fafdf87f8..373dab5173ca 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1833,9 +1833,20 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	 * possibly truncate them.. so write AND block!
 	 */
 	if (ci->i_wrbuffer_ref_head < ci->i_wrbuffer_ref) {
+		struct ceph_cap_snap *capsnap;
+		to = ci->i_truncate_size;
+		list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
+			// MDS should have revoked Frw caps
+			WARN_ON_ONCE(capsnap->writing);
+			if (capsnap->dirty_pages && capsnap->size > to)
+				to = capsnap->size;
+		}
+		spin_unlock(&ci->i_ceph_lock);
 		dout("__do_pending_vmtruncate %p flushing snaps first\n",
 		     inode);
-		spin_unlock(&ci->i_ceph_lock);
+
+		truncate_pagecache(inode, to);
+
 		filemap_write_and_wait_range(&inode->i_data, 0,
 					     inode->i_sb->s_maxbytes);
 		goto retry;
-- 
2.13.5

