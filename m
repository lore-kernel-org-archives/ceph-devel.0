Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FE5C47082
	for <ceph-devel@archiver.kernel.org>; Thu,  3 Jun 2021 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE08613B1
	for <ceph-devel@archiver.kernel.org>; Thu,  3 Jun 2021 16:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFCQyS (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 3 Jun 2021 12:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhFCQyR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:54:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C83EA61026;
        Thu,  3 Jun 2021 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622739153;
        bh=sUAx6Bs9Bea4y+qyqqQ+GfmTetvBTInBDqt5fFw8oVA=;
        h=From:To:Subject:Date:From;
        b=Fx3a2IkgBRm2eU9ycYylQQUJ0UQuY1whWlKNtSwXkWxoP1lx44PV9zaeYXPNgF7rm
         tSXvGHgAQu6dJJBdApbaEPnzx18cYKUfzol7WxmpZBpoIqz7caIJSnxAOVqdpjUBUr
         TjMwdlOuB8S6F06zhw1fv4xiAjT7RymOaNAWpwTHEN7TX7Bg4yQghv/ARtlvOlLHr0
         y65TIl0MhAUc+dOc71fhru0Ch6cs22R+dd58MV+AtMjzivzAJpKqSzSmiR7neCHKAF
         hZBZ1gfN50h+HDFIXPSmlWwQ4gj+2Lumgpvk6FNjvGNVhVH0gi149Whd2RrQrxNVcr
         /XlKYLotZfG/Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com
Subject: [PATCH 0/3] ceph: locking fixes for snaprealm handling
Date:   Thu,  3 Jun 2021 12:52:28 -0400
Message-Id: <20210603165231.110559-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The snaprealm handling code has a number of really old and misleading
comments that claim that we need certain locks when holding certain
functions. Some of them are wrong, and at least one caller is not
holding the snap_rwsem when filling an inode.

The first patch in this series adds some lockdep annotations that mirror
the comments. The second one relaxes the lockdep annotations for a
couple of the functions to better conform with the real requirements of
the code. The last patch then fixes a bug in async create code and
ensures that we're holding the correct locks when filling a new inode.

Jeff Layton (3):
  ceph: add some lockdep assertions around snaprealm handling
  ceph: clean up locking annotation for ceph_get_snap_realm and
    __lookup_snap_realm
  ceph: must hold snap_rwsem when filling inode for async create

 fs/ceph/file.c  |  3 +++
 fs/ceph/inode.c |  2 ++
 fs/ceph/snap.c  | 20 ++++++++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.31.1

