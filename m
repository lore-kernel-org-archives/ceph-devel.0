From: Sage Weil <sweil@redhat.com>
Subject: infernalis feature freeze
Date: Wed, 12 Aug 2015 14:20:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33722 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbbHLVUN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 Aug 2015 17:20:13 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id EDBC791D2B
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2015 21:20:12 +0000 (UTC)
Received: from redhat.com (ovpn-112-37.phx2.redhat.com [10.3.112.37])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t7CLKBmj009704
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2015 17:20:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The infernalis feature freeze is coming up Real Soon Now.  I've marked 
some of the pull requests on github that I would like to see merged.  
Please take a look:

	https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+milestone%3Ainfernalis

Ideally we should focus our testing efforts on whatever is on this list.

I didn't look at the bug fix PRs carefully since generally these go in 
once tested regardless of any feature freeze, but I suggest we mark things 
that need to make it into infernalis anyway so that we focus our efforts.

The big items on my list that are pending testing are:

	wip-newstore-sort (teuthology running now)
	wip-newstore (will be marked experimental)
	wip-osd-compat (enforces upgrades include hammer, needs qa)
	wip-user (run daemons as user 'ceph')
	proxy writes (Sam is testing this)
	bufferlist tuning (performance)
	MOSDOp staged decoding (performance)

There's tons of other stuff pending that is not on this list.  As always, 
our ability to merge code is limited primarily on our ability to test 
it--we can't afford to destabilize core ceph by merging something that we 
aren't confident will work correctly and will not easily break down the 
line.  If you have something pending that you want to get in, the single 
biggest thing you can do to help that happen is to write more or better 
tests for it (e.g., things that run during 'make check') and to run the 
teuthology regression suite (see Loic's recent blogs about doing this with 
OpenStack[1]).

Thanks!
sage

[1] http://dachary.org/?p=3852
