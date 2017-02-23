From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/3] libceph, ceph: get rid of ack vs commit
Date: Thu, 23 Feb 2017 21:59:18 +0100
Message-ID: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33249 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdBWVGR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 16:06:17 -0500
Received: by mail-wr0-f193.google.com with SMTP id g10so1869wrg.0
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2017 13:06:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>, Zheng Yan <zyan@redhat.com>

Hello,

This is all straightforward and passes tests, but I'd greatly
appreciate an extra set of eyes on the fs/ceph bits.

Thanks,

                Ilya


Ilya Dryomov (3):
  ceph: remove special ack vs commit behavior
  libceph: get rid of ack vs commit
  libceph, rbd, ceph: WRITE | ONDISK -> WRITE

 drivers/block/rbd.c             |   6 +-
 fs/ceph/addr.c                  |  14 ++---
 fs/ceph/caps.c                  |   2 -
 fs/ceph/file.c                  | 101 ++-------------------------------
 fs/ceph/inode.c                 |   9 ---
 fs/ceph/super.c                 |   1 -
 fs/ceph/super.h                 |   4 +-
 include/linux/ceph/osd_client.h |   6 +-
 net/ceph/cls_lock_client.c      |  12 ++--
 net/ceph/osd_client.c           | 120 ++++++++++------------------------------
 10 files changed, 48 insertions(+), 227 deletions(-)

-- 
2.4.3

