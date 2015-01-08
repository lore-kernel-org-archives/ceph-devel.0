From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc4
Date: Thu, 8 Jan 2015 10:41:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501081040050.3041@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client for-linus

These are both pretty trivial: a sparse warning fix and size_t printk 
thing.

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (2):
      ceph: use %zu for len in ceph_fill_inline_data()
      libceph: fix sparse endianness warnings

 fs/ceph/addr.c                  | 2 +-
 include/linux/ceph/osd_client.h | 4 ++--
 net/ceph/auth_x.c               | 2 +-
 net/ceph/mon_client.c           | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
