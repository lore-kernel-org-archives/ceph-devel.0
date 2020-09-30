Return-Path: <SRS0=DpAl=DH=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D45FC4727F
	for <ceph-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D612076B
	for <ceph-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601467830;
	bh=W+WRJiA5Dyo40yCBkIH+gN+ujGTSXHZQ4oEjCxbLe9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H5BsmuuZLjhrIkzxv6YwISCbGhaKv9DAjY66GS2kuez0520wKxTnQ5Pg6nBzGSiwE
	 s1anPcO1ufCpTpVi3izSt+VE4wuwrI40STpnexjghn88YSmd7Fo3mqRUe66uqHp+Xo
	 whnxp6PDRxamFYnhuTB4AjE88UtPKcf2tYxYx30A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgI3MK3 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgI3MK3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:10:29 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660672076E;
        Wed, 30 Sep 2020 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601467828;
        bh=W+WRJiA5Dyo40yCBkIH+gN+ujGTSXHZQ4oEjCxbLe9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkw43O9sOtysoqLCvfj3UxK2RVHtv86nWuBs1uP6HA9riajC2FubqQ0NBwzSRDfXK
         nxA4OhDtLt5jc1Iefa3zuhYQkyeiZLruvCDuTpp9QG+COdJtMbo+r8gbT8E/br9+RB
         iWD/kSP31baOF4sNQ20c0e1UbMhLd/E1X4Y/nI0k=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, ukernel@gmail.com, pdonnell@redhat.com
Subject: [RFC PATCH v2 1/4] ceph: don't WARN when removing caps due to blocklisting
Date:   Wed, 30 Sep 2020 08:10:22 -0400
Message-Id: <20200930121025.9257-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930121025.9257-1-jlayton@kernel.org>
References: <20200925140851.320673-1-jlayton@kernel.org>
 <20200930121025.9257-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

We expect to remove dirty caps when the client is blocklisted. Don't
throw a warning in that case.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index c7e69547628e..2ee3f316afcf 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1149,7 +1149,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	/* remove from inode's cap rbtree, and clear auth cap */
 	rb_erase(&cap->ci_node, &ci->i_caps);
 	if (ci->i_auth_cap == cap) {
-		WARN_ON_ONCE(!list_empty(&ci->i_dirty_item));
+		WARN_ON_ONCE(!list_empty(&ci->i_dirty_item) && !mdsc->fsc->blocklisted);
 		ci->i_auth_cap = NULL;
 	}
 
-- 
2.26.2

