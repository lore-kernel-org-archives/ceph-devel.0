From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH v2 0/5] libceph: support for replica reads
Date: Sat, 30 May 2020 17:34:34 +0200
Message-ID: <20200530153439.31312-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgE3Pel (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 30 May 2020 11:34:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70499C03E969
        for <ceph-devel@vger.kernel.org>; Sat, 30 May 2020 08:34:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so7190098wrp.2
        for <ceph-devel@vger.kernel.org>; Sat, 30 May 2020 08:34:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>

Hello,

This adds support for replica reads (balanced and localized reads)
to rbd and ceph.  crush_location syntax is slightly different, see
patch 3 for details.

v1 -> v2:
- change crush_location syntax
- rename read_policy to read_from_replica, add read_from_replica=no
- crush_location and read_from_replica are now overridable

Thanks,

                Ilya


Ilya Dryomov (5):
  libceph: add non-asserting rbtree insertion helper
  libceph: decode CRUSH device/bucket types and names
  libceph: crush_location infrastructure
  libceph: support for balanced and localized reads
  libceph: read_from_replica option

 include/linux/ceph/libceph.h    |  13 +-
 include/linux/ceph/osd_client.h |   1 +
 include/linux/ceph/osdmap.h     |  19 +-
 include/linux/crush/crush.h     |   6 +
 net/ceph/ceph_common.c          |  75 +++++++
 net/ceph/crush/crush.c          |   3 +
 net/ceph/debugfs.c              |   6 +-
 net/ceph/osd_client.c           |  92 +++++++-
 net/ceph/osdmap.c               | 363 +++++++++++++++++++++++++++-----
 9 files changed, 517 insertions(+), 61 deletions(-)

-- 
2.19.2
