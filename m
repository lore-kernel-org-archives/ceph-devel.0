From: Jeff Liu <jeff.liu@easystack.cn>
Subject: [PATCH] mds/mdstypes.h: drop the unnecessary format string of snprintf
Date: Mon, 27 Jun 2016 14:26:08 +0800
Message-ID: <5770C700.1020202@easystack.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:3328 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbcF0G0P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 02:26:15 -0400
Received: from [192.168.0.111] (unknown [103.10.86.234])
	by m199-177.yeah.net (HMail) with ESMTPSA id A92AE1105668
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 14:26:10 +0800 (CST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Drop the unnecessary format string of snprintf

Signed-off-by: Jie Liu <jeff.liu@easystack.cn>
---
 src/mds/mdstypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
index c69a655..3414ecd 100644
--- a/src/mds/mdstypes.h
+++ b/src/mds/mdstypes.h
@@ -741,7 +741,7 @@ struct dentry_key_t {
       uint64_t val(snapid);
       snprintf(b, sizeof(b), "%" PRIx64, val);
     } else {
-      snprintf(b, sizeof(b), "%s", "head");
+      snprintf(b, sizeof(b), "head");
     }
     ostringstream oss;
     oss << name << "_" << b;
-- 
1.8.3.2

