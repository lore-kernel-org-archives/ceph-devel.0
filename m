From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] ceph: use calc_pages_for() in start_read()
Date: Mon, 04 Mar 2013 12:15:20 -0600
Message-ID: <5134E4B8.5090908@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E46C.9020402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:53696 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858Ab3CDSPV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:15:21 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so6572965ieb.34
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:15:20 -0800 (PST)
In-Reply-To: <5134E46C.9020402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There's a spot that computes the number of pages to allocate for a
page-aligned length by just shifting it.  Use calc_pages_for()
instead, to be consistent with usage everywhere else.  The result
is the same.

The reason for this is to make it clearer in an upcoming patch that
this calculation is duplicated.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index cfef3e0..a284a1f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -314,7 +314,7 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 		return PTR_ERR(req);

 	/* build page vector */
-	nr_pages = len >> PAGE_CACHE_SHIFT;
+	nr_pages = calc_pages_for(0, len);
 	pages = kmalloc(sizeof(*pages) * nr_pages, GFP_NOFS);
 	ret = -ENOMEM;
 	if (!pages)
-- 
1.7.9.5

