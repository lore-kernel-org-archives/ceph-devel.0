From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/4] libceph: add nocephx_sign_messages option
Date: Mon,  2 Nov 2015 23:44:10 +0100
Message-ID: <1446504250-25647-5-git-send-email-idryomov@gmail.com>
References: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35705 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbbKBVEe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 16:04:34 -0500
Received: by wicll6 with SMTP id ll6so58049069wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2015 13:04:32 -0800 (PST)
In-Reply-To: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

Support for message signing was merged into 3.19, along with
nocephx_require_signatures option.  But, all that option does is allow
the kernel client to talk to clusters that don't support MSG_AUTH
feature bit.  That's pretty useless, given that it's been supported
since bobtail.

Meanwhile, if one disables message signing on the server side with
"cephx sign messages = false", it becomes impossible to use the kernel
client since it expects messages to be signed if MSG_AUTH was
negotiated.  Add nocephx_sign_messages option to support this use case.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/libceph.h |  3 ++-
 net/ceph/auth_x.c            |  7 +++++++
 net/ceph/ceph_common.c       | 12 ++++++++++++
 net/ceph/messenger.c         |  2 +-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index a7caafe03d3c..3e3799cdc6e6 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -29,8 +29,9 @@
 #define CEPH_OPT_NOSHARE          (1<<1) /* don't share client with other sbs */
 #define CEPH_OPT_MYIP             (1<<2) /* specified my ip */
 #define CEPH_OPT_NOCRC            (1<<3) /* no data crc on writes */
-#define CEPH_OPT_NOMSGAUTH	  (1<<4) /* not require cephx message signature */
+#define CEPH_OPT_NOMSGAUTH	  (1<<4) /* don't require msg signing feat */
 #define CEPH_OPT_TCP_NODELAY	  (1<<5) /* TCP_NODELAY on TCP sockets */
+#define CEPH_OPT_NOMSGSIGN	  (1<<6) /* don't sign msgs */
 
 #define CEPH_OPT_DEFAULT   (CEPH_OPT_TCP_NODELAY)
 
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 3a544ca6b5ce..10d87753ed87 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -8,6 +8,7 @@
 
 #include <linux/ceph/decode.h>
 #include <linux/ceph/auth.h>
+#include <linux/ceph/libceph.h>
 #include <linux/ceph/messenger.h>
 
 #include "crypto.h"
@@ -698,6 +699,9 @@ static int ceph_x_sign_message(struct ceph_auth_handshake *auth,
 {
 	int ret;
 
+	if (ceph_test_opt(from_msgr(msg->con->msgr), NOMSGSIGN))
+		return 0;
+
 	ret = calcu_signature((struct ceph_x_authorizer *)auth->authorizer,
 			      msg, &msg->footer.sig);
 	if (ret < 0)
@@ -712,6 +716,9 @@ static int ceph_x_check_message_signature(struct ceph_auth_handshake *auth,
 	__le64 sig_check;
 	int ret;
 
+	if (ceph_test_opt(from_msgr(msg->con->msgr), NOMSGSIGN))
+		return 0;
+
 	ret = calcu_signature((struct ceph_x_authorizer *)auth->authorizer,
 			      msg, &sig_check);
 	if (ret < 0)
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index d1494d1a8592..6b4d3a1684de 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -245,6 +245,8 @@ enum {
 	Opt_nocrc,
 	Opt_cephx_require_signatures,
 	Opt_nocephx_require_signatures,
+	Opt_cephx_sign_messages,
+	Opt_nocephx_sign_messages,
 	Opt_tcp_nodelay,
 	Opt_notcp_nodelay,
 };
@@ -267,6 +269,8 @@ static match_table_t opt_tokens = {
 	{Opt_nocrc, "nocrc"},
 	{Opt_cephx_require_signatures, "cephx_require_signatures"},
 	{Opt_nocephx_require_signatures, "nocephx_require_signatures"},
+	{Opt_cephx_sign_messages, "cephx_sign_messages"},
+	{Opt_nocephx_sign_messages, "nocephx_sign_messages"},
 	{Opt_tcp_nodelay, "tcp_nodelay"},
 	{Opt_notcp_nodelay, "notcp_nodelay"},
 	{-1, NULL}
@@ -491,6 +495,12 @@ ceph_parse_options(char *options, const char *dev_name,
 		case Opt_nocephx_require_signatures:
 			opt->flags |= CEPH_OPT_NOMSGAUTH;
 			break;
+		case Opt_cephx_sign_messages:
+			opt->flags &= ~CEPH_OPT_NOMSGSIGN;
+			break;
+		case Opt_nocephx_sign_messages:
+			opt->flags |= CEPH_OPT_NOMSGSIGN;
+			break;
 
 		case Opt_tcp_nodelay:
 			opt->flags |= CEPH_OPT_TCP_NODELAY;
@@ -534,6 +544,8 @@ int ceph_print_client_options(struct seq_file *m, struct ceph_client *client)
 		seq_puts(m, "nocrc,");
 	if (opt->flags & CEPH_OPT_NOMSGAUTH)
 		seq_puts(m, "nocephx_require_signatures,");
+	if (opt->flags & CEPH_OPT_NOMSGSIGN)
+		seq_puts(m, "nocephx_sign_messages,");
 	if ((opt->flags & CEPH_OPT_TCP_NODELAY) == 0)
 		seq_puts(m, "notcp_nodelay,");
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 11108076bac3..0cc5608b2c8f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2677,7 +2677,7 @@ more:
 		if (ret <= 0) {
 			switch (ret) {
 			case -EBADMSG:
-				con->error_msg = "bad crc";
+				con->error_msg = "bad crc/signature";
 				/* fall through */
 			case -EBADE:
 				ret = -EIO;
-- 
2.4.3

