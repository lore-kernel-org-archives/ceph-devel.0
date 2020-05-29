From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/5] libceph: support for replica reads
Date: Fri, 29 May 2020 17:19:47 +0200
Message-ID: <20200529151952.15184-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgE2PTz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 May 2020 11:19:55 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB2CC08C5C8
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2020 08:19:54 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p18so2013905eds.7
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2020 08:19:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>

Hello,

This adds support for replica reads (balanced and localized reads)
to rbd and ceph.  crush_location syntax is slightly different, see
patch 3 for details.

Thanks,

                Ilya


Ilya Dryomov (5):
  libceph: add non-asserting rbtree insertion helper
  libceph: decode CRUSH device/bucket types and names
  libceph: crush_location infrastructure
  libceph: support for balanced and localized reads
  libceph: read_policy option

 include/linux/ceph/libceph.h    |  13 +-
 include/linux/ceph/osd_client.h |   1 +
 include/linux/ceph/osdmap.h     |  19 +-
 include/linux/crush/crush.h     |   6 +
 net/ceph/ceph_common.c          |  51 +++++
 net/ceph/crush/crush.c          |   3 +
 net/ceph/debugfs.c              |   6 +-
 net/ceph/osd_client.c           |  92 +++++++-
 net/ceph/osdmap.c               | 361 +++++++++++++++++++++++++++-----
 9 files changed, 491 insertions(+), 61 deletions(-)

-- 
2.19.2
