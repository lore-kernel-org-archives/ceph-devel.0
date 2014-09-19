From: Sage Weil <sweil@redhat.com>
Subject: issue 8747 / 9011
Date: Fri, 19 Sep 2014 16:43:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409191642270.19460@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47399 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbaISXnc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 19:43:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: onlyjob@member.fsf.org
Cc: ceph-devel@vger.kernel.org

Hey Dmitry,

Are you still seeing this crash?

 osd/ReplicatedPG.cc: 5297: FAILED assert(soid < scrubber.start || soid >= scrubber.end)

We haven't turned it up in our testing in the last two months, so we 
still have no log of it occurring.

Thanks!
sage
