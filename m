From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH] libceph: fix ceph_msg_new error path
Date: Tue,  3 May 2011 02:29:56 +0000
Message-ID: <1304389796-11363-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60794 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab1ECCdR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2011 22:33:17 -0400
Received: by pwi15 with SMTP id 15so2932094pwi.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 May 2011 19:33:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>

If memory allocation failed, calling ceph_msg_put() will cause GPF
since some of ceph_msg variables are not initialized first.

Fix Bug #970.

Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
---
 net/ceph/messenger.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 05f3578..e15a82c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2267,6 +2267,19 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags)
 	m->more_to_follow = false;
 	m->pool = NULL;
 
+	/* middle */
+	m->middle = NULL;
+
+	/* data */
+	m->nr_pages = 0;
+	m->page_alignment = 0;
+	m->pages = NULL;
+	m->pagelist = NULL;
+	m->bio = NULL;
+	m->bio_iter = NULL;
+	m->bio_seg = 0;
+	m->trail = NULL;
+
 	/* front */
 	if (front_len) {
 		if (front_len > PAGE_CACHE_SIZE) {
@@ -2286,19 +2299,6 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags)
 	}
 	m->front.iov_len = front_len;
 
-	/* middle */
-	m->middle = NULL;
-
-	/* data */
-	m->nr_pages = 0;
-	m->page_alignment = 0;
-	m->pages = NULL;
-	m->pagelist = NULL;
-	m->bio = NULL;
-	m->bio_iter = NULL;
-	m->bio_seg = 0;
-	m->trail = NULL;
-
 	dout("ceph_msg_new %p front %d\n", m, front_len);
 	return m;
 
-- 
1.7.2.3

