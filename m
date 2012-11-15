From: Sage Weil <sage@inktank.com>
Subject: new process: cherry-picking to stable releases
Date: Thu, 15 Nov 2012 09:30:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211150926180.26823@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44941 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798Ab2KORaF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 12:30:05 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 281F581340
	for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 09:30:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id F286881340
	for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 09:30:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If you are *ever* cherry-picking something to an older stable branch, 
please use 

 git cherry-pick -x <sha1>

That will append a '(cherry-picked from ....)' message to the bottom of 
the commit, allowing us to always find the original commit that we are 
duplicating.

This implies that we are always committing to the master/next branch 
*first*, and then cherry-picking to stable.  As a general rule, a fix 
should always be 'upstream' first in the new branches before it is 
backported to something older.  The exception is fix that is unique to the 
stable branch, for example because the new code has changed.

Thanks!
sage

