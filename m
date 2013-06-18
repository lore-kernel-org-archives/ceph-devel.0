From: Sage Weil <sage@inktank.com>
Subject: ceph-deploy problems on weird /dev device names?
Date: Tue, 18 Jun 2013 13:43:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306181341430.1089@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43118 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932687Ab3FRUnD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jun 2013 16:43:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

I remember seeing a few reports of problems from users with strange block 
device names in /dev (sdaa*, c0d1p2* etc.) and have a bug open 
(http://tracker.ceph.com/issues/5345), but looking at the code I don't 
immediately see the problem, and I don't have any machines that have this 
problem.  Are there any users who have seen this problem who can try the 
latest version and/or help test a fix?

Thanks!
sage

