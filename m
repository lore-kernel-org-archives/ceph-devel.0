From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: must hold mutex for reset_changed_osds()
Date: Wed, 15 May 2013 16:35:09 -0500
Message-ID: <5193FF8D.2070403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:54169 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3EOVfM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 May 2013 17:35:12 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so2796066oag.8
        for <ceph-devel@vger.kernel.org>; Wed, 15 May 2013 14:35:11 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id qj8sm4892439oeb.2.2013.05.15.14.35.10
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 15 May 2013 14:35:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

An osd client has a red-black tree describing its osds, and
occasionally we would get crashes due to one of these trees tree
becoming corrupt somehow.

The problem turned out to be that reset_changed_osds() was being
called without protection of the osd client request mutex.  That
function would call __reset_osd() for any osd that had changed, and
__reset_osd() would call __remove_osd() for any osd with no
outstanding requests, and finally __remove_osd() would remove the
corresponding entry from the red-black tree.  Thus, the tree was
getting modified without having any lock protection, and was
vulnerable to problems due to concurrent updates.

This appears to be the only osd tree updating path that has this
problem.  It can be fairly easily fixed by moving the call up
a few lines, to just before the request mutex gets dropped
in kick_requests().

This resolves:
    http://tracker.ceph.com/issues/5043
Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d5953b8..3a246a6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1675,13 +1675,13 @@ static void kick_requests(struct ceph_osd_client
*osdc, int force_resend)
 		__register_request(osdc, req);
 		__unregister_linger_request(osdc, req);
 	}
+	reset_changed_osds(osdc);
 	mutex_unlock(&osdc->request_mutex);

 	if (needmap) {
 		dout("%d requests for down osds, need new map\n", needmap);
 		ceph_monc_request_next_osdmap(&osdc->client->monc);
 	}
-	reset_changed_osds(osdc);
 }


-- 
1.7.9.5

