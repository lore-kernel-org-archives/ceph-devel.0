From: weiyj_lk@163.com
Subject: [PATCH -next] rbd: fix error return code in rbd_dev_device_setup()
Date: Thu, 14 Aug 2014 08:56:08 +0800
Message-ID: <1407977768-15119-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-13.163.com ([220.181.12.13]:48910 "EHLO m12-13.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbaHNA4X (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Aug 2014 20:56:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@kernel.org>, Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, ceph-devel@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOMEM from the workqueue alloc error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/block/rbd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 623c841..f3be022 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5088,8 +5087,10 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
 
 	rbd_dev->rq_wq = alloc_workqueue(rbd_dev->disk->disk_name, 0, 0);
-	if (!rbd_dev->rq_wq)
+	if (!rbd_dev->rq_wq) {
+		ret = -ENOMEM;
 		goto err_out_mapping;
+	}
 
 	ret = rbd_bus_add_dev(rbd_dev);
 	if (ret)

