From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/2] rbd: convert to using flags field
Date: Tue, 28 Feb 2012 20:41:55 -0800
Message-ID: <4F4DAC93.5090309@dreamhost.com>
References: <4F4DAC48.7060804@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47085 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134Ab2B2Elz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:41:55 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 865FB24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:41:55 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 78CF024325
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:41:55 -0800 (PST)
In-Reply-To: <4F4DAC48.7060804@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

To allow having more than just read-only as Boolean state associated
with an rbd_device, replace the "read_only" field with a more
general "flags" field.  The non-atomic versions of bit operations
are fine for our purposes.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   14 ++++++++++----
  1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e7b443a..da38804 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -176,7 +176,8 @@ struct rbd_device {
  	char                    snap_name[RBD_MAX_SNAP_NAME_LEN];
  	u32 cur_snap;	/* index+1 of current snapshot within snap context
  			   0 - for the head */
-	int read_only;
+
+	unsigned long		flags;

  	struct list_head	node;

@@ -187,19 +188,24 @@ struct rbd_device {
  	struct device		dev;
  };

+/* Bit position definitions for the rbd_device->flags */
+enum {
+	RBD_DEV_FLAG_READ_ONLY,
+};
+
  static inline bool rbd_dev_is_readonly(struct rbd_device *rbd_dev)
  {
-	return rbd_dev->read_only;
+	return test_bit(RBD_DEV_FLAG_READ_ONLY, &rbd_dev->flags);
  }

  static inline void rbd_dev_set_readonly(struct rbd_device *rbd_dev)
  {
-	rbd_dev->read_only = true;
+	__set_bit(RBD_DEV_FLAG_READ_ONLY, &rbd_dev->flags);
  }

  static inline void rbd_dev_clear_readonly(struct rbd_device *rbd_dev)
  {
-	rbd_dev->read_only = false;
+	__clear_bit(RBD_DEV_FLAG_READ_ONLY, &rbd_dev->flags);
  }

  static DEFINE_MUTEX(ctl_mutex);	  /* Serialize 
open/close/setup/teardown */
-- 
1.7.5.4

