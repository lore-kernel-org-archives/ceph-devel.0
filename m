From: Sage Weil <sage@inktank.com>
Subject: disabling updatedb
Date: Tue, 18 Feb 2014 08:47:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402180845440.15052@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33962 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbaBRQr4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Feb 2014 11:47:56 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-maintainers@ceph.com, ceph-devel@vger.kernel.org

Dan at CERN noticed that his performance was tanking because updatedb was 
running against /var/lib/ceph.  updatedb has a PRUNE line in 
/etc/updatedb.conf that we should presumably be adding ourselves to.  One 
user pointed out a package that uses sed to rewrite this line in the init 
script on start.

I have two questions:

- is there no better way than sed to add ourselves to this list?
- should we do it in the init script, or postinst, or both?

Presumably this is a problem others have solved with other packages.

	http://tracker.ceph.com/issues/7451

sage
