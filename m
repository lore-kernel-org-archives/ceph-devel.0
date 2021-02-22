Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C6C433DB
	for <ceph-devel@archiver.kernel.org>; Mon, 22 Feb 2021 14:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5686064DF0
	for <ceph-devel@archiver.kernel.org>; Mon, 22 Feb 2021 14:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhBVO0r (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 22 Feb 2021 09:26:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhBVOYV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:24:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E23F64DB1;
        Mon, 22 Feb 2021 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614003814;
        bh=PLlXyvwEGoWQn+iokk71W8sWpPHQqCKZgTzWqhPF9js=;
        h=From:To:Cc:Subject:Date:From;
        b=dR02o5KaLkQuXEiU0GK3x0lcCLtquaYaBhOKcYeOGvRvT+LRKo7LBBrlKSz/0evZE
         KVHnFGIK5QRpq9n0qz+7kCzLTx5wUWYTlQH7bFuF0D2oFwygEbDdKxrGwYwHtSRzf0
         MRzKA6GJaX70n8bRZavFRYVal3LXQlmIHByTrMN1fUxx9kdq1HvmCNWxlGK2QFNlsK
         IqS8KKJcnZUDjGydwZgv/syBUvVNvSMYs8eJT5rG64QiFKSc4I6oW14MvwzsImhh0A
         Ejw0QO08g0DpnVVaiL90kYwBFBEczdi7NuOwOrkRtRZcBdCC2x+VuTVa8h8nY+0Vrw
         xQ5EBkvHuJOjQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     pdonnell@redhat.com, idryomov@gmail.com
Subject: [PATCH] ceph: fix the inline data handling
Date:   Mon, 22 Feb 2021 09:23:32 -0500
Message-Id: <20210222142332.256981-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Patrick saw some testcase failures with inlined data enabled. While it
is true that the data is uninlined before write_begin is called, the
i_inline_version is not updated until much later, after the write is
complete, when the caps are dirtied.

Fix the code to allow for write_begin on the first page of a
still-inlined inode, as long as the page is still Uptodate.

Reported-by: Patrick Donnelly <pdonnell@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

This is a fix for the netfs conversion. If this tests out OK, I'll plan
to fold this fix into the write_begin conversion.

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7b0980980ac0..f7c3247616d9 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1234,29 +1234,30 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 	pgoff_t index = pos >> PAGE_SHIFT;
 	int r;
 
+	/*
+	 * Uninlining should have already been done and everything updated, EXCEPT
+	 * for inline_version sent to the MDS.
+	 */
 	if (ci->i_inline_version != CEPH_INLINE_NONE) {
-		/*
-		 * In principle, we should never get here, as the inode should have been uninlined
-		 * before we're allowed to write to the page (in write_iter or page_mkwrite).
-		 */
-		WARN_ONCE(1, "ceph: write_begin called on still-inlined inode!\n");
+		page = grab_cache_page_write_begin(mapping, index, flags);
+		if (!page)
+			return -ENOMEM;
 
 		/*
-		 * Uptodate inline data should have been added
-		 * into page cache while getting Fcr caps.
+		 * The inline_version on a new inode is set to 1. If that's the
+		 * case, then the page is brand new and isn't yet Uptodate.
 		 */
-		if (index == 0) {
-			r = -EINVAL;
+		r = 0;
+		if (index == 0 && ci->i_inline_version != 1) {
+			if (!PageUptodate(page)) {
+				WARN_ONCE(1, "ceph: write_begin called on still-inlined inode (inline_version %llu)!\n",
+					  ci->i_inline_version);
+				r = -EINVAL;
+			}
 			goto out;
 		}
-
-		page = grab_cache_page_write_begin(mapping, index, flags);
-		if (!page)
-			return -ENOMEM;
-
 		zero_user_segment(page, 0, PAGE_SIZE);
 		SetPageUptodate(page);
-		r = 0;
 		goto out;
 	}
 
@@ -1442,9 +1443,6 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-/*
- * Reuse write_begin here for simplicity.
- */
 static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-- 
2.29.2

