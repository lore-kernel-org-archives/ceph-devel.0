Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31C8C433EF
	for <ceph-devel@archiver.kernel.org>; Fri,  1 Apr 2022 15:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352182AbiDAPHq (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350270AbiDAOrW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2022 10:47:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927FD2A1E9B;
        Fri,  1 Apr 2022 07:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0B39B82511;
        Fri,  1 Apr 2022 14:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2078C340F2;
        Fri,  1 Apr 2022 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823848;
        bh=mHKZ7ckdU7TkU9H+n/vpGu0Ah9I3UG0+uNUuTBwQZLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JII1diyuvhjYivXhx7ID9YX4vZGs2JGv+Hnf8Mk6faARb8HOmg43oHK2haf0+URHf
         UBnxHpsz3/leIXa7Fyiawo73+/klN8VUmSI8gAC1SLCjDXq/VQdGaao8UKYmjON2/Z
         E9LS16LlNGHZRazgpfK6gnNkLEl1iM5Go+FINVTwHdMAFBIGpUMpBSA7gfOT4FkKuz
         EJGefpVc4sHL398L6F2RF14NDTz3f/xGMgR/95yes6iuMDwHcXN+5DxgOB1C2GFelG
         F6Bca2zaHxJ7eBhkel6G9eIPwgDu2CV2LhaqMawDsXneo2PQQ+kzDrvoyeQEK0hx3L
         SuJe913gr3BvQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 105/109] ceph: fix inode reference leakage in ceph_get_snapdir()
Date:   Fri,  1 Apr 2022 10:32:52 -0400
Message-Id: <20220401143256.1950537-105-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143256.1950537-1-sashal@kernel.org>
References: <20220401143256.1950537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 322794d3355c33adcc4feace0045d85a8e4ed813 ]

The ceph_get_inode() will search for or insert a new inode into the
hash for the given vino, and return a reference to it. If new is
non-NULL, its reference is consumed.

We should release the reference when in error handing cases.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/inode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index e3322fcb2e8d..6d87991cf67e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -87,13 +87,13 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	if (!S_ISDIR(parent->i_mode)) {
 		pr_warn_once("bad snapdir parent type (mode=0%o)\n",
 			     parent->i_mode);
-		return ERR_PTR(-ENOTDIR);
+		goto err;
 	}
 
 	if (!(inode->i_state & I_NEW) && !S_ISDIR(inode->i_mode)) {
 		pr_warn_once("bad snapdir inode type (mode=0%o)\n",
 			     inode->i_mode);
-		return ERR_PTR(-ENOTDIR);
+		goto err;
 	}
 
 	inode->i_mode = parent->i_mode;
@@ -113,6 +113,12 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	}
 
 	return inode;
+err:
+	if ((inode->i_state & I_NEW))
+		discard_new_inode(inode);
+	else
+		iput(inode);
+	return ERR_PTR(-ENOTDIR);
 }
 
 const struct inode_operations ceph_file_iops = {
-- 
2.34.1

