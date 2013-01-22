From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] rbd: small changes
Date: Tue, 22 Jan 2013 15:57:58 -0600
Message-ID: <50FF0B66.20805@inktank.com>
References: <50FF0B22.5060201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64110 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab3AVV6C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:58:02 -0500
Received: by mail-ie0-f180.google.com with SMTP id c10so12344275ieb.39
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:58:01 -0800 (PST)
In-Reply-To: <50FF0B22.5060201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

A few very minor changes to the rbd code:
    - RBD_MAX_OPT_LEN is unused, so get rid of it
    - Consolidate rbd options definitions
    - Make rbd_segment_name() return pointer to const char

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 007b726..4ed0741 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -69,7 +69,6 @@
 			(NAME_MAX - (sizeof (RBD_SNAP_DEV_NAME_PREFIX) - 1))

 #define RBD_MAX_SNAP_COUNT	510	/* allows max snapc to fit in 4KB */
-#define RBD_MAX_OPT_LEN		1024

 #define RBD_SNAP_HEAD_NAME	"-"

@@ -96,8 +95,6 @@
 #define DEV_NAME_LEN		32
 #define MAX_INT_FORMAT_WIDTH	((5 * sizeof (int)) / 2 + 1)

-#define RBD_READ_ONLY_DEFAULT		false
-
 /*
  * block device image metadata (in-memory version)
  */
@@ -156,10 +153,6 @@ struct rbd_spec {
 	struct kref	kref;
 };

-struct rbd_options {
-	bool	read_only;
-};
-
 /*
  * an instance of the client.  multiple devices may share an rbd client.
  */
@@ -475,6 +468,12 @@ static match_table_t rbd_opts_tokens = {
 	{-1, NULL}
 };

+struct rbd_options {
+	bool	read_only;
+};
+
+#define RBD_READ_ONLY_DEFAULT	false
+
 static int parse_rbd_opts_token(char *c, void *private)
 {
 	struct rbd_options *rbd_opts = private;
@@ -773,7 +772,7 @@ static void rbd_header_free(struct rbd_image_header
*header)
 	header->snapc = NULL;
 }

-static char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
+static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
 {
 	char *name;
 	u64 segment;
@@ -1338,7 +1337,7 @@ static int rbd_do_op(struct request *rq,
 		     struct rbd_req_coll *coll,
 		     int coll_index)
 {
-	char *seg_name;
+	const char *seg_name;
 	u64 seg_ofs;
 	u64 seg_len;
 	int ret;
-- 
1.7.9.5

