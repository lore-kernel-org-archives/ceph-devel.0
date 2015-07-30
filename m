From: Sage Weil <sweil@redhat.com>
Subject: dropping old distros: el6, precise 12.04, debian wheezy?
Date: Thu, 30 Jul 2015 06:54:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36788 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbbG3NyQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Jul 2015 09:54:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

As time marches on it becomes increasingly difficult to maintain proper 
builds and packages for older distros.  For example, as we make the 
systemd transition, maintaining the kludgey sysvinit and udev support for 
centos6/rhel6 is a pain in the butt and eats up time and energy to 
maintain and test that we could be spending doing more useful work.

"Dropping" them would mean:

 - Ongoing development on master (and future versions like infernalis and 
jewel) would not be tested on these distros.

 - We would stop building upstream release packages on ceph.com for new 
releases.

 - We would probably continue building hammer and firefly packages for 
future bugfix point releases.

 - The downstream distros would probably continue to package them, but the 
burden would be on them.  For example, if Ubuntu wanted to ship Jewel on 
precise 12.04, they could, but they'd probably need to futz with the 
packaging and/or build environment to make it work.

So... given that, I'd like to gauge user interest in these old distros.  
Specifically,

 CentOS6 / RHEL6
 Ubuntu precise 12.04
 Debian wheezy

Would anyone miss them?

In particular, dropping these three would mean we could drop sysvinit 
entirely and focus on systemd (and continue maintaining the existing 
upstart files for just a bit longer).  That would be a relief.  (The 
sysvinit files wouldn't go away in the source tree, but we wouldn't worry 
about packaging and testing them properly.)

Thanks!
sage
