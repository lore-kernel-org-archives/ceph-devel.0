From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/5] libceph: timeout handling fixes
Date: Thu, 21 May 2015 15:35:01 +0300
Message-ID: <1432211706-10473-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33596 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbbEUMfa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 08:35:30 -0400
Received: by wicmx19 with SMTP id mx19so11535269wic.0
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 05:35:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

Hello,

With libceph timeouts becoming more and more of a user-exposed thing
rather than a debugging thing it's time we harden the supporting code.
The issues addressed in this series are described in 2/5.

5/5 is just rebase of an already posted and reviewed patch.

Zheng, please have a look at fs/ceph parts.

Thanks,

                Ilya


Ilya Dryomov (5):
  libceph: nuke time_sub()
  libceph: store timeouts in jiffies, verify user input
  libceph: a couple tweaks for wait loops
  ceph: simplify two mount_timeout sites
  rbd: timeout watch teardown on unmap with mount_timeout

 drivers/block/rbd.c          | 43 ++++++++++++++++++++++++++++-----------
 fs/ceph/dir.c                | 16 +++++----------
 fs/ceph/mds_client.c         | 26 +++++++++++++-----------
 fs/ceph/mds_client.h         |  2 +-
 fs/ceph/super.c              |  2 +-
 include/linux/ceph/libceph.h | 20 ++++++++----------
 net/ceph/ceph_common.c       | 48 +++++++++++++++++++++++++++++++-------------
 net/ceph/mon_client.c        | 13 +++++++++---
 net/ceph/osd_client.c        | 15 +++++++-------
 9 files changed, 111 insertions(+), 74 deletions(-)

-- 
1.9.3

