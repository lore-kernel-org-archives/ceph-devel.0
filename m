From: Sage Weil <sage@inktank.com>
Subject: problem with /lib/lsb/init-functions
Date: Tue, 8 Apr 2014 09:38:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404080936130.28550@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46101 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756919AbaDHQiH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 12:38:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: onlyjob@debian.org
Cc: alfredo.deza@inktank.com, ceph-devel@vger.kernel.org

Hi Dmitry,

In commit 012bb5fb5bbc76e5a2c5037dc0c6558f0b1b0a45 we added a dependency 
on /lib/lsb/init-functions which is not present on rpm-based machines.  
This thread

	http://www.redhat.com/archives/rhl-devel-list/2007-August/msg01920.html

proposes a workaround but there is also some concern about this being 
slow.  Do you know what the best practice is here?  I'm not familiar with 
this area.

	http://tracker.ceph.com/issues/8028

Thanks!
sage

