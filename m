From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 3/8] ceph: add comments for handle_cap_flush_ack logic
Date: Mon, 23 Mar 2020 12:07:03 -0400
Message-ID: <20200323160708.104152-4-jlayton@kernel.org>
References: <20200323160708.104152-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgCWQHN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:07:13 -0400
In-Reply-To: <20200323160708.104152-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 01877f91b85b..6220425e2a9c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3491,14 +3491,26 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	bool wake_mdsc = false;
 
 	list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_list) {
+		/* Is this the one that was flushed? */
 		if (cf->tid == flush_tid)
 			cleaned = cf->caps;
-		if (cf->caps == 0) /* capsnap */
+
+		/* Is this a capsnap? */
+		if (cf->caps == 0)
 			continue;
+
 		if (cf->tid <= flush_tid) {
+			/*
+			 * An earlier or current tid. The FLUSH_ACK should
+			 * represent a superset of this flush's caps.
+			 */
 			wake_ci |= __detach_cap_flush_from_ci(ci, cf);
 			list_add_tail(&cf->i_list, &to_remove);
 		} else {
+			/*
+			 * This is a later one. Any caps in it are still dirty
+			 * so don't count them as cleaned.
+			 */
 			cleaned &= ~cf->caps;
 			if (!cleaned)
 				break;
-- 
2.25.1
