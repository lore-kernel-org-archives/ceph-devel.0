From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] ceph: distinguish between unreachable and busy osds
 when resetting a connection
Date: Wed, 22 Jun 2011 12:26:24 -0600
Message-ID: <1308767187-10376-2-git-send-email-jaschut@sandia.gov>
References: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53421 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758540Ab1FVS1F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2011 14:27:05 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1AD7E17322A
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2011 12:27:03 -0600 (MDT)
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2011 12:26:48 -0600
In-Reply-To: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Previously, when clients' sustained offered write load exceeded the
sustained throughput of the OSDs, normal operation was that client
messages timed out while waiting to be processed by the OSDs.  The
client response to this was to reset the connection to the OSD
handling a timed-out message.

Ceph OSDs can now send keepalives when waiting for sufficient buffer
space to receive a message from a client.  This patch causes clients
to notice the keepalives, and not reset a connection serving a
timed-out message if anything, particularly a keepalive, has been
received recently.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 include/linux/ceph/messenger.h |    1 +
 net/ceph/messenger.c           |    9 +++++++++
 net/ceph/osd_client.c          |    9 +++++++++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 31d91a6..0b12f5e 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -141,6 +141,7 @@ struct ceph_connection {
 	struct ceph_messenger *msgr;
 	struct socket *sock;
 	unsigned long state;	/* connection state (see flags above) */
+	unsigned long last_rcv;
 	const char *error_msg;  /* error message, if any */
 
 	struct ceph_entity_addr peer_addr; /* peer address */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 78b55f4..9eea67e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -416,6 +416,7 @@ void ceph_con_init(struct ceph_messenger *msgr, struct ceph_connection *con)
 	memset(con, 0, sizeof(*con));
 	atomic_set(&con->nref, 1);
 	con->msgr = msgr;
+	con->last_rcv = jiffies;
 	mutex_init(&con->mutex);
 	INIT_LIST_HEAD(&con->out_queue);
 	INIT_LIST_HEAD(&con->out_sent);
@@ -1855,6 +1856,7 @@ more:
 		ret = process_connect(con);
 		if (ret < 0)
 			goto out;
+		con->last_rcv = jiffies;
 		goto more;
 	}
 
@@ -1870,6 +1872,7 @@ more:
 		ret = ceph_tcp_recvmsg(con->sock, buf, skip);
 		if (ret <= 0)
 			goto out;
+		con->last_rcv = jiffies;
 		con->in_base_pos += ret;
 		if (con->in_base_pos)
 			goto more;
@@ -1881,6 +1884,7 @@ more:
 		ret = ceph_tcp_recvmsg(con->sock, &con->in_tag, 1);
 		if (ret <= 0)
 			goto out;
+		con->last_rcv = jiffies;
 		dout("try_read got tag %d\n", (int)con->in_tag);
 		switch (con->in_tag) {
 		case CEPH_MSGR_TAG_MSG:
@@ -1889,6 +1893,9 @@ more:
 		case CEPH_MSGR_TAG_ACK:
 			prepare_read_ack(con);
 			break;
+		case CEPH_MSGR_TAG_KEEPALIVE:
+			prepare_read_tag(con);
+			goto out;
 		case CEPH_MSGR_TAG_CLOSE:
 			set_bit(CLOSED, &con->state);   /* fixme */
 			goto out;
@@ -1910,6 +1917,7 @@ more:
 			}
 			goto out;
 		}
+		con->last_rcv = jiffies;
 		if (con->in_tag == CEPH_MSGR_TAG_READY)
 			goto more;
 		process_message(con);
@@ -1919,6 +1927,7 @@ more:
 		ret = read_partial_ack(con);
 		if (ret <= 0)
 			goto out;
+		con->last_rcv = jiffies;
 		process_ack(con);
 		goto more;
 	}
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 7330c27..30fa648 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1094,6 +1094,15 @@ static void handle_timeout(struct work_struct *work)
 
 		osd = req->r_osd;
 		BUG_ON(!osd);
+
+		/*
+		 * Only reset osd if we haven't recently received something
+		 * from it - if we have, it's just busy, and hasn't gotten
+		 * to this request yet.
+		 */
+		if (time_before(jiffies, osd->o_con.last_rcv + timeout))
+			break;
+
 		pr_warning(" tid %llu timed out on osd%d, will reset osd\n",
 			   req->r_tid, osd->o_osd);
 		__kick_osd_requests(osdc, osd);
-- 
1.7.1


