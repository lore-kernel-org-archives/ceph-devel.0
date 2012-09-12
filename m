From: Sage Weil <sage@inktank.com>
Subject: Re: Quick CentOS/RHEL question ...
Date: Wed, 12 Sep 2012 08:56:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209120854160.16510@cobra.newdream.net>
References: <50185964.3010803@scalableinformatics.com> <sfid-H20120801-021007-+045.02-1@marduk.tchpc.tcd.ie> <CAC-hyiF3jkA_VnPM8Ty9B+GnzH2xDbun9RQs+CE4yHgAp5OfnA@mail.gmail.com> <20120912154218.GA14887@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48705 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab2ILP4l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 11:56:41 -0400
In-Reply-To: <20120912154218.GA14887@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: Yehuda Sadeh <yehuda@inktank.com>, landman@scalableinformatics.com, ceph-devel@vger.kernel.org

On Wed, 12 Sep 2012, Jimmy Tang wrote:
> On Tue, Jul 31, 2012 at 06:09:59PM -0700, Yehuda Sadeh wrote:
> > On Tue, Jul 31, 2012 at 3:17 PM, Joe Landman
> > <landman@scalableinformatics.com> wrote:
> > > Hi folks
> > >
> > >   I was struggling and failing to get Ceph properly built/installed for
> > > CentOS 6 (and 5) last week.  Is this simply not a recommended platform?
> > > Please advise.  Thanks!
> > 
> > As mentioned by the other responses, it is possible to get Ceph built
> > for RHEL/CentOS even though it's probably not trivial. Getting proper
> > packaging for these distributions is pretty high on our list. We'd
> > love to hear about specific the issues that you have had.
> > 
> 
> Will there also be backports of the kernel modules for cephfs and rbd?
> That's probably a make or break feature for anyone using RHEL based
> distros as they are not likely to want to upgrade their kernels
> manually and maintain them for security fixes. I guess if there are no
> kernel modules for cephfs and rbd RHEL could still be used as a osd,
> mon or mds.

We do not have any kernel backports planned at this point.  The RHEL 
kernels also tend to be pretty old, so it's likely a fair bit of work.

That said, the server stuff should all run fine on RHEL/CentOS.  We are 
now doing builds on centos 6 as part of our continuous builds 
(ceph.com/gitbuilders.cgi), and the next release will include centos rpms 
(and hopefully Fedora).  Looking forward, we'll be adding opensuse and 
sles rpms as well.

sage

