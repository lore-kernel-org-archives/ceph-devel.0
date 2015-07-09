From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc2
Date: Thu, 9 Jul 2015 13:10:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507091256510.28782@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850AbbGIUKs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Jul 2015 16:10:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There is a fix for CephFS and RBD when used within containers/namespaces, 
and a fix for the address learning the client is supposed to do when 
initially talking to the Ceph cluster.

There are also two patches updating MAINTAINERS.  One breaks out the 
common Ceph code shared by fs/ceph and drivers/block/rbd.c into a separate 
entry with the appropriate maintainers listed.  The second adds a second 
reference to the github tree where the Ceph client development takes place 
(before it is pushed to korg and then to you).  The goal here is to move 
closer to a situation where Ilya Dryomov or one of the other maintainers 
can push things to you if I am unavailable.  Ilya has done most of the 
work preparing branches for upstream recently; you should not be surprised 
to hear from him if I am trapped in some internet-less wasteland or hit by 
a bus or something.  In the meantime, we'll work on getting him added to 
the kernel web of trust.

Thanks-
sage


----------------------------------------------------------------
Ilya Dryomov (2):
      libceph: enable ceph in a non-default network namespace
      libceph: treat sockaddr_storage with uninitialized family as blank

Sage Weil (2):
      MAINTAINERS: update ceph entries
      MAINTAINERS: add secondary tree for ceph modules

 MAINTAINERS                    | 22 ++++++++++++++++++----
 include/linux/ceph/messenger.h |  3 +++
 net/ceph/ceph_common.c         | 16 ++++++++++------
 net/ceph/messenger.c           | 24 ++++++++++++++++--------
 4 files changed, 47 insertions(+), 18 deletions(-)
