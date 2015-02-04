From: Sage Weil <sweil@redhat.com>
Subject: hammer is frozen
Date: Wed, 4 Feb 2015 12:51:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502041242400.27042@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38279 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161409AbbBDUvZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 Feb 2015 15:51:25 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t14KpOOW029739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 4 Feb 2015 15:51:25 -0500
Received: from redhat.com (ovpn-112-43.phx2.redhat.com [10.3.112.43])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t14KpNIc001688
	for <ceph-devel@vger.kernel.org>; Wed, 4 Feb 2015 15:51:24 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I created the branch on Monday, but am traveling and forgot to send an 
email.  This means we're not merging new features until we have a handle 
on the testing and the QA results are looking good.

Specifically:

- There is a 'hammer' ceph.git branch.  Please target any bug fixes at 
  this.

- The 'next' branch is deleted for the time being (see above)

- Do not merge any new features to master; not yet.  It's too confusing 
  and we have enough work to do stabilizing things.

- There are still several pull requests open that are bug fixes and target 
  master that should get merged once they are tested, so we will probably 
  merge hammer and master together periodically to avoid doing all the 
  merged manually.  (Another reason not to merge any new code into master 
  that does not target hammer.)

- We're using the 'hammer' milestone on github to track what to pay 
  attention to.  Please help keep it in sync with the open pull 
  requests that are hammer-bound vs future work for infernalis.

If there is something exceptional that hasn't made it in yet and is 
low-risk, plea your case, but no promises.  Bribery in the form of fixes 
for open bugs can be effective.  :)

Thanks!
sage
