Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA47BFC616B
	for <ceph-devel@archiver.kernel.org>; Fri, 25 Aug 2023 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjHYUNT (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 25 Aug 2023 16:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjHYUM6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Aug 2023 16:12:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE4A2689;
        Fri, 25 Aug 2023 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZIXbxbmWrTOUb6mh+hr1l56LloeqSAYd7MvHY9X30AE=; b=PjsxjRjlgunQfDgdcbQe11qeaU
        JEgmj/e8JGFhVzrLK2w0f5lGIUY4iAyPpdYGwaGHm6Xz+eobMovp2Rw3PYD084ahFz5Ziw1NqPu/5
        bC1KFcVY3guT8PwXyOPW5pcEKBhPt4Y1DvzZi/48yeIH5jZ6SUMiLkpG49puz6E3H5k4scS9rNPYu
        iFo5lHHy5JgmZy7UxvODxsP/8gHF4f4jukuz/cNtZNtNTzqzmTdhORC3eBdhQOt4pVS/jPnxYHOER
        DD1ExqVHEqc44s55KQ0AgWLRGBW0bTf/0t3etxACeNIRM/6DOvqDHR/G8zohNfX8qZYrXpMbsMFyX
        lhqFq9xA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAV-001SZk-CS; Fri, 25 Aug 2023 20:12:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/15] ceph: Add a migrate_folio method
Date:   Fri, 25 Aug 2023 21:12:14 +0100
Message-Id: <20230825201225.348148-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230825201225.348148-1-willy@infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The ceph_snap_context is independent of the address of the data, so we
can implement folio migration by just removing the ceph_snap_context
from the existing folio and attach it to the new one, which is exactly
what filemap_migrate_folio() does.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7c7dfcd63cd1..a0a1fac1a0db 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1563,6 +1563,7 @@ const struct address_space_operations ceph_aops = {
 	.invalidate_folio = ceph_invalidate_folio,
 	.release_folio = ceph_release_folio,
 	.direct_IO = noop_direct_IO,
+	.migrate_folio = filemap_migrate_folio,
 };
 
 static void ceph_block_sigs(sigset_t *oldset)
-- 
2.40.1

