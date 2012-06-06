From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: use con get/put ops from osd_client
Date: Tue, 05 Jun 2012 22:30:46 -0500
Message-ID: <4FCECEE6.7000809@inktank.com>
References: <4FCECD7F.9030002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:63930 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab2FFDan (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 23:30:43 -0400
Received: by ghrr11 with SMTP id r11so4943580ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 20:30:42 -0700 (PDT)
In-Reply-To: <4FCECD7F.9030002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From Sage Weil <sage@inktank.com>

There were a few direct calls to ceph_con_{get,put}() instead of the con
ops from osd_client.c.  This is a bug since those ops aren't defined to
be ceph_con_get/put.

This breaks refcounting on the ceph_osd structs that contain the
ceph_connections, and could lead to all manner of strangeness.

The purpose of the ->get and ->put methods in a ceph connection are
to allow the connection to indicate it has a reference to something
external to the messaging system, *not* to indicate something
external has a reference to the connection.

[elder@inktank.com: added that last sentence]

Signed-off-by: Sage Weil <sage@newdream.net>
Reviewed-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d8b6d31..5b41a69 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -144,7 +144,7 @@ void ceph_osdc_release_request(struct kref *kref)
 		     req->r_pages, req->r_con_filling_msg);
 		ceph_con_revoke_message(req->r_con_filling_msg,
 				      req->r_reply);
-		ceph_con_put(req->r_con_filling_msg);
+		req->r_con_filling_msg->ops->put(req->r_con_filling_msg);
 	}
 	if (req->r_reply)
 		ceph_msg_put(req->r_reply);
@@ -1216,7 +1216,7 @@ static void handle_reply(struct ceph_osd_client
*osdc, struct ceph_msg *msg,
 	if (req->r_con_filling_msg == con && req->r_reply == msg) {
 		dout(" dropping con_filling_msg ref %p\n", con);
 		req->r_con_filling_msg = NULL;
-		ceph_con_put(con);
+		con->ops->put(con);
 	}

 	if (!req->r_got_reply) {
@@ -2028,7 +2028,7 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 		dout("get_reply revoking msg %p from old con %p\n",
 		     req->r_reply, req->r_con_filling_msg);
 		ceph_con_revoke_message(req->r_con_filling_msg, req->r_reply);
-		ceph_con_put(req->r_con_filling_msg);
+		req->r_con_filling_msg->ops->put(req->r_con_filling_msg);
 		req->r_con_filling_msg = NULL;
 	}

@@ -2063,7 +2063,7 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 #endif
 	}
 	*skip = 0;
-	req->r_con_filling_msg = ceph_con_get(con);
+	req->r_con_filling_msg = con->ops->get(con);
 	dout("get_reply tid %lld %p\n", tid, m);

 out:
-- 
1.7.5.4

