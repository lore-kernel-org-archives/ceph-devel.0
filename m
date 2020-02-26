From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: simplify ceph_monc_handle_map()
Date: Wed, 26 Feb 2020 17:22:43 +0100
Message-ID: <20200226162243.12028-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39414 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgBZQXC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Feb 2020 11:23:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so3872373wme.4
        for <ceph-devel@vger.kernel.org>; Wed, 26 Feb 2020 08:23:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>

ceph_monc_handle_map() confuses static checkers which report a
false use-after-free on monc->monmap, missing that monc->monmap and
client->monc.monmap is the same pointer.

Use monc->monmap consistently and get rid of "old", which is redundant.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/mon_client.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 9d9e4e4ea600..3d8c8015e976 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -467,7 +467,7 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
 				 struct ceph_msg *msg)
 {
 	struct ceph_client *client = monc->client;
-	struct ceph_monmap *monmap = NULL, *old = monc->monmap;
+	struct ceph_monmap *monmap;
 	void *p, *end;
 
 	mutex_lock(&monc->mutex);
@@ -484,13 +484,13 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
 		goto out;
 	}
 
-	if (ceph_check_fsid(monc->client, &monmap->fsid) < 0) {
+	if (ceph_check_fsid(client, &monmap->fsid) < 0) {
 		kfree(monmap);
 		goto out;
 	}
 
-	client->monc.monmap = monmap;
-	kfree(old);
+	kfree(monc->monmap);
+	monc->monmap = monmap;
 
 	__ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);
 	client->have_fsid = true;
-- 
2.19.2
