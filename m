From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/2] rbd: retry mapping with a new osdmap if pool doesn't exist
Date: Mon, 21 Apr 2014 17:26:16 +0400
Message-ID: <1398086776-7228-2-git-send-email-ilya.dryomov@inktank.com>
References: <1398086776-7228-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:61050 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbaDUN0W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Apr 2014 09:26:22 -0400
Received: by mail-ee0-f49.google.com with SMTP id c41so3596864eek.22
        for <ceph-devel@vger.kernel.org>; Mon, 21 Apr 2014 06:26:21 -0700 (PDT)
Received: from localhost ([109.110.67.18])
        by mx.google.com with ESMTPSA id u1sm103628764eex.31.2014.04.21.06.26.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 06:26:21 -0700 (PDT)
In-Reply-To: <1398086776-7228-1-git-send-email-ilya.dryomov@inktank.com>
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
request an osdmap update when bumping a ref on an existing client.
Doing this in a generic way is hard because monitors don't send any
meaningful response if the client osdmap epoch is equal to the server
epoch.  (We get a subscribe ack, but it's stateless and relying on it
is probably not a good idea.)

So fix this in an ad-hoc way, without hurting the common case.  The
side effect of this fix is that

    $ sudo rbd map <junk>/<junk>

can take up to mount_timeout to error out, but it's interruptible (and
can be worked around in userspace by checking the arguments more
carefully in the future).

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 552a2edcaa74..9d71c726a691 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4682,6 +4682,23 @@ out_err:
 	return ret;
 }
 
+static int rbd_add_get_pool_id(struct rbd_client *rbdc, const char *pool_name)
+{
+	int tries = 0;
+	int ret;
+
+again:
+	ret = ceph_pg_poolid_by_name(rbdc->client->osdc.osdmap, pool_name);
+	if (ret == -ENOENT && tries++ < 1) {
+		ceph_monc_request_next_osdmap(&rbdc->client->monc);
+		(void) ceph_monc_wait_next_osdmap(&rbdc->client->monc,
+				rbdc->client->options->mount_timeout * HZ);
+		goto again;
+	}
+
+	return ret;
+}
+
 /*
  * An rbd format 2 image has a unique identifier, distinct from the
  * name given to it by the user.  Internally, that identifier is
@@ -5053,7 +5070,6 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	struct rbd_options *rbd_opts = NULL;
 	struct rbd_spec *spec = NULL;
 	struct rbd_client *rbdc;
-	struct ceph_osd_client *osdc;
 	bool read_only;
 	int rc = -ENOMEM;
 
@@ -5075,8 +5091,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
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

