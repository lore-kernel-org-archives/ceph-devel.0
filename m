From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] rbd storage pool support for libvirt
Date: Thu, 18 Nov 2010 10:38:16 +0000
Message-ID: <20101118103816.GV15851@redhat.com>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net> <20101103135900.GQ29893@redhat.com> <Pine.LNX.4.64.1011051530100.21692@cobra.newdream.net> <20101108131634.GJ26714@redhat.com> <4CE47443.4000503@hq.newdream.net> <4CE489C2.2090003@hq.newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48816 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0KRKiq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Nov 2010 05:38:46 -0500
Content-Disposition: inline
In-Reply-To: <4CE489C2.2090003@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <joshd@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Wed, Nov 17, 2010 at 06:04:50PM -0800, Josh Durgin wrote:
> On 11/17/2010 04:33 PM, Josh Durgin wrote:
> >Hi Daniel,
> >
> >On 11/08/2010 05:16 AM, Daniel P. Berrange wrote:
> >>>>>In any case, before someone goes off and implements something, does
> >>>>>this
> >>>>>look like the right general approach to adding rbd support to libvirt?
> >>>>
> >>>>I think this looks reasonable. I'd be inclined to get the storage pool
> >>>>stuff working with the kernel RBD driver& UDEV rules for stable path
> >>>>names, since that avoids needing to make any changes to guest XML
> >>>>format. Support for QEMU with the native librados CEPH driver could
> >>>>be added as a second patch.
> >>>
> >>>Okay, that sounds reasonable. Supporting the QEMU librados driver is
> >>>definitely something we want to target, though, and seems to be route
> >>>that
> >>>more users are interested in. Is defining the XML syntax for a guest VM
> >>>something we can discuss now as well?
> >>>
> >>>(BTW this is biting NBD users too. Presumably the guest VM XML should
> >>>look similar?
> >>
> >>And also Sheepdog storage volumes. To define a syntax for all these we
> >>need
> >>to determine what configuration metadata is required at a per-VM level
> >>for
> >>each of them. Then try and decide how to represent that in the guest XML.
> >>It looks like at a VM level we'd need a hostname, port number and a
> >>volume
> >>name (or path).
> >
> >It looks like that's what Sheepdog needs from the patch that was
> >submitted earlier today. For RBD, we would want to allow multiple hosts,
> >and specify the pool and image name when the QEMU librados driver is
> >used, e.g.:
> >
> ><disk type="rbd" device="disk">
> ><driver name="qemu" type="raw" />
> ><source vdi="image_name" pool="pool_name">
> ><host name="mon1.example.org" port="6000">
> ><host name="mon2.example.org" port="6000">
> ><host name="mon3.example.org" port="6000">
> ></source>
> ><target dev="vda" bus="virtio" />
> ></disk>
> >
> >As you mentioned earlier, we could just use the existing source format
> >for the kernel RBD driver.
> >
> >Does this seem like a reasonable format for the VM XML? Any suggestions?
> 
> Also, it would be convenient to be able to specify which RBD driver to 
> use in the guest XML, so that it's independent of the libvirt pool 
> configuration. Would having two different rbd disk types be the right 
> approach here?

What do you mean by  RBD driver here ? kernel vs native QEMU ? If so,
the kernel case is trivially handled by the <disk type='block'> case,
so we only need new syntax for the native QEMU impl


Daniel
-- 
|: Red Hat, Engineering, London    -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org -o- http://virt-manager.org -o- http://deltacloud.org :|
|: http://autobuild.org        -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-   F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|
