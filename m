From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] libceph: set peer name on con_open, not init
Date: Tue, 26 Jun 2012 14:46:44 -0700
Message-ID: <4FEA2DC4.5080409@inktank.com>
References: <4FEA2D76.8080907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54565 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231Ab2FZVqr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 17:46:47 -0400
Received: by pbbrp8 with SMTP id rp8so631906pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 14:46:46 -0700 (PDT)
In-Reply-To: <4FEA2D76.8080907@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The peer name may change on each open attempt, even when the
connection is reused.

Signed-off-by: Sage Weil <sage@inktank.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
  fs/ceph/mds_client.c           |    7 ++++---
  include/linux/ceph/messenger.h |    4 ++--
  net/ceph/messenger.c           |   12 +++++++-----
  net/ceph/mon_client.c          |    8 ++++----
  net/ceph/osd_client.c          |   10 ++++++----
  5 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ecd7f15..5ac6434 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -394,8 +394,7 @@ static struct ceph_mds_session 
*register_session(struct ceph_mds_client *mdsc,
  	s->s_seq = 0;
  	mutex_init(&s->s_mutex);

-	ceph_con_init(&s->s_con, s, &mds_con_ops, &mdsc->fsc->client->msgr,
-		CEPH_ENTITY_TYPE_MDS, mds);
+	ceph_con_init(&s->s_con, s, &mds_con_ops, &mdsc->fsc->client->msgr);

  	spin_lock_init(&s->s_gen_ttl_lock);
  	s->s_cap_gen = 0;
@@ -437,7 +436,8 @@ static struct ceph_mds_session 
*register_session(struct ceph_mds_client *mdsc,
  	mdsc->sessions[mds] = s;
  	atomic_inc(&s->s_ref);  /* one ref to sessions[], one to caller */

-	ceph_con_open(&s->s_con, ceph_mdsmap_get_addr(mdsc->mdsmap, mds));
+	ceph_con_open(&s->s_con, CEPH_ENTITY_TYPE_MDS, mds,
+		      ceph_mdsmap_get_addr(mdsc->mdsmap, mds));

  	return s;

@@ -2529,6 +2529,7 @@ static void send_mds_reconnect(struct 
ceph_mds_client *mdsc,
  	session->s_seq = 0;

  	ceph_con_open(&session->s_con,
+		      CEPH_ENTITY_TYPE_MDS, mds,
  		      ceph_mdsmap_get_addr(mdsc->mdsmap, mds));

  	/* replay unsafe requests */
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 002d504..cb9d38f 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -232,9 +232,9 @@ extern void ceph_messenger_init(struct 
ceph_messenger *msgr,

  extern void ceph_con_init(struct ceph_connection *con, void *private,
  			const struct ceph_connection_operations *ops,
-			struct ceph_messenger *msgr, __u8 entity_type,
-			__u64 entity_num);
+			struct ceph_messenger *msgr);
  extern void ceph_con_open(struct ceph_connection *con,
+			  __u8 entity_type, __u64 entity_num,
  			  struct ceph_entity_addr *addr);
  extern bool ceph_con_opened(struct ceph_connection *con);
  extern void ceph_con_close(struct ceph_connection *con);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 3eef039..fe42a36 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -523,12 +523,17 @@ EXPORT_SYMBOL(ceph_con_close);
  /*
   * Reopen a closed connection, with a new peer address.
   */
-void ceph_con_open(struct ceph_connection *con, struct ceph_entity_addr 
*addr)
+void ceph_con_open(struct ceph_connection *con,
+		   __u8 entity_type, __u64 entity_num,
+		   struct ceph_entity_addr *addr)
  {
  	dout("con_open %p %s\n", con, ceph_pr_addr(&addr->in_addr));
  	set_bit(OPENING, &con->state);
  	WARN_ON(!test_and_clear_bit(CLOSED, &con->state));

+	con->peer_name.type = (__u8) entity_type;
+	con->peer_name.num = cpu_to_le64(entity_num);
+
  	memcpy(&con->peer_addr, addr, sizeof(*addr));
  	con->delay = 0;      /* reset backoff memory */
  	queue_con(con);
@@ -548,7 +553,7 @@ bool ceph_con_opened(struct ceph_connection *con)
   */
  void ceph_con_init(struct ceph_connection *con, void *private,
  	const struct ceph_connection_operations *ops,
-	struct ceph_messenger *msgr, __u8 entity_type, __u64 entity_num)
+	struct ceph_messenger *msgr)
  {
  	dout("con_init %p\n", con);
  	memset(con, 0, sizeof(*con));
@@ -558,9 +563,6 @@ void ceph_con_init(struct ceph_connection *con, void 
*private,

  	con_sock_state_init(con);

-	con->peer_name.type = (__u8) entity_type;
-	con->peer_name.num = cpu_to_le64(entity_num);
-
  	mutex_init(&con->mutex);
  	INIT_LIST_HEAD(&con->out_queue);
  	INIT_LIST_HEAD(&con->out_sent);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index e9db3de..44b8526 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -142,12 +142,9 @@ static int __open_session(struct ceph_mon_client *monc)
  		monc->sub_renew_after = jiffies;  /* i.e., expired */
  		monc->want_next_osdmap = !!monc->want_next_osdmap;

-		ceph_con_init(&monc->con, monc, &mon_con_ops,
-			&monc->client->msgr,
-			CEPH_ENTITY_TYPE_MON, monc->cur_mon);
-
  		dout("open_session mon%d opening\n", monc->cur_mon);
  		ceph_con_open(&monc->con,
+			      CEPH_ENTITY_TYPE_MON, monc->cur_mon,
  			      &monc->monmap->mon_inst[monc->cur_mon].addr);

  		/* initiatiate authentication handshake */
@@ -798,6 +795,9 @@ int ceph_monc_init(struct ceph_mon_client *monc, 
struct ceph_client *cl)
  	if (!monc->m_auth)
  		goto out_auth_reply;

+	ceph_con_init(&monc->con, monc, &mon_con_ops,
+		      &monc->client->msgr);
+
  	monc->cur_mon = -1;
  	monc->hunting = true;
  	monc->sub_renew_after = jiffies;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index db2da54..c252711 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -639,8 +639,7 @@ static struct ceph_osd *create_osd(struct 
ceph_osd_client *osdc, int onum)
  	INIT_LIST_HEAD(&osd->o_osd_lru);
  	osd->o_incarnation = 1;

-	ceph_con_init(&osd->o_con, osd, &osd_con_ops, &osdc->client->msgr,
-		CEPH_ENTITY_TYPE_OSD, onum);
+	ceph_con_init(&osd->o_con, osd, &osd_con_ops, &osdc->client->msgr);

  	INIT_LIST_HEAD(&osd->o_keepalive_item);
  	return osd;
@@ -750,7 +749,8 @@ static int __reset_osd(struct ceph_osd_client *osdc, 
struct ceph_osd *osd)
  		ret = -EAGAIN;
  	} else {
  		ceph_con_close(&osd->o_con);
-		ceph_con_open(&osd->o_con, &osdc->osdmap->osd_addr[osd->o_osd]);
+		ceph_con_open(&osd->o_con, CEPH_ENTITY_TYPE_OSD, osd->o_osd,
+			      &osdc->osdmap->osd_addr[osd->o_osd]);
  		osd->o_incarnation++;
  	}
  	return ret;
@@ -1005,7 +1005,9 @@ static int __map_request(struct ceph_osd_client *osdc,
  		dout("map_request osd %p is osd%d\n", req->r_osd, o);
  		__insert_osd(osdc, req->r_osd);

-		ceph_con_open(&req->r_osd->o_con, &osdc->osdmap->osd_addr[o]);
+		ceph_con_open(&req->r_osd->o_con,
+			      CEPH_ENTITY_TYPE_OSD, o,
+			      &osdc->osdmap->osd_addr[o]);
  	}

  	if (req->r_osd) {
-- 
1.7.9.5

