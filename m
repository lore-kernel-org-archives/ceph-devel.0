From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ceph: add kfree() to error path
Date: Thu, 8 Jul 2010 14:49:38 +0200
Message-ID: <20100708124938.GJ19184@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39705 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab0GHMwK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jul 2010 08:52:10 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Noah Watkins <noah@noahdesu.com>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

We leak a "pi" on this error path.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/fs/ceph/osdmap.c b/fs/ceph/osdmap.c
index 50ce64e..277f8b3 100644
--- a/fs/ceph/osdmap.c
+++ b/fs/ceph/osdmap.c
@@ -568,6 +568,7 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
 		if (ev > CEPH_PG_POOL_VERSION) {
 			pr_warning("got unknown v %d > %d of ceph_pg_pool\n",
 				   ev, CEPH_PG_POOL_VERSION);
+			kfree(pi);
 			goto bad;
 		}
 		__decode_pool(p, pi);
