From: Wido den Hollander <wido@widodh.nl>
Subject: Re: v0.24 released
Date: Tue, 21 Dec 2010 09:36:03 +0100
Message-ID: <1292920563.2297.2.camel@wido-desktop>
References: <Pine.LNX.4.64.1012201828110.29684@cobra.newdream.net>
	 <AANLkTikz3=Zbf09F9brLcT2FxWyVwOFq+oVRgaszHsoa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51998 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932695Ab0LUIgH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Dec 2010 03:36:07 -0500
In-Reply-To: <AANLkTikz3=Zbf09F9brLcT2FxWyVwOFq+oVRgaszHsoa@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ravi Pinjala <pstatic@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Ravi,

Indeed, Ubuntu 10.10 has the libcrypto++8 package, but you could always
build from the source, not that hard.

apt-get install dpkg-dev
git clone git://ceph.newdream.net/git/ceph.git
cd ceph
git checkout -b rc origin/rc
dpkg-buildpackage

It will then need some dependencies, just install those. Afterwards you
should end up with a few nice .deb files!

Wido

On Mon, 2010-12-20 at 21:15 -0800, Ravi Pinjala wrote:
> The debian package doesn't install on ubuntu 10.10 - it depends on
> libcrypto++7, which seems not to be available anymore. (Makes me miss
> Gentoo :( )
> 
> --Ravi
> 
> On Mon, Dec 20, 2010 at 6:28 PM, Sage Weil <sage@newdream.net> wrote:
> > We've released v0.24, just in time for the holidays!  Big changes this
> > time around include:
> >
> >  * mds: many fixes with clustered failure recovery
> >  * mds: bloom filter to reduce directory reads
> >  * mds: configurable directory hash functions (for fragmentation)
> >  * rbd: import/export tools are smart about holes (i.e., use FIEMAP)
> >  * osd: many recovery improvements, mostly making data available more
> >   quickly
> >  * osd: automatic background scrubbing when load is low
> >  * osd: fixes with dedicated backend replication network
> >  * osd: use new (2.6.37) btrfs ioctls for async snapshot creation
> >  * replaced openssl dependency with libcrypto++ (licensing issue)
> >  * librados: "zero-copy" reads
> >  * misc bug fixes, man pages, and code cleanup
> >
> > The focus for the next release (v0.25) is on OSD and MDS stability,
> > directory fragmentation recovery, and fsck preliminaries; see the roadmap
> > for more details.
> >
> > Relevant URLs:
> >  * Direct download at: http://ceph.newdream.net/download/ceph-0.24.tar.gz
> >  * For Debian packages, see http://ceph.newdream.net/wiki/Debian
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

