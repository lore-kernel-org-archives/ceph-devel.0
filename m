From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/4] rbd: move ctl_mutex lock inside rbd_client_create()
Date: Tue, 28 Feb 2012 19:45:43 -0800
Message-ID: <4F4D9F67.8000803@dreamhost.com>
References: <4F4D9F0E.4080804@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46377 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030471Ab2B2Dpo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:45:44 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3D8FB2431D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:45:44 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 0E1FC242C3
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:45:44 -0800 (PST)
In-Reply-To: <4F4D9F0E.4080804@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Since rbd_client_create() is only called in one place, move the
acquisition of the mutex around that call inside that function.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   11 +++++++----
  1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 99d5920..b3c4140 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -257,9 +257,11 @@ static struct rbd_client *rbd_client_create(struct 
ceph_options *opt,
  	kref_init(&rbdc->kref);
  	INIT_LIST_HEAD(&rbdc->node);

+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+
  	rbdc->client = ceph_create_client(opt, rbdc, 0, 0);
  	if (IS_ERR(rbdc->client))
-		goto out_rbdc;
+		goto out_mutex;
  	opt = NULL; /* Now rbdc->client is responsible for opt */

  	ret = ceph_open_session(rbdc->client);
@@ -272,12 +274,15 @@ static struct rbd_client *rbd_client_create(struct 
ceph_options *opt,
  	list_add_tail(&rbdc->node, &rbd_client_list);
  	spin_unlock(&node_lock);

+	mutex_unlock(&ctl_mutex);
+
  	dout("rbd_client_create created %p\n", rbdc);
  	return rbdc;

  out_err:
  	ceph_destroy_client(rbdc->client);
-out_rbdc:
+out_mutex:
+	mutex_unlock(&ctl_mutex);
  	kfree(rbdc);
  out_opt:
  	if (opt)
@@ -396,9 +401,7 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,
  	}
  	spin_unlock(&node_lock);

-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
  	rbdc = rbd_client_create(opt, rbd_opts);
-	mutex_unlock(&ctl_mutex);

  	if (IS_ERR(rbdc)) {
  		ret = PTR_ERR(rbdc);
-- 
1.7.5.4

