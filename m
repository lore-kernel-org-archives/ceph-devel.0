Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110E0C433E0
	for <ceph-devel@archiver.kernel.org>; Wed, 17 Feb 2021 12:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D830764E42
	for <ceph-devel@archiver.kernel.org>; Wed, 17 Feb 2021 12:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhBQM7d (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 17 Feb 2021 07:59:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhBQM7a (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:59:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0171564E58;
        Wed, 17 Feb 2021 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613566729;
        bh=jByn3pd5Lf5X/ITyDqMYpD/JF7aF9DGK01pxbQKkl+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhOkW9eowlZFb5F4NsF81aYXpSE9VfDL3haT8KbNe8KKc0NIz731FiMMIP+ZGIqCT
         4/y7+wV7KbdjRtqMsFSMCzwPMdjayT0ZrLA7Jb59HvbBFsaOaIcZrXosOcj+bLizJ4
         6j8bUu69pys/ocye32zePKB8A7VE6me3K9k4+zagGP8VfvNfYIFVwgulyYGYGEJEfR
         YIppVVOkc1R+19RvT0Ipvtz6+/JmdCLrdgiXxyfuLvgWqQ/IJXmPy7LxBlbe4sNJcq
         OM+Ec94FkH8M7ECFXYcrbcMiHJ/eal1gGWisdD1kA/YpxVJ+JrqoQsu1UZRVRsuhtX
         bbvwGj8DWAWTQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com, idryomov@gmail.com
Cc:     xiubli@redhat.com, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/6] ceph: rework PageFsCache handling
Date:   Wed, 17 Feb 2021 07:58:41 -0500
Message-Id: <20210217125845.10319-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210217125845.10319-1-jlayton@kernel.org>
References: <20210217125845.10319-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

With the new fscache API, the PageFsCache bit now indicates that the
page is being written to the cache and shouldn't be modified or released
until it's finished.

Change releasepage and invalidatepage to wait on that bit before
returning.

Also define FSCACHE_USE_NEW_IO_API so that we opt into the new fscache
API.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org
Cc: linux-cachefs@redhat.com
Cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/addr.c  | 9 ++++++++-
 fs/ceph/super.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2b17bb36e548..fbfa49db06fd 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -146,6 +146,8 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc = page_snap_context(page);
 
+	wait_on_page_fscache(page);
+
 	inode = page->mapping->host;
 	ci = ceph_inode(inode);
 
@@ -168,11 +170,16 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	ClearPagePrivate(page);
 }
 
-static int ceph_releasepage(struct page *page, gfp_t g)
+static int ceph_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
 	     page, page->index, PageDirty(page) ? "" : "not ");
 
+	if (PageFsCache(page)) {
+		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
+			return 0;
+		wait_on_page_fscache(page);
+	}
 	return !PagePrivate(page);
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index b62d8fee3b86..96bd3487d788 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -21,6 +21,7 @@
 #include <linux/ceph/libceph.h>
 
 #ifdef CONFIG_CEPH_FSCACHE
+#define FSCACHE_USE_NEW_IO_API
 #include <linux/fscache.h>
 #endif
 
-- 
2.29.2

