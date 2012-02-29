From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/4] libceph: make ceph_tcp_connect() return int
Date: Tue, 28 Feb 2012 20:46:38 -0800
Message-ID: <4F4DADAE.2000708@dreamhost.com>
References: <4F4DAD34.2030202@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48680 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965408Ab2B2Eqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:46:38 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 7596624318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:46:38 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 6A7E024314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:46:38 -0800 (PST)
In-Reply-To: <4F4DAD34.2030202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is no real need for ceph_tcp_connect() to return the socket
pointer it creates, since it already assigns it to con->sock, which
is visible to the caller.  Instead, have it return an error code,
which tidies things up a bit.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   14 ++++++--------
  1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 2e496e2..9a8a479 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -236,7 +236,7 @@ static void set_sock_callbacks(struct socket *sock,
  /*
   * initiate connection to a remote socket.
   */
-static struct socket *ceph_tcp_connect(struct ceph_connection *con)
+static int ceph_tcp_connect(struct ceph_connection *con)
  {
  	struct sockaddr_storage *paddr = &con->peer_addr.in_addr;
  	struct socket *sock;
@@ -246,7 +246,7 @@ static struct socket *ceph_tcp_connect(struct 
ceph_connection *con)
  	ret = sock_create_kern(con->peer_addr.in_addr.ss_family, SOCK_STREAM,
  			       IPPROTO_TCP, &sock);
  	if (ret)
-		return ERR_PTR(ret);
+		return ret;
  	sock->sk->sk_allocation = GFP_NOFS;

  #ifdef CONFIG_LOCKDEP
@@ -269,11 +269,11 @@ static struct socket *ceph_tcp_connect(struct 
ceph_connection *con)
  		sock_release(sock);
  		con->error_msg = "connect error";

-		return ERR_PTR(ret);
+		return ret;
  	}
  	con->sock = sock;

-	return sock;
+	return 0;
  }

  static int ceph_tcp_recvmsg(struct socket *sock, void *buf, size_t len)
@@ -1850,11 +1850,9 @@ more:
  		con->in_tag = CEPH_MSGR_TAG_READY;
  		dout("try_write initiating connect on %p new state %lu\n",
  		     con, con->state);
-		con->sock = ceph_tcp_connect(con);
-		if (IS_ERR(con->sock)) {
-			con->sock = NULL;
+		ret = ceph_tcp_connect(con);
+		if (ret < 0) {
  			con->error_msg = "connect error";
-			ret = -1;
  			goto out;
  		}
  	}
-- 
1.7.5.4

