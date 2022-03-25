Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B779EC433EF
	for <ceph-devel@archiver.kernel.org>; Fri, 25 Mar 2022 09:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358540AbiCYJwM (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 25 Mar 2022 05:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358536AbiCYJwL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Mar 2022 05:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3F1CC539
        for <ceph-devel@vger.kernel.org>; Fri, 25 Mar 2022 02:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 299E460BC9
        for <ceph-devel@vger.kernel.org>; Fri, 25 Mar 2022 09:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39712C340F1;
        Fri, 25 Mar 2022 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648201836;
        bh=ABb+DAmOZEyRrnFJe6GSPCaQx8UCw5xOLfDCdznbv6o=;
        h=From:To:Cc:Subject:Date:From;
        b=mwT/J11f2N+sd3ytgPWK1vB96l6MR5hJzpApyGJQCJRLx8dTMqS/6+M9tZPNj712P
         hW92t3t2DRnDdQgG2TWY1vPTZniudXdcKWYKT0W28PFbrUZl52d57CHaieJqykU3w5
         JA9+DOBUhtvPGyIUmDvsmL0+6mNg2+Nx3Oflgl8fouXQKt5HfXTM+qBKemG6orK4sB
         PawyS3q8j07znuoDVx6LWOlquOA5uyTVmzQVukbyPWVgBKP50bjCC0tu+jkPkvfV4P
         /4r7rkyRGeYO80jjUxhdvuGfdTs2ZzVwzC3x8eQ5/FD2H6RFVqIg/ruJLQQlpvkUuM
         155WANseMZp8w==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org
Subject: [PATCH v5 0/7] libceph: add support for sparse reads
Date:   Fri, 25 Mar 2022 05:50:27 -0400
Message-Id: <20220325095034.5217-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Yet another revised version of the sparse read patches. The first 4 and
last patch are essentially the same as the ones I posted earlier this
week, modulo a couple of small changes. Patches 5 and 6 add support for
sparse reads to ms_mode=secure and ms_mode=legacy mounts.

This series is necessary for the fscrypt integration work. In fact, I
was able to run the fscrypt series I posted earlier this week on top of
this and it worked just fine.

Again, I'm mostly looking for feedback from Ilya at this point, but I'll
probably go ahead and merge this into the testing branch later today
(unless anyone pipes up with objections).

Jeff Layton (7):
  libceph: add spinlock around osd->o_requests
  libceph: define struct ceph_sparse_extent and add some helpers
  libceph: add sparse read support to msgr2 crc state machine
  libceph: add sparse read support to OSD client
  libceph: support sparse reads on msgr2 secure codepath
  libceph: add sparse read support to msgr1
  ceph: add new mount option to enable sparse reads

 fs/ceph/addr.c                  |  18 +-
 fs/ceph/file.c                  |  51 +++++-
 fs/ceph/super.c                 |  16 +-
 fs/ceph/super.h                 |   8 +
 include/linux/ceph/messenger.h  |  33 ++++
 include/linux/ceph/osd_client.h |  71 +++++++-
 net/ceph/messenger.c            |   1 +
 net/ceph/messenger_v1.c         |  98 ++++++++++-
 net/ceph/messenger_v2.c         | 289 +++++++++++++++++++++++++++++---
 net/ceph/osd_client.c           | 266 ++++++++++++++++++++++++++++-
 10 files changed, 807 insertions(+), 44 deletions(-)

-- 
2.35.1

