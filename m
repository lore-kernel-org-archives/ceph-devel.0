From: Sage Weil <sage@inktank.com>
Subject: ceph.com/debian alias changed argonaut -> bobtail
Date: Fri, 18 Jan 2013 12:47:06 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301181244320.8622@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49607 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab3ARUrH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 15:47:07 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1E4C180060
	for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 12:47:07 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E9C8E80060
	for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 12:47:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


	http://ceph.com/debian

was a symlink to debian-argonaut.  That's now rolled over to 
debian-bobtail.  If you have that URL configured in your sources.list, 
you'll now get the bobtail packages on the next 'apt-get upgrade' (if you 
run such commands).  Be careful!  Please refer to the upgrade document at

	http://ceph.com/docs/master/install/upgrading-ceph/#upgrading-from-argonaut-to-bobtail

In general, we recommend putting the explicit release name in the URL, 
e.g.

	http://ceph.com/debian-bobtail

sage
