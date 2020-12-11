Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9211DC4361B
	for <ceph-devel@archiver.kernel.org>; Fri, 11 Dec 2020 12:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4124823ECD
	for <ceph-devel@archiver.kernel.org>; Fri, 11 Dec 2020 12:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395210AbgLKMkU (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 11 Dec 2020 07:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436533AbgLKMjl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:39:41 -0500
From:   Jeff Layton <jlayton@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com
Subject: [PATCH 0/3] ceph: don't call ceph_check_caps in page_mkwrite
Date:   Fri, 11 Dec 2020 07:38:55 -0500
Message-Id: <20201211123858.7522-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

I've been working on the fscache rework, and have hit some rather
complex lockdep circular locking warnings. Most of them involve two
filesystems (cephfs and the local cachefiles fs), so it's not clear
to me whether they are false positives.

They do involve the mmap_lock though, which is taken up in the vfs. I
think it would probably be best to not do the ceph_check_caps call with
that lock held if we can avoid it.

The first patch in this series fixes what looks like a probable bug to
me. If we want to avoid checking caps in some cases, then we probably
also want to avoid flushing the snaps too since that involves the same
locks.

The second patch replaces the patch that I sent a few weeks ago to add
a queue_inode_work helper.

The last patch extends some work that Xiubo did earlier to allow skipping
the caps check after putting references. It adds a new "flavor" when
putting caps that instead has the inode work do the check or flush after
the refcounts have been decremented.

Jeff Layton (3):
  ceph: fix flush_snap logic after putting caps
  ceph: clean up inode work queueing
  ceph: allow queueing cap/snap handling after putting cap references

 fs/ceph/addr.c  |  2 +-
 fs/ceph/caps.c  | 36 +++++++++++++++++++++++------
 fs/ceph/inode.c | 61 ++++++++++---------------------------------------
 fs/ceph/super.h | 40 +++++++++++++++++++++++++++-----
 4 files changed, 76 insertions(+), 63 deletions(-)

-- 
2.29.2

