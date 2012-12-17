From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] libceph: init event->node in ceph_osdc_create_event()
Date: Mon, 17 Dec 2012 12:33:27 -0600
Message-ID: <50CF6577.40106@inktank.com>
References: <50CF6501.5070707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:65291 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868Ab2LQSdZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 13:33:25 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so5844955iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 10:33:25 -0800 (PST)
In-Reply-To: <50CF6501.5070707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The red-black node node in the ceph osd event structure is not
initialized in create_osdc_create_event().  Because this node can
be the subject of a RB_EMPTY_NODE() call later on, we should ensure
the node is initialized properly for that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a6dc6ac..2bce3d4 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1563,6 +1563,7 @@ int ceph_osdc_create_event(struct ceph_osd_client
*osdc,
 	event->data = data;
 	event->osdc = osdc;
 	INIT_LIST_HEAD(&event->osd_node);
+	RB_CLEAR_NODE(&event->node);
 	kref_init(&event->kref);   /* one ref for us */
 	kref_get(&event->kref);    /* one ref for the caller */
 	init_completion(&event->completion);
-- 
1.7.9.5

