From: Sage Weil <sage@inktank.com>
Subject: 0.48 imminent
Date: Mon, 18 Jun 2012 09:55:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206180951570.11790@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37373 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab2FRQz1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 12:55:27 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 3D779BC654
	for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 09:55:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 14248BC654
	for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 09:55:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

v0.48 is essentially ready, but we'd like to test it for a few more days 
before release.  If you are interested in helping out, it's the 'next' 
branch of ceph.git.

A few notes:

 - There is a disk-format change in this release.  The first time you 
   start ceph-osd it will do a slowish conversion, and you won't be able 
   to downgrade.

 - This will form the basis of our first named 'stable' release.  If you 
   care what we name it, go vote at

	http://bit.ly/LROUnL

sage
