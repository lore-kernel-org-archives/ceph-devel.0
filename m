From: Sage Weil <sage@newdream.net>
Subject: ceph tree in linux-next
Date: Fri, 2 Mar 2012 21:41:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203022138440.15833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57635 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2CCFlA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Mar 2012 00:41:00 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sfr@canb.auug.org.au
Cc: ceph-devel@vger.kernel.org

Hi Stephen,

The Ceph kernel tree has moved[1], and we've reworked the way we're 
managing commits in our tree.  Can you update linux-next to pull from

	git://github.com/ceph/ceph-client.git#master

That'll ensure that anything we've tested and reviewed gets into -next 
without us having to remember to push a for-next branch.

Thanks!
sage


[1] http://ceph.newdream.net/2012/03/the-git-repositories-have-moved/
