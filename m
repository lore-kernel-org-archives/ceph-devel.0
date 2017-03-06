From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: don't set weight to IN when OSD is destroyed
Date: Mon,  6 Mar 2017 19:43:58 +0100
Message-ID: <1488825838-11576-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33264 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932420AbdCFSxc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 13:53:32 -0500
Received: by mail-wm0-f66.google.com with SMTP id n11so15260715wma.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Mar 2017 10:53:31 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-108-116.net.upcbroadband.cz. [78.102.108.116])
        by smtp.gmail.com with ESMTPSA id 32sm26180762wrr.64.2017.03.06.10.44.17
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 10:44:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Since ceph.git commit 4e28f9e63644 ("osd/OSDMap: clear osd_info,
osd_xinfo on osd deletion"), weight is set to IN when OSD is deleted.
This changes the result of applying an incremental for clients, not
just OSDs.  Because CRUSH computations are obviously affected,
pre-4e28f9e63644 servers disagree with post-4e28f9e63644 clients on
object placement, resulting in misdirected requests.

Mirrors ceph.git commit a6009d1039a55e2c77f431662b3d6cc5a8e8e63f.

Fixes: 930c53286977 ("libceph: apply new_state before new_up_client on incrementals")
Link: http://tracker.ceph.com/issues/19122
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osdmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index cc22dd282a3e..ffe9e904d4d1 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1379,7 +1379,6 @@ static int decode_new_up_state_weight(void **p, void *end,
 		if ((map->osd_state[osd] & CEPH_OSD_EXISTS) &&
 		    (xorstate & CEPH_OSD_EXISTS)) {
 			pr_info("osd%d does not exist\n", osd);
-			map->osd_weight[osd] = CEPH_OSD_IN;
 			ret = set_primary_affinity(map, osd,
 						   CEPH_OSD_DEFAULT_PRIMARY_AFFINITY);
 			if (ret)
-- 
2.4.3

