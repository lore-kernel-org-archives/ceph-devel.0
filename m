From: Sage Weil <sweil@redhat.com>
Subject: Re: Breaks & Replaces in debian/control in backports
Date: Thu, 30 Jul 2015 05:25:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507300524200.22099@cobra.newdream.net>
References: <55AB89C4.50503@dachary.org> <55B9D202.8050805@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-157019502-1438259129=:22099"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56361 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbbG3MZa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Jul 2015 08:25:30 -0400
In-Reply-To: <55B9D202.8050805@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-157019502-1438259129=:22099
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 30 Jul 2015, Loic Dachary wrote:
> Hi,
> 
> What I proposed does not actually work because the package versions are not ceph-0.94.2 but ceph-0.94.2-1trusty ( https://github.com/ceph/ceph-build/blob/master/gen_debian_version.sh and https://github.com/ceph/ceph-build/blob/master/build_debs.sh#L35) and will therefore match the constraint and upgrading from ceph-0.94.2-1trusty to ceph=0.94.2-197-g1e841b0-1trusty or ceph=0.94.3-1trusty will not do the right thing:
> 
> 2015-07-29T22:06:05.579 INFO:teuthology.orchestra.run.ovh228114:Running: u'sudo DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install librbd1-dbg=0.94.2-197-g1e841b0-1trusty ceph=0.94.2-197-g1e841b0-1trusty ceph-test=0.94.2-197-g1e841b0-1trusty ceph-dbg=0.94.2-197-g1e841b0-1trusty rbd-fuse=0.94.2-197-g1e841b0-1trusty librados2-dbg=0.94.2-197-g1e841b0-1trusty ceph-fuse-dbg=0.94.2-197-g1e841b0-1trusty libcephfs-jni=0.94.2-197-g1e841b0-1trusty libcephfs1-dbg=0.94.2-197-g1e841b0-1trusty radosgw=0.94.2-197-g1e841b0-1trusty librados2=0.94.2-197-g1e841b0-1trusty libcephfs1=0.94.2-197-g1e841b0-1trusty ceph-mds=0.94.2-197-g1e841b0-1trusty radosgw-dbg=0.94.2-197-g1e841b0-1trusty librbd1=0.94.2-197-g1e841b0-1trusty py
 thon-ceph=0.94.2-197-g1e841b0-1trusty ceph-test-dbg=0.94.2-197-g1e841b0-1trusty ceph-fuse=0.94.2-197-g1e841b0-1trusty ceph-common=0.94.2-197-g1e841b0-1trusty libcephfs-java=0.94.2-197-g1e84!
 1b0-1trusty 
> ceph-common-dbg=0.94.2-197-g1e841b0-1trusty ceph-mds-dbg=0.94.2-197-g1e841b0-1trusty'
> 
> 2015-07-29T22:11:11.258 INFO:teuthology.orchestra.run.ovh228114.stderr:dpkg: error processing archive /var/cache/apt/archives/ceph-common_0.94.2-197-g1e841b0-1trusty_amd64.deb (--unpack):
> 2015-07-29T22:11:11.259 INFO:teuthology.orchestra.run.ovh228114.stderr: trying to overwrite '/usr/lib/python2.7/dist-packages/ceph_argparse.py', which is also in package ceph 0.94.2-1trusty
> 
> The release files found in ceph.com have a fixed prefix ( -1trusty, -1jessie, etc. ) if the version in Breaks and Replaces is -2 it will always be immediately greater. This is not what happens in Debian GNU/Linux or Ubuntu because the package is not part of the sources. When packaging for ceph.com repositories we are creating packages that are native (in the sense that modifying the package requires a new release of the sources because the packaging is part of the sources) but contrary to what is usually done with native packages, we append a -XXXX debian version which is supposed to be the version of the debian directory when it lives outside of the sources.
> 
> I filed http://tracker.ceph.com/issues/12529 as "Fix" : it's not a bug but would definitely make things easier to understand.
> 
> Please let me know if I got it right this time ;-)

Should we just drop the suffix?  I tried to match up with the backport 
suffixes (e.g., ~bpo70 for wheezy) so that when you did a dist-upgrade it 
would be able to pull in the next version.  It sounds like it's not 
worth it, though...

sage


> 
> Cheers
> 
> On 19/07/2015 13:28, Loic Dachary wrote:
> > Hi Ken,
> > 
> > In the context of https://github.com/ceph/ceph/pull/5206 we need to adapt the version constraints for the Breaks / Replaces in debian/control. What we currently do is something like x.y.z-vvv where we randomly pick vvv to be something we're sure won't be greater than the actual vvv from git-describe that will be associated to this specific commit (otherwise the constraints won't be satisfied and the install will break). 
> > 
> > When backporting it translates into something like:
> > 
> > Package: ceph
> > Depends: ceph-common (>= 0.94.2-23)
> > 
> > Package: ceph-common
> > Replaces: ceph-client-tools,
> > 	  ceph (<< 0.94.2-23),
> > Breaks: ceph (<< 0.94.2-23),
> > 
> > I propose instead we use the version of the previous stable release like so:
> > 
> > Package: ceph
> > Depends: ceph-common (>> 0.94.2)
> > 
> > Package: ceph-common
> > Replaces: ceph-client-tools,
> > 	  ceph (<= 0.94.2),
> > Breaks: ceph (<= 0.94.2),
> > 
> > I think it achieves the same thing and is less error prone in the case of backports. The risk is that upgrading from v0.94.2-34 to the version with this change will fail because the conditions are satisified (it thinks all versions after v0.94.2 have the change). But the odds of having a test machine with this specific version already installed are close to non-existent. The odds of us picking the wrong number and ending up with something that's either too high or too small are higher.
> > 
> > What do you think ?
> > 
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 
> 
--557981400-157019502-1438259129=:22099--
