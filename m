From: Sage Weil <sage@inktank.com>
Subject: Re: bobtail release candidates
Date: Mon, 26 Nov 2012 08:22:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211260821510.23552@cobra.newdream.net>
References: <alpine.DEB.2.00.1211250953400.23552@cobra.newdream.net> <50B36DC6.6000308@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49290 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab2KZQW5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 11:22:57 -0500
In-Reply-To: <50B36DC6.6000308@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On Mon, 26 Nov 2012, Wido den Hollander wrote:
> Hi,
> 
> On 11/26/2012 01:57 AM, Sage Weil wrote:
> > Hi all,
> > 
> > There are automatic builds of the prerelease bobtail code available under
> > the 'next' branch.
> > 
> > For debs,
> > 	http://ceph.com/docs/master/install/debian/#add-development-testing-packages
> > 
> > For example, for Ubuntu 12.04 precise,
> > 	http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/next/
> > 
> > And RPMs for el6,
> > 	http://gitbuilder.ceph.com/ceph-rpm-centos6-x86_64-basic/ref/next/RPMS/x86_64/
> > 
> > Any testing and early feedback is greatly appreciated.
> > 
> 
> I just gave it a try on a small setup I'm toying with and noticed this after
> the package upgrade:
> 
> [599557.873110] init: /etc/init/ceph-mds.conf:9: Expected token
> [599557.880938] init: /etc/init/ceph-osd.conf:9: Expected token
> [599557.900269] init: /etc/init/ceph-mon.conf:9: Expected token
> 
> I'm not so familiar with upstart, but line 9 contains:
> 
> limit nofile 8192

Whoops, the fix for this is in wip-upstart.  I'll merge that in.

> I also got this message when starting my OSDs:
> 
> "No osd devs defined!"
> 
> I indeed haven't defined any devs, I've mounted the drives in the fstab.
> 
> Should I change this, or?

No, I'll remove that echo.  There is no need to make noise about this, I 
think.

sage
