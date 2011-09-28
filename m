From: Sage Weil <sage@newdream.net>
Subject: [PATCH 0/5] Ceph fixes for 3.1[-rc9]
Date: Wed, 28 Sep 2011 10:26:26 -0700
Message-ID: <1317230791-6642-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46486 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab1I1R0i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 13:26:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Here is my fix queue for 3.1.  The first two patches are pretty 
straightforward.

The third was a list lifecycle issue that was crashing RBD reliably on 
any OSD state change.  It's been pretty well tested now (the fix is a 
couple weeks old).

The last two patches are new.  The bug responsible for misdirected 
requests due to the client not tracking the pg_temp mappings correctly 
(and using the CRUSH mapping instead).

Any last minute eyeballs before I send these upstream would be great!

Thanks-
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

