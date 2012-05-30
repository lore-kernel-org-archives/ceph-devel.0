From: Alex Elder <elder@inktank.com>
Subject: [PATCH 11/13] libceph: init monitor connection when opening
Date: Wed, 30 May 2012 14:35:16 -0500
Message-ID: <4FC67674.8090508@inktank.com>
References: <4FC673FC.3060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34496 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab2E3TfP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:35:15 -0400
Received: by mail-vc0-f174.google.com with SMTP id f11so125386vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:35:14 -0700 (PDT)
In-Reply-To: <4FC673FC.3060004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hold off initializing a monitor client's connection until just
before it gets opened for use.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/mon_client.c |   13 ++++++-------
  1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ac4d6b1..77da480 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -119,6 +119,7 @@ static void __close_session(struct ceph_mon_client 
*monc)
  	dout("__close_session closing mon%d\n", monc->cur_mon);
  	ceph_con_revoke(&monc->con, monc->m_auth);
  	ceph_con_close(&monc->con);
+	monc->con.private = NULL;
  	monc->cur_mon = -1;
  	monc->pending_auth = 0;
  	ceph_auth_reset(monc->auth);
@@ -141,9 +142,13 @@ static int __open_session(struct ceph_mon_client *monc)
  		monc->sub_renew_after = jiffies;  /* i.e., expired */
  		monc->want_next_osdmap = !!monc->want_next_osdmap;

-		dout("open_session mon%d opening\n", monc->cur_mon);
+		ceph_con_init(&monc->client->msgr, &monc->con);
+		monc->con.private = monc;
+		monc->con.ops = &mon_con_ops;
  		monc->con.peer_name.type = CEPH_ENTITY_TYPE_MON;
  		monc->con.peer_name.num = cpu_to_le64(monc->cur_mon);
+
+		dout("open_session mon%d opening\n", monc->cur_mon);
  		ceph_con_open(&monc->con,
  			      &monc->monmap->mon_inst[monc->cur_mon].addr);

@@ -760,10 +765,6 @@ int ceph_monc_init(struct ceph_mon_client *monc, 
struct ceph_client *cl)
  		goto out;

  	/* connection */
-	ceph_con_init(&monc->client->msgr, &monc->con);
-	monc->con.private = monc;
-	monc->con.ops = &mon_con_ops;
-
  	/* authentication */
  	monc->auth = ceph_auth_init(cl->options->name,
  				    cl->options->key);
@@ -836,8 +837,6 @@ void ceph_monc_stop(struct ceph_mon_client *monc)
  	mutex_lock(&monc->mutex);
  	__close_session(monc);

-	monc->con.private = NULL;
-
  	mutex_unlock(&monc->mutex);

  	ceph_auth_destroy(monc->auth);
-- 
1.7.5.4

