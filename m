From: Sage Weil <sage@inktank.com>
Subject: [PATCH 0/8] Last batch of messenger fixes, misc
Date: Mon, 30 Jul 2012 08:59:23 -0700
Message-ID: <1343663971-3221-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45760 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab2G3P7l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 11:59:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

After banging my head against an ffsb failure (#2867) for much of the 
weekend, I finally realized there were several places in the messenger 
were we were dropping and retaking the con mutex and not revalidating 
the con->state. Along the way a few other minor issues came up.

Please review, especialy the con_in_msg_alloc refactor.  With this batch 
I think things are ready to send to Linus for 3.6-rc1.

Thanks!
sage


Sage Weil (8):
  libceph: be less chatty about stray replies
  ceph: update MAINTAINERS file
  libceph: fix handling of immediate socket connect failure
  libceph: revoke mon_client messages on session restart
  libceph: verify state after retaking con lock after dispatch
  libceph: avoid dropping con mutex before fault
  libceph: change ceph_con_in_msg_alloc convention to be less weird
  libceph: recheck con state after allocating incoming message

 MAINTAINERS           |    9 ++---
 net/ceph/messenger.c  |   94 +++++++++++++++++++++++++++++++------------------
 net/ceph/mon_client.c |    4 +++
 net/ceph/osd_client.c |    4 +--
 4 files changed, 70 insertions(+), 41 deletions(-)

-- 
1.7.9.5

