Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339F0C433E9
	for <ceph-devel@archiver.kernel.org>; Mon, 15 Mar 2021 18:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A2064F37
	for <ceph-devel@archiver.kernel.org>; Mon, 15 Mar 2021 18:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCOSHs (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 15 Mar 2021 14:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhCOSHU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:07:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F9CF64F37;
        Mon, 15 Mar 2021 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615831640;
        bh=AlajZnYK1cbulqk1lQLn9BPuxq9jUuZejkdjoUBA0Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axXjXGt1FSsrEy4rCGHT2YFZKypBXvJfJYTQgxRiqyNfef7G7g2fbwxPVek5JvIZV
         hMC6S0OFgigtNDlLge/6uSmgq5mBN/pRCl+GlKh0JyNbWtjymp2rQqSQuoCW7tzU4/
         a4+/DDB+wt7doYdyS8sS4nUzQZein8Eq0JNckgj8R3VBJfKrHoYmHB+fzDe9zq5cR9
         7Ibh4Ffn386Wz/TMVjs8X7UuWeWY9TGHQVX5eexAhTtTEZpI6MvEmWSnZsfnkJ/qW+
         GaKN1+Z2lfEH2Q0a2Xz+LZ+gQbU7fgFjviw31kBAGuiv0EWGtuSAjrGmyS9HN7mCck
         zsE3+ux5B+W3w==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH 1/2] ceph: don't clobber i_snap_caps on non-I_NEW inode
Date:   Mon, 15 Mar 2021 14:07:16 -0400
Message-Id: <20210315180717.266155-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315180717.266155-1-jlayton@kernel.org>
References: <20210315180717.266155-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

We want the snapdir to mirror the non-snapped directory's attributes for
most things, but i_snap_caps represents the caps granted on the snapshot
directory by the MDS itself. A misbehaving MDS could issue different
caps for the snapdir and we lose them here.

Only reset i_snap_caps when the inode is I_NEW.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 26dc7a296f6b..fc7f4bf63306 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -101,12 +101,13 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	inode->i_atime = parent->i_atime;
 	inode->i_op = &ceph_snapdir_iops;
 	inode->i_fop = &ceph_snapdir_fops;
-	ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
-	ci->i_rbytes = 0;
 	ci->i_btime = ceph_inode(parent)->i_btime;
+	ci->i_rbytes = 0;
 
-	if (inode->i_state & I_NEW)
+	if (inode->i_state & I_NEW) {
+		ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
 		unlock_new_inode(inode);
+	}
 
 	return inode;
 }
-- 
2.30.2

