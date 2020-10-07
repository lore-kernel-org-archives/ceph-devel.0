Return-Path: <SRS0=cUke=DO=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E8C4363D
	for <ceph-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43332080A
	for <ceph-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602073029;
	bh=DM3lhiyb9vtqaeq4r9CabQrC5813XAm1UlasKR7oEX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O1IbDEzEhLp176jRwvfO/qk1RdL/ohLIa4/T2v8TBmSapH6Pgt/Zy/BoSK2n+dPd6
	 bHGk54lM77p2jZBu3GomV0/MxAnld0NE7KNZH19Gm2vcykYt8++Kq8S6rZKdPp9Oyu
	 8kw01HdfLgNi8AdEXRHdjJDr3ies6vXCutgsaD4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgJGMRI (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 7 Oct 2020 08:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgJGMRH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:17:07 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7605A20870;
        Wed,  7 Oct 2020 12:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602073027;
        bh=DM3lhiyb9vtqaeq4r9CabQrC5813XAm1UlasKR7oEX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeN0kCc2bp5YQc3DvqeGZhu0C49akP0qSbsd/FVyMHTJ+GCckNwvZogM8nyGiaDbl
         2ErkODE3YsaWUSSWIOKdQ8G3zEw9fduo+rMeC6d8kDjtMFn3thkEkduphWzLCfVKGs
         jvnEPEPbdI7iictlWs1pSaEyOD3BDre5bNhyZVWQ=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, ukernel@gmail.com, pdonnell@redhat.com
Subject: [PATCH v4 4/5] ceph: remove timeout on allowing reconnect after blocklisting
Date:   Wed,  7 Oct 2020 08:16:59 -0400
Message-Id: <20201007121700.10489-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007121700.10489-1-jlayton@kernel.org>
References: <20201007121700.10489-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

30 minutes is a long time to wait, and this makes it difficult to test
the feature by manually blocklisting clients. Remove the timeout
infrastructure and just allow the client to reconnect at will.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.c | 5 -----
 fs/ceph/super.h      | 1 -
 2 files changed, 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 91de271d0093..240eee5baa0f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4374,12 +4374,7 @@ static void maybe_recover_session(struct ceph_mds_client *mdsc)
 	if (!READ_ONCE(fsc->blocklisted))
 		return;
 
-	if (fsc->last_auto_reconnect &&
-	    time_before(jiffies, fsc->last_auto_reconnect + HZ * 60 * 30))
-		return;
-
 	pr_info("auto reconnect after blocklisted\n");
-	fsc->last_auto_reconnect = jiffies;
 	ceph_force_reconnect(fsc->sb);
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d0cb6a51c6a4..9ced23b092f5 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -108,7 +108,6 @@ struct ceph_fs_client {
 
 	int mount_state;
 
-	unsigned long last_auto_reconnect;
 	bool blocklisted;
 
 	bool have_copy_from2;
-- 
2.26.2

