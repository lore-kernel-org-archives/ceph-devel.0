From: Alex Elder <elder@inktank.com>
Subject: [PATCH 13/13] libceph: set CLOSED state bit in con_init
Date: Wed, 30 May 2012 14:35:24 -0500
Message-ID: <4FC6767C.8080207@inktank.com>
References: <4FC673FC.3060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34496 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab2E3TfX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:35:23 -0400
Received: by mail-vc0-f174.google.com with SMTP id f11so125386vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:35:23 -0700 (PDT)
In-Reply-To: <4FC673FC.3060004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Once a connection is fully initialized, it is really in a CLOSED
state, so make that explicit by setting the bit in its state field.

It is possible for a connection in NEGOTIATING state to get a
failure, leading to ceph_fault() and ultimately ceph_con_close().
Clear that bits if it is set in that case, to reflect that the
connection truly is closed and is no longer participating in a
connect sequence.

Issue a warning if ceph_con_open() is called on a connection that
is not in CLOSED state.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |    8 +++++++-
  1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index cdf8299..85bfe12 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -452,10 +452,13 @@ void ceph_con_close(struct ceph_connection *con)
  	dout("con_close %p peer %s\n", con,
  	     ceph_pr_addr(&con->peer_addr.in_addr));
  	set_bit(CLOSED, &con->state);  /* in case there's queued work */
+	clear_bit(NEGOTIATING, &con->state);
  	clear_bit(STANDBY, &con->state);  /* avoid connect_seq bump */
+
  	clear_bit(LOSSYTX, &con->flags);  /* so we retry next connect */
  	clear_bit(KEEPALIVE_PENDING, &con->flags);
  	clear_bit(WRITE_PENDING, &con->flags);
+
  	mutex_lock(&con->mutex);
  	reset_connection(con);
  	con->peer_global_seq = 0;
@@ -472,7 +475,8 @@ void ceph_con_open(struct ceph_connection *con, 
struct ceph_entity_addr *addr)
  {
  	dout("con_open %p %s\n", con, ceph_pr_addr(&addr->in_addr));
  	set_bit(OPENING, &con->state);
-	clear_bit(CLOSED, &con->state);
+	WARN_ON(!test_and_clear_bit(CLOSED, &con->state));
+
  	memcpy(&con->peer_addr, addr, sizeof(*addr));
  	con->delay = 0;      /* reset backoff memory */
  	queue_con(con);
@@ -534,6 +538,8 @@ void ceph_con_init(struct ceph_connection *con, void 
*private,
  	INIT_LIST_HEAD(&con->out_queue);
  	INIT_LIST_HEAD(&con->out_sent);
  	INIT_DELAYED_WORK(&con->work, con_work);
+
+	set_bit(CLOSED, &con->state);
  }
  EXPORT_SYMBOL(ceph_con_init);

-- 
1.7.5.4

