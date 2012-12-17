From: Alex Elder <elder@inktank.com>
Subject: [PATCH,v2 1/3] libceph: init osd->o_node in create_osd()
Date: Mon, 17 Dec 2012 12:33:10 -0600
Message-ID: <50CF6566.3010603@inktank.com>
References: <50CF6501.5070707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50989 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab2LQSdJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 13:33:09 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so9806971ieb.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 10:33:08 -0800 (PST)
In-Reply-To: <50CF6501.5070707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The red-black node node in the ceph osd structure is not initialized
in create_osd().  Because this node can be the subject of a
RB_EMPTY_NODE() call later on, we should ensure the node is
initialized properly for that.  Add a call to RB_CLEAR_NODE()
initialize it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: use RB_CLEAR_NODE() instead of rb_init_node()

 net/ceph/osd_client.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 32bd696..a6dc6ac 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -642,6 +642,7 @@ static struct ceph_osd *create_osd(struct
ceph_osd_client *osdc, int onum)
 	atomic_set(&osd->o_ref, 1);
 	osd->o_osdc = osdc;
 	osd->o_osd = onum;
+	RB_CLEAR_NODE(&osd->o_node);
 	INIT_LIST_HEAD(&osd->o_requests);
 	INIT_LIST_HEAD(&osd->o_linger_requests);
 	INIT_LIST_HEAD(&osd->o_osd_lru);
-- 
1.7.9.5

