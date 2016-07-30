From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] libceph: fix return value check in alloc_msg_with_page_vector()
Date: Sat, 30 Jul 2016 00:37:57 +0000
Message-ID: <1469839077-3607-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36447 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbcG3AiD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 20:38:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id y134so6204543pfg.3
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 17:38:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, ceph-devel@vger.kernel.org

In case of error, the function ceph_alloc_page_vector() returns
ERR_PTR() and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

Fixes: 1907920324f1 ('libceph: support for sending notifies')
Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 net/ceph/osd_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b5ec096..a97e7b5 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4220,7 +4220,7 @@ static struct ceph_msg *alloc_msg_with_page_vector(struct ceph_msg_header *hdr)
 
 		pages = ceph_alloc_page_vector(calc_pages_for(0, data_len),
 					       GFP_NOIO);
-		if (!pages) {
+		if (IS_ERR(pages)) {
 			ceph_msg_put(m);
 			return NULL;
 		}

