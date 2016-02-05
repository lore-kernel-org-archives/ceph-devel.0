From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 4/6] libceph: make sure redirect does not change namespace
Date: Fri,  5 Feb 2016 22:31:35 +0800
Message-ID: <1454682697-84638-5-git-send-email-zyan@redhat.com>
References: <1454682697-84638-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38580 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbcBEOcN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Feb 2016 09:32:13 -0500
In-Reply-To: <1454682697-84638-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sweil@redhat.com, idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 net/ceph/osd_client.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0eb27ad..1d13605 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1725,10 +1725,23 @@ static int ceph_oloc_decode(void **p, void *end,
 	}
 
 	if (struct_v >= 5) {
+		bool changed = false;
 		u32 ns_len = ceph_decode_32(p);
 		if (ns_len > 0) {
 			ceph_decode_need(p, end, ns_len, e_inval);
+			if (oloc->pool != -1 &&
+			    (!oloc->pool_ns ||
+			     ceph_compare_pool_ns(oloc->pool_ns, *p, ns_len)))
+				changed = true;
 			*p += ns_len;
+		} else {
+			if (oloc->pool != -1 && oloc->pool_ns)
+				changed = true;
+		}
+		if (changed) {
+			/* redirect changes namespace */
+			pr_warn("ceph_object_locator::nspace is changed\n");
+			goto e_inval;
 		}
 	}
 
@@ -1901,7 +1914,9 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	}
 
 	if (decode_redir) {
+		redir.oloc.pool_ns = req->r_target_oloc.pool_ns;
 		err = ceph_redirect_decode(&p, end, &redir);
+		redir.oloc.pool_ns = NULL;
 		if (err)
 			goto bad_put;
 	} else {
-- 
2.5.0

