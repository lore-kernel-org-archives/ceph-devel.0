Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310CFC433F5
	for <ceph-devel@archiver.kernel.org>; Fri,  4 Mar 2022 16:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbiCDQOj (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 4 Mar 2022 11:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiCDQOi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2022 11:14:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0C6157216;
        Fri,  4 Mar 2022 08:13:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D9D81F385;
        Fri,  4 Mar 2022 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646410429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k//hednYVEXD6LxAe4AW1qGWx3sbmOd1vX1eHIwIpr8=;
        b=IzXUkpy3WtznZCKTJL7u60nkG2OAD90PajjHgaIUDBtYq8MIvK8r53T8L3f2lcZiAAED3n
        2qF0So6w6cVBJUb4rhzYSaCIWJBShrZOSbMrY/E6Vwh2iI4cO1ftVuFsDaput4cbfc2uDY
        AsGDNmN8JzA0clo2jF/0bPFP47cKEoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646410429;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k//hednYVEXD6LxAe4AW1qGWx3sbmOd1vX1eHIwIpr8=;
        b=8H86Nb3It4SjlAYlaDNrQJDPjGgQwvSigCcKtpChoHGaWgnOjD0GEkDgMfhfgWxXZ1zRUP
        qGwQwS0aQxhCRsDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1655B13B64;
        Fri,  4 Mar 2022 16:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OcB6Ar06ImKeRAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 04 Mar 2022 16:13:49 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b55044ab;
        Fri, 4 Mar 2022 16:14:04 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH 0/3] ceph: minor fixes and encrypted snapshot names
Date:   Fri,  4 Mar 2022 16:14:00 +0000
Message-Id: <20220304161403.19295-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Hi!

I'm sending another iteration of the encrypted snapshot names patch.  This
patch assumes PR#45224 [1] to be merged as it adds support for the
alternate names.

Two notes:

1. Patch 0001 is just a small fix from another fscrypt patch.  It's
   probably better to simply squash it.

2. I'm not sure how easy it is to hit the UAF fixed by patch 0002.  I can
   reproduce it easily by commenting the code that adds the
   DCACHE_NOKEY_NAME flag in patch 0003.

Any comments are welcome (including for the PR mentioned above, of course).

[1] https://github.com/ceph/ceph/pull/45224

Luís Henriques (3):
  ceph: fix error path in ceph_readdir()
  ceph: fix use-after-free in ceph_readdir
  ceph: add support for encrypted snapshot names

 fs/ceph/dir.c   | 11 ++++++++++-
 fs/ceph/inode.c | 13 +++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

