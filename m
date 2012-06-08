From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Fri, 08 Jun 2012 14:55:44 +0200
Message-ID: <6535521.l6e0muMKBm@pc10>
References: <21601270.dfB0BsVfyn@pc10> <4FD10575.7010300@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:38936 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363Ab2FHMzt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Jun 2012 08:55:49 -0400
In-Reply-To: <4FD10575.7010300@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am Donnerstag, 7. Juni 2012, 12:48:05 schrieben Sie:
> On 06/07/2012 11:04 AM, Guido Winkelmann wrote:
> > Hi,
> > 
> > I'm using Ceph with RBD to provide network-transparent disk images for
> > KVM-
> > based virtual servers. The last two days, I've been hunting some weird
> > elusive bug where data in the virtual machines would be corrupted in
> > weird ways. It usually manifests in files having some random data -
> > usually zeroes - at the start before the actual contents that should be
> > in there start.
> 
> I definitely want to figure out what's going on with this.
> A few questions:
> 
> Are you using rbd caching? If so, what settings?
> 
> In either case, does the corruption still occur if you
> switch caching on/off? There are different I/O paths here,
> and this might tell us if the problem is on the client side.

Okay, I've tried enabling rbd caching now, and so far, the problem appears to 
be gone.

I am using libvirt for starting and managing the virtual machines, and what I 
did was change the <source> element for the virtual disk from

<source protocol='rbd' name='rbd/name_of_image'>

to

<source protocol='rbd' name='rbd/name_of_image:rbd_cache=true'>

and then restart the VM.
(I found that in one of your mails on this list; there does not appear to be 
any proper documentation on this...)

The iotester does not find any corruptions with these settings.

The VM ist still horribly broken, but that's probably lingering filesystem 
damage from yesterday. I'll try with a fresh image next.

I did not change anything else in the setup. In particular, the OSDs still use 
btrfs. One of the OSD has been restarted, though. I will run another test with 
a VM without rbd caching, to make sure it wasn't by random chance restarting 
that one osd that made the real difference.

Enabling btrfs did not appear to make any difference wrt performance, but 
that's probably because my tests mostly create sustained sequential IO, for 
which caches are generally not very helpful.

Enabling rbd caching is not a solution I particularly like, for two reasons:

1. In my setup, migrating VMs from one host to another is a normal part of 
operation, and I still don't know ho to prevent data corruption (in the form 
of silently lost writes) when combining rbd caching and migration.

2. I'm not really looking into speeding up single VM, I'm really more 
interested in just how many VMs I can run before performance starts degrading 
for everyone, and I don't think rbd caching will help with that.

Regards,
	Guido

