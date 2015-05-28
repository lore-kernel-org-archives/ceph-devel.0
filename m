From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: python-ceph centos7 epel issues
Date: Thu, 28 May 2015 12:02:44 -0400 (EDT)
Message-ID: <1595601325.6118136.1432828964873.JavaMail.zimbra@redhat.com>
References: <CABZ+qq==Dr-VAmnNjUSK5vyGhHZFw88pBFiVGBQxLS=JMAt_MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:45133 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbbE1QCr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 12:02:47 -0400
In-Reply-To: <CABZ+qq==Dr-VAmnNjUSK5vyGhHZFw88pBFiVGBQxLS=JMAt_MA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: ceph-devel@vger.kernel.org

I've been trying to debug this issue, and it's why I haven't pushed that epel-testing package to stable yet. Your email is helping to illuminate a bit more what is happening. Today I've unpushed -0.5 from epel-testing in Bodhi because it's clear -0.5 doesn't resolve the situation and just makes it worse for you guys. We need more fixes in a -0.6 EPEL release.

My hunch is that we need to do two separate things to resolve this situation:

1) Bump the RPM Epoch in Firefly upstream to "1", to bring sanity to the version number comparisons that the EPEL packages are doing,

2) Add additional version numbers to the Obsoletes that ceph-devel-compat and python-ceph-compat packages in EPEL are doing.

I'll try testing this combination with some scratch builds.

- Ken

----- Original Message -----
> From: "Dan van der Ster" <dan@vanderster.com>
> To: "Ken Dreyer" <kdreyer@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Thursday, May 28, 2015 7:38:51 AM
> Subject: python-ceph centos7 epel issues
> 
> Hi Ken,
> 
> I'm having trouble installing ceph cleanly on CentOS 7 -- I guess this
> is related to https://bugzilla.redhat.com/1193182.
> 
> (1) If I disable epel-testing, and have check_obsoletes = 1, then the
> install works [ http://pastebin.com/gvHbRJ3T ].
> 
> (2) With epel-testing enabled -- to get your new -0.5 "fixed"
> python-ceph rpms -- the install fails in two different ways, depending
> on check_obsoletes. With check_obsoletes = 1 [
> http://pastebin.com/AWRdP2Hh ] and without it [
> http://pastebin.com/8Uxj6N1s ]
> 
> Do you understand what's happening with the -0.5 package? In the
> meantime we're doing (1) above to install ceph.
> 
> Thanks, Dan
> 
