From: Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] fs/ceph: return errcode in __get_parent().
Date: Fri,  6 Mar 2020 09:34:20 +0800
Message-ID: <1583458460-31917-1-git-send-email-hqjagain@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
List-Id: ceph-devel.vger.kernel.org

return real errcode when it's different from ENOENT.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 fs/ceph/export.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index b6bfa94..79dc068 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -315,6 +315,11 @@ static struct dentry *__get_parent(struct super_block *sb,
 
 	req->r_num_caps = 1;
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
+	if (err) {
+		ceph_mdsc_put_request(req);
+		return ERR_PTR(err);
+	}
+
 	inode = req->r_target_inode;
 	if (inode)
 		ihold(inode);
-- 
1.8.3.1
