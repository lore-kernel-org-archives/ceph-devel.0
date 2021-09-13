Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C2C433EF
	for <ceph-devel@archiver.kernel.org>; Mon, 13 Sep 2021 22:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7187601FA
	for <ceph-devel@archiver.kernel.org>; Mon, 13 Sep 2021 22:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349030AbhIMWmv (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 13 Sep 2021 18:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344834AbhIMWkz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:40:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 233F861372;
        Mon, 13 Sep 2021 22:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631572564;
        bh=VMuY59nRMHXM9oxHOBCuhkMtxetplSSkJKf7WghjCD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3C9jfwDVV3ee6AWIG8skt2+w0GCHsEzdKjquj5eMpeHl0VrAfFyH5Y/nhe5hOvbu
         1Np+XkJg6Bwk1zydtfYJW8EHNHoZ7oG3Gjzh2I9IUmrHtredVe+iUxg3G0UwbSdMnE
         D5HpT9InjpC6XmVwqP06VWkfuusD1byJXgnK1Vk1xN7OhAQok6Mi8H55wyFj9y3tO1
         7IRj10WDFYh96K66ecVg3E1eZN5WuAFKI/+L0sx2kOwNqioWexOdkNECwBZkQDwP/k
         Zy+0J+RZtCz80ce6yJmV1IZEBJ3MGN0BiqzLTMf5MwibR/KaKK25QbOFrPenSgRtJ/
         9o2gCf82s5HRw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 2/8] ceph: lockdep annotations for try_nonblocking_invalidate
Date:   Mon, 13 Sep 2021 18:35:55 -0400
Message-Id: <20210913223601.436675-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913223601.436675-1-sashal@kernel.org>
References: <20210913223601.436675-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 3eaf5aa1cfa8c97c72f5824e2e9263d6cc977b03 ]

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 9d74cd37b395..154c47282a34 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1545,6 +1545,8 @@ static int __mark_caps_flushing(struct inode *inode,
  * try to invalidate mapping pages without blocking.
  */
 static int try_nonblocking_invalidate(struct inode *inode)
+	__releases(ci->i_ceph_lock)
+	__acquires(ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u32 invalidating_gen = ci->i_rdcache_gen;
-- 
2.30.2

