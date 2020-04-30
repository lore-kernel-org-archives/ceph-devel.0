From: Wu Bo <wubo40@huawei.com>
Subject: [PATCH V3] fs/ceph:fix double unlock in handle_cap_export()
Date: Thu, 30 Apr 2020 14:12:49 +0800
Message-ID: <1588227169-83237-1-git-send-email-wubo40@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org, ukernel@gmail.com, sage@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com, linfeilong@huawei.com, wubo40@huawei.com
List-Id: ceph-devel.vger.kernel.org

If the ceph_mdsc_open_export_target_session() return fails,
we should add mutex_lock(&session->s_mutex) on IS_ERR(tsession) block 
to avoid twice unlocking. because the session->s_mutex will be unlock
at the out_unlock lable.

--
v2 -> v3:
  - Rewrite solution, adding a mutex_lock(&session->s_mutex) 
    to the IS_ERR(tsession) block.
  - Modify the comment more clearly.
v1 -> v2:
  - add spin_lock(&ci->i_ceph_lock) before goto out_unlock lable
     

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/ceph/caps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 185db76..d27d778 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3746,6 +3746,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		WARN_ON(1);
 		tsession = NULL;
 		target = -1;
+		mutex_lock(&session->s_mutex);
 	}
 	goto retry;
 
-- 
1.8.3.1
