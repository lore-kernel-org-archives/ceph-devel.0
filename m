From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 06/47] block-rbd: Rename jump labels in rbd_add_parse_args()
Date: Mon, 12 Sep 2016 20:47:51 +0200
Message-ID: <96128866-0e4e-65bb-9342-44ce885616e5@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Sep 2016 15:20:48 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a6d9a06..dd4da1f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5709,27 +5709,27 @@ static int rbd_add_parse_args(const char *buf,
 		return -ENOMEM;
 	if (!*options) {
 		rbd_warn(NULL, "no options provided");
-		goto out_err;
+		goto free_options;
 	}
 
 	spec = rbd_spec_alloc();
 	if (!spec)
-		goto out_mem;
+		goto status_indication;
 
 	spec->pool_name = dup_token(&buf, NULL);
 	if (!spec->pool_name)
-		goto out_mem;
+		goto status_indication;
 	if (!*spec->pool_name) {
 		rbd_warn(NULL, "no pool name provided");
-		goto out_err;
+		goto free_options;
 	}
 
 	spec->image_name = dup_token(&buf, NULL);
 	if (!spec->image_name)
-		goto out_mem;
+		goto status_indication;
 	if (!*spec->image_name) {
 		rbd_warn(NULL, "no image name provided");
-		goto out_err;
+		goto free_options;
 	}
 
 	/*
@@ -5742,11 +5742,11 @@ static int rbd_add_parse_args(const char *buf,
 		len = sizeof (RBD_SNAP_HEAD_NAME) - 1;
 	} else if (len > RBD_MAX_SNAP_NAME_LEN) {
 		ret = -ENAMETOOLONG;
-		goto out_err;
+		goto free_options;
 	}
 	snap_name = kmemdup(buf, len + 1, GFP_KERNEL);
 	if (!snap_name)
-		goto out_mem;
+		goto status_indication;
 	*(snap_name + len) = '\0';
 	spec->snap_name = snap_name;
 
@@ -5754,7 +5754,7 @@ static int rbd_add_parse_args(const char *buf,
 
 	rbd_opts = kzalloc(sizeof (*rbd_opts), GFP_KERNEL);
 	if (!rbd_opts)
-		goto out_mem;
+		goto status_indication;
 
 	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
 	rbd_opts->queue_depth = RBD_QUEUE_DEPTH_DEFAULT;
@@ -5764,7 +5764,7 @@ static int rbd_add_parse_args(const char *buf,
 					parse_rbd_opts_token, rbd_opts);
 	if (IS_ERR(copts)) {
 		ret = PTR_ERR(copts);
-		goto out_err;
+		goto free_options;
 	}
 	kfree(options);
 
@@ -5773,9 +5773,9 @@ static int rbd_add_parse_args(const char *buf,
 	*rbd_spec = spec;
 
 	return 0;
-out_mem:
+ status_indication:
 	ret = -ENOMEM;
-out_err:
+ free_options:
 	kfree(rbd_opts);
 	rbd_spec_put(spec);
 	kfree(options);
-- 
2.10.0
