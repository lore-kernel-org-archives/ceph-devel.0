From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] libceph: don't use rb_init_node() in ceph_osdc_alloc_request()
Date: Mon, 17 Dec 2012 12:33:43 -0600
Message-ID: <50CF6587.70108@inktank.com>
References: <50CF6501.5070707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61905 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab2LQSdl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 13:33:41 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so9808017ieb.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 10:33:41 -0800 (PST)
In-Reply-To: <50CF6501.5070707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The red-black node in the ceph osd request structure is initialized
in ceph_osdc_alloc_request() using rbd_init_node().  We do need to
initialize this, because in __unregister_request() we call
RB_EMPTY_NODE(), which expects the node it's checking to have
been initialized.  But rb_init_node() is apparently overkill, and
may in fact be on its way out.  So use RB_CLEAR_NODE() instead.

For a little more background, see this commit:
    4c199a93 rbtree: empty nodes have no color"

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2bce3d4..7cd0a7f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -221,7 +221,7 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	kref_init(&req->r_kref);
 	init_completion(&req->r_completion);
 	init_completion(&req->r_safe_completion);
-	rb_init_node(&req->r_node);
+	RB_CLEAR_NODE(&req->r_node);
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 	INIT_LIST_HEAD(&req->r_linger_item);
 	INIT_LIST_HEAD(&req->r_linger_osd);
-- 
1.7.9.5

