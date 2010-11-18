From: Sage Weil <sage@newdream.net>
Subject: Re: [libvirt] rbd storage pool support for libvirt
Date: Thu, 18 Nov 2010 09:13:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011180905001.2270@cobra.newdream.net>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net>
 <20101103135900.GQ29893@redhat.com> <Pine.LNX.4.64.1011051530100.21692@cobra.newdream.net>
 <20101108131634.GJ26714@redhat.com> <4CE47443.4000503@hq.newdream.net>
 <20101118104214.GW15851@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36307 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441Ab0KRRJ2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Nov 2010 12:09:28 -0500
In-Reply-To: <20101118104214.GW15851@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Josh Durgin <joshd@hq.newdream.net>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Thu, 18 Nov 2010, Daniel P. Berrange wrote:
> On Wed, Nov 17, 2010 at 04:33:07PM -0800, Josh Durgin wrote:
> > Hi Daniel,
> > 
> > On 11/08/2010 05:16 AM, Daniel P. Berrange wrote:
> > >>>>In any case, before someone goes off and implements something, does this
> > >>>>look like the right general approach to adding rbd support to libvirt?
> > >>>
> > >>>I think this looks reasonable. I'd be inclined to get the storage pool
> > >>>stuff working with the kernel RBD driver&  UDEV rules for stable path
> > >>>names, since that avoids needing to make any changes to guest XML
> > >>>format. Support for QEMU with the native librados CEPH driver could
> > >>>be added as a second patch.
> > >>
> > >>Okay, that sounds reasonable.  Supporting the QEMU librados driver is
> > >>definitely something we want to target, though, and seems to be route that
> > >>more users are interested in.  Is defining the XML syntax for a guest VM
> > >>something we can discuss now as well?
> > >>
> > >>(BTW this is biting NBD users too.  Presumably the guest VM XML should
> > >>look similar?
> > >
> > >And also Sheepdog storage volumes. To define a syntax for all these we need
> > >to determine what configuration metadata is required at a per-VM level for
> > >each of them. Then try and decide how to represent that in the guest XML.
> > >It looks like at a VM level we'd need a hostname, port number and a volume
> > >name (or path).
> > 
> > It looks like that's what Sheepdog needs from the patch that was
> > submitted earlier today. For RBD, we would want to allow multiple hosts,
> > and specify the pool and image name when the QEMU librados driver is
> > used, e.g.:
> > 
> >     <disk type="rbd" device="disk">
> >       <driver name="qemu" type="raw" />
> >       <source vdi="image_name" pool="pool_name">
> >         <host name="mon1.example.org" port="6000">
> >         <host name="mon2.example.org" port="6000">
> >         <host name="mon3.example.org" port="6000">
> >       </source>
> >       <target dev="vda" bus="virtio" />
> >     </disk>
> > 
> > Does this seem like a reasonable format for the VM XML? Any suggestions?
> 
> I'm basically wondering whether we should be going for separate types for
> each of NBD, RBD & Sheepdog, as per your proposal & the sheepdog one earlier
> today. Or type to merge them into one type 'nework' which covers any kind of
> network block device, and list a protocol on the  source element, eg
> 
>      <disk type="network" device="disk">
>        <driver name="qemu" type="raw" />
>        <source protocol='rbd|sheepdog|nbd' name="...some image identifier...">
>          <host name="mon1.example.org" port="6000">
>          <host name="mon2.example.org" port="6000">
>          <host name="mon3.example.org" port="6000">
>        </source>
>        <target dev="vda" bus="virtio" />
>      </disk>

That would work...

One thing that I think should be considered, though, is that both RBD and 
NBD can be used for non-qemu instances by mapping a regular block device 
via the host's kernel.  And in that case, there's some sysfs-fu (at least 
in the rbd case; I'm not familiar with how the nbd client works) required 
to set up/tear down the block device.

I think the ideal would be if either method (qemu or kernel driver) could 
be used, and libvirt could take care of that process of setting up the 
block device so that RBD (and/or NBD) can be used with non-qemu instances. 
If that means totally separate <disk> descriptions for the two scenarios, 
that's fine, as long as there's a way for a storage pool driver to be used 
to set up both types of mappings...

sage
