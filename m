Return-Path: <SRS0=4IBn=B6=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF6AC433DF
	for <ceph-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589EA207FB
	for <ceph-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882165;
	bh=v9H/VNClXTCOSayoDs+ffigBMW2X2b5UbOg2dweTYX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ha9J2oRyyYYiiB0nCnxwxZYQU4ZAoyXLtquAeE8YUZSYSZDlk54Zpu/Wzy1HF/Ma/
	 7aqTzTbV3nr3xZUOLovr1KfAmhZ2NjD8Mz7HT71iqX5XfRJrBW+vVt9r3qYtMOyNT+
	 3y4guINcMKXVLihY+vJ9KCb7g8ShcyNjlH+F8baM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgHTAJO (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbgHTACr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:02:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37E621775;
        Thu, 20 Aug 2020 00:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881767;
        bh=v9H/VNClXTCOSayoDs+ffigBMW2X2b5UbOg2dweTYX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIQU/v6KYZz+QfIV3QiAbOrK6QzjzVMOLnQbkaS/faQwV05810ClCpendA6u8Bs+f
         r0lmbIC9/sMlvEMi7WB/XzyB6WUK2FpoYsRj6PIbRYHdPDWiAnIMWgYl8JZvtrpw2I
         EMl+unqcD8nK2TVBTafvnL03Q/Kyiztqo5IJWKpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>,
        syzbot+b57f46d8d6ea51960b8c@syzkaller.appspotmail.com,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/22] ceph: fix use-after-free for fsc->mdsc
Date:   Wed, 19 Aug 2020 20:02:20 -0400
Message-Id: <20200820000229.215333-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000229.215333-1-sashal@kernel.org>
References: <20200820000229.215333-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit a7caa88f8b72c136f9a401f498471b8a8e35370d ]

If the ceph_mdsc_init() fails, it will free the mdsc already.

Reported-by: syzbot+b57f46d8d6ea51960b8c@syzkaller.appspotmail.com
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b79fe6549df6f..676e4ff1df2f3 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4141,7 +4141,6 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 		return -ENOMEM;
 	}
 
-	fsc->mdsc = mdsc;
 	init_completion(&mdsc->safe_umount_waiters);
 	init_waitqueue_head(&mdsc->session_close_wq);
 	INIT_LIST_HEAD(&mdsc->waiting_for_map);
@@ -4193,6 +4192,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 
 	strscpy(mdsc->nodename, utsname()->nodename,
 		sizeof(mdsc->nodename));
+
+	fsc->mdsc = mdsc;
 	return 0;
 }
 
-- 
2.25.1

