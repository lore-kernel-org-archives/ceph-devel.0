From: Sage Weil <sage@inktank.com>
Subject: Re: Understanding Ceph
Date: Sat, 19 Jan 2013 10:16:10 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com>
 <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59380 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab3ASSQL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 13:16:11 -0500
In-Reply-To: <50FAE116.2010504@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Cc: Peter Smith <peterfruits@gmail.com>, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>, ceph-devel@vger.kernel.org

On Sat, 19 Jan 2013, Jeff Mitchell wrote:
> Sage Weil wrote:
> > On Sun, 20 Jan 2013, Peter Smith wrote:
> > > Thanks for the reply, Sage and everyone.
> > > 
> > > Sage, so I can expect Ceph-rbd works well on Centos 6.3 if I only use
> > > it as the Cinder volume backend because the librbd in QEMU doesn't
> > > make use of kernel client, right?
> > 
> > Then the dependency is on the qemu version.  I don't remember that off the
> > top of my head, or know what version rhel6 ships.  Most people deploying
> > openstack and rbd are using a more modern distro (like ubuntu 12.04).
> 
> This discussion has made me curious: I'm using Ganeti to manage VMs, which
> manages the storage using the kernel client and passes in the dev device to
> qemu.
> 
> Can you comment on any known performance differences between the two methods
> -- native qemu+librbd creating a block device vs. the kernel client creating a
> block device?

librbd is faster-paced and has more features, including client-side 
caching (analogous to the cache in a hard drive), discard, and support for 
image cloning.  It tends to perform better.

The kernel client can be combined with FlashCache or something similar, 
although that isn't something we've tested.

We generally recommend the KVM+librbd route, as it is easier to manage the 
dependencies, and is well integrated with libvirt.  FWIW this is what 
OpenStack and CloudStack normally use.

sage
