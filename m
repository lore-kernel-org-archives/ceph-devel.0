From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 3/3] Ceph fscache: Wait for completion of object initialization
Date: Thu, 26 Dec 2013 06:29:28 -0800
Message-ID: <c2d6ad79005983f3834fbe5b8e241281f74296fe.1388066937.git.liwang@ubuntukylin.com>
References: <cover.1388066937.git.liwang@ubuntukylin.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <cover.1388066937.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1388066937.git.liwang@ubuntukylin.com>
References: <cover.1388066937.git.liwang@ubuntukylin.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Milosz Tanski <milosz@adfin.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Min Chen <minchen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

From: Yunchuan Wen <yunchuanwen@ubuntukylin.com>

The object store limit needs to be updated after writing,
and this can be done provided the corresponding object has already
been initialized. Current object initialization is done asynchrously,
which introduce a race if a file is opened, then immediately followed
by a writing, the initialization may have not completed, the code will
reach the ASSERT in fscache_submit_exclusive_op() to cause kernel
bug.

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/ceph/cache.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 8c44fdd..834f9f3 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -205,6 +205,7 @@ void ceph_fscache_register_inode_cookie(struct ceph_fs_client* fsc,
 	ci->fscache = fscache_acquire_cookie(fsc->fscache,
 					     &ceph_fscache_inode_object_def,
 					     ci, true);
+	fscache_check_consistency(ci->fscache);
 done:
 	mutex_unlock(&inode->i_mutex);
 
-- 
1.7.9.5

