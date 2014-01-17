From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/3] libceph: add function names to timeout dout()s
Date: Fri, 17 Jan 2014 15:28:22 +0200
Message-ID: <1389965304-5667-2-git-send-email-ilya.dryomov@inktank.com>
References: <1389965304-5667-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:65042 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbaAQN3W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 08:29:22 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so1767904eak.30
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jan 2014 05:29:20 -0800 (PST)
In-Reply-To: <1389965304-5667-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Add function names to timeout-related dout()s in handle_timeout() and
handle_osds_timeout().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 959d332ed534..548e63b5bcfa 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1402,7 +1402,8 @@ static void handle_timeout(struct work_struct *work)
 	unsigned long keepalive =
 		osdc->client->options->osd_keepalive_timeout * HZ;
 	struct list_head slow_osds;
-	dout("timeout\n");
+
+	dout("%s timeout\n", __func__);
 	down_read(&osdc->map_sem);
 
 	ceph_monc_request_next_osdmap(&osdc->client->monc);
@@ -1446,7 +1447,7 @@ static void handle_osds_timeout(struct work_struct *work)
 	unsigned long delay =
 		osdc->client->options->osd_idle_ttl * HZ >> 2;
 
-	dout("osds timeout\n");
+	dout("%s osds timeout\n", __func__);
 	down_read(&osdc->map_sem);
 	remove_old_osds(osdc);
 	up_read(&osdc->map_sem);
-- 
1.7.10.4

