From: Sage Weil <sage@newdream.net>
Subject: Re: Recommended btrfs mount options
Date: Wed, 23 Nov 2011 07:13:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111230704560.5214@cobra.newdream.net>
References: <CAO47_-_V4d=3abABvqrV+muJ3cF-J-=-RQ748Vr+U=_ZdffZfw@mail.gmail.com>
 <Pine.LNX.4.64.1111221415280.11288@cobra.newdream.net> <or39dful05.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35331 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab1KWPND (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 10:13:03 -0500
In-Reply-To: <or39dful05.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

On Wed, 23 Nov 2011, Alexandre Oliva wrote:
> On Nov 22, 2011, Sage Weil <sage@newdream.net> wrote:
> 
> > On Tue, 22 Nov 2011, Christian Brunner wrote:
> 
> >> - compression: I'm using lzo compression right now, as my CPUs in the
> >> OSD nodes where idle most of the time and it is improving throughput
> >> quite a bit.
> 
> > The caveat here is that there is a corner case with inline extents and the 
> > clone ioctl that isn't implemented.
> 
> What happens when you trigger that case?  Crash or corruption?
> 
> I ask because I've been running with zlib compression, and I haven't
> noticed any problems along these lines, though I haven't got to a point
> in which I'm doing more than rsyncing whole trees into the filesystem
> yet.

Took another look at this.  The ioctl will return EINVAL from 
fs/btrfs/ioctl.c:2416:

				if (comp && (skip || trim)) {
					ret = -EINVAL;
					btrfs_end_transaction(trans, root);
					goto out;
				}

If os/FileStore.cc::_do_clone_range() sees EINVAL, it falls back to doing 
a copy.  That may not be ideal in some cases, but at least it's 
"correct".  For example,

0-8192 compressed inline
8192-100MB normal extent

and we clone 4k - 100MB, and get EINVAL, we ideally wouldn't fall back to 
naively copying 100MB.  For RBD, those blocks are 4MB by default, so it's 
not a big deal.

So you should be okay here.  

sage



> >> - nocluster (requires an additional btrfs patch from Alexandre): I was
> >> reading that he was able to reduce the excessive metadata overhead,
> >> but it is slower. Does anyone know more about it?
> 
> > We haven't tried this.
> 
> I've used it occasionally and temporarily, to rebalance metadata and
> bring btrfs (even with clustered allocation) back to a faster pace
> without umount.
> 
> -- 
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
