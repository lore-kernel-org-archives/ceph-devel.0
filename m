From: Sage Weil <sweil@redhat.com>
Subject: dropping filestore+btrfs testing for luminous
Date: Fri, 30 Jun 2017 03:21:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbdF3DVb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Jun 2017 23:21:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

We're having a series of problems with the valgrind included in xenial[1] 
that have led us to restrict all valgrind tests to centos nodes.  At teh 
same time, we're also seeing spurious ENOSPC errors from btrfs on both 
centos on xenial kernels[2], making trusty the only distro where btrfs 
works reliably.

Teuthology doesn't handle this well when it tries to put together the 
test matrix (we can't test filestore+btrfs+valgrind).

The easiest thing is to

1/ Stop testing filestore+btrfs for luminous onward.  We've recommended 
against btrfs for a long time and are moving toward bluestore anyway.

2/ Leave btrfs in the mix for jewel, and manually tolerate and filter out 
the occasional ENOSPC errors we see.  (They make the test runs noisy but 
are pretty easy to identify.)

If we don't stop testing filestore on btrfs now, I'm not sure when we 
would ever be able to stop, and that's pretty clearly not sustainable.
Does that seem reasonable?  (Pretty please?)

sage


[1] http://tracker.ceph.com/issues/18126 and http://tracker.ceph.com/issues/20360
[2] http://tracker.ceph.com/issues/20169
