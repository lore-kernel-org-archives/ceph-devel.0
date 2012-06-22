From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/9] libceph: change TAG_CLOSE handling
Date: Fri, 22 Jun 2012 17:48:35 -0500
Message-ID: <4FE4F643.6010705@inktank.com>
References: <4FE4F534.1000009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:51215 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab2FVWsf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 18:48:35 -0400
Received: by yhnn12 with SMTP id n12so2326227yhn.10
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 15:48:35 -0700 (PDT)
In-Reply-To: <4FE4F534.1000009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Currently, if a connection is READY in try_read(), and a CLOSE tag
is the what is received next, the connection's state changes from
CONNECTED to CLOSED and try_read() returns.

If this happens, control returns to con_work(), and try_write()
is called.  If there was queued data to send, try_write() appears
to attempt to send it despite the receipt of the CLOSE tag.

Eventually, try_write() will return either:
  - A non-negative value, in which case con_work() will end, and
    will at some point get triggered to run by an event.
  - -EAGAIN, in which case control returns to the top of con_work()
  - Some other error, which will cause con_work() to call
    ceph_fault(), which will close the socket and force a new
    connection sequence to be initiated on the next write.

At the top of con_work(), if the connection is in CLOSED state,
the same fault handling will be done as would happen for any
other error.

Instead of messing with the connection state deep inside try_read(),
just have try_read() return a negative value (an errno), and let
the fault handling code in con_work() take care of resetting the
connection right away.  This will also close the connection before
needlessly sending any queued data to the other end.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2273,8 +2273,7 @@ more:
 			prepare_read_ack(con);
 			break;
 		case CEPH_MSGR_TAG_CLOSE:
-			clear_bit(CONNECTED, &con->state);
-			set_bit(CLOSED, &con->state);   /* fixme */
+			ret = -EIO;
 			goto out;
 		default:
 			goto bad_tag;
