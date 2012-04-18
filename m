From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/6] rbd: protect read of snapshot sequence number
Date: Wed, 18 Apr 2012 09:40:59 -0500
Message-ID: <4F8ED27B.7050105@dreamhost.com>
References: <4F8ED154.6050500@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39324 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab2DROlA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:41:00 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 847432449D
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:03 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 51A332444A
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:03 -0700 (PDT)
In-Reply-To: <4F8ED154.6050500@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is updated whenever a snapshot is added or deleted, and the
snapc pointer is changed with every refresh of the header.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
Reviewed-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |    4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1685,7 +1685,9 @@
  	if (ret < 0)
  		return ret;

-	dev->header.snapc->seq =  new_snapid;
+	down_write(&dev->header_rwsem);
+	dev->header.snapc->seq = new_snapid;
+	up_write(&dev->header_rwsem);

  	return 0;
  bad:
