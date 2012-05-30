From: Alex Elder <elder@inktank.com>
Subject: [PATCH 09/13] libceph: start tracking connection socket state
Date: Wed, 30 May 2012 14:35:07 -0500
Message-ID: <4FC6766B.1090307@inktank.com>
References: <4FC673FC.3060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45094 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab2E3TfG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:35:06 -0400
Received: by mail-qc0-f174.google.com with SMTP id o28so104576qcr.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:35:05 -0700 (PDT)
In-Reply-To: <4FC673FC.3060004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Start explicitly keeping track of the state of a ceph connection's
socket, separate from the state of the connection itself.  Create
placeholder functions to encapsulate the state transitions.

     --------
     | NEW* |  transient initial state
     --------
         | con_sock_state_init()
         v
     ----------
     | CLOSED |  initialized, but no socket (and no
     ----------  TCP connection)
      ^      \
      |       \ con_sock_state_connecting()
      |        ----------------------
      |                              \
      + con_sock_state_closed()       \
      |\                               \
      | \                               \
      |  -----------                     \
      |  | CLOSING |  socket event;       \
      |  -----------  await close          \
      |       ^                            |
      |       |                            |
      |       + con_sock_state_closing()   |
      |      / \                           |
      |     /   ---------------            |
      |    /                   \           v
      |   /                    --------------
      |  /    -----------------| CONNECTING |  socket created, TCP
      |  |   /                 --------------  connect initiated
      |  |   | con_sock_state_connected()
      |  |   v
     -------------
     | CONNECTED |  TCP connection established
     -------------

Make the socket state an atomic variable, reinforcing that it's a
distinct transtion with no possible "intermediate/both" states.
This is almost certainly overkill at this point, though the
transitions into CONNECTED and CLOSING state do get called via
socket callback (the rest of the transitions occur with the
connection mutex held).  We can back out the atomicity later.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  include/linux/ceph/messenger.h |    8 ++++-
  net/ceph/messenger.c           |   63 
++++++++++++++++++++++++++++++++++++++++
  2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 920235e..5e852f4 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -137,14 +137,18 @@ struct ceph_connection {
  	const struct ceph_connection_operations *ops;

  	struct ceph_messenger *msgr;
+
+	atomic_t sock_state;
  	struct socket *sock;
+	struct ceph_entity_addr peer_addr; /* peer address */
+	struct ceph_entity_addr peer_addr_for_me;
+
  	unsigned long flags;
  	unsigned long state;
  	const char *error_msg;  /* error message, if any */

-	struct ceph_entity_addr peer_addr; /* peer address */
  	struct ceph_entity_name peer_name; /* peer name */
-	struct ceph_entity_addr peer_addr_for_me;
+
  	unsigned peer_features;
  	u32 connect_seq;      /* identify the most recent connection
  				 attempt for this connection, client */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 29055df..7e11b07 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -29,6 +29,14 @@
   * the sender.
   */

+/* State values for ceph_connection->sock_state; NEW is assumed to be 0 */
+
+#define CON_SOCK_STATE_NEW		0	/* -> CLOSED */
+#define CON_SOCK_STATE_CLOSED		1	/* -> CONNECTING */
+#define CON_SOCK_STATE_CONNECTING	2	/* -> CONNECTED or -> CLOSING */
+#define CON_SOCK_STATE_CONNECTED	3	/* -> CLOSING or -> CLOSED */
+#define CON_SOCK_STATE_CLOSING		4	/* -> CLOSED */
+
  /* static tag bytes (protocol control messages) */
  static char tag_msg = CEPH_MSGR_TAG_MSG;
  static char tag_ack = CEPH_MSGR_TAG_ACK;
@@ -147,6 +155,54 @@ void ceph_msgr_flush(void)
  }
  EXPORT_SYMBOL(ceph_msgr_flush);

+/* Connection socket state transition functions */
+
+static void con_sock_state_init(struct ceph_connection *con)
+{
+	int old_state;
+
+	old_state = atomic_xchg(&con->sock_state, CON_SOCK_STATE_CLOSED);
+	if (WARN_ON(old_state != CON_SOCK_STATE_NEW))
+		printk("%s: unexpected old state %d\n", __func__, old_state);
+}
+
+static void con_sock_state_connecting(struct ceph_connection *con)
+{
+	int old_state;
+
+	old_state = atomic_xchg(&con->sock_state, CON_SOCK_STATE_CONNECTING);
+	if (WARN_ON(old_state != CON_SOCK_STATE_CLOSED))
+		printk("%s: unexpected old state %d\n", __func__, old_state);
+}
+
+static void con_sock_state_connected(struct ceph_connection *con)
+{
+	int old_state;
+
+	old_state = atomic_xchg(&con->sock_state, CON_SOCK_STATE_CONNECTED);
+	if (WARN_ON(old_state != CON_SOCK_STATE_CONNECTING))
+		printk("%s: unexpected old state %d\n", __func__, old_state);
+}
+
+static void con_sock_state_closing(struct ceph_connection *con)
+{
+	int old_state;
+
+	old_state = atomic_xchg(&con->sock_state, CON_SOCK_STATE_CLOSING);
+	if (WARN_ON(old_state != CON_SOCK_STATE_CONNECTING &&
+			old_state != CON_SOCK_STATE_CONNECTED))
+		printk("%s: unexpected old state %d\n", __func__, old_state);
+}
+
+static void con_sock_state_closed(struct ceph_connection *con)
+{
+	int old_state;
+
+	old_state = atomic_xchg(&con->sock_state, CON_SOCK_STATE_CLOSED);
+	if (WARN_ON(old_state != CON_SOCK_STATE_CONNECTED &&
+			old_state != CON_SOCK_STATE_CLOSING))
+		printk("%s: unexpected old state %d\n", __func__, old_state);
+}

  /*
   * socket callback functions
@@ -203,6 +259,7 @@ static void ceph_sock_state_change(struct sock *sk)
  		dout("%s TCP_CLOSE\n", __func__);
  	case TCP_CLOSE_WAIT:
  		dout("%s TCP_CLOSE_WAIT\n", __func__);
+		con_sock_state_closing(con);
  		if (test_and_set_bit(SOCK_CLOSED, &con->flags) == 0) {
  			if (test_bit(CONNECTING, &con->state))
  				con->error_msg = "connection failed";
@@ -213,6 +270,7 @@ static void ceph_sock_state_change(struct sock *sk)
  		break;
  	case TCP_ESTABLISHED:
  		dout("%s TCP_ESTABLISHED\n", __func__);
+		con_sock_state_connected(con);
  		queue_con(con);
  		break;
  	default:	/* Everything else is uninteresting */
@@ -277,6 +335,7 @@ static int ceph_tcp_connect(struct ceph_connection *con)
  		return ret;
  	}
  	con->sock = sock;
+	con_sock_state_connecting(con);

  	return 0;
  }
@@ -341,6 +400,7 @@ static int con_close_socket(struct ceph_connection *con)
  	rc = con->sock->ops->shutdown(con->sock, SHUT_RDWR);
  	sock_release(con->sock);
  	con->sock = NULL;
+	con_sock_state_closed(con);
  	return rc;
  }

@@ -460,6 +520,9 @@ void ceph_con_init(struct ceph_messenger *msgr, 
struct ceph_connection *con)
  	memset(con, 0, sizeof(*con));
  	atomic_set(&con->nref, 1);
  	con->msgr = msgr;
+
+	con_sock_state_init(con);
+
  	mutex_init(&con->mutex);
  	INIT_LIST_HEAD(&con->out_queue);
  	INIT_LIST_HEAD(&con->out_sent);
-- 
1.7.5.4

