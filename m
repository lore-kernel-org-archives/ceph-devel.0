From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] libceph: reset BACKOFF if unable to re-queue
Date: Tue, 09 Oct 2012 14:33:00 -0700
Message-ID: <5074980C.6090104@inktank.com>
References: <507497AC.5030609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53550 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab2JIVdD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 17:33:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5691963pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 14:33:03 -0700 (PDT)
In-Reply-To: <507497AC.5030609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If ceph_fault() is unable to queue work after a delay, it sets the
BACKOFF connection flag so con_work() will attempt to do so.

In con_work(), when BACKOFF is set, if queue_delayed_work() doesn't
result in newly-queued work, it simply ignores this condition and
proceeds as if no backoff delay were desired.  There are two
problems with this--one of which is a bug.

The first problem is simply that the intended behavior is to back
off, and if we aren't able queue the work item to run after a delay
we're not doing that.

The only reason queue_delayed_work() won't queue work is if the
provided work item is already queued.  In the messenger, this
means that con_work() is already scheduled to be run again.  So
if we simply set the BACKOFF flag again when this occurs, we know
the next con_work() call will again attempt to hold off activity
on the connection until after the delay.

The second problem--the bug--is a leak of a reference count.  If
queue_delayed_work() returns 0 in con_work(), con->ops->put() drops
the connection reference held on entry to con_work().  However,
processing is (was) allowed to continue, and at the end of the
function a second con->ops->put() is called.

This patch fixes both problems.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |    3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index f9f65fe..ece06bc 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2300,10 +2300,11 @@ restart:
  			mutex_unlock(&con->mutex);
  			return;
  		} else {
-			con->ops->put(con);
  			dout("con_work %p FAILED to back off %lu\n", con,
  			     con->delay);
+			set_bit(CON_FLAG_BACKOFF, &con->flags);
  		}
+		goto done;
  	}

  	if (con->state == CON_STATE_STANDBY) {
-- 
1.7.9.5

