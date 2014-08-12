From: Sage Weil <sage@inktank.com>
Subject: ceph-disk and dmcrypt
Date: Tue, 12 Aug 2014 09:39:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408120936270.13051@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48199 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbaHLQjU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Aug 2014 12:39:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: steveftaylor@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi Steve,

We ran into a problem with the ceph-disk changes back in 67339470 (they 
were breaking dmcrypt when the journal was on a separate device).  At the 
same time we resolved another bug.  With your change reverted, and the new 
fix, and other changes to ceph-disk since then, it appears to be working 
fine for all of my tests.

Do you mind testing the ceph-disk from wip-firefly-dmcrypt in your 
environment to verify that you don't see the original problem?  The 
explanation in your original commit sounds plausible (that the kernel 
wouldn't refresh the partition table if dmcrypt was consuming one of the 
partitions), but it just doesn't seem to be the case for me.

Thanks!
sage
