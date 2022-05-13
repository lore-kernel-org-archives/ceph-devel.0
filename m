Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673F0C433EF
	for <ceph-devel@archiver.kernel.org>; Fri, 13 May 2022 14:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378210AbiEMOjV (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 13 May 2022 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381518AbiEMOgP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2022 10:36:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA21C197D;
        Fri, 13 May 2022 07:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC13CB83069;
        Fri, 13 May 2022 14:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BACC34116;
        Fri, 13 May 2022 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652452194;
        bh=VhZ2iWd9LyrpSB6VS8GblLNN/hlfPXXuf235P2NBAi0=;
        h=From:To:Cc:Subject:Date:From;
        b=Yxr3bzCFvCEppxh/L2ckxfhuDDVKEvIk9IKbZ0tjgkObTa+wh3joJj5/Ijn4HfHZB
         G+h4wvxwel9DzzhTvrsFdl3J234RGgyHdo/NAEOhqb74k+vHz+iwjMcNdcjBtVFFvn
         /sbUuqTiMdg5Pl0Y5p4BBPFAEwnWK7WQkZ33AgcBX06iQOq5bc9CAT1OLH3tH1fuiq
         owIN6hJ9FVP/tJluKnGp7+Qb+K/V/maPbae8ESQCrzNqYx0xHl82aJw7zd771NipLP
         AzrRcVsLIupCF9wVKwFv/ky6oXFRlYGH9uIACsmB/RirdfkzheqpJ3j8ymjjOJT74G
         jnQVlp3yMR6kw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Xiubo Li <xiubli@redhat.com>,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] mm: BUG if filemap_alloc_folio gives us a folio with a non-NULL ->private
Date:   Fri, 13 May 2022 10:29:52 -0400
Message-Id: <20220513142952.27853-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

We've seen some instances where we call __filemap_get_folio and get back
one with a ->private value that is non-NULL. Let's have the allocator
bug if that happens.

URL: https://tracker.ceph.com/issues/55421
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Luís Henriques <lhenriques@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/filemap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

It might not hurt to merge this into mainline. If it pops then we know
something is very wrong.

diff --git a/mm/filemap.c b/mm/filemap.c
index 9a1eef6c5d35..74c3fb062ef7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -990,10 +990,12 @@ struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order)
 			n = cpuset_mem_spread_node();
 			folio = __folio_alloc_node(gfp, order, n);
 		} while (!folio && read_mems_allowed_retry(cpuset_mems_cookie));
-
-		return folio;
+	} else {
+		folio = folio_alloc(gfp, order);
 	}
-	return folio_alloc(gfp, order);
+	if (folio)
+		VM_BUG_ON_FOLIO(folio->private, folio);
+	return folio;
 }
 EXPORT_SYMBOL(filemap_alloc_folio);
 #endif
-- 
2.36.1

