From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] ceph: unlock dangling spinlock in try_flush_caps
Date: Thu, 19 Oct 2017 08:52:58 -0400
Message-ID: <20171019125258.19821-1-jlayton@kernel.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753297AbdJSMxA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Oct 2017 08:53:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

sparose warns:
    fs/ceph/caps.c:2042:9: warning: context imbalance in 'try_flush_caps' - wrong count at exit

We need to exit this function with the lock unlocked, but a couple of
cases leave it locked.

Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 157fe59fbabe..1978a8cb1cb1 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1991,6 +1991,7 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
 retry:
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_NOFLUSH) {
+		spin_unlock(&ci->i_ceph_lock);
 		dout("try_flush_caps skipping %p I_NOFLUSH set\n", inode);
 		goto out;
 	}
@@ -2008,8 +2009,10 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
 			mutex_lock(&session->s_mutex);
 			goto retry;
 		}
-		if (cap->session->s_state < CEPH_MDS_SESSION_OPEN)
+		if (cap->session->s_state < CEPH_MDS_SESSION_OPEN) {
+			spin_unlock(&ci->i_ceph_lock);
 			goto out;
+		}
 
 		flushing = __mark_caps_flushing(inode, session, true,
 						&flush_tid, &oldest_flush_tid);
-- 
2.13.6

