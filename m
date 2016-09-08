From: Sage Weil <sweil@redhat.com>
Subject: no more autotools
Date: Thu, 8 Sep 2016 14:00:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609081352170.9549@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754070AbcIHOA3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 10:00:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: adeza@redhat.com, abhishek@suse.com

Yesterday we merged a PR that removed all of the autotools build 
infrastructure from the master branch of ceph.git.  We'll be 100% cmake 
for Kraken.  Hooray!

Huge thank you to Ali, Casey, Kefu, and everyone else who helped with this 
effort!

The gitbuilder and teuthology bits should all now be fully functional with 
cmake-only as we've been doing builds and tests with it for a while.  
We've no doubt broken some things with the release builds.

I think the next step should be to do a dev release (11.0.1) to work 
through the kinks and ensure that in a few weeks/months time when we are 
ready for kraken -rc's everything is working.  Alfredo and Abhishek, this 
will be mostly fall on you :).  I think any master commit is fine for our 
purposes (it's just a dev checkpoint and the main goal is to make sure the 
build works, not produce a well-tested set of packages for end users).

sage
