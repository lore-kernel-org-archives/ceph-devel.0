From: Sage Weil <sage@newdream.net>
Subject: Re: ceph 0.44+ and leveldb
Date: Mon, 9 Apr 2012 22:36:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204092232550.26893@cobra.newdream.net>
References: <1333689498.19737.11.camel@julia.gcs.org.hu>
 <Pine.LNX.4.64.1204060943510.3020@cobra.newdream.net>
 <1333741995.2114.15.camel@jdlaptop.lesbg.loc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41456 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab2DJFg1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Apr 2012 01:36:27 -0400
In-Reply-To: <1333741995.2114.15.camel@jdlaptop.lesbg.loc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jonathan Dieter <jdieter@lesbg.com>
Cc: Laszlo Boszormenyi <gcs@debian.hu>, ceph-devel@vger.kernel.org

Hi Laszlo, Jonathan,

configure will now accept a --with-system-leveldb flag that will use the 
installed libleveldb.  For Debian, we just need to update debian/rules and 
add libsnappy-dev and libleveldb-dev to the build depends.

I didn't this in ceph.git because I'm building packages for various older 
distros and don't want to backport those packages right now.  Laszlo, can 
you carry that diff on your side when you submit upstream?

Jonathan, I'm not doing anything to the .spec file yet either, since 
presumably leveldb needs to be packaged first.

The change is in the next and master branches, so it'll be there for 
v0.45 (which I plan to release tomorrow).

sage



On Fri, 6 Apr 2012, Jonathan Dieter wrote:

> On Fri, 2012-04-06 at 09:49 -0700, Sage Weil wrote:
> > The problem here is that libleveldb-dev is only packaged for wheezy and 
> > precise, and we'd like to build packages for squeeze and oneiric, and 
> > make the build experience easy for non-debian/ubuntu users.  (I didn't 
> > check whether it was in rpm-based distros.)
> 
> It's not in Fedora (and probably not in RHEL/CentOS/ScientificLinux,
> etc).  However, Fedora's policy is that bundled libraries aren't
> allowed, so we (as in Fedora) really should be packaging leveldb
> separately ourselves.
> 
> > I think the ideal situation would be for the debs to build against the 
> > debian package, and allow others an easy way to get the correct source 
> > (by bundling it in the ceph source tarball, or via a simple build script 
> > that does the equivalent of git submodule update --init).
> > 
> > Do you have a clear picture of how that would work?
> 
> One common way would be to have a flag for ./configure, something like
> --use-system-leveldb, that would disable building the bundled leveldb.
> 
> I'm afraid I know next to nothing about autotools, so I'm not sure how
> exactly it's done, but I don't think it's particularly complex for
> someone who does know how to use autotools.
> 
> Jonathan
> 
