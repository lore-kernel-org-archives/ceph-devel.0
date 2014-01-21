From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v2 2/3] libceph: introduce con_fault_raise() and switch to it
Date: Tue, 21 Jan 2014 13:11:06 +0200
Message-ID: <1390302667-8729-3-git-send-email-ilya.dryomov@inktank.com>
References: <1390302667-8729-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:46307 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbaAULMK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jan 2014 06:12:10 -0500
Received: by mail-ee0-f51.google.com with SMTP id b57so4000062eek.24
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jan 2014 03:12:09 -0800 (PST)
In-Reply-To: <1390302667-8729-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

In preparation for connect timeout abstract ceph_connection
fault-initiating logic into a separate function and start using it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/messenger.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 2ed1304d22a7..c7e0143d24f1 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -378,6 +378,14 @@ static void con_sock_state_closed(struct ceph_connection *con)
 	     CON_SOCK_STATE_CLOSED);
 }
 
+
+static void con_fault_raise(struct ceph_connection *con)
+{
+	con_flag_set(con, CON_FLAG_SOCK_CLOSED);
+	queue_con(con);
+}
+
+
 /*
  * socket callback functions
  */
@@ -434,8 +442,7 @@ static void ceph_sock_state_change(struct sock *sk)
 	case TCP_CLOSE_WAIT:
 		dout("%s TCP_CLOSE_WAIT\n", __func__);
 		con_sock_state_closing(con);
-		con_flag_set(con, CON_FLAG_SOCK_CLOSED);
-		queue_con(con);
+		con_fault_raise(con);
 		break;
 	case TCP_ESTABLISHED:
 		dout("%s TCP_ESTABLISHED\n", __func__);
-- 
1.7.10.4

