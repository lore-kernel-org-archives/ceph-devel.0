From: Sage Weil <sweil@redhat.com>
Subject: open the floodgates...
Date: Thu, 21 Apr 2016 15:03:07 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604211432300.16393@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40691 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbcDUTDF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Apr 2016 15:03:05 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 670AA6264C
	for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2016 19:03:04 +0000 (UTC)
Received: from cpach ([10.3.112.6])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3LJ32Bm003393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2016 15:03:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

and release the (pull requests with code destined for) kraken!

One question: we moved from a 'next' branch to 'jewel' branch for the 
development period to represent the 'frozen' bugfix branch before each 
development checkpoint release.  Should we

1) Use a 'kraken' branch, just like we did with jewel.  After each dev 
release, merge in the next lump of new stuff from master.

2) Go back to a 'next' branch, like we did pre-jewel.

3) Give up on the delayed dev checkpoint release thing we've been doing 
(where we send bug fixes to next or kraken for 2 weeks before release) and 
just release regular checkpoints of master (as 11.0.z).

4) Stop doing development checkpoint releases entirely and let testers 
pull automated builds from gitbuilder or jenkins.

Thoughts?
sage
