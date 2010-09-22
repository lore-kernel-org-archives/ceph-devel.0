From: Sage Weil <sage@newdream.net>
Subject: Re: some questions about ceph deployment
Date: Wed, 22 Sep 2010 13:44:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009221343090.3172@cobra.newdream.net>
References: <000d01cb4c37$71fadf90$55f09eb0$@com>
 <Pine.LNX.4.64.1009171322440.29822@cobra.newdream.net>
 <AANLkTikLgvHVRnHC+ept0NZv7uGVpAL52hDdFH2wiN9L@mail.gmail.com>
 <Pine.LNX.4.64.1009220911290.6962@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39280 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab0IVUnI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 16:43:08 -0400
In-Reply-To: <Pine.LNX.4.64.1009220911290.6962@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cang lin <fwdflywl@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 22 Sep 2010, Sage Weil wrote:
> On Wed, 22 Sep 2010, cang lin wrote:
> > >          When I follow the instruction of
> > > http://ceph.newdream.net/wiki/Monitor_cluster_expansion to expand a
> > > monitor to ceph02, the following error occurred:
> > > >
> > > > root@ceph02:~#  /etc/init.d/ceph start mon1
> > > > [/etc/ceph/fetch_config/tmp/fetched.ceph.conf.14210] ceph.conf 100%  2565
> > >  2.5KB/s  00:00
> > > > === mon.1 ===
> > > > Starting Ceph mon1 on ceph02...
> > > >  ** WARNING: Ceph is still under heavy development, and is only suitable
> > > for **
> > > >  ** testing and review.  Do not trust it with important data.  **
> > > > terminate called after throwing an instance of 'std::logic_error'
> > > >   what():  basic_string::_S_construct NULL not valid
> > > > Aborted (core dumped)
> > > > failed: ' /usr/bin/cmon -i 1 -c /tmp/fetched.ceph.conf.14210 '
> > >
> > > I haven't seen that crash, but it looks like a std::string constructor is
> > > being passed a NULL pointer.  Do you have a core dump (to get a
> > > backtrace)?  Which version are you running (`cmon -v`)?
> > >
> > 
> > The cmon version is v0.21.1 when the crash happen and been updated to
> > v0.21.2.
> > 
> > The following backtrace is from v0.21.2:
> 
> Thanks, we'll see if we can reproduce and fix this one!

Ok, this one is fixed by commit 79b6f2f9e9dd70704644338c968f9ad070e5a8f8 
in the testing branch.  It actually should be printing an error that the 
'magic' file is missing from the mon data directory.  Maybe you skipped 
step #3 on the monitor cluster expansion page?

Thanks-
sage
