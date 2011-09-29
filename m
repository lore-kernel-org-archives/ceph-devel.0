From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph fixes for 3.1
Date: Thu, 29 Sep 2011 13:58:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109291355530.13653@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41211 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558Ab1I2U6s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2011 16:58:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph fixes from

  git://github.com/NewDreamNetwork/ceph-client.git for-linus

There are a few small fixes here (avoid unnecessary socket reconnects, 
small memory leak), and some more critical fixes with OSD request 
requeuing.  One bug fixes a crash that is reliably reproduced by cycling 
an OSD under a mapped RBD device, and the last two fix bugs in the 
tracking of temporary data location mappings.

Thanks!
sage


Jim Schutt (1):
      libceph: initialize ack_stamp to avoid unnecessary connection reset

Noah Watkins (1):
      libceph: fix parse options memory leak

Sage Weil (3):
      libceph: fix linger request requeuing
      libceph: fix pg_temp mapping calculation
      libceph: fix pg_temp mapping update

 net/ceph/ceph_common.c |    1 +
 net/ceph/messenger.c   |    1 +
 net/ceph/osd_client.c  |    4 +--
 net/ceph/osdmap.c      |   84 +++++++++++++++++++++++++----------------------
 4 files changed, 48 insertions(+), 42 deletions(-)
