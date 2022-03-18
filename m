Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E970C433F5
	for <ceph-devel@archiver.kernel.org>; Fri, 18 Mar 2022 13:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiCRNvv (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiCRNvh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2022 09:51:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F73312C6F4
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2022 06:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C27D0B823CC
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2022 13:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028D1C340E8;
        Fri, 18 Mar 2022 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647611415;
        bh=4MDIjM4wOyRn++O1zxScu/wyQzlf3T1xbhpfVcabSG4=;
        h=From:To:Cc:Subject:Date:From;
        b=eGnnjePurnWDoR179JwnT2mF2cgEG3qnvkjVNqIUie7Ne0oVfz5CGaJteUD5nWZc8
         7dVkdy6g2ryqm+4X+hsFRg0ynAyXDBc2PRmDffRiOGjlrwXMWuVjHTcJ9VAQeNA1Se
         t12A24qhopVAbWYJ2khm6sRz+09SRB9yhjqqa7WbUWv9RF2E/Y+J1SHDpsyUZs9vuC
         5DQ8NAPS1hfVcJcGKCflhZ5QY74Xlcv6ltfce6WaTqlWZ6rNq4+p53EGasMlY0UQ18
         AK+mzgny0r3rYEaxXRYfO06zFmAS7L8kALnZLjSr/f6xAOzEVhNmoaB1DQnQiXLECC
         EsK4PhmN7AIWA==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org
Subject: [PATCH v3 0/5] ceph/libceph: add support for sparse reads to msgr2 crc codepath
Date:   Fri, 18 Mar 2022 09:50:08 -0400
Message-Id: <20220318135013.43934-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

This is a revised version of the sparse read code I posted a week or so
ago. This work is required for fscrypt integration work, but may be
useful on its own as well, and may be applicable to RBD as well.

There are some significant differences from the last set:

- most of the extent data that comes in little-endian is now
  endian-converted in-place on BE arches.

- the OSD client now passes the extent map from the read back to the
  caller. This allows us to properly decrypt things at a higher level.
  It also makes it simpler for the caller to determine the actual length
  of the data read into the buffer

- this code should allow us to support multiple sparse read operations
  in an OSD request. That's not been tested yet though.

This has been tested with xfstests and it seems to work as expected, and
seems to be on-par performance-wise with "normal" reads.

Note that the messenger v2 CRC path is still the only part that has been
implemented so far. We'll need to implement support for v2-secure and v1
as well before we'll want to merge any of this.

We may also want to only selectively use sparse reads when necessary
but they don't seem to be any slower so it may be simpler to just always
use them.

Jeff Layton (5):
  libceph: add spinlock around osd->o_requests
  libceph: define struct ceph_sparse_extent and add some helpers
  libceph: add sparse read support to msgr2 crc state machine
  libceph: add sparse read support to OSD client
  ceph: convert to sparse reads

 fs/ceph/addr.c                  |  13 +-
 fs/ceph/file.c                  |  41 ++++-
 fs/ceph/super.h                 |   7 +
 include/linux/ceph/messenger.h  |  29 ++++
 include/linux/ceph/osd_client.h |  71 ++++++++-
 net/ceph/messenger.c            |   1 +
 net/ceph/messenger_v2.c         | 164 ++++++++++++++++++--
 net/ceph/osd_client.c           | 256 +++++++++++++++++++++++++++++++-
 8 files changed, 558 insertions(+), 24 deletions(-)

-- 
2.35.1

