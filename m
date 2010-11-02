From: Wido den Hollander <wido@widodh.nl>
Subject: Re: rbd storage pool support for libvirt
Date: Tue, 02 Nov 2010 20:50:09 +0100
Message-ID: <1288727409.2284.162.camel@wido-laptop.pcextreme.nl>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net>
	 <1288727271.2284.161.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:56934 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab0KBTuK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Nov 2010 15:50:10 -0400
Received: from [79.99.132.153] (unknown [79.99.132.153])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id C2BA241547
	for <ceph-devel@vger.kernel.org>; Tue,  2 Nov 2010 20:50:09 +0100 (CET)
In-Reply-To: <1288727271.2284.161.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Seems there was somebody recently with the same problem:
http://www.redhat.com/archives/libvir-list/2010-October/msg01247.html

NBD seems to be suffering from the same limitations as RBD.

On Tue, 2010-11-02 at 20:47 +0100, Wido den Hollander wrote:
> Hi,
> 
> I've given this a try a few months ago, what I found out that there is a
> difference between a storage pool and a disk declaration in libvirt.
> 
> I'll take the LVM storage pool as an example:
> 
> In src/storage you will find storage_backend_logical.c|h, these are
> simple "wrappers" around the LVM commands like lvcreate, lvremove, etc,
> etc.
> 
> 
> static int
> virStorageBackendLogicalDeleteVol(virConnectPtr conn ATTRIBUTE_UNUSED,
>                                   virStoragePoolObjPtr pool
> ATTRIBUTE_UNUSED,
>                                   virStorageVolDefPtr vol,
>                                   unsigned int flags ATTRIBUTE_UNUSED)
> {
>     const char *cmdargv[] = {
>         LVREMOVE, "-f", vol->target.path, NULL
>     };
> 
>     if (virRun(cmdargv, NULL) < 0)
>         return -1;
> 
>     return 0;
> }
> 
> 
> virStorageBackend virStorageBackendLogical = {
>     .type = VIR_STORAGE_POOL_LOGICAL,
> 
>     ....
>     ....
>     ....
>     .deleteVol = virStorageBackendLogicalDeleteVol,
>     ....
> };
> 
> As you can see, libvirt simply calls "lvremove" to remove the command,
> but this does not help you mapping the LV to a virtual machine, it's
> just a mechanism to manage your storage via libvirt, as you can do with
> Virt-Manager (which uses libvirt)
> 
> Below you find two screenshots how this works in Virt Manager, as you
> can see, you can manage your VG's and attach LV's to a Virtual Machine.
> 
> * http://zooi.widodh.nl/ceph/qemu-kvm/screenshots/storage_allocation.png
> *
> http://zooi.widodh.nl/ceph/qemu-kvm/screenshots/storage_manager_virt.png
> 
> Note, this is Virt Manager and not libvirt, but it uses libvirt you
> perform these actions.
> 
> On the CLI you have for example: vol-create, vol-delete, pool-create,
> pool-delete
> 
> But, there is no special disk format for a LV, in my XML there is:
> 
>     <disk type='block' device='disk'>
>       <source dev='/dev/xen-domains/v3-root'/>
>       <target dev='sda' bus='scsi'/>
>     </disk>
> 
> So libvirt somehow reads "source dev" and maps this back to a VG and LV.
> 
> A storage manager for RBD would simply mean implementing wrap functions
> around the "rbd" binary and parsing output from it.
> 
> Implementing RBD support in libvirt would then mean two things:
> 
> 1. Storage manager in libvirt
> 2. A special disk format for RBD
> 
> The first one is done as I explained above, but for the second one, I'm
> not sure how you could do that.
> 
> Libvirt now expects a disk to always be a file/block, the virtual disks
> like RBD and NBD are not supported.
> 
> For #2 we should have a "special" disk declaration format, like
> mentioned on the RedHat mailinglist:
> 
> http://www.redhat.com/archives/libvir-list/2010-June/msg00300.html
> 
> <disk type='rbd' device='disk'>
>   <driver name='qemu' type='raw' />
>   <source pool='rbd' image='alpha' />
>   <target dev='vda' bus='virtio' />
> </disk>
> 
> As images on a RBD image are always "raw", it might seem obsolete to
> define this, but newer version of Qemu don't autodetect formats.
> 
> Defining a monitor in the disk declaration won't be possible I think, I
> don't see a way to get that parameter down to librados, so we need a
> valid /etc/ceph/ceph.conf
> 
> Now, I'm not a libvirt expert, this is what I found in my search.
> 
> Any suggestions / thoughts about this?
> 
> Thanks,
> 
> Wido
> 
> On Mon, 2010-11-01 at 20:52 -0700, Sage Weil wrote:
> > Hi,
> > 
> > We've been working on RBD, a distributed block device backed by the Ceph 
> > distributed object store.  (Ceph is a highly scalable, fault tolerant 
> > distributed storage and file system; see http://ceph.newdream.net.)  
> > Although the Ceph file system client has been in Linux since 2.6.34, the 
> > RBD block device was just merged for 2.6.37.  We also have patches pending 
> > for Qemu that use librados to natively talk to the Ceph storage backend, 
> > avoiding any kernel dependency.
> > 
> > To support disks backed by RBD in libvirt, we originally proposed a 
> > 'virtual' type that simply passed the configuration information through to 
> > qemu, but that idea was shot down for a variety of reasons:
> > 
> > 	http://www.redhat.com/archives/libvir-list/2010-June/thread.html#00257
> > 
> > It sounds like the "right" approach is to create a storage pool type.  
> > Ceph also has a 'pool' concept that contains some number of RBD images and 
> > a command line tool to manipulate (create, destroy, resize, rename, 
> > snapshot, etc.) those images, which seems to map nicely onto the storage 
> > pool abstraction.  For example,
> > 
> >  $ rbd create foo -s 1000
> >  rbd image 'foo':
> >          size 1000 MB in 250 objects
> >          order 22 (4096 KB objects)
> >  adding rbd image to directory...
> >   creating rbd image...
> >  done.
> >  $ rbd create bar -s 10000
> >  [...]
> >  $ rbd list
> >  bar
> >  foo
> > 
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
> > 
> > or whatever (I'm not too familiar with the libvirt schema)?  One 
> > difference between the existing pool types listed at 
> > libvirt.org/storage.html is that RBD does not necessarily associate itself 
> > with a path in the local file system.  If the native qemu driver is used, 
> > there is no path involved, just a magic string passed to qemu 
> > (rbd:poolname/imagename).  If the kernel RBD driver is used, it gets 
> > mapped to a /dev/rbd/$n (or similar, depending on the udev rule), but $n 
> > is not static across reboots.
> > 
> > In any case, before someone goes off and implements something, does this 
> > look like the right general approach to adding rbd support to libvirt?
> > 
> > Thanks!
> > sage
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

