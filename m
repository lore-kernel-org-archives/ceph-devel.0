From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 4/8] ceph: don't release i_ceph_lock in handle_cap_trunc
Date: Mon, 23 Mar 2020 12:07:04 -0400
Message-ID: <20200323160708.104152-5-jlayton@kernel.org>
References: <20200323160708.104152-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbgCWQHN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:07:13 -0400
In-Reply-To: <20200323160708.104152-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com

There's no reason to do this here. Just have the caller handle it.
Also, add a lockdep assertion.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 6220425e2a9c..e112c1c802cf 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3651,10 +3651,9 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
  *
  * caller hold s_mutex.
  */
-static void handle_cap_trunc(struct inode *inode,
+static bool handle_cap_trunc(struct inode *inode,
 			     struct ceph_mds_caps *trunc,
 			     struct ceph_mds_session *session)
-	__releases(ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int mds = session->s_mds;
@@ -3665,7 +3664,9 @@ static void handle_cap_trunc(struct inode *inode,
 	int implemented = 0;
 	int dirty = __ceph_caps_dirty(ci);
 	int issued = __ceph_caps_issued(ceph_inode(inode), &implemented);
-	int queue_trunc = 0;
+	bool queue_trunc = false;
+
+	lockdep_assert_held(&ci->i_ceph_lock);
 
 	issued |= implemented | dirty;
 
@@ -3673,10 +3674,7 @@ static void handle_cap_trunc(struct inode *inode,
 	     inode, mds, seq, truncate_size, truncate_seq);
 	queue_trunc = ceph_fill_file_size(inode, issued,
 					  truncate_seq, truncate_size, size);
-	spin_unlock(&ci->i_ceph_lock);
-
-	if (queue_trunc)
-		ceph_queue_vmtruncate(inode);
+	return queue_trunc;
 }
 
 /*
@@ -3924,6 +3922,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	size_t snaptrace_len;
 	void *p, *end;
 	struct cap_extra_info extra_info = {};
+	bool queue_trunc;
 
 	dout("handle_caps from mds%d\n", session->s_mds);
 
@@ -4107,7 +4106,10 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_CAP_OP_TRUNC:
-		handle_cap_trunc(inode, h, session);
+		queue_trunc = handle_cap_trunc(inode, h, session);
+		spin_unlock(&ci->i_ceph_lock);
+		if (queue_trunc)
+			ceph_queue_vmtruncate(inode);
 		break;
 
 	default:
-- 
2.25.1
