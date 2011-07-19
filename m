From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Final ceph fix for 3.0
Date: Tue, 19 Jul 2011 11:43:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107191136530.11566@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56306 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab1GSSjq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2011 14:39:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org

Hi Linus,

I have a last minute fix for a bug calculating the file access mode 
when O_APPEND|O_RDWR is passed to open.  Please pull/cherry-pick from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

Thanks!
sage


Sage Weil (1):
      ceph: fix file mode calculation

 net/ceph/ceph_fs.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)





