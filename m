From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: set -EINVAL in one place in crush_decode()
Date: Thu, 13 Jul 2017 18:08:02 +0200
Message-ID: <1499962082-31986-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34799 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdGMQIg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jul 2017 12:08:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id p204so6032139wmg.1
        for <ceph-devel@vger.kernel.org>; Thu, 13 Jul 2017 09:08:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>

No sooner than Dan had fixed this issue in commit 293dffaad8d5
("libceph: NULL deref on crush_decode() error path"), I brought it
back.  Add a new label and set -EINVAL once, right before failing.

Fixes: 278b1d709c6a ("libceph: ceph_decode_skip_* helpers")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osdmap.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 7e01099e0a83..64ae9f89773a 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -338,7 +338,7 @@ static void crush_finalize(struct crush_map *c)
 static struct crush_map *crush_decode(void *pbyval, void *end)
 {
 	struct crush_map *c;
-	int err = -EINVAL;
+	int err;
 	int i, j;
 	void **p = &pbyval;
 	void *start = pbyval;
@@ -407,7 +407,6 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 			size = sizeof(struct crush_bucket_straw2);
 			break;
 		default:
-			err = -EINVAL;
 			goto bad;
 		}
 		BUG_ON(size == 0);
@@ -439,31 +438,31 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 			err = crush_decode_uniform_bucket(p, end,
 				  (struct crush_bucket_uniform *)b);
 			if (err < 0)
-				goto bad;
+				goto fail;
 			break;
 		case CRUSH_BUCKET_LIST:
 			err = crush_decode_list_bucket(p, end,
 			       (struct crush_bucket_list *)b);
 			if (err < 0)
-				goto bad;
+				goto fail;
 			break;
 		case CRUSH_BUCKET_TREE:
 			err = crush_decode_tree_bucket(p, end,
 				(struct crush_bucket_tree *)b);
 			if (err < 0)
-				goto bad;
+				goto fail;
 			break;
 		case CRUSH_BUCKET_STRAW:
 			err = crush_decode_straw_bucket(p, end,
 				(struct crush_bucket_straw *)b);
 			if (err < 0)
-				goto bad;
+				goto fail;
 			break;
 		case CRUSH_BUCKET_STRAW2:
 			err = crush_decode_straw2_bucket(p, end,
 				(struct crush_bucket_straw2 *)b);
 			if (err < 0)
-				goto bad;
+				goto fail;
 			break;
 		}
 	}
@@ -474,7 +473,6 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 		u32 yes;
 		struct crush_rule *r;
 
-		err = -EINVAL;
 		ceph_decode_32_safe(p, end, yes, bad);
 		if (!yes) {
 			dout("crush_decode NO rule %d off %x %p to %p\n",
@@ -489,7 +487,6 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 		/* len */
 		ceph_decode_32_safe(p, end, yes, bad);
 #if BITS_PER_LONG == 32
-		err = -EINVAL;
 		if (yes > (ULONG_MAX - sizeof(*r))
 			  / sizeof(struct crush_rule_step))
 			goto bad;
@@ -557,7 +554,7 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 	if (*p != end) {
 		err = decode_choose_args(p, end, c);
 		if (err)
-			goto bad;
+			goto fail;
 	}
 
 done:
@@ -567,10 +564,14 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 
 badmem:
 	err = -ENOMEM;
-bad:
+fail:
 	dout("crush_decode fail %d\n", err);
 	crush_destroy(c);
 	return ERR_PTR(err);
+
+bad:
+	err = -EINVAL;
+	goto fail;
 }
 
 int ceph_pg_compare(const struct ceph_pg *lhs, const struct ceph_pg *rhs)
-- 
2.4.3

