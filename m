From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 4.11-rc2
Date: Fri, 10 Mar 2017 16:34:24 +0100
Message-ID: <1489160064-26712-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36551 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754980AbdCJPet (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Mar 2017 10:34:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.11-rc2

for you to fetch changes up to 7cc5e38f2f0b0b58a22a4c18a56348dd99a71270:

  libceph: osd_request_timeout option (2017-03-07 14:30:38 +0100)

----------------------------------------------------------------
A fix for the recently discovered misdirected requests bug present in
jewel and later on the server side and all stable kernels, a fixup for
-rc1 CRUSH changes and two usability enhancements: osd_request_timeout
option and supported_features bus attribute.

----------------------------------------------------------------
Ilya Dryomov (4):
      libceph: fix crush_decode() for older maps
      libceph: don't set weight to IN when OSD is destroyed
      rbd: supported_features bus attribute
      libceph: osd_request_timeout option

 drivers/block/rbd.c             | 16 ++++++++++++----
 include/linux/ceph/libceph.h    |  2 ++
 include/linux/ceph/osd_client.h |  1 +
 net/ceph/ceph_common.c          | 15 +++++++++++++++
 net/ceph/osd_client.c           | 36 +++++++++++++++++++++++++++++++++++-
 net/ceph/osdmap.c               |  4 +---
 6 files changed, 66 insertions(+), 8 deletions(-)
