From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: client/cluster compatibility testing
Date: Thu, 16 Apr 2015 16:59:47 -0400 (EDT)
Message-ID: <1543401580.1470287.1429217987676.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1504160935130.18547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:46176 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbDPU7s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 16:59:48 -0400
In-Reply-To: <alpine.DEB.2.00.1504160935130.18547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

Yea, Sage, that sounds reasonable.

I added a ticket to capture this plan (http://tracker.ceph.com/issues/11413) and will add those tests soon.

Please add your comments to the ticket above.

I am assuming that it will look something like this for dumpling, firefly and hammer:

dumpling(stable) -> client-x
firefly(stable) -> client-x
hammer(stable) -> client-x

and reverse

dumpling-client(stable) -> cluster-x
firefly-cluster(stable) -> cluster-x
hammer-cluster(stable) -> cluster-x

Yes?

Thx
YuriW

----- Original Message -----
From: "Sage Weil" <sweil@redhat.com>
To: ceph-devel@vger.kernel.org
Sent: Thursday, April 16, 2015 9:42:29 AM
Subject: client/cluster compatibility testing

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

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
