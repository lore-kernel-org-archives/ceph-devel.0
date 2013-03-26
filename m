From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/6] libceph: send queued requests when starting new one
Date: Mon, 25 Mar 2013 21:28:08 -0500
Message-ID: <515107B8.2070401@inktank.com>
References: <5151071C.3000309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:36207 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab3CZC2K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 22:28:10 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so5928995iad.40
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 19:28:10 -0700 (PDT)
In-Reply-To: <5151071C.3000309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

An osd expects the transaction ids of arriving request messages from
a given client to increase monotonically.  So the osd client needs
to send its requests in ascending tid order.

The transaction id for a request is set at the time it is
registered, in __register_request().  This is also where the request
gets placed at the end of the osd client's unsent messages list.

At the end of ceph_osdc_start_request(), the request message for a
newly-mapped osd request is supplied to the messenger to be sent
(via __send_request()).  If any other messages were present in the
osd client's unsent list at that point they would be sent *after*
this new request message.

Because those unsent messages have already been registered, their
tids would be lower than the newly-mapped request message, and
sending that message first violates the tid ordering rule.

Rather than sending the new request only, send all queued requests
(including the new one) at that point in ceph_osdc_start_request().
This ensures the tid ordering property is preserved.

With this in place, all messages should now be sent in tid order
regardless of whether they're being sent for the first time or
re-sent as a result of a call to osd_reset().

This resolves:
    http://tracker.ceph.com/issues/4392

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 202b9cd..4d98424 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1806,7 +1806,7 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,
 		dout("send_request %p no up osds in pg\n", req);
 		ceph_monc_request_next_osdmap(&osdc->client->monc);
 	} else {
-		__send_request(osdc, req);
+		__send_queued(osdc);
 	}
 	rc = 0;
 out_unlock:
-- 
1.7.9.5

