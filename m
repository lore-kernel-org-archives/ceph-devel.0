From: Sage Weil <sage@inktank.com>
Subject: Re: Internal Qemu snapshots with RBD and libvirt
Date: Fri, 19 Jul 2013 15:41:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307191537260.795@cobra.newdream.net>
References: <51E807DD.5050805@42on.com> <51E9BE0E.7020609@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57108 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab3GSWls (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jul 2013 18:41:48 -0400
In-Reply-To: <51E9BE0E.7020609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 19 Jul 2013, Josh Durgin wrote:
> On 07/18/2013 08:21 AM, Wido den Hollander wrote:
> > Hi,
> > 
> > I'm working on the RBD integration for CloudStack 4.2 and now I got to
> > the point snapshotting.
> > 
> > The "problem" is that CloudStack uses libvirt for snapshotting
> > Instances, but Qemu/libvirt also tries to store the memory contents of
> > the domain to assure the snapshot is consistent.
> > 
> > So the way libvirt tries to do it is not possible with RBD right now,
> > since there is no way to store the internal memory.

It seems like the way to view this is that to snapshot a VM, we need to 
snapshot all N block devices attached to it, plus the internal memory.  
It's not that there is something missing from the RBD block device 
snapshot function, but that it is not clear where to put the memory at 
all.

Maybe the libvirt or qemu VM metadata should specify a separate image 
target for the RAM?  How is this normally done when you're using, say, 
qcow2?  It is assumed that it can be somehow stored with the first block 
device or something?

sage

> > 
> > I was thinking about using the Java librbd bindings to create the
> > snapshot, but that will not be consistent thus not 100% safe, so I'd
> > rather avoid that.
> > 
> > How is this done in OpenStack? Or are you facing similar issues?
> 
> OpenStack doesn't store the memory contents of a domain. For volume
> snapshots, it requires that the volume is detached, so there can be
> no inconsistency, and the actual snapshot handling is done by the volume
> driver in cinder, so libvirt is not involved at all. It just uses the
> rbd command (or now the python bindings).
> 
> > P.S.: I'm testing with libvirt 1.0.6 from the Ubuntu Cloud Team archive
> > with packages for OpenStack Havana.
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
