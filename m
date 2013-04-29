From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] rbd: drop module later
Date: Mon, 29 Apr 2013 13:00:21 -0500
Message-ID: <517EB535.9060308@inktank.com>
References: <517EB4F0.1070607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f175.google.com ([209.85.161.175]:33438 "EHLO
	mail-gg0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757950Ab3D2Sam (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 14:30:42 -0400
Received: by mail-gg0-f175.google.com with SMTP id l2so225428ggn.6
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 11:30:42 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id o49sm5303553yhj.3.2013.04.29.11.00.22
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 11:00:22 -0700 (PDT)
In-Reply-To: <517EB4F0.1070607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Drop the module reference at the end of rbd_remove() for symmetry
with adding a reference at the top of rbd_add().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ac94aa4..5904819 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4986,9 +4986,6 @@ static void rbd_dev_release(struct device *dev)
 	rbd_spec_put(rbd_dev->parent_spec);
 	kfree(rbd_dev->header_name);
 	rbd_dev_destroy(rbd_dev);
-
-	/* release module ref */
-	module_put(THIS_MODULE);
 }

 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
@@ -5071,6 +5068,7 @@ static ssize_t rbd_remove(struct bus_type *bus,

 	rbd_remove_all_snaps(rbd_dev);
 	rbd_bus_del_dev(rbd_dev);
+	module_put(THIS_MODULE);
 done:
 	mutex_unlock(&ctl_mutex);

-- 
1.7.9.5

