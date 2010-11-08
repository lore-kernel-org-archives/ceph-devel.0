From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] rbd storage pool support for libvirt
Date: Mon, 8 Nov 2010 13:16:34 +0000
Message-ID: <20101108131634.GJ26714@redhat.com>
References: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net> <20101103135900.GQ29893@redhat.com> <Pine.LNX.4.64.1011051530100.21692@cobra.newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59719 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771Ab0KHNQm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Nov 2010 08:16:42 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1011051530100.21692@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Fri, Nov 05, 2010 at 04:33:46PM -0700, Sage Weil wrote:
> On Wed, 3 Nov 2010, Daniel P. Berrange wrote:
> > > Something along the lines of
> > > 
> > >  <pool type="rbd">
> > >    <name>virtimages</name>
> > >    <source mode="kernel">
> > >      <host monitor="ceph-mon1.domain.com:6789"/>
> > >      <host monitor="ceph-mon2.domain.com:6789"/>
> > >      <host monitor="ceph-mon3.domain.com:6789"/>
> > >      <pool name="rbd"/>
> > >    </source>
> > >  </pool>
> > 
> > What do the 3 hostnames represent in this context ?
> 
> They're the host(s) that RBD needs to be fed to talk to the storage 
> cluster.  Ideally there's more than one for redundancy. Does the above 
> syntax look reasonable, or is there something you would propose instead?  
> From the RBD side of things, the key parameters are
> 
>  - pool name
>  - monitor address(es)
>  - user and secret key to authenticate with
> 
> If the 'rbd' command line tool is used for this, everything but the pool 
> can come out of the default /etc/ceph/ceph.conf config file, or we could
> have a way to specify a config path in the XML.

It makes sense to allow the hostname in the XML, because the general
goal is that you should be able to configure storage without needing
to SSH into a machine & manually setup config files. The XML does not
currently allow multiple hosts, but we can extend that. 

The pool name / user / key are already covered.

> > > In any case, before someone goes off and implements something, does this 
> > > look like the right general approach to adding rbd support to libvirt?
> > 
> > I think this looks reasonable. I'd be inclined to get the storage pool
> > stuff working with the kernel RBD driver & UDEV rules for stable path
> > names, since that avoids needing to make any changes to guest XML
> > format. Support for QEMU with the native librados CEPH driver could
> > be added as a second patch.
> 
> Okay, that sounds reasonable.  Supporting the QEMU librados driver is 
> definitely something we want to target, though, and seems to be route that 
> more users are interested in.  Is defining the XML syntax for a guest VM 
> something we can discuss now as well?
> 
> (BTW this is biting NBD users too.  Presumably the guest VM XML should 
> look similar?

And also Sheepdog storage volumes. To define a syntax for all these we need
to determine what configuration metadata is required at a per-VM level for
each of them. Then try and decide how to represent that in the guest XML.
It looks like at a VM level we'd need a hostname, port number and a volume
name (or path).

Regards,
Daniel
-- 
|: Red Hat, Engineering, London    -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org -o- http://virt-manager.org -o- http://deltacloud.org :|
|: http://autobuild.org        -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-   F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|
