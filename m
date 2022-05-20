Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4E1C4332F
	for <ceph-devel@archiver.kernel.org>; Fri, 20 May 2022 09:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243174AbiETJqo (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 20 May 2022 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244958AbiETJqg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 20 May 2022 05:46:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B66F04;
        Fri, 20 May 2022 02:46:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E18FA21B41;
        Fri, 20 May 2022 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653039993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ntYBk9ezG3CQc/UDLiRjt/vCGhzq8dn4N+lpgdsxHGA=;
        b=gGLRN80F3xUy8Uwu8dNVKVjOGRnJab96q54Dny217CVo1jMuULWZe+eYn4wWq3VWm10iSq
        twvNA3knhapAUv0ApchM4VB54Gx3+VJHQ4PmfKhvA+8U0NhBN7JVADRb5DfKDUKpqz6oCS
        3Z5JsPCPJXwWXDmcScDngk1Gae6OWAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653039993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ntYBk9ezG3CQc/UDLiRjt/vCGhzq8dn4N+lpgdsxHGA=;
        b=uorL/HCgzvZLn8yh4SQ8drtbWOEl86MY+leXnayKFWl1+YwoC6yeYjABTlaOS38Ey531aa
        RqKLpoBK6B67SuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 865F913AF4;
        Fri, 20 May 2022 09:46:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /rvNHXljh2KVdwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 20 May 2022 09:46:33 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 0dff867f;
        Fri, 20 May 2022 09:47:11 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     ceph-devel@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] ceph/002: fix test expected output
Date:   Fri, 20 May 2022 10:47:09 +0100
Message-Id: <20220520094709.30365-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Commit daa0c0146c7d ("fstests: replace hexdump with od command") broke
ceph/002 by adding an extra '0' in the offset column.  Fix it.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 tests/ceph/002.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ceph/002.out b/tests/ceph/002.out
index f7f1c0ba8487..4f766c257a9c 100644
--- a/tests/ceph/002.out
+++ b/tests/ceph/002.out
@@ -5,4 +5,4 @@ QA output created by 002
 *
 800000 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63 63  >cccccccccccccccc<
 *
-c000000
+c00000
