From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph fixes for 5.6-rc2
Date: Fri, 14 Feb 2020 17:49:44 +0100
Message-ID: <20200214164944.6044-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.6-rc2

for you to fetch changes up to 3b20bc2fe4c0cfd82d35838965dc7ff0b93415c6:

  ceph: noacl mount option is effectively ignored (2020-02-11 17:04:40 +0100)

----------------------------------------------------------------
A patch to make O_DIRECT | O_APPEND combination work better, a redo
of server path canonicalization patch that went into -rc1 and a fixup
for noacl mount option that got broken by the conversion to the new
mount API in 5.5.

----------------------------------------------------------------
Ilya Dryomov (1):
      ceph: canonicalize server path in place

Xiubo Li (2):
      ceph: do not execute direct write in parallel if O_APPEND is specified
      ceph: noacl mount option is effectively ignored

 fs/ceph/file.c  |  17 +++++---
 fs/ceph/super.c | 129 ++++++++++++++------------------------------------------
 fs/ceph/super.h |   2 +-
 3 files changed, 44 insertions(+), 104 deletions(-)
