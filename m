From: Ilya Dryomov <idryomov@gmail.com>
Subject: Ceph fix for 4.7-rc8
Date: Sat, 23 Jul 2016 17:34:27 +0200
Message-ID: <1469288067-21830-1-git-send-email-idryomov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

The following changes since commit 92d21ac74a9e3c09b0b01c764e530657e4c85c49:

  Linux 4.7-rc7 (2016-07-10 20:24:59 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.7-rc8

for you to fetch changes up to 930c532869774ebf8af9efe9484c597f896a7d46:

  libceph: apply new_state before new_up_client on incrementals (2016-07-22 15:17:40 +0200)

The tag is signed with a brand new key - Sage is on vacation and
I didn't anticipate this.  Hopefully that's not a no-no.

----------------------------------------------------------------
A fix for a long-standing bug in the incremental osdmap handling code
that caused misdirected requests, tagged for stable.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: apply new_state before new_up_client on incrementals

 net/ceph/osdmap.c | 156 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 113 insertions(+), 43 deletions(-)
