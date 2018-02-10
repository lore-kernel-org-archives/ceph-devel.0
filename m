From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH] ceph: change permission for readonly debugfs entries
Date: Sat, 10 Feb 2018 14:18:06 +0800
Message-ID: <1518243486-215336-1-git-send-email-cgxu519@icloud.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp004.me.com ([17.110.69.135]:58257 "EHLO
        mr11p00im-asmtp004.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeBJGSQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Feb 2018 01:18:16 -0500
Received: from process-dkim-sign-daemon.mr11p00im-asmtp004.me.com by
 mr11p00im-asmtp004.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3X002007E4VQ00@mr11p00im-asmtp004.me.com> for
 ceph-devel@vger.kernel.org; Sat, 10 Feb 2018 06:18:16 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, idryomov@gmail.com, Chengguang Xu <cgxu519@icloud.com>

Remove write permission for debugfs entries which only have readonly function.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
 fs/ceph/debugfs.c  |  8 ++++----
 net/ceph/debugfs.c | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 644def8..abdf98d 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -260,7 +260,7 @@ int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 		goto out;
 
 	fsc->debugfs_mdsmap = debugfs_create_file("mdsmap",
-					0600,
+					0400,
 					fsc->client->debugfs_dir,
 					fsc,
 					&mdsmap_show_fops);
@@ -268,7 +268,7 @@ int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 		goto out;
 
 	fsc->debugfs_mds_sessions = debugfs_create_file("mds_sessions",
-					0600,
+					0400,
 					fsc->client->debugfs_dir,
 					fsc,
 					&mds_sessions_show_fops);
@@ -276,7 +276,7 @@ int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 		goto out;
 
 	fsc->debugfs_mdsc = debugfs_create_file("mdsc",
-						0600,
+						0400,
 						fsc->client->debugfs_dir,
 						fsc,
 						&mdsc_show_fops);
@@ -292,7 +292,7 @@ int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 		goto out;
 
 	fsc->debugfs_dentry_lru = debugfs_create_file("dentry_lru",
-					0600,
+					0400,
 					fsc->client->debugfs_dir,
 					fsc,
 					&dentry_lru_show_fops);
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 1eef680..0ef0f32 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -418,7 +418,7 @@ int ceph_debugfs_client_init(struct ceph_client *client)
 		goto out;
 
 	client->monc.debugfs_file = debugfs_create_file("monc",
-						      0600,
+						      0400,
 						      client->debugfs_dir,
 						      client,
 						      &monc_show_fops);
@@ -426,7 +426,7 @@ int ceph_debugfs_client_init(struct ceph_client *client)
 		goto out;
 
 	client->osdc.debugfs_file = debugfs_create_file("osdc",
-						      0600,
+						      0400,
 						      client->debugfs_dir,
 						      client,
 						      &osdc_show_fops);
@@ -434,7 +434,7 @@ int ceph_debugfs_client_init(struct ceph_client *client)
 		goto out;
 
 	client->debugfs_monmap = debugfs_create_file("monmap",
-					0600,
+					0400,
 					client->debugfs_dir,
 					client,
 					&monmap_show_fops);
@@ -442,7 +442,7 @@ int ceph_debugfs_client_init(struct ceph_client *client)
 		goto out;
 
 	client->debugfs_osdmap = debugfs_create_file("osdmap",
-					0600,
+					0400,
 					client->debugfs_dir,
 					client,
 					&osdmap_show_fops);
@@ -450,7 +450,7 @@ int ceph_debugfs_client_init(struct ceph_client *client)
 		goto out;
 
 	client->debugfs_options = debugfs_create_file("client_options",
-					0600,
+					0400,
 					client->debugfs_dir,
 					client,
 					&client_options_show_fops);
-- 
1.8.3.1

