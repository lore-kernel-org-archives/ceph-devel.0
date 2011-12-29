From: Sage Weil <sage@newdream.net>
Subject: [PATCH 0/3] Ceph fixes for 3.2 final
Date: Wed, 28 Dec 2011 18:05:12 -0800
Message-ID: <1325124315-3487-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41604 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab1L2ChF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Dec 2011 21:37:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

This is a final set of fixes for 3.2.  The main issue is with the 
d_find_any_alias() code, which used to rely on the caller holding i_lock 
(this is no longer the case).  The last patch adds a mount option to 
enable/disable use of the dcache for negative lookups and readdir on 
directories the client has completely cached; there are some bugs 
lurking in that code so it is disabled for now.

I'll be sending this to Linus tomorrow, unless anyone see any problems!

sage


Alex Elder (2):
  ceph: take inode lock when finding an inode alias
  ceph: take a reference to the dentry in d_find_any_alias()

Sage Weil (1):
  ceph: enable/disable dentry complete flags via mount option

 fs/ceph/dir.c   |   50 +++++++++++++++++++++++++++++++++++++++++---------
 fs/ceph/super.c |   14 ++++++++++++++
 fs/ceph/super.h |    1 +
 3 files changed, 56 insertions(+), 9 deletions(-)

-- 
1.7.2.5

