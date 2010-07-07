From: Yehuda Sadeh <yehuda@hq.newdream.net>
Subject: [PATCH v3 04/10] ceph-rbd: enable creation of clients that don't need mds
Date: Wed,  7 Jul 2010 15:11:26 -0700
Message-ID: <e70422dca128ea1b3d06463e7d83568a40885c8b.1278539315.git.yehuda@hq.newdream.net>
References: <cover.1278539315.git.yehuda@hq.newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34443 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619Ab0GGVu0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jul 2010 17:50:26 -0400
In-Reply-To: <cover.1278539315.git.yehuda@hq.newdream.net>
In-Reply-To: <cover.1278539315.git.yehuda@hq.newdream.net>
References: <cover.1278539315.git.yehuda@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, sage@newdream.net, Yehuda Sadeh <yehuda@hq.newdream.net>

Preparing grounds for rbd that doesn't need mds client.

Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/debugfs.c    |   11 ++++++++---
 fs/ceph/mon_client.c |    3 ++-
 fs/ceph/super.c      |   18 ++++++++++++------
 fs/ceph/super.h      |    2 ++
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 3be33fb..c5d6a01 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -440,9 +440,14 @@ int ceph_debugfs_client_init(struct ceph_client *client)
 	if (!client->debugfs_congestion_kb)
 		goto out;
 
-	sprintf(name, "../../bdi/%s", dev_name(client->sb->s_bdi->dev));
-	client->debugfs_bdi = debugfs_create_symlink("bdi", client->debugfs_dir,
-						     name);
+	if (client->backing_dev_info.dev) {
+		sprintf(name, "../../bdi/%s",
+			dev_name(client->backing_dev_info.dev));
+		client->debugfs_bdi =
+			debugfs_create_symlink("bdi",
+					       client->debugfs_dir,
+					       name);
+	}
 
 	return 0;
 
diff --git a/fs/ceph/mon_client.c b/fs/ceph/mon_client.c
index 07a5399..4e022ed 100644
--- a/fs/ceph/mon_client.c
+++ b/fs/ceph/mon_client.c
@@ -787,7 +787,8 @@ static void dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 		break;
 
 	case CEPH_MSG_MDS_MAP:
-		ceph_mdsc_handle_map(&monc->client->mdsc, msg);
+		if (monc->client->have_mdsc)
+			ceph_mdsc_handle_map(&monc->client->mdsc, msg);
 		break;
 
 	case CEPH_MSG_OSD_MAP:
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index fa87f51..14c8f5a 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -584,7 +584,8 @@ static void destroy_mount_args(struct ceph_mount_args *args)
 /*
  * create a fresh client instance
  */
-static struct ceph_client *ceph_create_client(struct ceph_mount_args *args)
+struct ceph_client *ceph_create_client(struct ceph_mount_args *args,
+				       int need_mdsc)
 {
 	struct ceph_client *client;
 	int err = -ENOMEM;
@@ -639,9 +640,13 @@ static struct ceph_client *ceph_create_client(struct ceph_mount_args *args)
 	err = ceph_osdc_init(&client->osdc, client);
 	if (err < 0)
 		goto fail_monc;
-	err = ceph_mdsc_init(&client->mdsc, client);
-	if (err < 0)
-		goto fail_osdc;
+	if (need_mdsc) {
+		err = ceph_mdsc_init(&client->mdsc, client);
+		if (err < 0)
+			goto fail_osdc;
+		client->have_mdsc = 1;
+	}
+
 	return client;
 
 fail_osdc:
@@ -668,7 +673,8 @@ static void ceph_destroy_client(struct ceph_client *client)
 	dout("destroy_client %p\n", client);
 
 	/* unmount */
-	ceph_mdsc_stop(&client->mdsc);
+	if (client->have_mdsc)
+		ceph_mdsc_stop(&client->mdsc);
 	ceph_osdc_stop(&client->osdc);
 
 	/*
@@ -963,7 +969,7 @@ static int ceph_get_sb(struct file_system_type *fs_type,
 	}
 
 	/* create client (which we may/may not use) */
-	client = ceph_create_client(args);
+	client = ceph_create_client(args, 1);
 	if (IS_ERR(client)) {
 		err = PTR_ERR(client);
 		goto out_final;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 10a4a40..2602248 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -139,6 +139,8 @@ struct ceph_client {
 
 	int min_caps;                  /* min caps i added */
 
+	int have_mdsc;
+
 	struct ceph_messenger *msgr;   /* messenger instance */
 	struct ceph_mon_client monc;
 	struct ceph_mds_client mdsc;
-- 
1.5.6.5

