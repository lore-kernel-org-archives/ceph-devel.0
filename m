From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/4] libceph: make ceph_msgr_wq private
Date: Tue, 28 Feb 2012 20:46:26 -0800
Message-ID: <4F4DADA2.2010309@dreamhost.com>
References: <4F4DAD34.2030202@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48671 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965408Ab2B2Eq1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:46:27 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6A3ED24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:46:27 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 590FA24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:46:27 -0800 (PST)
In-Reply-To: <4F4DAD34.2030202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The messenger workqueue has no need to be public.  So give it static
scope.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  include/linux/ceph/messenger.h |    2 --
  net/ceph/messenger.c           |    2 +-
  2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 6b5af5f..5ca0f82 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -14,8 +14,6 @@
  struct ceph_msg;
  struct ceph_connection;

-extern struct workqueue_struct *ceph_msgr_wq;       /* receive work 
queue */
-
  /*
   * Ceph defines these callbacks for handling connection events.
   */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 03868cd..9c0f73a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -97,7 +97,7 @@ static void encode_my_addr(struct ceph_messenger *msgr)
  /*
   * work queue for all reading and writing to/from the socket.
   */
-struct workqueue_struct *ceph_msgr_wq;
+static struct workqueue_struct *ceph_msgr_wq;

  int ceph_msgr_init(void)
  {
-- 
1.7.5.4

