Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898E5C433EF
	for <ceph-devel@archiver.kernel.org>; Mon,  6 Jun 2022 23:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiFFXbs (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 6 Jun 2022 19:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiFFXbr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jun 2022 19:31:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0606A438
        for <ceph-devel@vger.kernel.org>; Mon,  6 Jun 2022 16:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FDFDB81C39
        for <ceph-devel@vger.kernel.org>; Mon,  6 Jun 2022 23:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD61DC385A9;
        Mon,  6 Jun 2022 23:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654558304;
        bh=cWRABr9NyaHY/Rqyk25+g44b06tbz+ergbwCfN42vLY=;
        h=From:To:Cc:Subject:Date:From;
        b=YyFYqzMsoLeb0ROdplEiJfoepGHNtWLZCsiCWN/MFTUsfLlQZWZLnFt8V/RIGBu6t
         bC8kSQpngWKIPjGYD/0E6JWcjgQc6LWphQ4oYKJPip4/Z/6++zyzSbcK3EggsfXDaf
         SkQ9/bib03HrehrkRxDT1Blx8lgSRI1vbxegLXBgGidUwR6mwbMfZ0FbpgNb5Oevlq
         LIUqe68Sh5cilujr1I5ccdGcRFmrgxdzBgQ5cKtSkyAIjozSNdXi5mu8NnTzZqcGIo
         oVgK4+DoUVHRXJ+YL/HQsst8Mf0FMdVOGuAGJr18kVC7kX7g2tcBuUcnfQP2GeAcSg
         pmuKsPU291cJg==
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org
Subject: [PATCH] ceph: wait on async create before checking caps for syncfs
Date:   Mon,  6 Jun 2022 19:31:42 -0400
Message-Id: <20220606233142.150457-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Currently, we'll call ceph_check_caps, but if we're still waiting on the
reply, we'll end up spinning around on the same inode in
flush_dirty_session_caps. Wait for the async create reply before
flushing caps.

Fixes: fbed7045f552 (ceph: wait for async create reply before sending any cap messages)
URL: https://tracker.ceph.com/issues/55823
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 1 +
 1 file changed, 1 insertion(+)

I don't know if this will fix the tx queue stalls completely, but I
haven't seen one with this patch in place. I think it makes sense on its
own, either way.

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 0a48bf829671..5ecfff4b37c9 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4389,6 +4389,7 @@ static void flush_dirty_session_caps(struct ceph_mds_session *s)
 		ihold(inode);
 		dout("flush_dirty_caps %llx.%llx\n", ceph_vinop(inode));
 		spin_unlock(&mdsc->cap_dirty_lock);
+		ceph_wait_on_async_create(inode);
 		ceph_check_caps(ci, CHECK_CAPS_FLUSH, NULL);
 		iput(inode);
 		spin_lock(&mdsc->cap_dirty_lock);
-- 
2.36.1

