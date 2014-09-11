From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] rbd: do not return -ERANGE on auth failure
Date: Thu, 11 Sep 2014 19:10:46 +0400
Message-ID: <1410448246-6635-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:40073 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbaIKPLG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 11:11:06 -0400
Received: by mail-la0-f50.google.com with SMTP id ty20so8630908lab.9
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 08:11:04 -0700 (PDT)
Received: from localhost ([109.110.67.183])
        by mx.google.com with ESMTPSA id my10sm425677lbb.9.2014.09.11.08.11.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Sep 2014 08:11:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Trying to map an image out of a pool for which we don't have an 'x'
permission bit fails with -ERANGE from ceph_extract_encoded_string()
due to an unsigned vs signed bug.  Fix it and get rid of the -ENIVAL
sink, thus exposing rbd::get_id cls method return value.  (I've seen
a bunch of unexplained -ERANGE reports, I bet this is it).

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4b97baf8afa3..fe3726c62a37 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4924,7 +4924,7 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
 		ret = image_id ? 0 : -ENOMEM;
 		if (!ret)
 			rbd_dev->image_format = 1;
-	} else if (ret > sizeof (__le32)) {
+	} else if (ret > (int)sizeof(u32)) {
 		void *p = response;
 
 		image_id = ceph_extract_encoded_string(&p, p + ret,
@@ -4932,8 +4932,6 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
 		ret = PTR_ERR_OR_ZERO(image_id);
 		if (!ret)
 			rbd_dev->image_format = 2;
-	} else {
-		ret = -EINVAL;
 	}
 
 	if (!ret) {
-- 
1.7.10.4

