From: Sage Weil <sweil@redhat.com>
Subject: Re: Fedora 22 systemd and ceph-deploy
Date: Mon, 3 Aug 2015 12:07:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508031205360.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net> <55BFBA99.4070205@suse.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1815850834-1438628848=:22099"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbbHCTH3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Aug 2015 15:07:29 -0400
In-Reply-To: <55BFBA99.4070205@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1815850834-1438628848=:22099
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Mon, 3 Aug 2015, Owen Synge wrote:
> Dear all,
> 
> My plan is to make a fedora22-systemd branch. I will leave fedora 20 as
> sysvinit.
> 
> Ok just done my first proper install of systemd ceph branch on fedora22.
> 
> I can confirm most of the issues.
> 
> I am giving up for the day, but so far applying SUSE/opensuse code to
> Fedora ceph-deploy code in ceph-deploy has helped a lot.
> 
>     cp /usr/lib/python2.7/site-packages/ceph_deploy/hosts/suse/mon/* \
>       /usr/lib/python2.7/site-packages/ceph_deploy/hosts/fedora/mon/
> 
> (Running on suse version patched release)
> 
> It can now set up the mon daemons correctly its self.
> 
> I will look into the udev rules, tomorrow morning, and remove some more
> fedora hard coding to "sysvinit".

There is a wip-systemd branch ceph-deploy that has enough ceph-deploy 
changes for me to successfully do the deployment of mon, osd, mds, and 
rgw.  The main thing it doesn't do is figure out which version of Ceph 
you're installing to decide whether to do systemd (post-hammer) or 
sysvinit (hammer and earlier).  That's going to be annoying, I'm afraid...

I suspect what we really want to do is abstract out the systemd behavior 
into something that the distros opt in to so that we aren't duplicating 
code across the suse, centos, rhel, and fedora host types...

sage


> 
> Best regards
> 
> Owen
> 
> 
> On 07/28/2015 09:13 PM, Sage Weil wrote:
> > Hey,
> > 
> > I've finally had some time to play with the systemd integration branch on 
> > fedora 22.  It's in wip-systemd and my current list of issues includes:
> > 
> > - after mon creation ceph-create-keys isn't run automagically
> >   - Personally I kind of hate how it was always run on mon startup and not 
> > just during cluster creation so I wouldn't mind *so* much if this became 
> > an explicit step, maybe triggered by ceph-deploy, after mon create.
> > 
> > - udev's attempt to trigger ceph-disk isn't working for me.  the osd 
> > service gets started but the mount isn't present and it fails to start.  
> > I'm a systemd noob and haven't sorted out how to get udev to log something 
> > meaningful to debug it.  Perhaps we should merge in the udev + 
> > systemd revamp patches here too...
> > 
> > - ceph-detect-init is only recently unbroken in master for fedora 22.
> > 
> > - ceph-deploy doesn't know that fedora should be systemd yet.
> > 
> > - ceph-deploy has a wip-systemd branch with a few things so far:
> >   - on mon create, we unconditionally systemctl enable ceph.target.  
> > i think osd create and mds create and rgw create should do the same thing, 
> > since the ceph.target is a catch-all bucket for any ceph service, and i 
> > don't think we want to enable it on install?
> >   - rgw create and mds create don't work yet
> >   - osd create doesn't enable ceph.target
> > 
> > - I'm guessing my ceph.spec changes to install teh systemd unit files 
> > aren't quite right... please review!  The gitbuilder turnaround is so slow 
> > it's hard to iterate and I don't really know what I'm doing here.
> > 
> > Owen, I'd like to get this just a tad bit more functional and then merge 
> > ASAP, then up any issues in the weeks leading up to infernalis.  What say 
> > ye?
> > 
> > sage
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -- 
> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB
> 21284 (AG
> Nürnberg)
> 
> Maxfeldstraße 5
> 
> 90409 Nürnberg
> 
> Germany
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--557981400-1815850834-1438628848=:22099--
