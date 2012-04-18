From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/6] rbd: remove conditional snapid parameters
Date: Wed, 18 Apr 2012 09:41:05 -0500
Message-ID: <4F8ED281.3040009@dreamhost.com>
References: <4F8ED154.6050500@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39332 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354Ab2DROlG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:41:06 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 5B9C62449D
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:09 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 2FA2B2444A
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:09 -0700 (PDT)
In-Reply-To: <4F8ED154.6050500@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The snapid parameters passed to rbd_do_op() and rbd_req_sync_op()
are now always either a valid snapid or an explicit CEPH_NOSNAP.

[elder@dreamhost.com: Rephrased the description]

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
Reviewed-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |    4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1153,7 +1153,7 @@
  			 int coll_index)
  {
  	return rbd_do_op(rq, rbd_dev, NULL,
-			 (snapid ? snapid : CEPH_NOSNAP),
+			 snapid,
  			 CEPH_OSD_OP_READ,
  			 CEPH_OSD_FLAG_READ,
  			 2,
@@ -1172,7 +1172,7 @@
  			  u64 *ver)
  {
  	return rbd_req_sync_op(dev, NULL,
-			       (snapid ? snapid : CEPH_NOSNAP),
+			       snapid,
  			       CEPH_OSD_OP_READ,
  			       CEPH_OSD_FLAG_READ,
  			       NULL,
