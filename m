From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 1/4] Rbd: add an option for copy-on-read
Date: Thu, 21 May 2015 17:19:52 +0800
Message-ID: <55d6964afbe3bc8f130e8fe07c4dd46b8fbd8e21.1432177493.git.liwang@ubuntukylin.com>
References: <cover.1432177493.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:37362 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbEUJ2t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 05:28:49 -0400
In-Reply-To: <cover.1432177493.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1432177493.git.liwang@ubuntukylin.com>
References: <cover.1432177493.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Alex Elder <elder@kernel.org>, Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, Min Chen <minchen@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

From: Min Chen <minchen@ubuntukylin.com>

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
---
 drivers/block/rbd.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ec6c5c6..446204b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -324,6 +324,7 @@ struct rbd_mapping {
 	u64                     size;
 	u64                     features;
 	bool			read_only;
+	bool			copy_on_read;	/* rbd map option: copy on read */
 };
 
 /*
@@ -733,6 +734,7 @@ enum {
 	/* string args above */
 	Opt_read_only,
 	Opt_read_write,
+	Opt_copy_on_read,
 	/* Boolean args above */
 	Opt_last_bool,
 };
@@ -744,15 +746,19 @@ static match_table_t rbd_opts_tokens = {
 	{Opt_read_only, "ro"},		/* Alternate spelling */
 	{Opt_read_write, "read_write"},
 	{Opt_read_write, "rw"},		/* Alternate spelling */
+	{Opt_copy_on_read, "copy_on_read"},
+	{Opt_copy_on_read, "cor"},	/* Alternate spelling */
 	/* Boolean args above */
 	{-1, NULL}
 };
 
 struct rbd_options {
 	bool	read_only;
+	bool	copy_on_read;
 };
 
 #define RBD_READ_ONLY_DEFAULT	false
+#define RBD_COPY_ON_READ_DEFAULT false
 
 static int parse_rbd_opts_token(char *c, void *private)
 {
@@ -788,6 +794,9 @@ static int parse_rbd_opts_token(char *c, void *private)
 	case Opt_read_write:
 		rbd_opts->read_only = false;
 		break;
+	case Opt_copy_on_read:
+		rbd_opts->copy_on_read = true;
+		break;
 	default:
 		rbd_assert(false);
 		break;
@@ -1736,6 +1745,13 @@ static void rbd_osd_trivial_callback(struct rbd_obj_request *obj_request)
 	obj_request_done_set(obj_request);
 }
 
+static inline bool is_copy_on_read(struct rbd_device *rbd_dev)
+{
+	rbd_assert(rbd_dev);
+	rbd_assert(&rbd_dev->mapping);
+	return !rbd_dev->mapping.read_only && rbd_dev->mapping.copy_on_read;
+}
+
 static void rbd_osd_read_callback(struct rbd_obj_request *obj_request)
 {
 	struct rbd_img_request *img_request = NULL;
@@ -4933,6 +4949,7 @@ static int rbd_add_parse_args(const char *buf,
 		goto out_mem;
 
 	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
+	rbd_opts->copy_on_read = RBD_COPY_ON_READ_DEFAULT;
 
 	copts = ceph_parse_options(options, mon_addrs,
 					mon_addrs + mon_addrs_size - 1,
@@ -5385,6 +5402,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	struct rbd_spec *spec = NULL;
 	struct rbd_client *rbdc;
 	bool read_only;
+	bool copy_on_read;
 	int rc = -ENOMEM;
 
 	if (!try_module_get(THIS_MODULE))
@@ -5395,6 +5413,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	if (rc < 0)
 		goto err_out_module;
 	read_only = rbd_opts->read_only;
+	copy_on_read = rbd_opts->copy_on_read;
 	kfree(rbd_opts);
 	rbd_opts = NULL;	/* done with this */
 
@@ -5436,7 +5455,9 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 
 	if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
 		read_only = true;
+
 	rbd_dev->mapping.read_only = read_only;
+	rbd_dev->mapping.copy_on_read = copy_on_read;
 
 	rc = rbd_dev_device_setup(rbd_dev);
 	if (rc) {
-- 
1.9.1

