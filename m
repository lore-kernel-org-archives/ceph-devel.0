From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] docs: Add CloudStack documentation
Date: Wed, 5 Sep 2012 08:42:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209050841070.8916@cobra.newdream.net>
References: <1344462671-21848-1-git-send-email-wido@widodh.nl> <CADxhoDR-3guBfFXc_QSmvPthVp5R=vS9tB2zpn-WRaLCSAu=ZA@mail.gmail.com> <50476FAE.8030107@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47064 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab2IEPmV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 11:42:21 -0400
In-Reply-To: <50476FAE.8030107@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Calvin Morrow <calvin.morrow@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 5 Sep 2012, Wido den Hollander wrote:
> On 09/05/2012 05:21 PM, Calvin Morrow wrote:
> > I saw the limitations section references only being able to configure
> > a single monitor.  Some followup questions for someone interested in
> > using RBD with Cloudstack 4:
> > 
> > Is it that you can only specify a single monitor to connect to within
> > Cloudstack 4 (but can still have a 3 monitor configuration) ... or
> > must you only have a single monitor for some reason?
> > 
> 
> You can only specify one monitor in CloudStack, but your cluster can have
> multiple.
> 
> This is due to the internals of CloudStack. It stores storage pools in a URI
> format, like: rbd://admin:secret@1.2.3.4/rbd
>
> In that format there is no way of storing multiple monitors.

What if you use a dns name with multiple A records?  The ceph bits are all 
smart enough to populate the monitor search list with all A and AAAA 
records...

sage

> > If you have a ceph.conf on the kvm nodes with more monitors, will it
> > pick up on the additional monitors?
> > 
> 
> That is a good question, I'm not sure, but I wouldn't recommend it. It could
> confuse you.
> 
> With CloudStack two components are involved:
> * libvirt with a storage pool
> * Qemu connecting to RBD
> 
> Both could read the ceph.conf since librbd does it, but I don't know if it
> will pick up any additional monitors.
> 
> > Is it possible to use a "floating" ip address resource in a pacemaker
> > configuration for the CloudStack "monitor" IP address?  Is there any
> > other way around a single-monitor point of failure?
> > 
> 
> Your Virtual Machines will not stop functioning if that monitor dies. As soon
> as librbd connects it receives the full monitor map and it functions.
> 
> You won't be able to start instances or do any RBD operations as long as that
> monitor is down.
> 
> I don't know if you can use VRRP for a monitor, but it wouldn't put all the
> effort in it.
> 
> It's on my roadmap to implement RBD layering in a upcoming CloudStack release,
> since the whole storage layer is getting a make-over.
> 
> This should enable me to also tune caching settings per pool and probably
> sqeeuze in a way to use multiple monitors as well.
> 
> I'm aiming for CloudStack 4.1 or 4.2 for this to be implemented.
> 
> > Thanks for your hard work and any guidance you can provide!
> > 
> 
> You're welcome!
> 
> Wido
> 
> > Calvin
> > 
> > On Wed, Aug 8, 2012 at 3:51 PM, Wido den Hollander <wido@widodh.nl> wrote:
> > > 
> > > The basic documentation about how you can use RBD with CloudStack
> > > 
> > > Signed-off-by: Wido den Hollander <wido@widodh.nl>
> > > ---
> > >   doc/rbd/rbd-cloudstack.rst |   49
> > > ++++++++++++++++++++++++++++++++++++++++++++
> > >   doc/rbd/rbd.rst            |    2 +-
> > >   2 files changed, 50 insertions(+), 1 deletion(-)
> > >   create mode 100644 doc/rbd/rbd-cloudstack.rst
> > > 
> > > diff --git a/doc/rbd/rbd-cloudstack.rst b/doc/rbd/rbd-cloudstack.rst
> > > new file mode 100644
> > > index 0000000..04e1a7c
> > > --- /dev/null
> > > +++ b/doc/rbd/rbd-cloudstack.rst
> > > @@ -0,0 +1,49 @@
> > > +===================
> > > + RBD and Apache CloudStack
> > > +===================
> > > +You can use RBD to run instances on in Apache CloudStack.
> > > +
> > > +This can be done by adding a RBD pool as Primary Storage.
> > > +
> > > +There are a couple of prerequisites:
> > > +* You need to CloudStack 4.0 or higher
> > > +* Qemu on the Hypervisor has to be compiled with RBD enabled
> > > +* The libvirt version on the Hypervisor has to be at least 0.10 with RBD
> > > enabled
> > > +
> > > +Make sure you meet this requirements before installing the CloudStack
> > > Agent on the Hypervisor(s)!
> > > +
> > > +.. important:: To use RBD with CloudStack, you must have a running Ceph
> > > cluster!
> > > +
> > > +Limitations
> > > +-------------
> > > +Running instances from RBD has a couple of limitations:
> > > +
> > > +* An additional NFS Primary Storage pool is required for running System
> > > VM's
> > > +* Snapshotting RBD volumes is not possible (at this moment)
> > > +* Only one monitor can be configured
> > > +
> > > +Add Hypervisor
> > > +-------------
> > > +Please follow the official CloudStack documentation how to do this.
> > > +
> > > +There is no special way of adding a Hypervisor when using RBD, nor is any
> > > configuration needed on the hypervisor.
> > > +
> > > +Add RBD Primary Storage
> > > +-------------
> > > +Once the hypervisor has been added, log on to the CloudStack UI.
> > > +
> > > +* Infrastructure
> > > +* Primary Storage
> > > +* "Add Primary Storage"
> > > +* Select "Protocol" RBD
> > > +* Fill in your cluster information (cephx is supported)
> > > +* Optionally add the tag 'rbd'
> > > +
> > > +Now you should be able to deploy instances on RBD.
> > > +
> > > +RBD Disk Offering
> > > +-------------
> > > +Create a special "Disk Offering" which needs to match the tag 'rbd' so
> > > you can make sure the StoragePoolAllocator
> > > +chooses the RBD pool when searching for a suiteable storage pool.
> > > +
> > > +Since there is also a NFS storage pool it's possible that instances get
> > > deployed on NFS instead of RBD.
> > > diff --git a/doc/rbd/rbd.rst b/doc/rbd/rbd.rst
> > > index af1682f..6fd1999 100644
> > > --- a/doc/rbd/rbd.rst
> > > +++ b/doc/rbd/rbd.rst
> > > @@ -31,7 +31,7 @@ the Ceph FS filesystem, and RADOS block devices
> > > simultaneously.
> > >          QEMU and RBD <qemu-rbd>
> > >          libvirt <libvirt>
> > >          RBD and OpenStack <rbd-openstack>
> > > -
> > > +       RBD and CloudStack <rbd-cloudstack>
> > > 
> > > 
> > > 
> > > --
> > > 1.7.9.5
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
