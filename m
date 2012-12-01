From: Sage Weil <sage@inktank.com>
Subject: wip-msgr-delay-queue
Date: Sat, 1 Dec 2012 12:51:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212011249450.9862@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56231 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab2LAUvW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Dec 2012 15:51:22 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: greg@inktank.com

Is ready to merge, after a final look.  There is one additional patch that 
handles the connection fault and reconnect cases that hasn't been reviewed 
yet.  Passed the rados suite, although when we add it to the night suite 
we'll want lower probabilities because most of the runs took hours to 
complete with the artificial delays.

Thanks!
sage
