From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 0/3] fix some rbd-fuse related issues
Date: Mon, 28 Jan 2013 16:33:41 +0100
Message-ID: <1359387224-6769-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:38897 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603Ab3A1Pds (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Jan 2013 10:33:48 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, Dan Mick <dan.mick@inktank.com>

Here three patches to fix some issues with the new rbd-fuse
code and an issues with the fuse handling in configure.

Danny Al-Gaaf (3):
  configure: fix check for fuse_getgroups()
  rbd-fuse: fix usage of conn->want
  rbd-fuse: fix printf format for off_t and size_t

 configure.ac            |  8 ++++----
 src/rbd_fuse/rbd-fuse.c | 12 +++++++-----
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
1.8.1.1

