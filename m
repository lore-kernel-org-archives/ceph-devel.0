From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fix for 4.13-rc8
Date: Fri,  1 Sep 2017 17:58:07 +0200
Message-ID: <1504281487-13094-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit cc4a41fe5541a73019a864883297bd5043aa6d98:

  Linux 4.13-rc7 (2017-08-27 17:20:40 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.13-rc8

for you to fetch changes up to dd2bc473482eedc60c29cf00ad12568ce40ce511:

  ceph: fix readpage from fscache (2017-09-01 00:04:26 +0200)

----------------------------------------------------------------
ceph fscache page locking fix from Zheng, marked for stable.

----------------------------------------------------------------
Yan, Zheng (1):
      ceph: fix readpage from fscache

 fs/ceph/addr.c  | 24 +++++++++++++++---------
 fs/ceph/cache.c | 12 +++---------
 2 files changed, 18 insertions(+), 18 deletions(-)
