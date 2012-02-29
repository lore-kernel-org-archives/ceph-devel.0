From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/3] rbd: reduce memory used for rbd_dev fields
Date: Tue, 28 Feb 2012 19:52:58 -0800
Message-ID: <4F4DA11A.4040707@dreamhost.com>
References: <4F4DA086.7050601@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52326 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030721Ab2B2Dw7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:52:59 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2DCB724318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:52:59 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 1F5F024314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:52:59 -0800 (PST)
In-Reply-To: <4F4DA086.7050601@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The length of the string containing the monitor address
specification(s) will never exceed the length of the string passed
in to rbd_add().  The same holds true for the ceph + rbd options
string.  So reduce the amount of memory allocated for these to
that length rather than the maximum (1024 bytes).

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d5b4500..1488a52 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2233,11 +2233,11 @@ static ssize_t rbd_add(struct bus_type *bus,
  	if (!try_module_get(THIS_MODULE))
  		return -ENODEV;

-	mon_dev_name = kmalloc(RBD_MAX_OPT_LEN, GFP_KERNEL);
+	mon_dev_name = kmalloc(count, GFP_KERNEL);
  	if (!mon_dev_name)
  		goto err_out_mod;

-	options = kmalloc(RBD_MAX_OPT_LEN, GFP_KERNEL);
+	options = kmalloc(count, GFP_KERNEL);
  	if (!options)
  		goto err_mon_dev;

-- 
1.7.5.4

