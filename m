From: Sage Weil <sweil@redhat.com>
Subject: dropping trusty
Date: Thu, 30 Nov 2017 17:21:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711301711470.12766@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751383AbdK3RVp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Nov 2017 12:21:45 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: dgallowa@redhat.com, ceph-users@ceph.com

We're talking about dropping trusty support for mimic due to the old 
compiler (incomplete C++11), hassle of using an updated toolchain, general 
desire to stop supporting old stuff, and lack of user objections to 
dropping it in the next release.

We would continue to build trusty packages for luminous and older 
releases, just not mimic going forward.

My question is whether we should drop all of the trusty installs on smithi 
and focus testing on xenial and centos.  I haven't seen any trusty related 
failures in half a year.  There were some kernel-related issues 6+ months 
ago that are resolved, and there is a valgrind issue with xenial that is 
making us do valgrind only on centos, but otherwise I don't recall any 
other problems.  I think the likelihood of a trusty-specific regression on 
luminous/jewel is low.  Note that we can still do install and smoke 
testing on VMs to ensure the packages work; we just wouldn't stress test.

Does this seem reasonable?  If so, we could reimage the trusty hosts 
immediately, right?

Am I missing anything?

sage
 
