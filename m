Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA79C28D13
	for <ceph-devel@archiver.kernel.org>; Thu, 25 Aug 2022 13:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242770AbiHYNcA (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242721AbiHYNbr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2022 09:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6FFB5174
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2022 06:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B7B261D15
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2022 13:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2E5C433B5;
        Thu, 25 Aug 2022 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661434304;
        bh=ApL6RGwkkLRptlqfQV9WN+EukbodlFPBqDdYU54bQKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=soImeGfCIvCZYmEq4D22q7gBnCoLb6bPyu65+KdGMj5FxGjCSceNpVS/397Wk0sse
         fCCihpwK0vjZMWlD1n+L1ZrXgO48YJsan46nNwS73GJ2995f08I9W3YSh7zf9dt1Ee
         swCUTM1s74VUO0J4ejZcOlWaUv283Jt/fpMEsJ/AYwDVgX/14YMWh28gPLT45JHfP1
         qqgl7KKXBmL93fZtXH+ag3Ky4h+P6SKprZhS0LjyAq15jZ/+l4fqHZM60bms8dquwj
         t2GjIb4olxTTSYViZ2e6WNIfHZ/4aWYx/SM0gkL+9pqBL+1ZXennaiGL4J/VO3qPkY
         7VEd4C8b2rapA==
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com, idryomov@gmail.com
Cc:     lhenriques@suse.de, ceph-devel@vger.kernel.org
Subject: [PATCH v15 14/29] ceph: disable fallocate for encrypted inodes
Date:   Thu, 25 Aug 2022 09:31:17 -0400
Message-Id: <20220825133132.153657-15-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825133132.153657-1-jlayton@kernel.org>
References: <20220825133132.153657-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

...hopefully, just for now.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 31de744b1a5f..64f8f668970f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2183,6 +2183,9 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (!S_ISREG(inode->i_mode))
 		return -EOPNOTSUPP;
 
+	if (IS_ENCRYPTED(inode))
+		return -EOPNOTSUPP;
+
 	prealloc_cf = ceph_alloc_cap_flush();
 	if (!prealloc_cf)
 		return -ENOMEM;
-- 
2.37.2

