From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/3] rbd: terminate rbd_opts_tokens with Opt_err
Date: Thu, 25 Jun 2015 12:11:18 +0300
Message-ID: <1435223480-35238-2-git-send-email-idryomov@gmail.com>
References: <1435223480-35238-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34873 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbbFYJLk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 05:11:40 -0400
Received: by lbbwc1 with SMTP id wc1so41497847lbb.2
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 02:11:39 -0700 (PDT)
Received: from localhost.localdomain ([109.110.66.238])
        by mx.google.com with ESMTPSA id ew11sm7055678lac.31.2015.06.25.02.11.38
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 02:11:38 -0700 (PDT)
In-Reply-To: <1435223480-35238-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Also nuke useless Opt_last_bool and don't break lines unnecessarily.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index bc88fbcb9715..4de8c9167c4b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -724,7 +724,7 @@ static struct rbd_client *rbd_client_find(struct ceph_options *ceph_opts)
 }
 
 /*
- * mount options
+ * (Per device) rbd map options
  */
 enum {
 	Opt_last_int,
@@ -733,8 +733,7 @@ enum {
 	/* string args above */
 	Opt_read_only,
 	Opt_read_write,
-	/* Boolean args above */
-	Opt_last_bool,
+	Opt_err
 };
 
 static match_table_t rbd_opts_tokens = {
@@ -744,8 +743,7 @@ static match_table_t rbd_opts_tokens = {
 	{Opt_read_only, "ro"},		/* Alternate spelling */
 	{Opt_read_write, "read_write"},
 	{Opt_read_write, "rw"},		/* Alternate spelling */
-	/* Boolean args above */
-	{-1, NULL}
+	{Opt_err, NULL}
 };
 
 struct rbd_options {
@@ -761,22 +759,15 @@ static int parse_rbd_opts_token(char *c, void *private)
 	int token, intval, ret;
 
 	token = match_token(c, rbd_opts_tokens, argstr);
-	if (token < 0)
-		return -EINVAL;
-
 	if (token < Opt_last_int) {
 		ret = match_int(&argstr[0], &intval);
 		if (ret < 0) {
-			pr_err("bad mount option arg (not int) "
-			       "at '%s'\n", c);
+			pr_err("bad mount option arg (not int) at '%s'\n", c);
 			return ret;
 		}
 		dout("got int token %d val %d\n", token, intval);
 	} else if (token > Opt_last_int && token < Opt_last_string) {
-		dout("got string token %d val %s\n", token,
-		     argstr[0].from);
-	} else if (token > Opt_last_string && token < Opt_last_bool) {
-		dout("got Boolean token %d\n", token);
+		dout("got string token %d val %s\n", token, argstr[0].from);
 	} else {
 		dout("got token %d\n", token);
 	}
@@ -789,9 +780,10 @@ static int parse_rbd_opts_token(char *c, void *private)
 		rbd_opts->read_only = false;
 		break;
 	default:
-		rbd_assert(false);
-		break;
+		/* libceph prints "bad option" msg */
+		return -EINVAL;
 	}
+
 	return 0;
 }
 
-- 
1.9.3

