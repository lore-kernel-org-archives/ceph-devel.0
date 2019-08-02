From: john.hubbard@gmail.com
Subject: [PATCH] fs/ceph: don't return a value from void function
Date: Thu,  1 Aug 2019 18:06:58 -0700
Message-ID: <20190802010658.18150-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
List-Id: ceph-devel.vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

This fixes a build warning to that effect.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

I ran into this while working on unrelated changes, to
convert ceph over to put_user_page().

This patch is against the latest linux.git.

thanks,
John Hubbard
NVIDIA


 fs/ceph/debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 2eb88ed22993..facb387c2735 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -294,7 +294,6 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 
 void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 {
-	return 0;
 }
 
 void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
-- 
2.22.0
