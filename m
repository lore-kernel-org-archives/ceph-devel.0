From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for -rc3
Date: Thu, 2 Feb 2012 13:24:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202021321160.14628@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42564 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097Ab2BBVY5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 16:24:57 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are fixes for a misnamed xattr, a deadlock that lockdep turned up, a 
missing decode check, and some miscellaneous leaks and races.

Thanks!
sage


Alex Elder (4):
      ceph: change "ceph.layout" xattr to be "ceph.file.layout"
      ceph: create a new session lock to avoid lock inversion
      rbd: fix a memory leak in rbd_get_client()
      rbd: fix safety of rbd_put_client()

Sage Weil (1):
      ceph: initialize client debugfs outside of monc->mutex

Xi Wang (1):
      ceph: fix length validation in parse_reply_info()

 drivers/block/rbd.c    |    7 +++++--
 fs/ceph/caps.c         |    4 ++--
 fs/ceph/dir.c          |    4 ++--
 fs/ceph/mds_client.c   |   10 +++++++---
 fs/ceph/mds_client.h   |    7 +++++--
 fs/ceph/xattr.c        |    4 +++-
 net/ceph/ceph_common.c |    2 --
 net/ceph/mon_client.c  |   13 ++++++++++++-
 8 files changed, 36 insertions(+), 15 deletions(-)
