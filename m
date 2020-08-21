Return-Path: <SRS0=/ley=B7=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25265C433E1
	for <ceph-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84B7206DA
	for <ceph-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598028418;
	bh=1yPzK9t3GFlkQwdBVi7C7ZW6wopToJk1Y05XWH4ziTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ruuh9l+dT+kXfYyixxwB24Pzl2RwPI4Bp2io1zgZrJJiAxsnmdYaWuN6TA12c01kG
	 s3UlLhVXxQH/Dkoa93thO19yU51QVu/L2+S5o00KnUFzXwCY8n5uCseGx9wKBbiSLW
	 ubRAaz9gapjxdWC4ZdW8MmSxzULgpTc/VsoCzdD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgHUQqp (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgHUQUb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:20:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 687C222CBB;
        Fri, 21 Aug 2020 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026774;
        bh=1yPzK9t3GFlkQwdBVi7C7ZW6wopToJk1Y05XWH4ziTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdQQJRUd1DTgjm4UukzaVUwcttnvH+w72edgG95+B80WkaMrjlXFN+qMF3V00cyXK
         dlTW34MUxa3FuKdrqZU9mSTv9Wp06XqO6D3StITwmLoyAwaGyFKXK0M93KZbv9KJul
         7Lqd7K+uqktVPBZrygTufbmceuKkp5Q7gnDOFVaQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 28/30] ceph: fix potential mdsc use-after-free crash
Date:   Fri, 21 Aug 2020 12:18:55 -0400
Message-Id: <20200821161857.348955-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161857.348955-1-sashal@kernel.org>
References: <20200821161857.348955-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit fa9967734227b44acb1b6918033f9122dc7825b9 ]

Make sure the delayed work stopped before releasing the resources.

cancel_delayed_work_sync() will only guarantee that the work finishes
executing if the work is already in the ->worklist.  That means after
the cancel_delayed_work_sync() returns, it will leave the work requeued
if it was rearmed at the end. That can lead to a use after free once the
work struct is freed.

Fix it by flushing the delayed work instead of trying to cancel it, and
ensure that the work doesn't rearm if the mdsc is stopping.

URL: https://tracker.ceph.com/issues/46293
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f36ddfea4997e..06109314d93c8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3518,6 +3518,9 @@ static void delayed_work(struct work_struct *work)
 	dout("mdsc delayed_work\n");
 	ceph_check_delayed_caps(mdsc);
 
+	if (mdsc->stopping)
+		return;
+
 	mutex_lock(&mdsc->mutex);
 	renew_interval = mdsc->mdsmap->m_session_timeout >> 2;
 	renew_caps = time_after_eq(jiffies, HZ*renew_interval +
@@ -3851,7 +3854,16 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 {
 	dout("stop\n");
-	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
+	/*
+	 * Make sure the delayed work stopped before releasing
+	 * the resources.
+	 *
+	 * Because the cancel_delayed_work_sync() will only
+	 * guarantee that the work finishes executing. But the
+	 * delayed work will re-arm itself again after that.
+	 */
+	flush_delayed_work(&mdsc->delayed_work);
+
 	if (mdsc->mdsmap)
 		ceph_mdsmap_destroy(mdsc->mdsmap);
 	kfree(mdsc->sessions);
-- 
2.25.1

