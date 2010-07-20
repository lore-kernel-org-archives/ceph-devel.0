From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] ceph fixes for 2.6.35-rc6
Date: Tue, 20 Jul 2010 16:22:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007151246150.655@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51570 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933098Ab0GTXUj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jul 2010 19:20:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes for 2.6.35-rc6 from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

There are two memory leak fixes, a fix for an occasional crash when OSDs 
restart, mds reconnect fixes, and fixes for IPv6 addresses.  One of those 
(fix printing of ipv6 addrs') was overrunning a buffer and is a must-fix.  
The other two just make IPv6 addresses work properly. The recovering MDS 
patches fix a couple bugs that turn up when replaying uncommitted requests 
against a recovering MDS.

Thanks!
sage

Dan Carpenter (1):
      ceph: add kfree() to error path

Sage Weil (7):
      ceph: fix message revocation
      ceph: fix leak of mon authorizer
      ceph: fix printing of ipv6 addrs
      ceph: fix parsing of ipv6 addresses
      ceph: fix creation of ipv6 sockets
      ceph: reuse request message when replaying against recovering mds
      ceph: do not include cap/dentry releases in replayed messages

 fs/ceph/auth_x.c     |    3 ++
 fs/ceph/mds_client.c |   35 +++++++++++++++++++++---
 fs/ceph/mds_client.h |    1 +
 fs/ceph/messenger.c  |   71 ++++++++++++++++++++++++++------------------------
 fs/ceph/osdmap.c     |    1 +
 5 files changed, 72 insertions(+), 39 deletions(-)
