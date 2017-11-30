From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: drop negtive child dentries before try pruning inode's alias
Date: Thu, 30 Nov 2017 22:12:59 +0800
Message-ID: <20171130141259.8577-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752713AbdK3ONE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Nov 2017 09:13:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 672D54E90E
        for <ceph-devel@vger.kernel.org>; Thu, 30 Nov 2017 14:13:04 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

negtive child dentry holds reference on inode's alias, it makes
d_prune_aliases() do nothing.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/mds_client.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index da181acd4a61..9e7bb5fa9295 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1440,6 +1440,30 @@ static int __close_session(struct ceph_mds_client *mdsc,
 	return request_close_session(mdsc, session);
 }
 
+static bool drop_negative_children(struct dentry *dentry)
+{
+	struct dentry *child;
+	bool all_negtive = true;
+
+	if (!d_is_dir(dentry))
+		goto out;
+
+	spin_lock(&dentry->d_lock);
+	list_for_each_entry(child, &dentry->d_subdirs, d_child) {
+		if (d_really_is_positive(child)) {
+			all_negtive = false;
+			break;
+		}
+	}
+	spin_unlock(&dentry->d_lock);
+
+	if (all_negtive)
+		shrink_dcache_parent(dentry);
+out:
+	dput(dentry);
+	return all_negtive;
+}
+
 /*
  * Trim old(er) caps.
  *
@@ -1495,15 +1519,20 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 		__ceph_remove_cap(cap, true);
 		session->s_trim_caps--;
 	} else {
-		int refs;
+		struct dentry *dentry;
 		/* try dropping referring dentries */
 		spin_unlock(&ci->i_ceph_lock);
-		d_prune_aliases(inode);
-		refs = atomic_read(&inode->i_count);
-		if (refs == 1)
-			session->s_trim_caps--;
-		dout("trim_caps_cb %p cap %p  pruned, count now %d\n",
-		     inode, cap, refs);
+		dentry = d_find_any_alias(inode);
+		/* drop_negative_children() calls dput() */
+		if (dentry && drop_negative_children(dentry)) {
+			int refs;
+			d_prune_aliases(inode);
+			refs = atomic_read(&inode->i_count);
+			if (refs == 1)
+				session->s_trim_caps--;
+			dout("trim_caps_cb %p cap %p pruned, count now %d\n",
+			     inode, cap, refs);
+		}
 		return 0;
 	}
 
-- 
2.13.6

