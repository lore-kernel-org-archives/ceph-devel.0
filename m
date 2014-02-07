From: Sage Weil <sage@inktank.com>
Subject: [GIT PULL] Ceph fixes for -rc2
Date: Fri, 7 Feb 2014 11:40:57 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402071041250.26572@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Linus,

Please pull the following fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There is an RBD fix for a crash due to the immutable bio changes, an error 
path fix, and a locking fix in the recent redirect support.

Thanks!
sage

----------------------------------------------------------------
Ilya Dryomov (4):
      libceph: fix error handling in ceph_osdc_init()
      libceph: factor out logic from ceph_osdc_start_request()
      libceph: take map_sem for read in handle_reply()
      libceph: do not dereference a NULL bio pointer

 net/ceph/messenger.c  |  8 +++--
 net/ceph/osd_client.c | 84 +++++++++++++++++++++++++++++++++------------------
 2 files changed, 60 insertions(+), 32 deletions(-)
