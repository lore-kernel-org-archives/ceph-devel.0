Return-Path: <SRS0=GXXA=B2=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DB2C433DF
	for <ceph-devel@archiver.kernel.org>; Sun, 16 Aug 2020 22:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3946C206F4
	for <ceph-devel@archiver.kernel.org>; Sun, 16 Aug 2020 22:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgHPWKu (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Sun, 16 Aug 2020 18:10:50 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:41170 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgHPWKu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 16 Aug 2020 18:10:50 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Aug 2020 18:10:49 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 4C0E31801629E
        for <ceph-devel@vger.kernel.org>; Sun, 16 Aug 2020 22:05:02 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1ED8F182CED2A;
        Sun, 16 Aug 2020 22:05:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stamp42_5612a0827011
X-Filterd-Recvd-Size: 1779
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sun, 16 Aug 2020 22:05:00 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     ceph-devel@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ceph: Neaten debugging
Date:   Sun, 16 Aug 2020 15:04:51 -0700
Message-Id: <cover.1597615399.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Convert special case dout macro to pr_debug and neatening.

Joe Perches (2):
  ceph: Use generic debugging facility
  ceph: Remove embedded function names from pr_debug uses

 fs/ceph/addr.c                  | 266 ++++++++--------
 fs/ceph/cache.c                 |  22 +-
 fs/ceph/caps.c                  | 533 ++++++++++++++++----------------
 fs/ceph/debugfs.c               |   4 +-
 fs/ceph/dir.c                   | 141 ++++-----
 fs/ceph/export.c                |  36 +--
 fs/ceph/file.c                  | 170 +++++-----
 fs/ceph/inode.c                 | 338 ++++++++++----------
 fs/ceph/ioctl.c                 |   6 +-
 fs/ceph/locks.c                 |  42 +--
 fs/ceph/mds_client.c            | 374 +++++++++++-----------
 fs/ceph/mdsmap.c                |  16 +-
 fs/ceph/metric.c                |   4 +-
 fs/ceph/quota.c                 |   4 +-
 fs/ceph/snap.c                  | 135 ++++----
 fs/ceph/super.c                 |  67 ++--
 fs/ceph/xattr.c                 |  64 ++--
 include/linux/ceph/ceph_debug.h |  30 --
 include/linux/ceph/messenger.h  |   2 +-
 19 files changed, 1139 insertions(+), 1115 deletions(-)

-- 
2.26.0

