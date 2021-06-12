Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B341FC48BE5
	for <ceph-devel@archiver.kernel.org>; Sat, 12 Jun 2021 00:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D04613BA
	for <ceph-devel@archiver.kernel.org>; Sat, 12 Jun 2021 00:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFLANm (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 11 Jun 2021 20:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhFLANm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:13:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2C0C611C9;
        Sat, 12 Jun 2021 00:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623456703;
        bh=Tu5a8C+SqP0zJQs3rIaJjHW135ITBA0pKl8xjZ4BBQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCHuMNqon0HM1HNFS6XMXUM4LKNlPv+bAtPvkLzHm+stdMFIFUhJbV2hD7iJjvPrN
         rxqqgd5MAEz7ntHHBHLZbsWnZ74SCPGXbz26c8NKQ0qe6bSOMfvuxC4zDY26BDpYsH
         kQ1FUR/couJD3vcCfD6XipHOTNYqEr6yU/w8+LkktY0HvoDxn+qr5eGSWsXNuCYPhh
         JcbRh+86spoYV0Op57kSNPdmhbWs/MZdCaULa0cZVrfnr7PLuhNDqRVPBP7hBe/SUc
         qGMCQnTr80VSjYuuAnD3CbqnGfWp+DsZwQeSXn6Yv03vya/yVx8jG0WAgZ5ywWmon7
         yCv0ukS63LZag==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-cachefs@redhat.com, pfmeec@rit.edu, willy@infradead.org,
        dhowells@redhat.com, idryomov@gmail.com, stable@vger.kernel.org,
        Andrew W Elble <aweits@rit.edu>
Subject: [PATCH v2] ceph: fix write_begin optimization when write is beyond EOF
Date:   Fri, 11 Jun 2021 20:11:41 -0400
Message-Id: <20210612001141.167797-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611195904.160416-1-jlayton@kernel.org>
References: <20210611195904.160416-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

It's not sufficient to skip reading when the pos is beyond the EOF.
There may be data at the head of the page that we need to fill in
before the write. Only elide the read if the pos is beyond the last page
in the file.

Cc: <stable@vger.kernel.org> # v5.10+
Fixes: 1cc1699070bd ("ceph: fold ceph_update_writeable_page into ceph_write_begin")
Reported-by: Andrew W Elble <aweits@rit.edu>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

This version fixes the one-off bug that Willy pointed out in v1.

Note that v5.13 has been converted to use the new netfs read helper lib,xi
so this fix is for v5.10.z through v5.12.z.

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 26e66436f005..813ab4256dbb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1353,11 +1353,11 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 		/*
 		 * In some cases we don't need to read at all:
 		 * - full page write
-		 * - write that lies completely beyond EOF
+		 * - write that lies in a page that is completely beyond EOF
 		 * - write that covers the the page from start to EOF or beyond it
 		 */
 		if ((pos_in_page == 0 && len == PAGE_SIZE) ||
-		    (pos >= i_size_read(inode)) ||
+		    (index > (i_size_read(inode) - 1) / PAGE_SIZE) ||
 		    (pos_in_page == 0 && (pos + len) >= i_size_read(inode))) {
 			zero_user_segments(page, 0, pos_in_page,
 					   pos_in_page + len, PAGE_SIZE);
-- 
2.31.1

