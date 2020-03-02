From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v6 01/13] ceph: make kick_flushing_inode_caps non-static
Date: Mon,  2 Mar 2020 09:14:22 -0500
Message-ID: <20200302141434.59825-2-jlayton@kernel.org>
References: <20200302141434.59825-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgCBOOh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:14:37 -0500
In-Reply-To: <20200302141434.59825-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com

We'll need this to kick any flushing caps once the create reply
comes in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c  | 6 +++---
 fs/ceph/super.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b34f9be29622..553fd1d52456 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2427,8 +2427,8 @@ void ceph_kick_flushing_caps(struct ceph_mds_client *mdsc,
 	}
 }
 
-static void kick_flushing_inode_caps(struct ceph_mds_session *session,
-				     struct ceph_inode_info *ci)
+void ceph_kick_flushing_inode_caps(struct ceph_mds_session *session,
+				   struct ceph_inode_info *ci)
 {
 	struct ceph_mds_client *mdsc = session->s_mdsc;
 	struct ceph_cap *cap = ci->i_auth_cap;
@@ -3325,7 +3325,7 @@ static void handle_cap_grant(struct inode *inode,
 	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT) {
 		if (newcaps & ~extra_info->issued)
 			wake = true;
-		kick_flushing_inode_caps(session, ci);
+		ceph_kick_flushing_inode_caps(session, ci);
 		spin_unlock(&ci->i_ceph_lock);
 		up_read(&session->s_mdsc->snap_rwsem);
 	} else {
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index e586cff3dfd5..d10513c6f0a1 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1051,6 +1051,8 @@ extern void ceph_early_kick_flushing_caps(struct ceph_mds_client *mdsc,
 					  struct ceph_mds_session *session);
 extern void ceph_kick_flushing_caps(struct ceph_mds_client *mdsc,
 				    struct ceph_mds_session *session);
+void ceph_kick_flushing_inode_caps(struct ceph_mds_session *session,
+				   struct ceph_inode_info *ci);
 extern struct ceph_cap *ceph_get_cap_for_mds(struct ceph_inode_info *ci,
 					     int mds);
 extern void ceph_get_cap_refs(struct ceph_inode_info *ci, int caps);
-- 
2.24.1
