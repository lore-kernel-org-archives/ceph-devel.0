From: "Don Talton (dotalton)" <dotalton@cisco.com>
Subject: RE: are there plans to move to a newer google perftools?
Date: Tue, 10 Dec 2013 01:47:13 +0000
Message-ID: <57ED724085B72141BB091CF1314E471F01817C6A@xmb-rcd-x15.cisco.com>
References: <57ED724085B72141BB091CF1314E471F01817C1A@xmb-rcd-x15.cisco.com>
 <alpine.DEB.2.00.1312091706520.13726@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alln-iport-8.cisco.com ([173.37.142.95]:27710 "EHLO
	alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab3LJBrO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Dec 2013 20:47:14 -0500
In-Reply-To: <alpine.DEB.2.00.1312091706520.13726@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Ceph Development (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

Hi Sage,

It's Ubuntu 12.04 LTS

Mongo wants to install libgoogle-perftools4, whereas ceph wants to install libgoogle-perftools0. 

This is leaving libgoogle-perftools0 in a broken state and, I'm assuming this is the cause, making ceph fault. Ceph works great before the installation of libgoogle-perftools4. 

This is with using mongo v2.4.6 and seemingly any version of ceph. I've tried bobtail, dumpling, and cuttlefish.

Dpkg status:
rc  libgoogle-perftools0
ii  libgoogle-perftools4

dpkg -p ceph:
Depends: binutils, ceph-common, cryptsetup-bin | cryptsetup, gdisk, parted, python, python-argparse, sdparm | hdparm, uuid-runtime, xfsprogs, libaio1 (>= 0.3.93), libboost-thread1.46.1 (>= 1.46.1-1), libc6 (>= 2.14), libgcc1 (>= 1:4.1.1), libgoogle-perftools0, libnspr4 (>= 1.8.0.10), libnss3 (>= 3.12.0~1.9b1), libsnappy1, libstdc++6 (>= 4.6), libuuid1 (>= 2.16)

It makes sense that ceph would use the latest, but it's exploding for me :)


> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com]
> Sent: Monday, December 09, 2013 6:07 PM
> To: Don Talton (dotalton)
> Cc: Ceph Development (ceph-devel@vger.kernel.org)
> Subject: Re: are there plans to move to a newer google perftools?
> 
> Hi Donald,
> 
> What exactly is the conflict?  And what distro?  I believe we should be using
> whatever version of the library is installed.
> 
> sage
> 
> On Tue, 10 Dec 2013, Don Talton (dotalton) wrote:
> 
> > I'm trying to package/install mongodb and ceph on the same server and
> there are conflict due to the version differences.
> >
> > Donald Talton
> > Systems Development Unit
> > dotalton@cisco.com
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> >
