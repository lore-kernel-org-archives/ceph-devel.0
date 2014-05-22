From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v3 4/4] rbd: make sure we have latest osdmap on 'rbd map'
Date: Thu, 22 May 2014 20:50:08 +0400
Message-ID: <1400777408-7016-5-git-send-email-ilya.dryomov@inktank.com>
References: <1400777408-7016-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33075 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbaEVQuV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 May 2014 12:50:21 -0400
Received: by mail-wi0-f177.google.com with SMTP id f8so4661363wiw.4
        for <ceph-devel@vger.kernel.org>; Thu, 22 May 2014 09:50:20 -0700 (PDT)
Received: from localhost ([109.110.67.203])
        by mx.google.com with ESMTPSA id en6sm1237060wib.11.2014.05.22.09.50.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 09:50:20 -0700 (PDT)
In-Reply-To: <1400777408-7016-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Given an existing idle mapping (img1), mapping an image (img2) in
a newly created pool (pool2) fails:

    $ ceph osd pool create pool1 8 8
    $ rbd create --size 1000 pool1/img1
    $ sudo rbd map pool1/img1
    $ ceph osd pool create pool2 8 8
    $ rbd create --size 1000 pool2/img2
    $ sudo rbd map pool2/img2
    rbd: sysfs write failed
    rbd: map failed: (2) No such file or directory

This is because client instances are shared by default and we don't
request an osdmap update when bumping a ref on an existing client.  The
fix is to use the mon_get_version request to see if the osdmap we have
is the latest, and block until the requested update is received if it's
not.

Fixes: http://tracker.ceph.com/issues/8184

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
v2:
- send mon_get_version request and wait for a reply only if we were
  unable to locate the pool (i.e. don't hurt the common case)

v3:
- make use of the updated MMonGetVersionReply userspace code, which
  will now populate MMonGetVersionReply tid with the tid of the
  original MMonGetVersion request

 drivers/block/rbd.c |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 552a2edcaa74..daf7b4659b4a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4683,6 +4683,38 @@ out_err:
 }
 
 /*
+ * Return pool id (>= 0) or a negative error code.
+ */
+static int rbd_add_get_pool_id(struct rbd_client *rbdc, const char *pool_name)
+{
+	u64 newest_epoch;
+	unsigned long timeout = rbdc->client->options->mount_timeout * HZ;
+	int tries = 0;
+	int ret;
+
+again:
+	ret = ceph_pg_poolid_by_name(rbdc->client->osdc.osdmap, pool_name);
+	if (ret == -ENOENT && tries++ < 1) {
+		ret = ceph_monc_do_get_version(&rbdc->client->monc, "osdmap",
+					       &newest_epoch);
+		if (ret < 0)
+			return ret;
+
+		if (rbdc->client->osdc.osdmap->epoch < newest_epoch) {
+			ceph_monc_request_next_osdmap(&rbdc->client->monc);
+			(void) ceph_monc_wait_osdmap(&rbdc->client->monc,
+						     newest_epoch, timeout);
+			goto again;
+		} else {
+			/* the osdmap we have is new enough */
+			return -ENOENT;
+		}
+	}
+
+	return ret;
+}
+
+/*
  * An rbd format 2 image has a unique identifier, distinct from the
  * name given to it by the user.  Internally, that identifier is
  * what's used to specify the names of objects related to the image.
@@ -5053,7 +5085,6 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	struct rbd_options *rbd_opts = NULL;
 	struct rbd_spec *spec = NULL;
 	struct rbd_client *rbdc;
-	struct ceph_osd_client *osdc;
 	bool read_only;
 	int rc = -ENOMEM;
 
@@ -5075,8 +5106,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	}
 
 	/* pick the pool */
-	osdc = &rbdc->client->osdc;
-	rc = ceph_pg_poolid_by_name(osdc->osdmap, spec->pool_name);
+	rc = rbd_add_get_pool_id(rbdc, spec->pool_name);
 	if (rc < 0)
 		goto err_out_client;
 	spec->pool_id = (u64)rc;
-- 
1.7.10.4

