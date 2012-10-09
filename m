From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] libceph: let con_work() handle backoff
Date: Tue, 09 Oct 2012 14:33:11 -0700
Message-ID: <50749817.7090900@inktank.com>
References: <507497AC.5030609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53550 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab2JIVdN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 17:33:13 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5691963pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 14:33:13 -0700 (PDT)
In-Reply-To: <507497AC.5030609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Both ceph_fault() and con_work() include handling for imposing a
delay before doing further processing on a faulted connection.
The latter is used only if ceph_fault() is unable to.

Instead, just let con_work() always be responsible for implementing
the delay.  After setting up the delay value, set the BACKOFF flag
on the connection unconditionally and call queue_con() to ensure
con_work() will get called to handle it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |   20 ++------------------
  1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index ece06bc..9170c20 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2398,24 +2398,8 @@ static void ceph_fault(struct ceph_connection *con)
  			con->delay = BASE_DELAY_INTERVAL;
  		else if (con->delay < MAX_DELAY_INTERVAL)
  			con->delay *= 2;
-		con->ops->get(con);
-		if (queue_delayed_work(ceph_msgr_wq, &con->work,
-				       round_jiffies_relative(con->delay))) {
-			dout("fault queued %p delay %lu\n", con, con->delay);
-		} else {
-			con->ops->put(con);
-			dout("fault failed to queue %p delay %lu, backoff\n",
-			     con, con->delay);
-			/*
-			 * In many cases we see a socket state change
-			 * while con_work is running and end up
-			 * queuing (non-delayed) work, such that we
-			 * can't backoff with a delay.  Set a flag so
-			 * that when con_work restarts we schedule the
-			 * delay then.
-			 */
-			set_bit(CON_FLAG_BACKOFF, &con->flags);
-		}
+		set_bit(CON_FLAG_BACKOFF, &con->flags);
+		queue_con(con);
  	}

  out_unlock:
-- 
1.7.9.5

