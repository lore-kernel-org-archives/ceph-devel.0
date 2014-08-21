From: Sage Weil <sweil@redhat.com>
Subject: watch/notify changes
Date: Thu, 21 Aug 2014 15:34:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408211517320.31172@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49343 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769AbaHUWeG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 18:34:06 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 6A73280453
	for <ceph-devel@vger.kernel.org>; Thu, 21 Aug 2014 15:34:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2B0F780453
	for <ceph-devel@vger.kernel.org>; Thu, 21 Aug 2014 15:34:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sam and Josh and I discussed the state of watch/notify a couple weeks 
back.  Here are our notes:

	http://pad.ceph.com/p/watch-notify

I've mapped most of these to tickets or bugs and noted them in the pad.

Ignore the fact that these are in the v0.86 sprint currently; it's just 
easier to enter them that way.

If there are other issues we're missing here, let's address them now.  The 
API changes so far can be seen at

	https://github.com/ceph/ceph/commit/7ba30230505c6eede06cb2e2cb64210fdd4025a8
	https://github.com/ceph/ceph/commit/d179dd970e52db8b0c07b20f69c9e3be6bc43f09

sage
