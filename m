From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] rbd storage pool support for libvirt
Date: Thu, 18 Nov 2010 10:42:14 +0000
Message-ID: <20101118104214.GW15851@redhat.com>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net> <20101103135900.GQ29893@redhat.com> <Pine.LNX.4.64.1011051530100.21692@cobra.newdream.net> <20101108131634.GJ26714@redhat.com> <4CE47443.4000503@hq.newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51804 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756376Ab0KRKmW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Nov 2010 05:42:22 -0500
Content-Disposition: inline
In-Reply-To: <4CE47443.4000503@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <joshd@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Wed, Nov 17, 2010 at 04:33:07PM -0800, Josh Durgin wrote:
> Hi Daniel,
> 
> On 11/08/2010 05:16 AM, Daniel P. Berrange wrote:
> >>>>In any case, before someone goes off and implements something, does this
> >>>>look like the right general approach to adding rbd support to libvirt?
> >>>
> >>>I think this looks reasonable. I'd be inclined to get the storage pool
> >>>stuff working with the kernel RBD driver&  UDEV rules for stable path
> >>>names, since that avoids needing to make any changes to guest XML
> >>>format. Support for QEMU with the native librados CEPH driver could
> >>>be added as a second patch.
> >>
> >>Okay, that sounds reasonable.  Supporting the QEMU librados driver is
> >>definitely something we want to target, though, and seems to be route that
> >>more users are interested in.  Is defining the XML syntax for a guest VM
> >>something we can discuss now as well?
> >>
> >>(BTW this is biting NBD users too.  Presumably the guest VM XML should
> >>look similar?
> >
> >And also Sheepdog storage volumes. To define a syntax for all these we need
> >to determine what configuration metadata is required at a per-VM level for
> >each of them. Then try and decide how to represent that in the guest XML.
> >It looks like at a VM level we'd need a hostname, port number and a volume
> >name (or path).
> 
> It looks like that's what Sheepdog needs from the patch that was
> submitted earlier today. For RBD, we would want to allow multiple hosts,
> and specify the pool and image name when the QEMU librados driver is
> used, e.g.:
> 
>     <disk type="rbd" device="disk">
>       <driver name="qemu" type="raw" />
>       <source vdi="image_name" pool="pool_name">
>         <host name="mon1.example.org" port="6000">
>         <host name="mon2.example.org" port="6000">
>         <host name="mon3.example.org" port="6000">
>       </source>
>       <target dev="vda" bus="virtio" />
>     </disk>
> 
> Does this seem like a reasonable format for the VM XML? Any suggestions?

I'm basically wondering whether we should be going for separate types for
each of NBD, RBD & Sheepdog, as per your proposal & the sheepdog one earlier
today. Or type to merge them into one type 'nework' which covers any kind of
network block device, and list a protocol on the  source element, eg

     <disk type="network" device="disk">
       <driver name="qemu" type="raw" />
       <source protocol='rbd|sheepdog|nbd' name="...some image identifier...">
         <host name="mon1.example.org" port="6000">
         <host name="mon2.example.org" port="6000">
         <host name="mon3.example.org" port="6000">
       </source>
       <target dev="vda" bus="virtio" />
     </disk>


Regards,
Daniel
-- 
|: Red Hat, Engineering, London    -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org -o- http://virt-manager.org -o- http://deltacloud.org :|
|: http://autobuild.org        -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-   F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|
