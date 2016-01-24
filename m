From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph updates for -rc1
Date: Sun, 24 Jan 2016 09:51:23 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601240945110.6082@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997AbcAXOvN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 24 Jan 2016 09:51:13 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph updates for 4.5-rc1 from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

The two main changes are aio support in CephFS, and a series that fixes 
several issues in the authentication key timeout/renewal code.  On top of 
that are a variety of cleanups and minor bug fixes.

Thanks!
sage

----------------------------------------------------------------
Geliang Tang (2):
      libceph: use list_next_entry instead of list_entry_next
      libceph: use list_for_each_entry_safe

Ilya Dryomov (6):
      libceph: fix ceph_msg_revoke()
      libceph: clear messenger auth_retry flag if we fault
      libceph: fix authorizer invalidation, take 2
      libceph: invalidate AUTH in addition to a service ticket
      libceph: kill off ceph_x_ticket_handler::validity
      libceph: remove outdated comment

Markus Elfring (1):
      rbd: delete an unnecessary check before rbd_dev_destroy()

Minfei Huang (1):
      ceph: Avoid to propagate the invalid page point

Yan, Zheng (4):
      ceph: fix double page_unlock() in page_mkwrite()
      ceph: Asynchronous IO support
      ceph: re-send AIO write request when getting -EOLDSNAP error
      ceph: use i_size_{read,write} to get/set i_size

Yaowei Bai (2):
      ceph: remove unused functions in ceph_frag.h
      ceph: ceph_frag_contains_value can be boolean

 drivers/block/rbd.c            |   3 +-
 fs/ceph/addr.c                 |  14 +-
 fs/ceph/cache.c                |   8 +-
 fs/ceph/file.c                 | 509 ++++++++++++++++++++++++++++++-----------
 fs/ceph/inode.c                |   8 +-
 include/linux/ceph/ceph_frag.h |  37 +--
 include/linux/ceph/messenger.h |   2 +-
 net/ceph/auth_x.c              |  49 +++-
 net/ceph/auth_x.h              |   2 +-
 net/ceph/messenger.c           | 105 ++++++---
 net/ceph/mon_client.c          |   4 -
 11 files changed, 501 insertions(+), 240 deletions(-)
