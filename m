From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] rbd: give rbd_obj_read_sync() buffer void type
Date: Sun, 21 Apr 2013 16:16:57 -0500
Message-ID: <51745749.3010604@inktank.com>
References: <5174571C.4010203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:40344 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab3DUVRA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 17:17:00 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so3877711ieb.40
        for <ceph-devel@vger.kernel.org>; Sun, 21 Apr 2013 14:17:00 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id 8sm12884790igi.4.2013.04.21.14.16.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:16:58 -0700 (PDT)
In-Reply-To: <5174571C.4010203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Make the buf parameter into which the data is to be read have type
void pointer.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5724d41..e6da301 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2854,7 +2854,7 @@ static void rbd_free_disk(struct rbd_device *rbd_dev)
 static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 				const char *object_name,
 				u64 offset, u64 length,
-				char *buf, u64 *version)
+				void *buf, u64 *version)

 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
@@ -2957,8 +2957,7 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev,
u64 *version)
 			return ERR_PTR(-ENOMEM);

 		ret = rbd_obj_read_sync(rbd_dev, rbd_dev->header_name,
-				       0, size,
-				       (char *) ondisk, version);
+				       0, size, ondisk, version);
 		if (ret < 0)
 			goto out_err;
 		if (WARN_ON((size_t) ret < size)) {
-- 
1.7.9.5

