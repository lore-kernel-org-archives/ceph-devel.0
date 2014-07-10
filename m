From: Sage Weil <sweil@redhat.com>
Subject: v0.80.2?
Date: Thu, 10 Jul 2014 16:31:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407101629490.16614@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41381 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaGJXbS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jul 2014 19:31:18 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 93A8A81354
	for <ceph-devel@vger.kernel.org>; Thu, 10 Jul 2014 16:31:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9180681354
	for <ceph-devel@vger.kernel.org>; Thu, 10 Jul 2014 16:31:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We built v0.80.2 yesterday and pushed it out to the repos, but quickly 
discovered a regression in radosgw that preventing reading objects written 
with earlier versions.  We pulled the packages, fixed the bug, and are 
rerunning tests to confirm the fix and ensure there aren't other 
upgrade-related issues.  We expect to have a v0.80.3 ready tomorrow or 
Monday.

sage
