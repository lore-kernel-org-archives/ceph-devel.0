From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5/8] rbd: don't crash or leak on errors in rbd_img_obj_parent_read_full_callback()
Date: Mon, 19 Sep 2016 19:03:25 +0200
Message-ID: <1474304608-17958-6-git-send-email-idryomov@gmail.com>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35424 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbcISRDt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 13:03:49 -0400
Received: by mail-yw0-f196.google.com with SMTP id u82so8530417ywc.2
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 10:03:49 -0700 (PDT)
In-Reply-To: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

- fix parent_length == img_request->xferred assert to not fire on
  copyup read failures
- don't leak pages if copyup read fails or we can't allocate a new osd
  request

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d8070bd29fd1..b9a4e79a663f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2666,7 +2666,7 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 	rbd_assert(obj_request_type_valid(orig_request->type));
 	img_result = img_request->result;
 	parent_length = img_request->length;
-	rbd_assert(parent_length == img_request->xferred);
+	rbd_assert(img_result || parent_length == img_request->xferred);
 	rbd_img_request_put(img_request);
 
 	rbd_assert(orig_request->img_request);
@@ -2719,6 +2719,7 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 	return;
 
 out_err:
+	ceph_release_page_vector(pages, page_count);
 	orig_request->result = img_result;
 	orig_request->xferred = 0;
 	rbd_img_request_get(orig_request->img_request);
-- 
2.4.3

