Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64912C433EF
	for <ceph-devel@archiver.kernel.org>; Tue, 24 May 2022 09:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiEXJmY (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 24 May 2022 05:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiEXJmV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2022 05:42:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A6E52E5F;
        Tue, 24 May 2022 02:42:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 649D721A11;
        Tue, 24 May 2022 09:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653385339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a1J5PSMp3r+wQWg4I2gAw29QQ98Ls3q2zeFV14zGoIQ=;
        b=Y+qF1t9L5puitqy+nnZynN1htGHDzCGInOH5G2xZZvefqtJZyLV0w2ZA5sTQ384gWLkHaE
        vkT01rHe6zqnd/00+wWaA6eQwPaOJ3j45aHr4S/WuNrKFinlxWwWl529cw3F6XUWZ9wI8c
        XaNMRNV4Vho2HQoIc1Tl0m2tbUFJoX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653385339;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a1J5PSMp3r+wQWg4I2gAw29QQ98Ls3q2zeFV14zGoIQ=;
        b=h06JboV5wP4YUd/QzktlATWjv177YWVReQNSGWwWmzHjMm2DXOqS5tB6ElNmBri9LubFZj
        qBe/1Ik792cMToBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2663913ADF;
        Tue, 24 May 2022 09:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9miNBnuojGJXCwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 24 May 2022 09:42:19 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 6875f8d8;
        Tue, 24 May 2022 09:42:57 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     ceph-devel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v2] ceph/001: skip metrics check if no copyfrom mount option is used
Date:   Tue, 24 May 2022 10:42:56 +0100
Message-Id: <20220524094256.16746-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Checking the metrics is only valid if 'copyfrom' mount option is
explicitly set, otherwise the kernel won't be doing any remote object
copies.  Fix the logic to skip this metrics checking if 'copyfrom' isn't
used.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 tests/ceph/001 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Changes since v1:
- Quoted 'hascopyfrom' variable in 'if' statement; while there, added
  quotes to the 'if' statement just above.

diff --git a/tests/ceph/001 b/tests/ceph/001
index 7970ce352bab..060c4c450091 100755
--- a/tests/ceph/001
+++ b/tests/ceph/001
@@ -86,11 +86,15 @@ check_copyfrom_metrics()
 	local copies=$4
 	local c1=$(get_copyfrom_total_copies)
 	local s1=$(get_copyfrom_total_size)
+	local hascopyfrom=$(_fs_options $TEST_DEV | grep "copyfrom")
 	local sum
 
-	if [ ! -d $metrics_dir ]; then
+	if [ ! -d "$metrics_dir" ]; then
 		return # skip metrics check if debugfs isn't mounted
 	fi
+	if [ -z "$hascopyfrom" ]; then
+		return # ... or if we don't have copyfrom mount option
+	fi
 
 	sum=$(($c0+$copies))
 	if [ $sum -ne $c1 ]; then
