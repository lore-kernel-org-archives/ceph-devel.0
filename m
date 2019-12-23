From: Chen Wandun <chenwandun@huawei.com>
Subject: [PATCH next] ceph: Fix debugfs_simple_attr.cocci warnings
Date: Mon, 23 Dec 2019 22:39:18 +0800
Message-ID: <1577111958-100981-1-git-send-email-chenwandun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org, sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: chenwandun@huawei.com
List-Id: ceph-devel.vger.kernel.org

Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
for debugfs files.

Semantic patch information:
Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
imposes some significant overhead as compared to
DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 fs/ceph/debugfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index c281f32..60a0f1a 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -243,8 +243,8 @@ static int congestion_kb_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
-			congestion_kb_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
+			 congestion_kb_set, "%llu\n");
 
 
 void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
@@ -264,11 +264,11 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 
 	dout("ceph_fs_debugfs_init\n");
 	fsc->debugfs_congestion_kb =
-		debugfs_create_file("writeback_congestion_kb",
-				    0600,
-				    fsc->client->debugfs_dir,
-				    fsc,
-				    &congestion_kb_fops);
+		debugfs_create_file_unsafe("writeback_congestion_kb",
+					   0600,
+					   fsc->client->debugfs_dir,
+					   fsc,
+					   &congestion_kb_fops);
 
 	snprintf(name, sizeof(name), "../../bdi/%s",
 		 dev_name(fsc->sb->s_bdi->dev));
-- 
2.7.4
