From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/2] ceph_features.h kernel update
Date: Tue, 24 Dec 2013 21:41:50 +0200
Message-ID: <1387914112-17809-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:42944 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab3LXTmn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Dec 2013 14:42:43 -0500
Received: by mail-ea0-f172.google.com with SMTP id q10so2613637ead.3
        for <ceph-devel@vger.kernel.org>; Tue, 24 Dec 2013 11:42:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Hello,

This is needed for the kernel to be able to advertise our new CRUSH_V2
features correctly.  wip-crush-2 depends and was rebased on top of
this.  Please make sure I got the 33rd bit work-around right.

Available from wip-ceph-features branch of ceph-client.git.

Thanks,

                Ilya


Ilya Dryomov (2):
  libceph: all features fields must be u64
  libceph: update ceph_features.h

 fs/ceph/mds_client.c               |   14 +++---
 fs/ceph/super.c                    |    4 +-
 include/linux/ceph/ceph_features.h |   96 ++++++++++++++++++++++++------------
 include/linux/ceph/libceph.h       |    8 +--
 include/linux/ceph/messenger.h     |   10 ++--
 net/ceph/ceph_common.c             |    4 +-
 net/ceph/messenger.c               |    8 +--
 7 files changed, 89 insertions(+), 55 deletions(-)

-- 
1.7.10.4

