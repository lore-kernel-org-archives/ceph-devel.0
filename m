Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E9EE49AD
	for <ceph-devel@archiver.kernel.org>; Fri, 25 Aug 2023 20:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjHYUNN (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 25 Aug 2023 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjHYUMk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Aug 2023 16:12:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B23268A;
        Fri, 25 Aug 2023 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fxy1kaAeEWtQm4Qa6KusH4MEhe1DgzyM9H3+GJSje7M=; b=OMTu+407vpy2Ju6kymNy+JhTEe
        Uy0vM00JXPoqmocEoS4OW9I3bCSHv0j4pCCsAUfoB1/cnEAf5fahgRUB3UBAYfXmjhqF8RRhN2b3m
        yprDZonXPHdszxqIzxtWfDIN3Khdv9jmsLlhrWb56cat+uuowFBoYZesi99KteJ9nQx0q2qWBMum4
        7U89OQNf8BTm5NWiD+wgS9/dPa3BDJ5eZ8Oo5On0b6EZrkSssJQwETJVniMjXdRnFys+Flk70aQxE
        l9J6/YOEIqZLBAIG/psH+SbrG87BiiNelOckCnF1rvVykENQlDsfSy7IlBzQRCsEspzXgVEV8aI4U
        HOMTL7Mg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAV-001SZw-TO; Fri, 25 Aug 2023 20:12:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/15] ceph: Convert ceph_read_iter() to use a folio to read inline data
Date:   Fri, 25 Aug 2023 21:12:20 +0100
Message-Id: <20230825201225.348148-11-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230825201225.348148-1-willy@infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Use the folio APIs instead of the page APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b1da02f5dbe3..5c4f763b1304 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2083,19 +2083,19 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	if (retry_op > HAVE_RETRIED && ret >= 0) {
 		int statret;
-		struct page *page = NULL;
+		struct folio *folio = NULL;
 		loff_t i_size;
 		if (retry_op == READ_INLINE) {
-			page = __page_cache_alloc(GFP_KERNEL);
-			if (!page)
+			folio = filemap_alloc_folio(GFP_KERNEL, 0);
+			if (!folio)
 				return -ENOMEM;
 		}
 
-		statret = __ceph_do_getattr(inode, page,
-					    CEPH_STAT_CAP_INLINE_DATA, !!page);
+		statret = __ceph_do_getattr(inode, &folio->page,
+					    CEPH_STAT_CAP_INLINE_DATA, !!folio);
 		if (statret < 0) {
-			if (page)
-				__free_page(page);
+			if (folio)
+				folio_put(folio);
 			if (statret == -ENODATA) {
 				BUG_ON(retry_op != READ_INLINE);
 				goto again;
@@ -2112,8 +2112,8 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 						   iocb->ki_pos + len);
 				end = min_t(loff_t, end, PAGE_SIZE);
 				if (statret < end)
-					zero_user_segment(page, statret, end);
-				ret = copy_page_to_iter(page,
+					folio_zero_segment(folio, statret, end);
+				ret = copy_folio_to_iter(folio,
 						iocb->ki_pos & ~PAGE_MASK,
 						end - iocb->ki_pos, to);
 				iocb->ki_pos += ret;
@@ -2126,7 +2126,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				iocb->ki_pos += ret;
 				read += ret;
 			}
-			__free_pages(page, 0);
+			folio_put(folio);
 			return read;
 		}
 
-- 
2.40.1

