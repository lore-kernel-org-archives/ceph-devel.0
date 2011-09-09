From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for 3.1-rc6
Date: Thu, 8 Sep 2011 21:34:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109082131500.5346@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58212 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab1IIE3S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2011 00:29:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://ceph.newdream.net/git/ceph-client.git for-linus

There are a few memory leaks here (particularly with the msgpool), and a 
small request path encoding fix that avoids unnecessary ESTALEs from NFS 
reexport.

Thanks!
sage


Noah Watkins (1):
      ceph: fix memory leak

Sage Weil (3):
      libceph: fix msgpool
      ceph: fix encoding of ino only (not relative) paths
      libceph: fix leak of osd structs during shutdown

 fs/ceph/mds_client.c  |    2 +-
 fs/ceph/super.c       |    4 ++--
 net/ceph/msgpool.c    |   40 +++++++++++++++++++++++++++++-----------
 net/ceph/osd_client.c |   22 +++++++++++++++++-----
 4 files changed, 49 insertions(+), 19 deletions(-)
