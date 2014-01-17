From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/3] libceph: introduce con_fault_raise() and switch to it
Date: Fri, 17 Jan 2014 15:28:23 +0200
Message-ID: <1389965304-5667-3-git-send-email-ilya.dryomov@inktank.com>
References: <1389965304-5667-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:49827 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbaAQN3Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 08:29:24 -0500
Received: by mail-ea0-f178.google.com with SMTP id a15so630378eae.9
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jan 2014 05:29:22 -0800 (PST)
In-Reply-To: <1389965304-5667-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

In preparation for connect timeout abstract ceph_connection
fault-initiating logic into a separate function and start using it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/messenger.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 2ed1304d22a7..8ed76faf7032 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -378,6 +378,15 @@ static void con_sock_state_closed(struct ceph_connection *con)
 	     CON_SOCK_STATE_CLOSED);
 }
 
+
+static void con_fault_raise(struct ceph_connection *con)
+{
+	con_sock_state_closing(con);
+	con_flag_set(con, CON_FLAG_SOCK_CLOSED);
+	queue_con(con);
+}
+
+
 /*
  * socket callback functions
  */
@@ -433,9 +442,7 @@ static void ceph_sock_state_change(struct sock *sk)
 		dout("%s TCP_CLOSE\n", __func__);
 	case TCP_CLOSE_WAIT:
 		dout("%s TCP_CLOSE_WAIT\n", __func__);
-		con_sock_state_closing(con);
-		con_flag_set(con, CON_FLAG_SOCK_CLOSED);
-		queue_con(con);
+		con_fault_raise(con);
 		break;
 	case TCP_ESTABLISHED:
 		dout("%s TCP_ESTABLISHED\n", __func__);
-- 
1.7.10.4

