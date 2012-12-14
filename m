From: Sage Weil <sage@inktank.com>
Subject: ceph on nilfs2?
Date: Thu, 13 Dec 2012 16:47:21 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212131643480.2817@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54354 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab2LNArV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 19:47:21 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AB47A80060
	for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 16:47:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 85D9C80060
	for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 16:47:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

nilfs2 has a 'continuous snapshotting' architecture that the ceph-osd can 
take advantage of for making fully-consistent checkpoints of state for 
recovering from a crash.  If these checkpoints are efficient enough, in 
fact, you may even get away with not having a journal file/device at all.  
Provided ceph can trigger snapshot creation when it wants to, can roll 
back to a previous snapshot on startup, and gets the basic features it 
needs out of the fs (mainly xattrs), this might be something worth looking 
at, if someone is looking for a project!

http://www.nilfs.org

sage
