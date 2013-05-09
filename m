From: Sage Weil <sage@inktank.com>
Subject: coverity scan - a plea for help!
Date: Thu, 9 May 2013 09:26:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305090922300.4023@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54780 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab3EIQ0v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 May 2013 12:26:51 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id CDABC80068
	for <ceph-devel@vger.kernel.org>; Thu,  9 May 2013 09:26:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id CB8F380068
	for <ceph-devel@vger.kernel.org>; Thu,  9 May 2013 09:26:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We were added to coverity's awesome scan program a while back, which gives 
free access to their static analysis tool to open source projects.

Currently it identifies 421 issues.  We've already taken care of the ones 
that are highest impact, but the usefulness of periodic scans is limited 
until we can eliminate the noise from the remaining issues and easily see 
when new problems come up.

If anybody is interested in helping out in the cleanup effort, let me know 
and I'll share the login info.  This would provide significant value to 
our overall quality efforts and is a pretty easy way to make a meaningful 
contribution to the project without a huge investment in understanding the 
code and architecture!

sage
