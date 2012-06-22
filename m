From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/9] libceph: kill fail_protocol()
Date: Fri, 22 Jun 2012 17:48:41 -0500
Message-ID: <4FE4F649.5060703@inktank.com>
References: <4FE4F534.1000009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53187 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab2FVWsk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 18:48:40 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so1973383ggl.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 15:48:40 -0700 (PDT)
In-Reply-To: <4FE4F534.1000009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

In the negotiating phase of establishing a connection, the server
can indicate various connection failures using special tag values.
The tags can mean: that the client does not have features needed
by the server; that the protocol advertised by the client is not
what the server expects; or that the authorizer data provided by
the client was not adequate to grant access.

These three cases are handled in process_connect(), which calls
fail_protocal() for all three.  The result of that is that the
connection gets reset, and the connection gets moved to CLOSED
state.

The previous patch description walks through what happens when
a connection gets marked CLOSED within try_read(), and why it's
sufficient (and better) to simply have it return a negative value.

So just do that--don't bother with fail_protocol(), just return a
negative value in these cases and let the caller sort out resetting
things.  Return -EIO in these cases rather than -1 (which can be
confused with -EPERM).

We can get rid of fail_protocol() because it is no longer used.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1476,12 +1476,6 @@ static int process_banner(struct ceph_co
 	return 1;
 }

-static void fail_protocol(struct ceph_connection *con)
-{
-	reset_connection(con);
-	set_bit(CLOSED, &con->state);  /* in case there's queued work */
-}
-
 static int process_connect(struct ceph_connection *con)
 {
 	u64 sup_feat = con->msgr->supported_features;
@@ -1499,8 +1493,7 @@ static int process_connect(struct ceph_c
 		       ceph_pr_addr(&con->peer_addr.in_addr),
 		       sup_feat, server_feat, server_feat & ~sup_feat);
 		con->error_msg = "missing required protocol features";
-		fail_protocol(con);
-		return -1;
+		return -EIO;

 	case CEPH_MSGR_TAG_BADPROTOVER:
 		pr_err("%s%lld %s protocol version mismatch,"
@@ -1510,8 +1503,7 @@ static int process_connect(struct ceph_c
 		       le32_to_cpu(con->out_connect.protocol_version),
 		       le32_to_cpu(con->in_reply.protocol_version));
 		con->error_msg = "protocol version mismatch";
-		fail_protocol(con);
-		return -1;
+		return -EIO;

 	case CEPH_MSGR_TAG_BADAUTHORIZER:
 		con->auth_retry++;
@@ -1597,8 +1589,7 @@ static int process_connect(struct ceph_c
 			       ceph_pr_addr(&con->peer_addr.in_addr),
 			       req_feat, server_feat, req_feat & ~server_feat);
 			con->error_msg = "missing required protocol features";
-			fail_protocol(con);
-			return -1;
+			return -EIO;
 		}
 		clear_bit(NEGOTIATING, &con->state);
 		set_bit(CONNECTED, &con->state);
