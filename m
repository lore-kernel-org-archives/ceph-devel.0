From: Chaitanya Huilgol <chaitanya.huilgol@gmail.com>
Subject: [PATCH 1/2] libceph: tcp_nodelay support
Date: Fri, 23 Jan 2015 16:41:25 +0530 (IST)
Message-ID: <alpine.DEB.2.10.1501231639250.28090@Ubuntu-VirtualBox>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1867404318-1422011488=:28090"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:56177 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbbAWLL3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 06:11:29 -0500
Received: by mail-pa0-f50.google.com with SMTP id rd3so7194633pab.9
        for <ceph-devel@vger.kernel.org>; Fri, 23 Jan 2015 03:11:29 -0800 (PST)
Received: from omr-cteravm-gm.sdcorp.global.sandisk.com ([182.71.241.147])
        by mx.google.com with ESMTPSA id w4sm1597352pdm.43.2015.01.23.03.11.27
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2015 03:11:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1867404318-1422011488=:28090
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>

TCP_NODELAY socket option set on connection sockets,
disables Nagle¢s algorithm and improves latency characteristics.
tcp_nodelay(default)/no_tcp_nodelay option flags provided to
enable/disable setting the socket option.

Signed-off-by: Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>
---
 include/linux/ceph/libceph.h   |  1 +
 include/linux/ceph/messenger.h |  4 +++-
 net/ceph/ceph_common.c         | 14 +++++++++++++-
 net/ceph/messenger.c           | 21 ++++++++++++++++++++-
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 8b11a79..4919eaa 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -30,6 +30,7 @@
 #define CEPH_OPT_MYIP             (1<<2) /* specified my ip */
 #define CEPH_OPT_NOCRC            (1<<3) /* no data crc on writes */
 #define CEPH_OPT_NOMSGAUTH	  (1<<4) /* not require cephx message signature */
+#define CEPH_OPT_NO_TCP_NODELAY   (1<<5) /* no TCP_NODELAY on TCP sockets */
 
 #define CEPH_OPT_DEFAULT   (0)
 
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index d9d396c..e50cade 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -57,6 +57,7 @@ struct ceph_messenger {
 
 	atomic_t stopping;
 	bool nocrc;
+	bool no_tcp_nodelay;
 
 	/*
 	 * the global_seq counts connections i (attempt to) initiate
@@ -264,7 +265,8 @@ extern void ceph_messenger_init(struct ceph_messenger *msgr,
 			struct ceph_entity_addr *myaddr,
 			u64 supported_features,
 			u64 required_features,
-			bool nocrc);
+			bool nocrc,
+			bool no_tcp_nodelay);
 
 extern void ceph_con_init(struct ceph_connection *con, void *private,
 			const struct ceph_connection_operations *ops,
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 5d5ab67..55d5e84 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -239,6 +239,8 @@ enum {
 	Opt_nocrc,
 	Opt_cephx_require_signatures,
 	Opt_nocephx_require_signatures,
+	Opt_tcp_nodelay,
+	Opt_no_tcp_nodelay,
 };
 
 static match_table_t opt_tokens = {
@@ -259,6 +261,8 @@ static match_table_t opt_tokens = {
 	{Opt_nocrc, "nocrc"},
 	{Opt_cephx_require_signatures, "cephx_require_signatures"},
 	{Opt_nocephx_require_signatures, "nocephx_require_signatures"},
+	{Opt_tcp_nodelay, "tcp_nodelay"},
+	{Opt_no_tcp_nodelay, "no_tcp_nodelay"},
 	{-1, NULL}
 };
 
@@ -464,6 +468,13 @@ ceph_parse_options(char *options, const char *dev_name,
 			opt->flags |= CEPH_OPT_NOMSGAUTH;
 			break;
 
+		case Opt_tcp_nodelay:
+			opt->flags &= ~CEPH_OPT_NO_TCP_NODELAY;
+			break;
+		case Opt_no_tcp_nodelay:
+			opt->flags |= CEPH_OPT_NO_TCP_NODELAY;
+			break;
+
 		default:
 			BUG_ON(token);
 		}
@@ -521,7 +532,8 @@ struct ceph_client *ceph_create_client(struct ceph_options *opt, void *private,
 	ceph_messenger_init(&client->msgr, myaddr,
 		client->supported_features,
 		client->required_features,
-		ceph_test_opt(client, NOCRC));
+		ceph_test_opt(client, NOCRC),
+		ceph_test_opt(client, NO_TCP_NODELAY));
 
 	/* subsystems */
 	err = ceph_monc_init(&client->monc, client);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 33a2f20..6464a17 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -469,6 +469,20 @@ static void set_sock_callbacks(struct socket *sock,
 /*
  * socket helpers
  */
+static void ceph_tcp_set_sock_options(struct ceph_connection *con)
+{
+	int rc;
+
+	if (!con->msgr->no_tcp_nodelay) {
+		/* Not requested to disable TCP_NODELAY, set it by default */
+		int optval = 1;
+		rc = kernel_setsockopt(con->sock, IPPROTO_TCP, TCP_NODELAY,
+		    (char *)&optval, sizeof(optval));
+		if (rc != 0) {
+			dout("Error: CEPH_CON_OPT: TCP_NODELAY: %d\n", rc);
+		}
+	}
+}
 
 /*
  * initiate connection to a remote socket.
@@ -513,6 +527,9 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 	sk_set_memalloc(sock->sk);
 
 	con->sock = sock;
+	/* process socket options if any */
+	ceph_tcp_set_sock_options(con);
+
 	return 0;
 }
 
@@ -2922,7 +2939,8 @@ void ceph_messenger_init(struct ceph_messenger *msgr,
 			struct ceph_entity_addr *myaddr,
 			u64 supported_features,
 			u64 required_features,
-			bool nocrc)
+			bool nocrc,
+			bool no_tcp_nodelay)
 {
 	msgr->supported_features = supported_features;
 	msgr->required_features = required_features;
@@ -2937,6 +2955,7 @@ void ceph_messenger_init(struct ceph_messenger *msgr,
 	get_random_bytes(&msgr->inst.addr.nonce, sizeof(msgr->inst.addr.nonce));
 	encode_my_addr(msgr);
 	msgr->nocrc = nocrc;
+	msgr->no_tcp_nodelay = no_tcp_nodelay;
 
 	atomic_set(&msgr->stopping, 0);
 
-- 
1.9.1

--8323329-1867404318-1422011488=:28090--
