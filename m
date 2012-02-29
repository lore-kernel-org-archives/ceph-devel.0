From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/4] ceph: make use of "else" where appropriate
Date: Tue, 28 Feb 2012 19:12:09 -0800
Message-ID: <4F4D9789.2080903@dreamhost.com>
References: <4F4D96F4.3080707@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44138 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030686Ab2B2DMK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:12:10 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2D85924318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:12:10 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 1E50F24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:12:10 -0800 (PST)
In-Reply-To: <4F4D96F4.3080707@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Rearrange ceph_tcp_connect() a bit, making use of "else" rather than
re-testing a value with consecutive "if" statements.  Don't record a
connection's socket pointer unless the connect operation is
successful.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   11 ++++-------
  1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 068cb7e..c9a413a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -247,7 +247,6 @@ static struct socket *ceph_tcp_connect(struct 
ceph_connection *con)
  			       IPPROTO_TCP, &sock);
  	if (ret)
  		return ERR_PTR(ret);
-	con->sock = sock;
  	sock->sk->sk_allocation = GFP_NOFS;

  #ifdef CONFIG_LOCKDEP
@@ -264,18 +263,16 @@ static struct socket *ceph_tcp_connect(struct 
ceph_connection *con)
  		dout("connect %s EINPROGRESS sk_state = %u\n",
  		     ceph_pr_addr(&con->peer_addr.in_addr),
  		     sock->sk->sk_state);
-		ret = 0;
-	}
-	if (ret < 0) {
+	} else if (ret < 0) {
  		pr_err("connect %s error %d\n",
  		       ceph_pr_addr(&con->peer_addr.in_addr), ret);
  		sock_release(sock);
-		con->sock = NULL;
  		con->error_msg = "connect error";
-	}

-	if (ret < 0)
  		return ERR_PTR(ret);
+	}
+	con->sock = sock;
+
  	return sock;
  }

-- 
1.7.5.4

