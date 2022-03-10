Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DE8C433FE
	for <ceph-devel@archiver.kernel.org>; Thu, 10 Mar 2022 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiCJR1O (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiCJR1G (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2022 12:27:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CF81CFD6;
        Thu, 10 Mar 2022 09:26:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64A641F441;
        Thu, 10 Mar 2022 17:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646933163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PMSTGqDSrsqbsJOsSeKSY5wwVv+P7I96rXhk4gSMG1Q=;
        b=QVS2aUjPuN+J53PgmPdRUT0wyTXmvoPudhWMP+GgtDcZMbFHhAiNqZq89qXCZPQxyxc3qE
        kpNLInQSUPGiXCbAcYO3OzBvW5khYO+syCUn+RzNCQEXegkTUSPLRqOlVuN6n7u1PYJsYr
        VGuUZIOvMTwey5CUzeKmTjRnlH0fubo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646933163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PMSTGqDSrsqbsJOsSeKSY5wwVv+P7I96rXhk4gSMG1Q=;
        b=M9SwbdpnlxJzut9/Gn1x1l51N/2Iqax32UyEvW+cF8fOQnC0RzefnKSq0UjjztF5M/1SsI
        RnsVeX+uoq+dE2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFC2413A66;
        Thu, 10 Mar 2022 17:26:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KR+RN6o0KmI0MQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 10 Mar 2022 17:26:02 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 6eaf85f2;
        Thu, 10 Mar 2022 17:26:17 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH 0/2] Add support for snapshot names encryption
Date:   Thu, 10 Mar 2022 17:26:14 +0000
Message-Id: <20220310172616.16212-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Hi!

So, I've changed this code back into and RFC as I'm not sure yet if this
is it's final form.  I think the 2 patches in this series should probably
be squashed into a single patch.  I decided to keep them separate as the
1st one is simple (it's the same patch I had already sent), and the 2nd
patch adds a lot more complexity to the whole thing.

So, I've looked at Xiubo initial patch for handling snapshots long names.
It was complex, of course, and it required extra MDS changes.  I *think*
my approach is slightly simpler, but I'm not entirely sure yet that I'm
handling every case.

In order to test this code the following PRs are required:

  mds: add protection from clients without fscrypt support #45073
  mds: use the whole string as the snapshot long name #45192
  mds: support alternate names for snapshots #45224
  mds: limit the snapshot names to 240 characters #45312

Comments are welcome, I'm still testing these patches and I do expect to
find that something is still missing.  And I do expect to find bugs.
These strings parsing scares me a lot, but I couldn't see a simpler
approach.

Luís Henriques (2):
  ceph: add support for encrypted snapshot names
  ceph: add support for handling encrypted snapshot names in subtree

 fs/ceph/crypto.c | 146 +++++++++++++++++++++++++++++++++++++++++------
 fs/ceph/crypto.h |   9 ++-
 fs/ceph/dir.c    |   9 +++
 fs/ceph/inode.c  |  13 +++++
 4 files changed, 156 insertions(+), 21 deletions(-)

