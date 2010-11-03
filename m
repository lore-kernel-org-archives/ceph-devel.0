From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] rbd storage pool support for libvirt
Date: Wed, 3 Nov 2010 13:59:00 +0000
Message-ID: <20101103135900.GQ29893@redhat.com>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50123 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488Ab0KCN7I (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Nov 2010 09:59:08 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Mon, Nov 01, 2010 at 08:52:05PM -0700, Sage Weil wrote:
> Hi,
> 
> We've been working on RBD, a distributed block device backed by the Ceph 
> distributed object store.  (Ceph is a highly scalable, fault tolerant 
> distributed storage and file system; see http://ceph.newdream.net.)  
> Although the Ceph file system client has been in Linux since 2.6.34, the 
> RBD block device was just merged for 2.6.37.  We also have patches pending 
> for Qemu that use librados to natively talk to the Ceph storage backend, 
> avoiding any kernel dependency.
> 
> To support disks backed by RBD in libvirt, we originally proposed a 
> 'virtual' type that simply passed the configuration information through to 
> qemu, but that idea was shot down for a variety of reasons:
> 
> 	http://www.redhat.com/archives/libvir-list/2010-June/thread.html#00257

NB, I'm not against adding new disk types to the guest XML, just
that each type should be explicitly modelled, rather than being
lumped under a generic 'virtual' type.
 
> It sounds like the "right" approach is to create a storage pool type.  

Sort of. There's really two separate aspects to handling storage
in libvirt

 1. How do you configure a VM to use a storage volume
 2. How do you list/create/delete storage volumes

The XML addition proposed in the mailing list post above is attempting
to cater for the first aspect. The storage pool type idea you're 
describing in this post is catering to the second aspect. 

If the storage pool ends up providing real block devices that exist
on the filesystem, then the first item is trivially solved, because
libvirt can already point any guest at a block device. If the storage
pool provides some kind of virtual device, then we'd still need to
decide how to deal with the XML for configuring the guest VM.

> Ceph also has a 'pool' concept that contains some number of RBD images and 
> a command line tool to manipulate (create, destroy, resize, rename, 
> snapshot, etc.) those images, which seems to map nicely onto the storage 
> pool abstraction.  For example,

Agreed, it does look like it'd map in quite well and let the RDB
functionality more or less 'just work' in virt-manager & other 
apps using storage pool APIs.

>  $ rbd create foo -s 1000
>  rbd image 'foo':
>          size 1000 MB in 250 objects
>          order 22 (4096 KB objects)
>  adding rbd image to directory...
>   creating rbd image...
>  done.
>  $ rbd create bar -s 10000
>  [...]
>  $ rbd list
>  bar
>  foo
> 
> Something along the lines of
> 
>  <pool type="rbd">
>    <name>virtimages</name>
>    <source mode="kernel">
>      <host monitor="ceph-mon1.domain.com:6789"/>
>      <host monitor="ceph-mon2.domain.com:6789"/>
>      <host monitor="ceph-mon3.domain.com:6789"/>
>      <pool name="rbd"/>
>    </source>
>  </pool>

What do the 3 hostnames represent in this context ?

> or whatever (I'm not too familiar with the libvirt schema)?  One 
> difference between the existing pool types listed at 
> libvirt.org/storage.html is that RBD does not necessarily associate itself 
> with a path in the local file system.  If the native qemu driver is used, 
> there is no path involved, just a magic string passed to qemu 
> (rbd:poolname/imagename).  If the kernel RBD driver is used, it gets 
> mapped to a /dev/rbd/$n (or similar, depending on the udev rule), but $n 
> is not static across reboots.

The docs about storage pool are slightly inaccurate. While it is
desirable that the storage volume path exists on the filesystem,
it is not something we strictly require. The only require that
there is some way to map from the storage volume path to the
corresponding guest XML

If we define a new guest XML syntax for RBD magic strings, then
we can also define a storage pool that provides path data in a
corresponding format.

WRT to the issue of /dev/rbd/$n being unstable, this is quite similar
to the issue of /dev/sdXX device names being unstable for SCSI. The
way to cope with this is to drop in a UDEV ruleset that creates 
symlinks with sensible names, eg perhaps setup symlinks for: 

  /dev/disk/by-id/rbd-$poolname-$imagename -> /dev/rbd/0

It might also make sense to wire up /dev/disk/by-path symlinks
for RBD devices.

> In any case, before someone goes off and implements something, does this 
> look like the right general approach to adding rbd support to libvirt?

I think this looks reasonable. I'd be inclined to get the storage pool
stuff working with the kernel RBD driver & UDEV rules for stable path
names, since that avoids needing to make any changes to guest XML
format. Support for QEMU with the native librados CEPH driver could
be added as a second patch.

Regards,
Daniel
-- 
|: Red Hat, Engineering, London    -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org -o- http://virt-manager.org -o- http://deltacloud.org :|
|: http://autobuild.org        -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-   F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|
