From: Sage Weil <sweil@redhat.com>
Subject: Re: RHEL 6.5 shared library upgrade safety
Date: Mon, 18 Aug 2014 08:32:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408180829490.28244@cobra.newdream.net>
References: <53F1EA1C.1020108@dachary.org> <alpine.DEB.2.00.1408180816390.28244@cobra.newdream.net> <53F21AFE.6090900@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55916 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbaHRPcI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 11:32:08 -0400
In-Reply-To: <53F21AFE.6090900@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 18 Aug 2014, Loic Dachary wrote:
> On 18/08/2014 17:17, Sage Weil wrote:
> > On Mon, 18 Aug 2014, Loic Dachary wrote:
> >> Hi Ceph,
> >>
> >> In RHEL 6.5, is the following scenario possible : 
> >>
> >> a) an OSD dlopen a shared library for erasure-code, 
> >> b) the shared library file is replaced while the OSD is running, 
> >> c) the OSD starts using the new file instead of the old one. 
> >>
> >> It seems unlikely but it would explain a weird stack trace at 
> >> http://tracker.ceph.com/issues/9153#note-5 so I'm double checking ;-)
> > 
> > I think this is possible and likely.  We had similar problems with the 
> > rados classes and eventually just made them load all available plugins on 
> > startup (and also on demand in case one is installed later).
> > 
> > The simplest thing is probably to do that here as well...
> 
> This will not solve the upgrade problem for Firefly daemons which are 
> are already running, unfortunately. Stopping the daemons while the 
> package is being upgraded seems safer and more generic (see the other 
> thread). Or are there issues with this approach ?

Operationally it is not something people want to do.  Usually admins 
upgrade and then do the restarts in a controlled way.  At least, that's 
what I've heard anecdotally.

FWIW the crash is also something that testing turns up but is unlikely to 
happen in production.  In testing, the workload is just starting when we 
start upgrading so the plugins haven't always loaded.  In production, it 
is unlikely that a user will be *just* starting to use the EC features 
right as they are also doing an upgrade.  Unless they forgot to restart 
daemons...

sage
