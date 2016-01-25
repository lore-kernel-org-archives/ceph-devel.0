From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 8/9] libceph: reschedule tick in mon_fault()
Date: Mon, 25 Jan 2016 12:29:40 +0100
Message-ID: <1453721381-20612-9-git-send-email-idryomov@gmail.com>
References: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35317 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756742AbcAYLaS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 06:30:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id 123so10693907wmz.2
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 03:30:18 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-114-179.net.upcbroadband.cz. [78.102.114.179])
        by smtp.gmail.com with ESMTPSA id 75sm15796950wmo.22.2016.01.25.03.30.16
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:30:16 -0800 (PST)
In-Reply-To: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Doing __schedule_delayed() in the hunting branch is pointless, as the
tick will have already been scheduled by then.

What we need to do instead is *reschedule* it in the !hunting branch,
after reopen_session() changes hunt_mult, which affects the delay.
This helps with spacing out connection attempts and avoiding things
like two back-to-back attempts followed by a longer period of waiting
around.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/mon_client.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 816fb813a336..a2b45cf79dca 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -222,8 +222,8 @@ static void __schedule_delayed(struct ceph_mon_client *monc)
 		delay = CEPH_MONC_PING_INTERVAL;
 
 	dout("__schedule_delayed after %lu\n", delay);
-	schedule_delayed_work(&monc->delayed_work,
-			      round_jiffies_relative(delay));
+	mod_delayed_work(system_wq, &monc->delayed_work,
+			 round_jiffies_relative(delay));
 }
 
 const char *ceph_sub_str[] = {
@@ -1166,9 +1166,9 @@ static void mon_fault(struct ceph_connection *con)
 	if (!monc->hunting) {
 		dout("%s hunting for new mon\n", __func__);
 		reopen_session(monc);
-	} else {
-		/* already hunting, let's wait a bit */
 		__schedule_delayed(monc);
+	} else {
+		dout("%s already hunting\n", __func__);
 	}
 out:
 	mutex_unlock(&monc->mutex);
-- 
2.4.3

