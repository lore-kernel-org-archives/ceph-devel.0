From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.8-rc6
Date: Thu,  8 Sep 2016 15:37:00 +0200
Message-ID: <1473341820-5508-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35324 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757492AbcIHNhO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 09:37:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit c6935931c1894ff857616ff8549b61236a19148f:

  Linux 4.8-rc5 (2016-09-04 14:31:46 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.8-rc6

for you to fetch changes up to 0f5aa88a7bb28b73253fb42b3df8202142769f39:

  ceph: do not modify fi->frag in need_reset_readdir() (2016-09-05 14:30:35 +0200)

----------------------------------------------------------------
A fix for a 4.7 performance regression, caused by a typo in an if
condition.

----------------------------------------------------------------
Nicolas Iooss (1):
      ceph: do not modify fi->frag in need_reset_readdir()

 fs/ceph/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
