From: Ilya Dryomov <idryomov@gmail.com>
Subject: [GIT PULL] Ceph updates for 4.21-rc1
Date: Thu,  3 Jan 2019 16:39:26 +0100
Message-ID: <20190103153926.15596-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 8fe28cb58bcb235034b64cbbb7550a8a43fd88be:

  Linux 4.20 (2018-12-23 15:55:59 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.21-rc1

for you to fetch changes up to 5ccedf1ccd710ba32f36986b49eeb764e53e7ef1:

  ceph: don't encode inode pathes into reconnect message (2018-12-26 16:08:36 +0100)

----------------------------------------------------------------
A fairly quiet round: a couple of messenger performance improvements
from myself and a few cap handling fixes from Zheng.

----------------------------------------------------------------
Chengguang Xu (1):
      ceph: remove redundant assignment

Ilya Dryomov (4):
      libceph: drop last_piece logic from write_partial_message_data()
      libceph: use sock_no_sendpage() as a fallback in ceph_tcp_sendpage()
      libceph: use MSG_SENDPAGE_NOTLAST with ceph_tcp_sendpage()
      libceph: switch more to bool in ceph_tcp_sendmsg()

Yan, Zheng (6):
      ceph: cleanup splice_dentry()
      ceph: don't update importing cap's mseq when handing cap export
      ceph: don't request excl caps when mount is readonly
      ceph: skip updating 'wanted' caps if caps are already issued
      ceph: update wanted caps after resuming stale session
      ceph: don't encode inode pathes into reconnect message

 fs/ceph/caps.c       |  75 ++++++++++++++++++------------
 fs/ceph/inode.c      |  60 ++++++++++--------------
 fs/ceph/mds_client.c | 129 ++++++++++++++++++++++++++++++---------------------
 fs/ceph/mds_client.h |  16 ++++---
 fs/ceph/mdsmap.c     |   1 -
 net/ceph/messenger.c |  55 +++++++++-------------
 6 files changed, 174 insertions(+), 162 deletions(-)
