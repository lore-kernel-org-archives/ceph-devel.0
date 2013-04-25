From: Sage Weil <sage@inktank.com>
Subject: Re: cuttlefish countdown
Date: Thu, 25 Apr 2013 09:13:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304250912180.4411@cobra.newdream.net>
References: <alpine.DEB.2.00.1304241527220.2772@cobra.newdream.net> <5178E6AB.4020403@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45697 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757220Ab3DYQNW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 12:13:22 -0400
In-Reply-To: <5178E6AB.4020403@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

http://tracker.ceph.com/projects/ceph/issues?query_id=27

It's the 'Bug queue' link on the lower right under 'custom queries'.  Now 
there are 6 (ignoring pending backport)... :(

s

On Thu, 25 Apr 2013, Wido den Hollander wrote:

> Hi,
> 
> On 04/25/2013 01:46 AM, Sage Weil wrote:
> > Hi everyone-
> > 
> > We are down to a handful of urgent bugs (3!) and a cuttlefish release date
> > that is less than a week away.  Thank you to everyone who has been
> > involved in coding, testing, and stabilizing this release.  We are close!
> > 
> 
> I'm trying to find the 3 urgent bugs for Cuttlefish, but I can't seem to fetch
> them out of Redmine: http://tracker.ceph.com/projects/1/issues?sort=position
> 
> That doesn't show me any open urgent bugs? Trying to figure out what's still
> open.
> 
> Wido
> 
> > If you would like to test the current release candidate, your efforts
> > would be much appreciated!  For deb systems, you can do
> > 
> >   wget -q -O-
> > 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/autobuild.asc' | sudo
> > apt-key add -
> >   echo deb http://gitbuilder.ceph.com/ceph-deb-$(lsb_release
> > -sc)-x86_64-basic/ref/next $(lsb_release -sc) main | sudo tee
> > /etc/apt/sources.list.d/ceph.list
> > 
> > For rpm users you can find packages at
> > 
> >   http://gitbuilder.ceph.com/ceph-rpm-centos6-x86_64-basic/ref/next/
> >   http://gitbuilder.ceph.com/ceph-rpm-fc17-x86_64-basic/ref/next/
> >   http://gitbuilder.ceph.com/ceph-rpm-fc18-x86_64-basic/ref/next/
> > 
> > A draft of the release notes is up at
> > 
> >   http://ceph.com/docs/master/release-notes/#v0-61
> > 
> > Let me know if I've missed anything!
> > 
> > sage
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> -- 
> Wido den Hollander
> 42on B.V.
> 
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> 
> 
