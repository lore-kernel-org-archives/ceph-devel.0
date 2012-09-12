From: Sage Weil <sage@inktank.com>
Subject: enabling cephx by default
Date: Tue, 11 Sep 2012 17:25:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209111722100.2433@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44109 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab2ILAZu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 20:25:50 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id BA20D8004B
	for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 17:25:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8980B8004B
	for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 17:25:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The next stable release will have cephx authentication enabled by default.  
We will probably do it in the next development release (v0.53) to work out 
any upgrade kinks well before that.  The process for setting up teh 
authentication keys on an existing cluster is at

	http://ceph.com/docs/master/cluster-ops/authentication/

This needs a few eyeballs to make sure the upgrade process makes sense...

Thanks!
sage
