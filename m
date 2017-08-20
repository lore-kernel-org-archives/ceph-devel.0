From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ceph: Delete an unnecessary return statement in
 update_dentry_lease()
Date: Sun, 20 Aug 2017 20:39:44 +0200
Message-ID: <8a9a3d91-91b2-81ed-eafc-66fc637de539@users.sourceforge.net>
References: <b05df66b-b8a7-ac63-989d-091efecf2ab8@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b05df66b-b8a7-ac63-989d-091efecf2ab8@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 20 Aug 2017 20:08:25 +0200

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 fs/ceph/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 010e7be768e6..8eae56b2d1d6 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1067,7 +1067,6 @@ static void update_dentry_lease(struct dentry *dentry,
 	spin_unlock(&dentry->d_lock);
 	if (old_lease_session)
 		ceph_put_mds_session(old_lease_session);
-	return;
 }
 
 /*
-- 
2.14.0
