From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] rbd: don't hold spinlock during messenger flush
Date: Thu, 05 Apr 2012 09:46:05 -0500
Message-ID: <4F7DB02D.7060807@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42527 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab2DEOqH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 10:46:07 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 9B40724438
	for <ceph-devel@vger.kernel.org>; Thu,  5 Apr 2012 07:48:17 -0700 (PDT)
Received: from [192.168.4.36] (unknown [12.207.22.82])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 2FF0B2442D
	for <ceph-devel@vger.kernel.org>; Thu,  5 Apr 2012 07:48:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A recent change made changes to the rbd_client_list be protected by
a spinlock.  Unfortunately in rbd_put_client(), the lock is taken
before possibly dropping the last reference to an rbd_client, and on
the last reference that eventually calls flush_workqueue() which can
sleep.

The problem was flagged by a debug spinlock warning:
     BUG: spinlock wrong CPU on CPU#3, rbd/27814

The solution is to move the spinlock acquisition and release inside
rbd_client_release(), which is the spot where it's really needed for
protecting the removal of the rbd_client from the client list.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 013c7a5..c1f7701 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -450,7 +450,9 @@ static void rbd_client_release(struct kref *kref)
  	struct rbd_client *rbdc = container_of(kref, struct rbd_client, kref);

  	dout("rbd_release_client %p\n", rbdc);
+	spin_lock(&rbd_client_list_lock);
  	list_del(&rbdc->node);
+	spin_unlock(&rbd_client_list_lock);

  	ceph_destroy_client(rbdc->client);
  	kfree(rbdc->rbd_opts);
@@ -463,9 +465,7 @@ static void rbd_client_release(struct kref *kref)
   */
  static void rbd_put_client(struct rbd_device *rbd_dev)
  {
-	spin_lock(&rbd_client_list_lock);
  	kref_put(&rbd_dev->rbd_client->kref, rbd_client_release);
-	spin_unlock(&rbd_client_list_lock);
  	rbd_dev->rbd_client = NULL;
  }

-- 
1.7.5.4

