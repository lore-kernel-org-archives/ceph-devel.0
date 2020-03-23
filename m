From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 7/8] ceph: fix potential race in ceph_check_caps
Date: Mon, 23 Mar 2020 12:07:07 -0400
Message-ID: <20200323160708.104152-8-jlayton@kernel.org>
References: <20200323160708.104152-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgCWQHP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:07:15 -0400
In-Reply-To: <20200323160708.104152-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com

Nothing ensures that session will still be valid by the time we
dereference the pointer. Take and put a reference.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 3eab905ba74b..061e52912991 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2051,12 +2051,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 			if (mutex_trylock(&session->s_mutex) == 0) {
 				dout("inverting session/ino locks on %p\n",
 				     session);
+				session = ceph_get_mds_session(session);
 				spin_unlock(&ci->i_ceph_lock);
 				if (took_snap_rwsem) {
 					up_read(&mdsc->snap_rwsem);
 					took_snap_rwsem = 0;
 				}
 				mutex_lock(&session->s_mutex);
+				ceph_put_mds_session(session);
 				goto retry;
 			}
 		}
-- 
2.25.1
