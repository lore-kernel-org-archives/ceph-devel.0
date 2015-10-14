From: Sage Weil <sage@newdream.net>
Subject: Re: [Ceph-announce] v9.1.0 Infernalis release candidate released
Date: Wed, 14 Oct 2015 05:37:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510140530190.6589@cobra.newdream.net>
References: <alpine.DEB.2.00.1510131356001.27022@cobra.newdream.net> <87io6998m7.fsf@meteor.durcheinandertal.bofh>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49455 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbbJNMhC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Oct 2015 08:37:02 -0400
In-Reply-To: <87io6998m7.fsf@meteor.durcheinandertal.bofh>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gaudenz Steinlin <gaudenz@debian.org>
Cc: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com, James Page <jamespage@debian.org>

On Wed, 14 Oct 2015, Gaudenz Steinlin wrote:
> 
> Hi
> 
> Sage Weil <sage@newdream.net> writes:
> > Upgrading from Firefly
> > ----------------------
> >
> > Upgrading directly from Firefly v0.80.z is not possible.  All clusters
> > must first upgrade to Hammer v0.94.4 or a later v0.94.z release; only
> > then is it possible to upgrade to Infernalis 9.2.z.
> >
> 
> What's the exact issue with upgrading directly from Firefly to
> Infernalis? Is it just that you can't run mixed Firefly and Infernalis
> versions at the same time during an upgrade or is also the on disk
> format changing so that Infernals daemons won't understand the Firefly
> data structures?

There are two issues:

1- By requiring that each ceph-osd process start up on hammer, we were 
able to remove a bunch of compatibility/conversion code for supporting 
pre-hammer on-disk formats.  This was just nice cleanup.

2- A running post-hammer OSD can't talk to a pre-hammer OSD.  Partly it 
was an opportunity to remove a bunch of compat code, but in the end we 
also had to make fixes to hammer itself to make it interoperate with 
infernalis (hence the requirement that you run v0.94.4+, not v0.94.z).

> This is bad for Debian as the current stable release contains Firefly
> and the next Debian stable will likely contain the LTS release scheduled
> after Infernalis. So there won't be a Debian stable with Hammer. But
> upgrades are important and we would really like to have an upgrade path
> From one Debian release to the next.
> 
> Is there anything that can be done about this? At least having an
> offline upgrade option would be nice, if an online upgrade is not
> possible. How are other distributions planing to handle this? Ubuntu
> will likely have a similar problem at least for LTS to LTS upgrades.

That does suck... I definitely didn't consider this possibility.

One possibility is to revert #1 above so that you can upgrade from 
firefly -> jewel as long as you stop all OSDs.  That rules out an online 
upgrade but at least it can be done with debian packages.  It's the patch 
series merged by cbe101e7db4265dfaeae3b85d5e7f266c6a1e9d5 that is the 
problem.

The other possiblity is to ask users to upgrade via ceph.com packages.  

Hrm...
sage

