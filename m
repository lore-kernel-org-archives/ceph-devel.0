From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] rbd: fix up some sysfs stuff
Date: Sat, 27 Apr 2013 07:32:43 -0500
Message-ID: <517BC56B.7000804@inktank.com>
References: <517BC525.8090403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:54163 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997Ab3D0Mcp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:32:45 -0400
Received: by mail-ie0-f178.google.com with SMTP id aq17so5784111iec.37
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:32:45 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id c2sm7775009igv.1.2013.04.27.05.32.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:32:44 -0700 (PDT)
In-Reply-To: <517BC525.8090403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This just tweaks a few things in the routines that implement
rbd sysfs files.

All of the entries for an rbd device in /sys/bus/rbd/devices/<id>/
will represent information whose valid values are known by the time
they are accessible.

Right now we get the size of the mapped image by a call to
get_capacity().  There's no need to do this, because that will
return what we last set the capacity to, which is just the size
recorded for the mapping.  So just show that value instead.

We also get this under protection of the header semaphore, in order
to provide a precisely correct value.  This isn't really necessary;
these files are really informational only and it's not necessary to
be so careful.

Finally, print a special value in case the major device number is
not recorded.  Right now that won't matter much but soon the parent
images won't have devices associated with them.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 37d9349..b6f32c2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3170,13 +3170,9 @@ static ssize_t rbd_size_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
-	sector_t size;

-	down_read(&rbd_dev->header_rwsem);
-	size = get_capacity(rbd_dev->disk);
-	up_read(&rbd_dev->header_rwsem);
-
-	return sprintf(buf, "%llu\n", (unsigned long long) size * SECTOR_SIZE);
+	return sprintf(buf, "%llu\n",
+		(unsigned long long)rbd_dev->mapping.size);
 }

 /*
@@ -3189,7 +3185,7 @@ static ssize_t rbd_features_show(struct device *dev,
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

 	return sprintf(buf, "0x%016llx\n",
-			(unsigned long long) rbd_dev->mapping.features);
+			(unsigned long long)rbd_dev->mapping.features);
 }

 static ssize_t rbd_major_show(struct device *dev,
@@ -3197,7 +3193,11 @@ static ssize_t rbd_major_show(struct device *dev,
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

-	return sprintf(buf, "%d\n", rbd_dev->major);
+	if (rbd_dev->major)
+		return sprintf(buf, "%d\n", rbd_dev->major);
+
+	return sprintf(buf, "(none)\n");
+
 }

 static ssize_t rbd_client_id_show(struct device *dev,
@@ -3223,7 +3223,7 @@ static ssize_t rbd_pool_id_show(struct device *dev,
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

 	return sprintf(buf, "%llu\n",
-		(unsigned long long) rbd_dev->spec->pool_id);
+			(unsigned long long) rbd_dev->spec->pool_id);
 }

 static ssize_t rbd_name_show(struct device *dev,
-- 
1.7.9.5

