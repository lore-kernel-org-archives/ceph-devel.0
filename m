From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 2/4] ceph: clear d_fsinfo pointer under d_lock
Date: Tue,  5 Jul 2016 12:27:47 -0400
Message-ID: <1467736069-27140-3-git-send-email-jlayton@redhat.com>
References: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbcGEQ1x (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Jul 2016 12:27:53 -0400
In-Reply-To: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, zyan@redhat.com
Cc: Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>

To check for a valid dentry lease, we need to get at the
ceph_dentry_info. Under rcuwalk though, we may end up with a dentry that
is on its way to destruction. Since we need to take the d_lock in
dentry_lease_is_valid already, we can just ensure that we clear the
d_fsinfo pointer out under the same lock before destroying it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/dir.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8ff7bcc7fc88..904dc671580f 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1286,10 +1286,14 @@ static void ceph_d_release(struct dentry *dentry)
 
 	dout("d_release %p\n", dentry);
 	ceph_dentry_lru_del(dentry);
+
+	spin_lock(&dentry->d_lock);
+	dentry->d_fsdata = NULL;
+	spin_unlock(&dentry->d_lock);
+
 	if (di->lease_session)
 		ceph_put_mds_session(di->lease_session);
 	kmem_cache_free(ceph_dentry_cachep, di);
-	dentry->d_fsdata = NULL;
 }
 
 static int ceph_snapdir_d_revalidate(struct dentry *dentry,
-- 
2.5.5

