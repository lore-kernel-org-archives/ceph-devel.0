From: Sage Weil <sage@inktank.com>
Subject: [PATCH 1/8] libceph: be less chatty about stray replies
Date: Mon, 30 Jul 2012 08:59:24 -0700
Message-ID: <1343663971-3221-2-git-send-email-sage@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45762 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab2G3P7l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 11:59:41 -0400
In-Reply-To: <1343663971-3221-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

There are many (normal) conditions that can lead to us getting
unexpected replies, include cluster topology changes, osd failures,
and timeouts.  There's no need to spam the console about it.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/osd_client.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ad427e6..42119c0 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2037,8 +2037,8 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 	if (!req) {
 		*skip = 1;
 		m = NULL;
-		pr_info("get_reply unknown tid %llu from osd%d\n", tid,
-			osd->o_osd);
+		dout("get_reply unknown tid %llu from osd%d\n", tid,
+		     osd->o_osd);
 		goto out;
 	}
 
-- 
1.7.9.5

