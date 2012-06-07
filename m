From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Thu, 07 Jun 2012 23:36:23 +0200
Message-ID: <1432839.r57HJoU1Hp@tolkien>
References: <21601270.dfB0BsVfyn@pc10> <4FD10575.7010300@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:50201 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757444Ab2FGVg3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jun 2012 17:36:29 -0400
In-Reply-To: <4FD10575.7010300@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thursday 07 June 2012 12:48:05 Josh Durgin wrote:
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

I'm not using rbd caching, and I wasn't planning on even trying before I have 
a much better understanding of how it affects VM migration.
 
> In either case, does the corruption still occur if you
> switch caching on/off? There are different I/O paths here,
> and this might tell us if the problem is on the client side.
> 
> Another thing to try is turning off sparse reads on the osd by setting
> filestore fiemap threshold = 0

Okay, I will try these things tomorrow.
 
[...]
> > The ceph cluster uses btrf for the osd's data dirs. The journal is on a
> > tmpfs. (This is not a production setup - luckily.)
> > The virtual machine is using ext4 as its filesystem.
> > There were no obvious other problems with either the ceph cluster or the
> > KVM host machines.
> 
> Were there any nodes with osds restarted during the test runs? I wonder
> if it's a problem with losing the tmpfs journal.

No, from the point when the rbd volume was created, all nodes were online all 
the time. No nodes were added or removed.
 
> As Oliver suggested, switching the osd data dir filesystem might help
> too.

Again, I'll try that tomorrow. BTW, I could use some advice on how to go about 
that. Right I would stop one osd process (not the whole machine), reformat and 
remount its btrfs devices as XFS, delete the journal, restart the osd, wait 
until the cluster is healthy again, repeat for all the osds in the cluster. Is 
that sufficient?

Oh, one other thing I just thought of:
The rbd volume in question was created as a copy, using the rbd cp command, 
from a template volume. I cannot recall seeing any corruption while using the 
original volume (which was created using rbd import). Maybe the bug only bites 
volumes that have been created as copies of other volumes? I'll have to do 
more tests along those lines as well...

Regards,
	Guido

