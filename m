From: Wido den Hollander <wido@widodh.nl>
Subject: Re: v0.24 released
Date: Tue, 21 Dec 2010 09:49:34 +0100
Message-ID: <1292921374.2297.4.camel@wido-desktop>
References: <Pine.LNX.4.64.1012201828110.29684@cobra.newdream.net>
	 <AANLkTikz3=Zbf09F9brLcT2FxWyVwOFq+oVRgaszHsoa@mail.gmail.com>
	 <1292920563.2297.2.camel@wido-desktop>
	 <AANLkTik91T8uLte6eYcpo-eq2ikPQJ-gxrHdu060GiWz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:33405 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757555Ab0LUItf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Dec 2010 03:49:35 -0500
Received: from [192.168.6.106] (cable-191-148.zeelandnet.nl [82.176.191.148])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 26A5576383
	for <ceph-devel@vger.kernel.org>; Tue, 21 Dec 2010 09:49:34 +0100 (CET)
In-Reply-To: <AANLkTik91T8uLte6eYcpo-eq2ikPQJ-gxrHdu060GiWz@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Sassy,

No, there is:

Build-Depends: debhelper (>= 6.0.7~), .., .., libcrypto++-dev

The build package then figures out which libcrypto library the resulting
packages have to depend on. (Like you said)

So this should now be a show stopper for building under Ubuntu 10.10

Wido

On Tue, 2010-12-21 at 10:46 +0200, Sassy Natan wrote:
> Wido,
> It depend if the libcrypto++X is not hard coded in the control file.
> 
> If not, and the control file is dynamically built, then the build will be fine
> if yes, please grep all file under the Debian folder to see if u have
> the libcrypto++7 hard coded somewhere then rebuild as Wido suggested.
> 
> Sassy
> 
> On Tue, Dec 21, 2010 at 10:36 AM, Wido den Hollander <wido@widodh.nl> wrote:
> > Hi Ravi,
> >
> > Indeed, Ubuntu 10.10 has the libcrypto++8 package, but you could always
> > build from the source, not that hard.
> >
> > apt-get install dpkg-dev
> > git clone git://ceph.newdream.net/git/ceph.git
> > cd ceph
> > git checkout -b rc origin/rc
> > dpkg-buildpackage
> >
> > It will then need some dependencies, just install those. Afterwards you
> > should end up with a few nice .deb files!
> >
> > Wido
> >
> > On Mon, 2010-12-20 at 21:15 -0800, Ravi Pinjala wrote:
> >> The debian package doesn't install on ubuntu 10.10 - it depends on
> >> libcrypto++7, which seems not to be available anymore. (Makes me miss
> >> Gentoo :( )
> >>
> >> --Ravi
> >>
> >> On Mon, Dec 20, 2010 at 6:28 PM, Sage Weil <sage@newdream.net> wrote:
> >> > We've released v0.24, just in time for the holidays!  Big changes this
> >> > time around include:
> >> >
> >> >  * mds: many fixes with clustered failure recovery
> >> >  * mds: bloom filter to reduce directory reads
> >> >  * mds: configurable directory hash functions (for fragmentation)
> >> >  * rbd: import/export tools are smart about holes (i.e., use FIEMAP)
> >> >  * osd: many recovery improvements, mostly making data available more
> >> >   quickly
> >> >  * osd: automatic background scrubbing when load is low
> >> >  * osd: fixes with dedicated backend replication network
> >> >  * osd: use new (2.6.37) btrfs ioctls for async snapshot creation
> >> >  * replaced openssl dependency with libcrypto++ (licensing issue)
> >> >  * librados: "zero-copy" reads
> >> >  * misc bug fixes, man pages, and code cleanup
> >> >
> >> > The focus for the next release (v0.25) is on OSD and MDS stability,
> >> > directory fragmentation recovery, and fsck preliminaries; see the roadmap
> >> > for more details.
> >> >
> >> > Relevant URLs:
> >> >  * Direct download at: http://ceph.newdream.net/download/ceph-0.24.tar.gz
> >> >  * For Debian packages, see http://ceph.newdream.net/wiki/Debian
> >> >
> >> > sage
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

