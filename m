From: Sage Weil <sage@inktank.com>
Subject: ACL tests
Date: Thu, 30 Jan 2014 16:20:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401301616370.11959@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48282 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbaAaAUq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jan 2014 19:20:46 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lucienchao@gmail.com
Cc: li.wang@ubuntukylin.com, zheng.z.yan@intel.com, ceph-devel@vger.kernel.org

Hi Guangliang,

There were a few hiccups getting the ACL support into Linus's tree, but 
it's in now, and it appears to work.  However, I tried out the tuxera 
posix test suite at

 http://www.tuxera.com/community/posix-test-suite/
 http://tuxera.com/sw/qa/pjd-fstest-20090130-RC.tgz

which has a set of acl tests, and several of them fail.  I would like to 
get the tests to all pass and get them added to the night QA so that we 
won't be chasing down (as many) strange user reports of permission errors 
down the line.  Are you able to take a look?

Thanks!
sage
