From: Sage Weil <sage@newdream.net>
Subject: [PATCH 0/5] pending items for 2.6.37
Date: Mon, 20 Dec 2010 11:15:26 -0800
Message-ID: <1292872531-18396-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41944 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932881Ab0LTTPe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Dec 2010 14:15:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

This is the current set of patches I have queued for the next -rc.  The 
direct-io page dirty ones could really use some review.  Also the buffer
alignment.

Thanks!
sage

---

Henry C Chang (3):
  ceph: fix direct-io on non-page-aligned buffers
  ceph: mark user pages dirty on direct-io reads
  ceph: handle partial result from get_user_pages

Sage Weil (2):
  ceph: fix msgr_init error path
  ceph: fix null pointer dereference in ceph_init_dentry for nfs
    reexport

 fs/ceph/dir.c                |    3 ++-
 fs/ceph/file.c               |   39 +++++++++++++++++++++++----------------
 include/linux/ceph/libceph.h |    6 ++++--
 net/ceph/messenger.c         |    8 +++-----
 net/ceph/pagevec.c           |   15 +++++++++------
 5 files changed, 41 insertions(+), 30 deletions(-)

