Return-Path: <SRS0=Fqvp=DN=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262FEC46466
	for <ceph-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8ED5206CB
	for <ceph-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601996136;
	bh=g8qf5ohxC5cRlgN+iulqXPNYylMwbC7CeErv9DlG0jI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nbiXvBki3TlR1Lm44231dtKZZwpcuVGlmLmg0zhRI/4sv6QZxcJaOllOzBehCWEsG
	 4jF7/2NXgQR8G7Eg3I49qZpz1oZ9zzXmjMzsOOn9MZQmUstVq8hZr9PRPPFepfA33P
	 q58x0a/b0KjwVxauYpU4PSRbgN6CR/1X0SLAxb90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJFOzc (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFOza (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:55:30 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F98206CB;
        Tue,  6 Oct 2020 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601996130;
        bh=g8qf5ohxC5cRlgN+iulqXPNYylMwbC7CeErv9DlG0jI=;
        h=From:To:Cc:Subject:Date:From;
        b=glIi8hqobWgeyB1Pg+EW/ndYiwFHBipXNu6sXWFB7rujtPNBJCaGnPZbKx1UvjQ12
         2vdTwvZrS4yahgtQBER7VoZ9l+o8wT76ynbamP5J7VAGIxBRWxxsdgk/ykzYB2+Fwy
         SQuGr6kmhuNem71kmFzGIeCcS2yoVjMOhGQBwI0k=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, ukernel@gmail.com, pdonnell@redhat.com
Subject: [PATCH v3 0/5] ceph: fix spurious recover_session=clean errors
Date:   Tue,  6 Oct 2020 10:55:21 -0400
Message-Id: <20201006145526.313151-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

v3: add RECOVER mount_state and allow dumping pagecache when it's set
    shrink size of mount_state field
v2: fix handling of async requests in patch to queue requests

This is the third revision of this patchset and should hopefully address
comments from Zheng and Ilya.

Original cover letter:

Ilya noticed that he would get spurious EACCES errors on calls done just
after blocklisting the client on mounts with recover_session=clean. The
session would get marked as REJECTED and that caused in-flight calls to
die with EACCES. This patchset seems to smooth over the problem, but I'm
not fully convinced it's the right approach.

The potential issue I see is that the client could take cap references to
do a call on a session that has been blocklisted. We then queue the
message and reestablish the session, but we may not have been granted
the same caps by the MDS at that point.

If this is a problem, then we probably need to rework it so that we
return a distinct error code in this situation and have the upper layers
issue a completely new mds request (with new cap refs, etc.)

Obviously, that's a much more invasive approach though, so it would be
nice to avoid that if this would suffice.

Jeff Layton (5):
  ceph: don't WARN when removing caps due to blocklisting
  ceph: make fsc->mount_state an int
  ceph: don't mark mount as SHUTDOWN when recovering session
  ceph: remove timeout on allowing reconnect after blocklisting
  ceph: queue MDS requests to REJECTED sessions when CLEANRECOVER is set

 fs/ceph/caps.c               |  2 +-
 fs/ceph/inode.c              |  2 +-
 fs/ceph/mds_client.c         | 25 +++++++++++++++----------
 fs/ceph/super.c              | 14 ++++++++++----
 fs/ceph/super.h              |  3 +--
 include/linux/ceph/libceph.h |  1 +
 6 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.26.2

