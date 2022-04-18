Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FD1C433EF
	for <ceph-devel@archiver.kernel.org>; Mon, 18 Apr 2022 15:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345031AbiDRPIB (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbiDRPHk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2022 11:07:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30538E199;
        Mon, 18 Apr 2022 06:59:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5368621621;
        Mon, 18 Apr 2022 13:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650290373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zj/qp1HcgBQX+/4vlQAgG9P0stPwQSdbGTrHMd1YsE=;
        b=xOQGAQuEnYUwUyg8wh4gtVmsy+CA4bUGysO8+O+AHMi8Q9hAmV2+YR0DoDBATu3f8To0Pl
        lkZqhZ6tCJ4cTPJeBD/jZs6ClhhFJWTDZhEVJk3yefvl27Zbh4r5FUabhEOhyYPdDO6b0T
        KQoFk4tTUYaQvoJFjE9ldljmy+LXvEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650290373;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zj/qp1HcgBQX+/4vlQAgG9P0stPwQSdbGTrHMd1YsE=;
        b=srmb/a6yaKBY9Jkvs7s/j6kQYRixTP1+q6ULlkvUxEALYwp2Zaiqego6fvLJjRzwINOmJ3
        ZNJyFGJCS+6WL5AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDFE213A9B;
        Mon, 18 Apr 2022 13:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yMgsM8RuXWLiOwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 18 Apr 2022 13:59:32 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 57addfaa;
        Mon, 18 Apr 2022 13:59:58 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v5 3/5] ceph: update documentation regarding snapshot naming limitations
Date:   Mon, 18 Apr 2022 14:59:55 +0100
Message-Id: <20220418135957.12056-4-lhenriques@suse.de>
In-Reply-To: <20220418135957.12056-1-lhenriques@suse.de>
References: <20220418135957.12056-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 Documentation/filesystems/ceph.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/filesystems/ceph.rst b/Documentation/filesystems/ceph.rst
index 4942e018db85..d487cabe792d 100644
--- a/Documentation/filesystems/ceph.rst
+++ b/Documentation/filesystems/ceph.rst
@@ -57,6 +57,16 @@ a snapshot on any subdirectory (and its nested contents) in the
 system.  Snapshot creation and deletion are as simple as 'mkdir
 .snap/foo' and 'rmdir .snap/foo'.
 
+Snapshot names have two limitations:
+
+* They can not start with an underscore ('_'), as these names are reserved
+  for internal usage by the MDS.
+* They can not exceed 240 characters in size.  This is because the MDS makes
+  use of long snapshot names internally, which follow the format:
+  `_<SNAPSHOT-NAME>_<INODE-NUMBER>`.  Since filenames in general can't have
+  more than 255 characters, and `<node-id>` takes 13 characters, the long
+  snapshot names can take as much as 255 - 1 - 1 - 13 = 240.
+
 Ceph also provides some recursive accounting on directories for nested
 files and bytes.  That is, a 'getfattr -d foo' on any directory in the
 system will reveal the total number of nested regular files and
