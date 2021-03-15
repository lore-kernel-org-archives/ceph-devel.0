Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5231AC4332B
	for <ceph-devel@archiver.kernel.org>; Mon, 15 Mar 2021 18:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311CB64F2A
	for <ceph-devel@archiver.kernel.org>; Mon, 15 Mar 2021 18:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhCOSHu (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 15 Mar 2021 14:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhCOSHT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:07:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E28A564F2A;
        Mon, 15 Mar 2021 18:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615831639;
        bh=v295vxGsC8ahqX+bV7Fu6wGb2RI3+X2koc0sedd0Jo0=;
        h=From:To:Cc:Subject:Date:From;
        b=d6gqOStNXhfjMECBN+vVoBUWiY4H4DeHzIa9A792+ZQThO8tkUOn919izl0ZIS154
         CmBgF8DwsJIcBTBxeAT7JkUdIdBiFMw9dQSvOGeajbrCiTLhBZzFNm1CkPT2KUPFOh
         DYCigy026h2DpMIG43rxy+9Ockc6ev0nZfS7qT3wlAU8brdPIYtvrxUN/yfNfPjisI
         YTl1nQ196CUZFMQizv8EDyBhGi1xnz7c7UU34PiUv3wTcsN6WOeicc95KA0m7QUYuG
         euNtoJ9K/sSEc6vy6uEH0+/QGUaqBLcpjA2jEA3e1nM7xUM5uJRjy9HySGViDrFDlL
         +IAkqllXB7D0Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH 0/2] ceph: snapdir dentry handling fixes
Date:   Mon, 15 Mar 2021 14:07:15 -0400
Message-Id: <20210315180717.266155-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

These patches fix a couple of problems that Al noticed around our
handling of snapdir dentries.

I'm going to feed these into our testing branch soon, along with
the ceph fixes (and helper patch) that Al posted in this series:

    https://lore.kernel.org/linux-fsdevel/YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk/

It makes for a bit of a messy testing branch for now, unfortunately,
with the fscache changes in there as well, but hopefully we can
merge some of these fixes soon and get the branch back into a
simpler state.

Jeff Layton (2):
  ceph: don't clobber i_snap_caps on non-I_NEW inode
  ceph: don't use d_add in ceph_handle_snapdir

 fs/ceph/dir.c   | 30 ++++++++++++++++++------------
 fs/ceph/file.c  |  6 ++++--
 fs/ceph/inode.c |  7 ++++---
 fs/ceph/super.h |  2 +-
 4 files changed, 27 insertions(+), 18 deletions(-)

-- 
2.30.2

