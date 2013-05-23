From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: flush dcache after zeroing page data
Date: Thu, 23 May 2013 07:11:45 -0500
Message-ID: <519E0781.4000603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38821 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab3EWMLq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 08:11:46 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so8329678iec.22
        for <ceph-devel@vger.kernel.org>; Thu, 23 May 2013 05:11:46 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id uv10sm11577183igb.3.2013.05.23.05.11.44
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 05:11:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Neither zero_bio_chain() nor zero_pages() contains a call to flush
caches after zeroing a portion of a page.  This can cause problems
on architectures that have caches that allow virtual address
aliasing.

This resolves:
    http://tracker.ceph.com/issues/4777

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6e377a0..f860dd6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1124,6 +1124,7 @@ static void zero_bio_chain(struct bio *chain, int
start_ofs)
 				buf = bvec_kmap_irq(bv, &flags);
 				memset(buf + remainder, 0,
 				       bv->bv_len - remainder);
+				flush_dcache_page(bv->bv_page);
 				bvec_kunmap_irq(buf, &flags);
 			}
 			pos += bv->bv_len;
@@ -1156,6 +1157,7 @@ static void zero_pages(struct page **pages, u64
offset, u64 end)
 		local_irq_save(flags);
 		kaddr = kmap_atomic(*page);
 		memset(kaddr + page_offset, 0, length);
+		flush_dcache_page(*page);
 		kunmap_atomic(kaddr);
 		local_irq_restore(flags);

-- 
1.7.9.5

