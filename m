From: Sage Weil <sage@newdream.net>
Subject: Re: systemd support
Date: Mon, 6 Jul 2015 12:46:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507061242300.13991@cobra.newdream.net>
References: <55970AFF.3020603@dachary.org> <559AD11F.4050100@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36173 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbbGFTqh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jul 2015 15:46:37 -0400
In-Reply-To: <559AD11F.4050100@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 6 Jul 2015, Ken Dreyer wrote:
> On 07/03/2015 04:21 PM, Loic Dachary wrote:
> > [cc'ing ceph-devel in case someone else has the answer]
> > 
> > Hi Ken,
> > 
> > I know very little about systemd and I'd like to learn more. My understanding
> > is that we have some support in the current master branch, but it is
> > incomplete. Are there differences with what I would find in the Red Hat
> > Storage 1.3 packages ? If I'm not mistaken RHEL7 uses systemd, therefore I
> > guess there may be a better support there. Unless it's using the legacy
> > sysvinit files ?
> 
> Hi Loic,
> 
> The RHCS product is using the legacy sysvinit scripts that are upstream.
> I doubt we'll use systemd unit files to manage the services in RHCS
> until those land upstream and get a lot of testing there.
> 
> There is a ticket to track the incorporation of systemd unit files for
> the services, here: http://tracker.ceph.com/issues/11344 . That ticket
> has some more details regarding the current situation upstream.
> 
> >From what I recall, both SUSE and Ubuntu have implemented systemd unit
> files downstream for the Ceph MON/OSD/MDS services.

I really really wanted to make this land for infernalis, but it'll have to 
happen quickly if that's to happen.  My suggestion (before I got sick) was 
to merge all of the systemd related changes into a wip-systemd branch and 
test/fix the integrated pile.  I'd start by just grabbing a few downburst 
VMs, instaling simple clusters with ceph-deploy, and geting used to the 
user experience of starting/stopping daemons, making sure things behave on 
boot, updating some of the docs, and so forth.  I suspect there are some 
minor ceph-deploy changes need to systemtl enable the mon and mds daemons
(osds would start indirectly via udev).

...but I would *love* it if infernalis used systemd natively for fc22 
(which has a gitbuilder now) and rhel/centos7.  I'm not sure what is 
downstream for ubuntu, but that could be pulled in as well.  We aren't 
building upstream suse packages so nothing to do there at this point 
except merge whatever Owen sends us :)

sage
