Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B58C433F5
	for <ceph-devel@archiver.kernel.org>; Thu,  7 Apr 2022 15:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbiDGPRB (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiDGPRA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2022 11:17:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807141F9A3D;
        Thu,  7 Apr 2022 08:15:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 09776212C6;
        Thu,  7 Apr 2022 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649344499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q1cZd0ZM0hzv0DGkhpIEZq7s77IIJxTYCjo6p+thLHo=;
        b=WUb7g9aQsHvHeCFjSaDCiNMSIvCLZJ+wTcpHM5Dqj6O+/31CUQCfunDovZsOzvcze32jaG
        P1fDoe3wS8GQshEeHpaOZxNbKruKBs+izwleeYxo6cVeBIV3BiGS2r0Zk4lv0dWObMjdNt
        BhefGxNQcr+CjL4TbdMImIZ9ZFhYexM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649344499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q1cZd0ZM0hzv0DGkhpIEZq7s77IIJxTYCjo6p+thLHo=;
        b=Q5iLKfzCpEV+FRBPm7V0bCPbUFtVnS7jxV0jsLkjCMN2QdOsLr8VAjptC6LIjtUmCwVsLS
        ZQ8q42Erwh4lsmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93FFB13485;
        Thu,  7 Apr 2022 15:14:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SPMdIfL/TmIFagAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 07 Apr 2022 15:14:58 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 4a5c2daf;
        Thu, 7 Apr 2022 15:15:21 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v4] ceph: invalidate pages when doing direct/sync writes
Date:   Thu,  7 Apr 2022 16:15:21 +0100
Message-Id: <20220407151521.7968-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

When doing a direct/sync write, we need to invalidate the page cache in
the range being written to.  If we don't do this, the cache will include
invalid data as we just did a write that avoided the page cache.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/file.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

Changes since v3:
- Dropped initial call to invalidate_inode_pages2_range()
- Added extra comment to document invalidation

Changes since v2:
- Invalidation needs to be done after a write

Changes since v1:
- Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
- Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5072570c2203..97f764b2fbdd 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1606,11 +1606,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		return ret;
 
 	ceph_fscache_invalidate(inode, false);
-	ret = invalidate_inode_pages2_range(inode->i_mapping,
-					    pos >> PAGE_SHIFT,
-					    (pos + count - 1) >> PAGE_SHIFT);
-	if (ret < 0)
-		dout("invalidate_inode_pages2_range returned %d\n", ret);
 
 	while ((len = iov_iter_count(from)) > 0) {
 		size_t left;
@@ -1938,6 +1933,20 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			break;
 		}
 		ceph_clear_error_write(ci);
+
+		/*
+		 * we need to invalidate the page cache here, otherwise the
+		 * cache will include invalid data in direct/sync writes.
+		 */
+		ret = invalidate_inode_pages2_range(
+				inode->i_mapping,
+				pos >> PAGE_SHIFT,
+				(pos + len - 1) >> PAGE_SHIFT);
+		if (ret < 0) {
+			dout("invalidate_inode_pages2_range returned %d\n",
+			     ret);
+			ret = 0;
+		}
 		pos += len;
 		written += len;
 		dout("sync_write written %d\n", written);
