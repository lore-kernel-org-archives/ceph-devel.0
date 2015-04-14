From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Mon, 13 Apr 2015 18:02:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504131800460.32097@cobra.newdream.net>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com> <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net> <5488FC46.5080106@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60690 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbbDNBCS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Apr 2015 21:02:18 -0400
In-Reply-To: <5488FC46.5080106@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, cjwatson@debian.org, timm@fnal.gov, ceph-maintainers@ceph.com, ceph-devel@vger.kernel.org

On Thu, 11 Dec 2014, Tim Serong wrote:
> On 12/11/2014 05:48 AM, Sage Weil wrote:
> > +ceph-devel
> > 
> > On Wed, 10 Dec 2014, Ken Dreyer wrote:
> >> On 12/06/2014 01:54 PM, Sage Weil wrote:
> >>> Hi Colin, Boris, Owen,
> >>>
> >>> We would like to choose a statically allocated uid and gid for use by Ceph 
> >>> storage servers.  The basic goals are:
> >>>
> >>>  - run daemons as non-root (right now everything is uid 0 (runtime and 
> >>> on-disk data) and this is clearly not ideal)
> >>>  - enable hot swap of disks between storage servers
> >>>  - standardize across distros so that we can build clusters with a mix
> >>>
> >>> To support the hot swap, we can't use the usual uids allocated dynamically 
> >>> during package installation.  Disks will completely filled with Ceph data 
> >>> files with the uid from one machine and will not be usable on another 
> >>> machine.
> >>>
> >>> I'm hoping we can choose a static uid/gid pair that is unused for Debian 
> >>> (and Ubuntu), Fedora (and RHEL/CentOS), and OpenSUSE/SLES.  This will let 
> >>> us maintain consistency across the entire ecosystem.
> >>
> >> How many system users should I request from the Fedora Packaging
> >> Committee, and what should their names be?
> >>
> >> For example, are ceph-mon and ceph-osd going to run under the same
> >> non-privileged system account?
> > 
> > Hmm, my first impulse was to make a single user and group.  But it might 
> > make sense that e.g. rgw should run in a different context than ceph-osd 
> > or ceph-mon.
> > 
> > If we go down that road, then maybe
> > 
> >  ceph-osd
> >  ceph-mon
> >  ceph-mds
> >  ceph-rgw
> >  ceph-calamari
> > 
> > and a 'ceph' group that we can use for /var/log/ceph etc for the qemu 
> > and other librados users?
> > 
> > Alternatively, if we just do user+group ceph, then rgw can run as www-data 
> > or apache (as it does now).  Not sure what makes the most sense for 
> > ceph-calamari.
> 
> FWIW my gut says go with a single ceph user+group and leave rgw running
> as the apache user.

Someone just tripped over this with hammer's radosgw, which doesn't 
require apache by default (using civetweb)--the apache user didn't 
exist.

It is probably simplest to make radosgw run as 'ceph' too.  This avoids 
all these issues, and will let radosgw log to /var/log/ceph/* too.

sage


> Calamari consists of a few pieces - the web-accessible bit runs as the
> apache user, then there's the cthulhu daemon, as well as carbon-cache
> for the graphite stuff.  These latter two I believe run as root (at
> least, they do with my SUSE packages which have systemd units for each
> of these services, and I assume they run as root on other distros where
> they're run under supervisord).  Now that I think of it though, I wonder
> if it makes sense to just run the whole lot as the apache user...?
> 
> Regards,
> 
> Tim
> -- 
> Tim Serong
> Senior Clustering Engineer
> SUSE
> tserong@suse.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
