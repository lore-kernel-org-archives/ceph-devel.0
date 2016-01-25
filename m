From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 9/9] libceph: behave in mon_fault() if cur_mon < 0
Date: Mon, 25 Jan 2016 12:29:41 +0100
Message-ID: <1453721381-20612-10-git-send-email-idryomov@gmail.com>
References: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36200 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbcAYLaT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 06:30:19 -0500
Received: by mail-wm0-f66.google.com with SMTP id l65so10674185wmf.3
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 03:30:19 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-114-179.net.upcbroadband.cz. [78.102.114.179])
        by smtp.gmail.com with ESMTPSA id 75sm15796950wmo.22.2016.01.25.03.30.17
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:30:17 -0800 (PST)
In-Reply-To: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This can happen if __close_session() in ceph_monc_stop() races with
a connection reset.  We need to ignore such faults, otherwise it's
likely we would take !hunting, call __schedule_delayed() and end up
with delayed_work() executing on invalid memory, among other things.

The (two!) con->private tests are useless, as nothing ever clears
con->private.  Nuke them.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/mon_client.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index a2b45cf79dca..cf638c009cfa 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1155,22 +1155,17 @@ static void mon_fault(struct ceph_connection *con)
 {
 	struct ceph_mon_client *monc = con->private;
 
-	if (!monc)
-		return;
-
-	dout("mon_fault\n");
 	mutex_lock(&monc->mutex);
-	if (!con->private)
-		goto out;
-
-	if (!monc->hunting) {
-		dout("%s hunting for new mon\n", __func__);
-		reopen_session(monc);
-		__schedule_delayed(monc);
-	} else {
-		dout("%s already hunting\n", __func__);
+	dout("%s mon%d\n", __func__, monc->cur_mon);
+	if (monc->cur_mon >= 0) {
+		if (!monc->hunting) {
+			dout("%s hunting for new mon\n", __func__);
+			reopen_session(monc);
+			__schedule_delayed(monc);
+		} else {
+			dout("%s already hunting\n", __func__);
+		}
 	}
-out:
 	mutex_unlock(&monc->mutex);
 }
 
-- 
2.4.3

