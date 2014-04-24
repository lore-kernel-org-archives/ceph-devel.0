From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/3] rbd: make sure we have latest osdmap on 'rbd map'
Date: Thu, 24 Apr 2014 20:23:27 +0400
Message-ID: <1398356607-10666-4-git-send-email-ilya.dryomov@inktank.com>
References: <1398356607-10666-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:55188 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbaDXQXh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Apr 2014 12:23:37 -0400
Received: by mail-ee0-f52.google.com with SMTP id e49so2030912eek.39
        for <ceph-devel@vger.kernel.org>; Thu, 24 Apr 2014 09:23:36 -0700 (PDT)
Received: from localhost ([109.110.67.18])
        by mx.google.com with ESMTPSA id t4sm17091455eeb.29.2014.04.24.09.23.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 09:23:35 -0700 (PDT)
In-Reply-To: <1398356607-10666-1-git-send-email-ilya.dryomov@inktank.com>
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
 drivers/block/rbd.c |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 552a2edcaa74..a3734726eef9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -723,15 +723,34 @@ static int parse_rbd_opts_token(char *c, void *private)
 static struct rbd_client *rbd_get_client(struct ceph_options *ceph_opts)
 {
 	struct rbd_client *rbdc;
+	u64 newest_epoch;
 
 	mutex_lock_nested(&client_mutex, SINGLE_DEPTH_NESTING);
 	rbdc = rbd_client_find(ceph_opts);
-	if (rbdc)	/* using an existing client */
-		ceph_destroy_options(ceph_opts);
-	else
+	if (!rbdc) {
 		rbdc = rbd_client_create(ceph_opts);
-	mutex_unlock(&client_mutex);
+		mutex_unlock(&client_mutex);
+		return rbdc;
+	}
+
+	/*
+	 * Using an existing client, make sure we've got the latest
+	 * osdmap.  Ignore the errors though, as failing to get it
+	 * doesn't necessarily prevent from working.
+	 */
+	if (ceph_monc_do_get_version(&rbdc->client->monc, "osdmap",
+				     &newest_epoch) < 0)
+		goto out;
+
+	if (rbdc->client->osdc.osdmap->epoch < newest_epoch) {
+		ceph_monc_request_next_osdmap(&rbdc->client->monc);
+		(void) ceph_monc_wait_osdmap(&rbdc->client->monc, newest_epoch,
+				    rbdc->client->options->mount_timeout * HZ);
+	}
 
+out:
+	mutex_unlock(&client_mutex);
+	ceph_destroy_options(ceph_opts);
 	return rbdc;
 }
 
-- 
1.7.10.4

