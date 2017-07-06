From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 1/2] ceph: update ceph_dentry_info::lease_session when necessary
Date: Thu,  6 Jul 2017 16:02:11 +0800
Message-ID: <20170706080212.28111-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753101AbdGFIBx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Jul 2017 04:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5DEA7EBD6
        for <ceph-devel@vger.kernel.org>; Thu,  6 Jul 2017 08:01:52 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

Current code does not update ceph_dentry_info::lease_session once
it is set. If auth mds of corresponding dentry changes, dentry lease
stays in invalid state.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 53f23c9..220dfd8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1016,6 +1016,7 @@ static void update_dentry_lease(struct dentry *dentry,
 	long unsigned ttl = from_time + (duration * HZ) / 1000;
 	long unsigned half_ttl = from_time + (duration * HZ / 2) / 1000;
 	struct inode *dir;
+	struct ceph_mds_session *old_lease_session = NULL;
 
 	/*
 	 * Make sure dentry's inode matches tgt_vino. NULL tgt_vino means that
@@ -1051,8 +1052,10 @@ static void update_dentry_lease(struct dentry *dentry,
 	    time_before(ttl, di->time))
 		goto out_unlock;  /* we already have a newer lease. */
 
-	if (di->lease_session && di->lease_session != session)
-		goto out_unlock;
+	if (di->lease_session && di->lease_session != session) {
+		old_lease_session = di->lease_session;
+		di->lease_session = NULL;
+	}
 
 	ceph_dentry_lru_touch(dentry);
 
@@ -1065,6 +1068,8 @@ static void update_dentry_lease(struct dentry *dentry,
 	di->time = ttl;
 out_unlock:
 	spin_unlock(&dentry->d_lock);
+	if (old_lease_session)
+		ceph_put_mds_session(old_lease_session);
 	return;
 }
 
-- 
2.9.4

