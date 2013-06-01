From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] rbd: take a little credit
Date: Fri, 31 May 2013 20:20:49 -0500
Message-ID: <51A94C71.8020100@inktank.com>
References: <51A94BC0.4080703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:50696 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab3FABUv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 21:20:51 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so5756694iea.32
        for <ceph-devel@vger.kernel.org>; Fri, 31 May 2013 18:20:50 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id jj6sm5855497igb.6.2013.05.31.18.20.49
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 May 2013 18:20:50 -0700 (PDT)
In-Reply-To: <51A94BC0.4080703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Add a name to the list of authors.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 107e1e5..cb88a9a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5287,6 +5287,7 @@ static void __exit rbd_exit(void)
 module_init(rbd_init);
 module_exit(rbd_exit);

+MODULE_AUTHOR("Alex Elder <elder@inktank.com>");
 MODULE_AUTHOR("Sage Weil <sage@newdream.net>");
 MODULE_AUTHOR("Yehuda Sadeh <yehuda@hq.newdream.net>");
 MODULE_DESCRIPTION("rados block device");
-- 
1.7.9.5

