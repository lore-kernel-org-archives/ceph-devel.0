From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc6
Date: Fri, 26 Feb 2016 11:05:31 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602261104200.1904@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes for -rc6 from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are two small messenger bug fixes and a log spam regression fix.

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (3):
      libceph: don't bail early from try_read() when skipping a message
      libceph: use the right footer size when skipping a message
      libceph: don't spam dmesg with stray reply warnings

 net/ceph/messenger.c  | 15 +++++++++++----
 net/ceph/osd_client.c |  4 ++--
 2 files changed, 13 insertions(+), 6 deletions(-)
