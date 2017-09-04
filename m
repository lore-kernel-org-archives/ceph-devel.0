From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 12/13] ceph: fix capsnap dirty pages accounting
Date: Mon,  4 Sep 2017 17:39:07 +0800
Message-ID: <20170904093908.57316-13-zyan@redhat.com>
References: <20170904093908.57316-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753390AbdIDJkt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 05:40:49 -0400
In-Reply-To: <20170904093908.57316-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

writepages_finish() calls ceph_put_wrbuffer_cap_refs() once for
all pages, parameter snapc is set to req->r_snapc. So writepages()
shouldn't write dirty pages associated with different snapc in
one OSD request.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 201e529e8a6c..1ffdb903eb79 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -930,8 +930,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 			/* only if matching snap context */
 			pgsnapc = page_snap_context(page);
-			if (pgsnapc->seq > snapc->seq) {
-				dout("page snapc %p %lld > oldest %p %lld\n",
+			if (pgsnapc != snapc) {
+				dout("page snapc %p %lld != oldest %p %lld\n",
 				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
 				unlock_page(page);
 				continue;
-- 
2.13.5

