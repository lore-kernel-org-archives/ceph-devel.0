Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502FCC433EF
	for <ceph-devel@archiver.kernel.org>; Fri, 10 Jun 2022 15:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbiFJPmP (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 10 Jun 2022 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349166AbiFJPls (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2022 11:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E62B2BAD
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2022 08:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0086061F9C
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2022 15:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F88C34114;
        Fri, 10 Jun 2022 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654875615;
        bh=BJTGWXPrXfs0xgne7BPYS3GmvmrSyQTzZNUBlci8D2A=;
        h=From:To:Cc:Subject:Date:From;
        b=RQ8mXJy8qJWH1sQ5/5D5TctvUzOczzZtx1DYF4eTvKf8f5sE2W7hyOsQ55jv47JCD
         7MwknYTGJ+kFG/5cFRSIcsWSwfvWlk7xb2RIMq9PHNnB97tUd1+kSpp4CMVL2/1GIs
         2NcCEqX7dEalSBVlA6lqd9+t5/CD6TJg60j07kxJIRcZsZOkKj5++4kWY83qZ/yG7w
         Iew5FPEX1I+0eCiS+maHQp22dwS0TKIPrmDTBttvJ7H/0k38MMhOFfNwVCIVnj+mcb
         HK9iUczJlSDao/yRKmvMpva7cp28JuYFJ89KKCU7/1vb2tLsPK4wv76BAYxlofnjrU
         URo6CpEFAIUAQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] ceph: switch back to testing for NULL folio->private in ceph_dirty_folio
Date:   Fri, 10 Jun 2022 11:40:13 -0400
Message-Id: <20220610154013.68259-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Willy requested that we change this back to warning on folio->private
being non-NULl. He's trying to kill off the PG_private flag, and so we'd
like to catch where it's non-NULL.

Add a VM_WARN_ON_FOLIO (since it doesn't exist yet) and change over to
using that instead of VM_BUG_ON_FOLIO along with testing the ->private
pointer.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c          | 2 +-
 include/linux/mmdebug.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b43cc01a61db..b24d6bdb91db 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -122,7 +122,7 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 	 * Reference snap context in folio->private.  Also set
 	 * PagePrivate so that we get invalidate_folio callback.
 	 */
-	VM_BUG_ON_FOLIO(folio_test_private(folio), folio);
+	VM_WARN_ON_FOLIO(folio->private, folio);
 	folio_attach_private(folio, snapc);
 
 	return ceph_fscache_dirty_folio(mapping, folio);
diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index d7285f8148a3..5107bade2ab2 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -54,6 +54,15 @@ void dump_mm(const struct mm_struct *mm);
 	}								\
 	unlikely(__ret_warn_once);					\
 })
+#define VM_WARN_ON_FOLIO(cond, folio)		({			\
+	int __ret_warn = !!(cond);					\
+									\
+	if (unlikely(__ret_warn)) {					\
+		dump_page(&folio->page, "VM_WARN_ON_FOLIO(" __stringify(cond)")");\
+		WARN_ON(1);						\
+	}								\
+	unlikely(__ret_warn);						\
+})
 #define VM_WARN_ON_ONCE_FOLIO(cond, folio)	({			\
 	static bool __section(".data.once") __warned;			\
 	int __ret_warn_once = !!(cond);					\
-- 
2.36.1

