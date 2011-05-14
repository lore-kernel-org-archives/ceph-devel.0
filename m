From: Sage Weil <sage@newdream.net>
Subject: [GIT PULL] Ceph/rbd fixes for 2.6.39
Date: Sat, 14 May 2011 12:54:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105141253040.17928@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57730 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab1ENTxZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 May 2011 15:53:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull a couple last minute rbd fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

The first is a simple memory leak.  The second is, unfortunately, a bit 
more involved.  There was a problem with the way we were doing the 
completions for split bios (spanning object boundaries) and the fix is 
non-trivial.  It's a bit big for -rc7, but OTOH the bug it fixes is pretty 
easy to trigger with an appropriate read workload.

Thanks!
sage


Sage Weil (1):
      rbd: fix leak of ops struct

Yehuda Sadeh (1):
      rbd: fix split bio handling

 drivers/block/rbd.c |  177 +++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 156 insertions(+), 21 deletions(-)

