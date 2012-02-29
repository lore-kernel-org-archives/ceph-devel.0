From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/4] rbd: release client list lock sooner
Date: Tue, 28 Feb 2012 19:45:39 -0800
Message-ID: <4F4D9F63.4080306@dreamhost.com>
References: <4F4D9F0E.4080804@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46364 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030471Ab2B2Dpk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:45:40 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 0E4A624314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:45:40 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E47BF242C3
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:45:39 -0800 (PST)
In-Reply-To: <4F4D9F0E.4080804@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In rbd_get_client(), if a client is reused, a number of things
get done while still holding the list lock unnecessarily.

This just moves a few things that need no lock protection outside
the lock.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   10 ++++++----
  1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4c5bb39..4bf8300 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -383,13 +383,15 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,
  	spin_lock(&node_lock);
  	rbdc = __rbd_client_find(opt);
  	if (rbdc) {
-		ceph_destroy_options(opt);
-		kfree(rbd_opts);
-
  		/* using an existing client */
  		kref_get(&rbdc->kref);
-		rbd_dev->rbd_client = rbdc;
  		spin_unlock(&node_lock);
+
+		rbd_dev->rbd_client = rbdc;
+
+		ceph_destroy_options(opt);
+		kfree(rbd_opts);
+
  		return 0;
  	}
  	spin_unlock(&node_lock);
-- 
1.7.5.4

