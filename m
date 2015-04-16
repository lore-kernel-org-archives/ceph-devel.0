From: Sage Weil <sweil@redhat.com>
Subject: client/cluster compatibility testing
Date: Thu, 16 Apr 2015 09:42:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504160935130.18547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39860 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbDPQ7D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Apr 2015 12:59:03 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3GGx0Zl003418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 12:59:03 -0400
Received: from redhat.com (ovpn-112-67.phx2.redhat.com [10.3.112.67])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3GGgT3X022369
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 12:42:30 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now that there are several different vendors shipping and supporting Ceph 
in their products, we'll invariably have people running different 
versions of Ceph that are interested in interoperability.  If we focus 
just on client <-> cluster compatability, I think the issues are (1) 
compatibility between upstream ceph versions (firefly vs hammer) and 
(2) ensuring that any downstream changes the vendor makes don't break that 
compatibility.

I think the simplest way to address this is to talk about compatibility in 
terms of the upstream stable releases (firefly, hammer, etc.), and test 
that compatibility with teuthology tests from ceph-qa-suite.git.  We have 
some basic inter-version client/cluster tests already in 
suites/upgrade/client-upgrade.  Currently these test new (version "x") 
clients against a given release (dumpling, firefly).  I think we just need 
to add hammer to that mix, and then add a second set of tests that do the 
reverse: test clients from a given release (dumpling, firefly, hammer) 
against an arbitrary cluster version ("x").

We'll obviously run these tests on upstream releases to ensure that we are 
not breaking compatibility (or are doing so in known, explicit ways).  
Downstream folks can run the same test suites against any changes they 
make as well to ensure that their product is "compatible with firefly 
clients," or whatever.

Does that sound reasonable?
sage

