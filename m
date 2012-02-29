From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/4] rbd: move ctl_mutex lock inside rbd_get_client()
Date: Tue, 28 Feb 2012 19:45:41 -0800
Message-ID: <4F4D9F65.80605@dreamhost.com>
References: <4F4D9F0E.4080804@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46368 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030471Ab2B2Dpm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:45:42 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id C03492431D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:45:41 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A844724314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:45:41 -0800 (PST)
In-Reply-To: <4F4D9F0E.4080804@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Since rbd_get_client() is only called in one place, move the
acquisition of the mutex around that call inside that function.

Furthermore, within rbd_get_client(), it appears the mutex only
needs to be held while calling rbd_client_create().  (Moving
the lock inside that function will wait for the next patch.)

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |    6 +++---
  1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4bf8300..99d5920 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -396,7 +396,10 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,
  	}
  	spin_unlock(&node_lock);

+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
  	rbdc = rbd_client_create(opt, rbd_opts);
+	mutex_unlock(&ctl_mutex);
+
  	if (IS_ERR(rbdc)) {
  		ret = PTR_ERR(rbdc);
  		goto done_err;
@@ -2273,10 +2276,7 @@ static ssize_t rbd_add(struct bus_type *bus,
  	/* initialize rest of new object */
  	snprintf(rbd_dev->name, DEV_NAME_LEN, DRV_NAME "%d", rbd_dev->id);

-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
  	rc = rbd_get_client(rbd_dev, mon_dev_name, options);
-	mutex_unlock(&ctl_mutex);
-
  	if (rc < 0)
  		goto err_out_slot;

-- 
1.7.5.4

