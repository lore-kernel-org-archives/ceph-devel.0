From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Wed, 10 Dec 2014 10:48:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46987 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932765AbaLJSsd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Dec 2014 13:48:33 -0500
In-Reply-To: <5488919E.4090109@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: cjwatson@debian.org, branto@redhat.com, osynge@suse.com, timm@fnal.gov, ceph-maintainers@ceph.com, ceph-devel@vger.kernel.org

+ceph-devel

On Wed, 10 Dec 2014, Ken Dreyer wrote:
> On 12/06/2014 01:54 PM, Sage Weil wrote:
> > Hi Colin, Boris, Owen,
> > 
> > We would like to choose a statically allocated uid and gid for use by Ceph 
> > storage servers.  The basic goals are:
> > 
> >  - run daemons as non-root (right now everything is uid 0 (runtime and 
> > on-disk data) and this is clearly not ideal)
> >  - enable hot swap of disks between storage servers
> >  - standardize across distros so that we can build clusters with a mix
> > 
> > To support the hot swap, we can't use the usual uids allocated dynamically 
> > during package installation.  Disks will completely filled with Ceph data 
> > files with the uid from one machine and will not be usable on another 
> > machine.
> > 
> > I'm hoping we can choose a static uid/gid pair that is unused for Debian 
> > (and Ubuntu), Fedora (and RHEL/CentOS), and OpenSUSE/SLES.  This will let 
> > us maintain consistency across the entire ecosystem.
> 
> How many system users should I request from the Fedora Packaging
> Committee, and what should their names be?
> 
> For example, are ceph-mon and ceph-osd going to run under the same
> non-privileged system account?

Hmm, my first impulse was to make a single user and group.  But it might 
make sense that e.g. rgw should run in a different context than ceph-osd 
or ceph-mon.

If we go down that road, then maybe

 ceph-osd
 ceph-mon
 ceph-mds
 ceph-rgw
 ceph-calamari

and a 'ceph' group that we can use for /var/log/ceph etc for the qemu 
and other librados users?

Alternatively, if we just do user+group ceph, then rgw can run as www-data 
or apache (as it does now).  Not sure what makes the most sense for 
ceph-calamari.

sage

