From: Sage Weil <sage@newdream.net>
Subject: Re: [libvirt] rbd storage pool support for libvirt
Date: Fri, 5 Nov 2010 16:33:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1011051530100.21692@cobra.newdream.net>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net>
 <20101103135900.GQ29893@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59020 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab0KEXaL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Nov 2010 19:30:11 -0400
In-Reply-To: <20101103135900.GQ29893@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

Hi Daniel,

On Wed, 3 Nov 2010, Daniel P. Berrange wrote:
> > Ceph also has a 'pool' concept that contains some number of RBD images and 
> > a command line tool to manipulate (create, destroy, resize, rename, 
> > snapshot, etc.) those images, which seems to map nicely onto the storage 
> > pool abstraction.  For example,
> 
> Agreed, it does look like it'd map in quite well and let the RDB
> functionality more or less 'just work' in virt-manager & other 
> apps using storage pool APIs.

Great!

> > Something along the lines of
> > 
> >  <pool type="rbd">
> >    <name>virtimages</name>
> >    <source mode="kernel">
> >      <host monitor="ceph-mon1.domain.com:6789"/>
> >      <host monitor="ceph-mon2.domain.com:6789"/>
> >      <host monitor="ceph-mon3.domain.com:6789"/>
> >      <pool name="rbd"/>
> >    </source>
> >  </pool>
> 
> What do the 3 hostnames represent in this context ?

They're the host(s) that RBD needs to be fed to talk to the storage 
cluster.  Ideally there's more than one for redundancy. Does the above 
syntax look reasonable, or is there something you would propose instead?  
From the RBD side of things, the key parameters are

 - pool name
 - monitor address(es)
 - user and secret key to authenticate with

If the 'rbd' command line tool is used for this, everything but the pool 
can come out of the default /etc/ceph/ceph.conf config file, or we could
have a way to specify a config path in the XML.

> > or whatever (I'm not too familiar with the libvirt schema)?  One 
> > difference between the existing pool types listed at 
> > libvirt.org/storage.html is that RBD does not necessarily associate itself 
> > with a path in the local file system.  If the native qemu driver is used, 
> > there is no path involved, just a magic string passed to qemu 
> > (rbd:poolname/imagename).  If the kernel RBD driver is used, it gets 
> > mapped to a /dev/rbd/$n (or similar, depending on the udev rule), but $n 
> > is not static across reboots.
> 
> The docs about storage pool are slightly inaccurate. While it is
> desirable that the storage volume path exists on the filesystem,
> it is not something we strictly require. The only require that
> there is some way to map from the storage volume path to the
> corresponding guest XML
> 
> If we define a new guest XML syntax for RBD magic strings, then
> we can also define a storage pool that provides path data in a
> corresponding format.

Ok thanks, that clarifies things.
 
> WRT to the issue of /dev/rbd/$n being unstable, this is quite similar
> to the issue of /dev/sdXX device names being unstable for SCSI. The
> way to cope with this is to drop in a UDEV ruleset that creates 
> symlinks with sensible names, eg perhaps setup symlinks for: 
> 
>   /dev/disk/by-id/rbd-$poolname-$imagename -> /dev/rbd/0
> 
> It might also make sense to wire up /dev/disk/by-path symlinks
> for RBD devices.

We're putting together some udev rules to do this.

> > In any case, before someone goes off and implements something, does this 
> > look like the right general approach to adding rbd support to libvirt?
> 
> I think this looks reasonable. I'd be inclined to get the storage pool
> stuff working with the kernel RBD driver & UDEV rules for stable path
> names, since that avoids needing to make any changes to guest XML
> format. Support for QEMU with the native librados CEPH driver could
> be added as a second patch.

Okay, that sounds reasonable.  Supporting the QEMU librados driver is 
definitely something we want to target, though, and seems to be route that 
more users are interested in.  Is defining the XML syntax for a guest VM 
something we can discuss now as well?

(BTW this is biting NBD users too.  Presumably the guest VM XML should 
look similar?

http://www.redhat.com/archives/libvir-list/2010-October/msg01247.html
)

Thanks!
sage
