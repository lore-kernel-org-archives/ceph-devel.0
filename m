From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for 2.6.37-rc7
Date: Mon, 20 Dec 2010 20:34:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012201438310.15201@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40420 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933461Ab0LUE3X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Dec 2010 23:29:23 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are a few fixes for direct-io reads (non-page aligned buffers, 
marking user pages dirty), two error path fixes, and the NULL dereference 
triggered by NFS export that Al pointed out.

Thanks!
sage


Henry C Chang (3):
      ceph: fix direct-io on non-page-aligned buffers
      ceph: mark user pages dirty on direct-io reads
      ceph: handle partial result from get_user_pages

Sage Weil (2):
      ceph: fix msgr_init error path
      ceph: fix null pointer dereference in ceph_init_dentry for nfs reexport

 fs/ceph/dir.c                |    3 ++-
 fs/ceph/file.c               |   39 +++++++++++++++++++++++----------------
 include/linux/ceph/libceph.h |    6 ++++--
 net/ceph/messenger.c         |    8 +++-----
 net/ceph/pagevec.c           |   15 +++++++++------
 5 files changed, 41 insertions(+), 30 deletions(-)

