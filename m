From: "Don Talton (dotalton)" <dotalton@cisco.com>
Subject: RE: are there plans to move to a newer google perftools?
Date: Tue, 10 Dec 2013 19:10:26 +0000
Message-ID: <57ED724085B72141BB091CF1314E471F01818E44@xmb-rcd-x15.cisco.com>
References: <57ED724085B72141BB091CF1314E471F01817C1A@xmb-rcd-x15.cisco.com>
 <alpine.DEB.2.00.1312091706520.13726@cobra.newdream.net>
 <57ED724085B72141BB091CF1314E471F01817C6A@xmb-rcd-x15.cisco.com>
 <57ED724085B72141BB091CF1314E471F01817C86@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:5371 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab3LJTK2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Dec 2013 14:10:28 -0500
In-Reply-To: <57ED724085B72141BB091CF1314E471F01817C86@xmb-rcd-x15.cisco.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Ceph Development (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

We repackaged dumpling using libgoogle-perftools4 and it does work, and does cohabitate with mongo.

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Don Talton (dotalton)
> Sent: Monday, December 09, 2013 6:53 PM
> To: Sage Weil
> Cc: Ceph Development (ceph-devel@vger.kernel.org)
> Subject: RE: are there plans to move to a newer google perftools?
> 
> I should add, I am using ceph deploy. Here is the output:
> 
> 
> 2013-12-09 18:42:58,340 [ceph][DEBUG ] The following packages have unmet
> dependencies:
> 2013-12-09 18:42:58,340 [ceph][DEBUG ]  ceph : Depends: libgoogle-
> perftools0 but it is not going to be installed
> 2013-12-09 18:42:58,340 [ceph][DEBUG ]  ceph-mds : Depends: libgoogle-
> perftools0 but it is not going to be installed
> 2013-12-09 18:42:58,341 [ceph][ERROR ] RuntimeError: command returned
> non-zero exit status: 100
> 2013-12-09 18:42:58,341 [ceph_deploy][ERROR ] RuntimeError: Failed to
> execute command: env DEBIAN_FRONTEND=noninteractive
> DEBIAN_PRIORITY=critical apt-get -q -o Dpkg::Options::=--force-confnew --
> no-install-recommends --assume-yes install -- ceph ceph-mds ceph-common
> ceph-fs-common gdisk
> 
> 
> 
> 
> 
> 
> 
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Don Talton (dotalton)
> > Sent: Monday, December 09, 2013 6:47 PM
> > To: Sage Weil
> > Cc: Ceph Development (ceph-devel@vger.kernel.org)
> > Subject: RE: are there plans to move to a newer google perftools?
> >
> > Hi Sage,
> >
> > It's Ubuntu 12.04 LTS
> >
> > Mongo wants to install libgoogle-perftools4, whereas ceph wants to
> > install libgoogle-perftools0.
> >
> > This is leaving libgoogle-perftools0 in a broken state and, I'm
> > assuming this is the cause, making ceph fault. Ceph works great before
> > the installation of libgoogle-perftools4.
> >
> > This is with using mongo v2.4.6 and seemingly any version of ceph.
> > I've tried bobtail, dumpling, and cuttlefish.
> >
> > Dpkg status:
> > rc  libgoogle-perftools0
> > ii  libgoogle-perftools4
> >
> > dpkg -p ceph:
> > Depends: binutils, ceph-common, cryptsetup-bin | cryptsetup, gdisk,
> > parted, python, python-argparse, sdparm | hdparm, uuid-runtime,
> > xfsprogs, libaio1 (>= 0.3.93), libboost-thread1.46.1 (>= 1.46.1-1),
> > libc6 (>= 2.14), libgcc1 (>= 1:4.1.1), libgoogle-perftools0, libnspr4
> > (>= 1.8.0.10), libnss3 (>= 3.12.0~1.9b1), libsnappy1, libstdc++6 (>=
> > 4.6), libuuid1 (>= 2.16)
> >
> > It makes sense that ceph would use the latest, but it's exploding for
> > me :)
> >
> >
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sage@inktank.com]
> > > Sent: Monday, December 09, 2013 6:07 PM
> > > To: Don Talton (dotalton)
> > > Cc: Ceph Development (ceph-devel@vger.kernel.org)
> > > Subject: Re: are there plans to move to a newer google perftools?
> > >
> > > Hi Donald,
> > >
> > > What exactly is the conflict?  And what distro?  I believe we should
> > > be using whatever version of the library is installed.
> > >
> > > sage
> > >
> > > On Tue, 10 Dec 2013, Don Talton (dotalton) wrote:
> > >
> > > > I'm trying to package/install mongodb and ceph on the same server
> > > > and
> > > there are conflict due to the version differences.
> > > >
> > > > Donald Talton
> > > > Systems Development Unit
> > > > dotalton@cisco.com
> > > >
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > > in the body of a message to majordomo@vger.kernel.org More
> > > majordomo
> > > > info at  http://vger.kernel.org/majordomo-info.html
> > > >
> > > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
