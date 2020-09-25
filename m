Return-Path: <SRS0=txDZ=DC=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8BEC4741F
	for <ceph-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF9121741
	for <ceph-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601042937;
	bh=6F4j/zHyzW/9amz8dBhHXMp1oxB2qwh/ha1jMM2pXHQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=is/hG3xBsxE1ImRCf+aJf1XYTycKktOs0FrmfJAWcQovMggBUaa4AzPmV/WxMWdQV
	 /gtH6xoiNxGa/dTQtmaDxqxIgZ0hJC5xk+60cJBTv9sdX4+QQj6haOKTFSN7SSuuuW
	 u5bsiPAmX8KjHQmQTWh0EV8lmjHaUzkiSwLKXkj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgIYOIz (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYOIy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:08:54 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7070E208A9;
        Fri, 25 Sep 2020 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601042933;
        bh=6F4j/zHyzW/9amz8dBhHXMp1oxB2qwh/ha1jMM2pXHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=vMFUJi0ck/FdLrMkxkU6r3zHLQ/zPP7D6y9LETH8xvBlm+mfp0hZXq4WdvKSHyZGk
         m3pzQHSLhO8Qw3azhsbjHCRXB9YDBAY4Vgfj5+lNlohLaT4PmK5EBFJ0He4UmDkRyn
         EnSOS0jb6yHv4puM9XJA5qFj8vIaK0fCwg3fAAi4=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, ukernel@gmail.com, pdonnell@redhat.com
Subject: [RFC PATCH 0/4] ceph: fix spurious recover_session=clean errors
Date:   Fri, 25 Sep 2020 10:08:47 -0400
Message-Id: <20200925140851.320673-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

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

Jeff Layton (4):
  ceph: don't WARN when removing caps due to blocklisting
  ceph: don't mark mount as SHUTDOWN when recovering session
  ceph: remove timeout on allowing reconnect after blocklisting
  ceph: queue request when CLEANRECOVER is set

 fs/ceph/caps.c       |  2 +-
 fs/ceph/mds_client.c | 10 ++++------
 fs/ceph/super.c      | 13 +++++++++----
 fs/ceph/super.h      |  1 -
 4 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.26.2

