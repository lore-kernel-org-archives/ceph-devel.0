From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Tue, 14 Apr 2015 08:21:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com> <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net> <5488FC46.5080106@suse.com> <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net>
 <552C9182.5030605@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40220 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbbDNPVS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Apr 2015 11:21:18 -0400
In-Reply-To: <552C9182.5030605@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, cjwatson@debian.org, timm@fnal.gov, osynge@suse.com, ceph-maintainers@ceph.com, ceph-devel@vger.kernel.org

On Tue, 14 Apr 2015, Tim Serong wrote:
> On 04/14/2015 11:05 AM, Sage Weil wrote:
> > Tim, Owen:
> > 
> > Can we get a 'ceph' user/group uid/gid allocated for SUSE to get this 
> > unstuck?  IMO the radosgw systemd stuff is blocked behind this too.
> 
> I haven't yet been able to get a good answer to assignment of static
> UIDs and GIDs (I was told all the ones between 0-99 are taken already).
> 
> But, if it's OK for the UID and GID numbers to potentially be different
> on different systems, adding a "ceph" user and "ceph" group is easy, we
> just add appropriate `groupadd -r ceph` and `useradd -r ceph`
> invocations to the rpm %pre script, which will give a UID/GID somewhere
> in the 100-499 range (see
> https://en.opensuse.org/openSUSE:Packaging_guidelines#Users_and_Groups
> for some notes on this).  We'd also want to update rpmlint to not whine
> about the "ceph" name.
> 
> I originally thought the risk of non-static UID/GID numbers on different
> systems was terrible, but...

I think we still want them to be static across a distro; it's the 
cross-distro change that will be relatively rare.  So a fixed ID from each 
distro family ought to be okay?

> > I think a osd-prestart.sh snippet (or similar) that does a chown -R of any 
> > non-root osd data to the local ceph user prior to starting the daemon will 
> > handle the cross-distro changes without too much trouble.  I'd lean toward 
> > not going from root -> ceph, though, and have the start script stay root 
> > and not drop privs if the data is owned by root.. that covers upgrades 
> > without interruption.
> > 
> > What do you think?
> 
> ...that sounds reasonable, and I think it would also handle the case
> where, say, you move an OSD from one SUSE host to another - if the
> UID/GID doesn't match (maybe some other `useradd`ing software was
> installed first on the other host), the chown will fix it anyway.
> 
> Are there any holes in this?

It would be nicer if the suse->suse case didn't require a chown, but yeah, 
it'd still work just fine...

sage


> 
> Regards,
> 
> Tim
> 
> 
> > 
> > 
> > On Thu, 11 Dec 2014, Tim Serong wrote:
> > 
> >> On 12/11/2014 05:48 AM, Sage Weil wrote:
> >>> +ceph-devel
> >>>
> >>> On Wed, 10 Dec 2014, Ken Dreyer wrote:
> >>>> On 12/06/2014 01:54 PM, Sage Weil wrote:
> >>>>> Hi Colin, Boris, Owen,
> >>>>>
> >>>>> We would like to choose a statically allocated uid and gid for use by Ceph 
> >>>>> storage servers.  The basic goals are:
> >>>>>
> >>>>>  - run daemons as non-root (right now everything is uid 0 (runtime and 
> >>>>> on-disk data) and this is clearly not ideal)
> >>>>>  - enable hot swap of disks between storage servers
> >>>>>  - standardize across distros so that we can build clusters with a mix
> >>>>>
> >>>>> To support the hot swap, we can't use the usual uids allocated dynamically 
> >>>>> during package installation.  Disks will completely filled with Ceph data 
> >>>>> files with the uid from one machine and will not be usable on another 
> >>>>> machine.
> >>>>>
> >>>>> I'm hoping we can choose a static uid/gid pair that is unused for Debian 
> >>>>> (and Ubuntu), Fedora (and RHEL/CentOS), and OpenSUSE/SLES.  This will let 
> >>>>> us maintain consistency across the entire ecosystem.
> >>>>
> >>>> How many system users should I request from the Fedora Packaging
> >>>> Committee, and what should their names be?
> >>>>
> >>>> For example, are ceph-mon and ceph-osd going to run under the same
> >>>> non-privileged system account?
> >>>
> >>> Hmm, my first impulse was to make a single user and group.  But it might 
> >>> make sense that e.g. rgw should run in a different context than ceph-osd 
> >>> or ceph-mon.
> >>>
> >>> If we go down that road, then maybe
> >>>
> >>>  ceph-osd
> >>>  ceph-mon
> >>>  ceph-mds
> >>>  ceph-rgw
> >>>  ceph-calamari
> >>>
> >>> and a 'ceph' group that we can use for /var/log/ceph etc for the qemu 
> >>> and other librados users?
> >>>
> >>> Alternatively, if we just do user+group ceph, then rgw can run as www-data 
> >>> or apache (as it does now).  Not sure what makes the most sense for 
> >>> ceph-calamari.
> >>
> >> FWIW my gut says go with a single ceph user+group and leave rgw running
> >> as the apache user.
> >>
> >> Calamari consists of a few pieces - the web-accessible bit runs as the
> >> apache user, then there's the cthulhu daemon, as well as carbon-cache
> >> for the graphite stuff.  These latter two I believe run as root (at
> >> least, they do with my SUSE packages which have systemd units for each
> >> of these services, and I assume they run as root on other distros where
> >> they're run under supervisord).  Now that I think of it though, I wonder
> >> if it makes sense to just run the whole lot as the apache user...?
> >>
> >> Regards,
> >>
> >> Tim
> >> -- 
> >> Tim Serong
> >> Senior Clustering Engineer
> >> SUSE
> >> tserong@suse.com
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > 
> 
> 
> -- 
> Tim Serong
> Senior Clustering Engineer
> SUSE
> tserong@suse.com
> 
> 
