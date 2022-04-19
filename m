Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1DDC433EF
	for <ceph-devel@archiver.kernel.org>; Tue, 19 Apr 2022 08:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350139AbiDSIv4 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 19 Apr 2022 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344989AbiDSIvz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2022 04:51:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1422B1B;
        Tue, 19 Apr 2022 01:49:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC0D121123;
        Tue, 19 Apr 2022 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650358152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=veZwth4pnkAc1b01KZ2PxJ5UoKpL05j2z6FljMj67zo=;
        b=zROyWiGnPlNa5+3/mUcvvdT6F4ulE0KTFzoi7l9Pbq7zhXKxvmQzUCmm/sRigWpcuCKS3W
        e7HXpqP6S8zOCVVirOrkl3FPeP/3HmmZIy0owUAZZWqx01ujTSelxuhKKyFqzP5XNMRbAL
        oBKItwYZ8E6u20QB4BldiaTB6GkTXew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650358152;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=veZwth4pnkAc1b01KZ2PxJ5UoKpL05j2z6FljMj67zo=;
        b=6i57B4fjuYRq0lKiVBvys5Ei37jjLOL+FXhIjqLGcNMqlx0NpHdAvo2LzSL/m28wMYRa0w
        igWTqCj+/KCZCGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3599B139BE;
        Tue, 19 Apr 2022 08:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lNAKCoh3XmIiegAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 19 Apr 2022 08:49:12 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 88491bf6;
        Tue, 19 Apr 2022 08:49:38 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ceph: fix compilation error when building kernel without FS_ENCRYPT
Date:   Tue, 19 Apr 2022 09:49:37 +0100
Message-Id: <20220419084937.3199-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

When compiling without FS_ENCRYPTION config, the kernel will fail to build
with:

fs/ceph/inode.c:196:7: error: no member named 'fscrypt_auth' in 'struct ceph_inode_info'

Enclose the code within an #ifdef CONFIG_FS_ENCRYPTION to fix it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/inode.c | 2 ++
 1 file changed, 2 insertions(+)

Jeff, feel free to squash this patch into one of the previous patches from
the snapshot names encryption series.

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 636e4e0a9dc6..5de7bb9048b7 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -189,6 +189,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	ci->i_rbytes = 0;
 	ci->i_btime = ceph_inode(parent)->i_btime;
 
+#ifdef CONFIG_FS_ENCRYPTION
 	/* if encrypted, just borrow fscrypt_auth from parent */
 	if (IS_ENCRYPTED(parent)) {
 		struct ceph_inode_info *pci = ceph_inode(parent);
@@ -205,6 +206,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 			goto err;
 		}
 	}
+#endif
 	if (inode->i_state & I_NEW) {
 		inode->i_op = &ceph_snapdir_iops;
 		inode->i_fop = &ceph_snapdir_fops;
