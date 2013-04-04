From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/9] ceph: use page_offset() in ceph_writepages_start()
Date: Thu, 04 Apr 2013 11:18:18 -0500
Message-ID: <515DA7CA.4040808@inktank.com>
References: <515DA755.2090504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:43260 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762890Ab3DDQSU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 12:18:20 -0400
Received: by mail-ia0-f177.google.com with SMTP id w33so2317317iag.8
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 09:18:20 -0700 (PDT)
In-Reply-To: <515DA755.2090504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There's one spot in ceph_writepages_start() that open-codes what
page_offset() does safely.  Use the macro so we don't have to worry
about wrapping.

This resolves:
    http://tracker.ceph.com/issues/4648

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 67d4965..6a5a08e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -900,7 +900,7 @@ get_more_pages:
 		}

 		/* submit the write */
-		offset = req->r_data_out.pages[0]->index << PAGE_CACHE_SHIFT;
+		offset = page_offset(req->r_data_out.pages[0]);
 		len = min((snap_size ? snap_size : i_size_read(inode)) - offset,
 			  (u64)locked_pages << PAGE_CACHE_SHIFT);
 		dout("writepages got %d pages at %llu~%llu\n",
-- 
1.7.9.5

