From: Sage Weil <sage@newdream.net>
Subject: ceph-client.git master
Date: Sun, 29 Jan 2012 09:04:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201290858380.12891@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46199 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab2A2REl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Jan 2012 12:04:41 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A8A53BC7BD
	for <ceph-devel@vger.kernel.org>; Sun, 29 Jan 2012 09:04:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 80496BC7BD
	for <ceph-devel@vger.kernel.org>; Sun, 29 Jan 2012 09:04:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I pulled Chris's btrfs for-linus branch into ceph-client.git master for 
the benefit of our qa runs (which use the same kernel on the client and 
server side).  This makes the master even more of a mess than it already 
was.

Alex, what do you think?  Right now the branches are roughly:

 for-next  -- tested and reviewed, for next window
 master    -- lightly tested.  this is what qa runs against.
 for-linus -- for linus to pull now.. either for -rc or current window.

We could make master the reviewed+tested branch, and do a 'testing' 
branch for the free-for-all, so that it's clearer to people that it's 
untested, likely to be rebased, etc.

sage
