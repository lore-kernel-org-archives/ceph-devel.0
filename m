From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/8] rbd: remove unnecessary asserts in rbd_dev_image_probe()
Date: Thu, 24 Jul 2014 12:42:44 +0400
Message-ID: <1406191369-6746-4-git-send-email-ilya.dryomov@inktank.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:58734 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934448AbaGXInE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:43:04 -0400
Received: by mail-la0-f44.google.com with SMTP id e16so1683127lan.3
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:43:01 -0700 (PDT)
Received: from localhost ([109.110.66.237])
        by mx.google.com with ESMTPSA id a7sm3874256lae.37.2014.07.24.01.43.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 01:43:00 -0700 (PDT)
In-Reply-To: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

spec->image_id assert doesn't buy us much and image_format is asserted
in rbd_dev_header_name() and rbd_dev_header_info() anyway.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0d3be608f16f..4541f6027e4a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5143,8 +5143,6 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
 	ret = rbd_dev_image_id(rbd_dev);
 	if (ret)
 		return ret;
-	rbd_assert(rbd_dev->spec->image_id);
-	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
 
 	ret = rbd_dev_header_name(rbd_dev);
 	if (ret)
-- 
1.7.10.4

