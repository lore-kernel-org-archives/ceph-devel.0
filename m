From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 2/2] ceph: multiple filesystem support
Date: Fri,  8 Apr 2016 14:50:26 +0800
Message-ID: <1460098226-69141-2-git-send-email-zyan@redhat.com>
References: <1460098226-69141-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56124 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498AbcDHGuk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Apr 2016 02:50:40 -0400
In-Reply-To: <1460098226-69141-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

To access non-default filesystem, we just need to subscribe to
mdsmap.<MDS_NAMESPACE_ID> and add a new mount option for mds
namespace id.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/super.c | 19 ++++++++++++++++++-
 fs/ceph/super.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index c973043..7db4fd6 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -108,6 +108,7 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
  * mount options
  */
 enum {
+	Opt_mds_namespace,
 	Opt_wsize,
 	Opt_rsize,
 	Opt_rasize,
@@ -143,6 +144,7 @@ enum {
 };
 
 static match_table_t fsopt_tokens = {
+	{Opt_mds_namespace, "mds_namespace=%d"},
 	{Opt_wsize, "wsize=%d"},
 	{Opt_rsize, "rsize=%d"},
 	{Opt_rasize, "rasize=%d"},
@@ -212,6 +214,9 @@ static int parse_fsopt_token(char *c, void *private)
 		break;
 
 		/* misc */
+	case Opt_mds_namespace:
+		fsopt->mds_namespace = intval;
+		break;
 	case Opt_wsize:
 		fsopt->wsize = intval;
 		break;
@@ -367,6 +372,7 @@ static int parse_mount_options(struct ceph_mount_options **pfsopt,
 	fsopt->max_readdir = CEPH_MAX_READDIR_DEFAULT;
 	fsopt->max_readdir_bytes = CEPH_MAX_READDIR_BYTES_DEFAULT;
 	fsopt->congestion_kb = default_congestion_kb();
+	fsopt->mds_namespace = -1;
 
 	/*
 	 * Distinguish the server list from the path in "dev_name".
@@ -457,6 +463,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",noacl");
 #endif
 
+	if (fsopt->mds_namespace >= 0)
+		seq_printf(m, ",mds_namespace=%d", fsopt->mds_namespace);
 	if (fsopt->wsize)
 		seq_printf(m, ",wsize=%d", fsopt->wsize);
 	if (fsopt->rsize != CEPH_RSIZE_DEFAULT)
@@ -530,7 +538,16 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 		goto fail;
 	}
 	fsc->client->extra_mon_dispatch = extra_mon_dispatch;
-	ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_MDSMAP, 0, true);
+
+	if (fsopt->mds_namespace < 0) {
+		ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_MDSMAP,
+				   0, true);
+	} else {
+		char mdsmap[CEPH_SUB_MAP_MAXLEN];
+		snprintf(mdsmap, sizeof(mdsmap), CEPH_SUB_MDSMAP".%d",
+			 fsopt->mds_namespace);
+		ceph_monc_want_map(&fsc->client->monc, mdsmap, 0, true);
+	}
 
 	fsc->mount_options = fsopt;
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index c56ff5d..1aeba59 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -62,6 +62,7 @@ struct ceph_mount_options {
 	int cap_release_safety;
 	int max_readdir;       /* max readdir result (entires) */
 	int max_readdir_bytes; /* max readdir result (bytes) */
+	int mds_namespace;
 
 	/*
 	 * everything above this point can be memcmp'd; everything below
-- 
2.5.0

