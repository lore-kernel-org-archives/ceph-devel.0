From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5/8] ceph: don't take i_ceph_lock in handle_cap_import
Date: Mon, 23 Mar 2020 12:07:05 -0400
Message-ID: <20200323160708.104152-6-jlayton@kernel.org>
References: <20200323160708.104152-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgCWQHO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:07:14 -0400
In-Reply-To: <20200323160708.104152-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com

Just take it before calling it. This means we have to do a couple of
minor in-memory operations under the spinlock now, but those shouldn't
be an issue.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index e112c1c802cf..3eab905ba74b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3824,7 +3824,6 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 			      struct ceph_mds_cap_peer *ph,
 			      struct ceph_mds_session *session,
 			      struct ceph_cap **target_cap, int *old_issued)
-	__acquires(ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap *cap, *ocap, *new_cap = NULL;
@@ -3849,14 +3848,13 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 
 	dout("handle_cap_import inode %p ci %p mds%d mseq %d peer %d\n",
 	     inode, ci, mds, mseq, peer);
-
 retry:
-	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ci, mds);
 	if (!cap) {
 		if (!new_cap) {
 			spin_unlock(&ci->i_ceph_lock);
 			new_cap = ceph_get_cap(mdsc, NULL);
+			spin_lock(&ci->i_ceph_lock);
 			goto retry;
 		}
 		cap = new_cap;
@@ -4070,6 +4068,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		} else {
 			down_read(&mdsc->snap_rwsem);
 		}
+		spin_lock(&ci->i_ceph_lock);
 		handle_cap_import(mdsc, inode, h, peer, session,
 				  &cap, &extra_info.issued);
 		handle_cap_grant(inode, session, cap,
-- 
2.25.1
