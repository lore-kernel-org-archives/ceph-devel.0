From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] libceph: dout() is missing a newline
Date: Fri, 17 Jan 2014 15:15:22 +0200
Message-ID: <1389964522-5357-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:38344 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbaAQNQS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 08:16:18 -0500
Received: by mail-ee0-f51.google.com with SMTP id b57so2134165eek.24
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jan 2014 05:16:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Add a missing newline to dout() in __reset_osd().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 733195170490..959d332ed534 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1044,8 +1044,8 @@ static int __reset_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
 			!ceph_con_opened(&osd->o_con)) {
 		struct ceph_osd_request *req;
 
-		dout(" osd addr hasn't changed and connection never opened,"
-		     " letting msgr retry");
+		dout("osd addr hasn't changed and connection never opened, "
+		     "letting msgr retry\n");
 		/* touch each r_stamp for handle_timeout()'s benfit */
 		list_for_each_entry(req, &osd->o_requests, r_osd_item)
 			req->r_stamp = jiffies;
-- 
1.7.10.4

