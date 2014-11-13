From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc5
Date: Thu, 13 Nov 2014 13:18:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411131314460.10048@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There is an overflow bug fix for cephfs from Zheng, a fix for handling 
large authentication ticket buffers in libceph from Ilya, and a few fixes 
for the request handling code from Ilya that affect RBD volumes.

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (4):
      libceph: do not crash on large auth tickets
      libceph: unlink from o_linger_requests when clearing r_osd
      libceph: clear r_req_lru_item in __unregister_linger_request()
      libceph: change from BUG to WARN for __remove_osd() asserts

Yan, Zheng (1):
      ceph: fix flush tid comparision

 fs/ceph/caps.c        |    2 +-
 net/ceph/crypto.c     |  169 ++++++++++++++++++++++++++++++++++++++-----------
 net/ceph/osd_client.c |    7 +-
 3 files changed, 138 insertions(+), 40 deletions(-)
