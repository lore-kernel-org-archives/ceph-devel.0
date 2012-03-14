From: Sage Weil <sage@newdream.net>
Subject: Re: q. about rbd-header
Date: Wed, 14 Mar 2012 14:22:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203141418590.11925@cobra.newdream.net>
References: <9CB50149-F22E-4130-80FD-1A8472891BD5@filoo.de>
 <89CB135C-CB66-4240-B89C-EFDFCB8AACF4@filoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55366 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033Ab2CNVW3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 17:22:29 -0400
In-Reply-To: <89CB135C-CB66-4240-B89C-EFDFCB8AACF4@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

On Wed, 14 Mar 2012, Oliver Francke wrote:
> Well,
> 
> nobody able to sched some light in?
> Did some math and found out how to fill the size bytes.
> 
> But, one question never got answered:
>     - why is - with busy VMs - frequently the first block affected,
>       with the result of damaged grub-loaders/partition-tables/filesystems?
>       Is this some NULL/zero pointer thingy in case of ceph-failure?
> 
> If you demand some broken images? we have many of them to investigate,
> unfortunately.

We are definitely interested in this failure, _especially_ if it's 
something you can reproduce.  Even some broken images are worth looking 
at, though, to see what the corruptions look like.  Can you share the 
first block of one of these images with us (without worrying about 
customer data)?

I've opened #2178 to track this.  We can either attach everything to the 
bug, or share data out of band if it needs to stay private.

Thanks!
sage



> 
> Maybe this sounds a bit harsh, after the 5th night-shift trying to repair images
> and keep customers calm, I think this is forgivable.
> 
> Oliver.
> 
> Am 14.03.2012 um 16:05 schrieb Oliver Francke:
> 
> > Hey,
> > 
> > anybody out there who could explain the structure of a rbd-header? After 
> > last crash we have about 10 images with a:
> >   2012-03-14 15:22:47.998790 7f45a61e3760 librbd: Error reading 
> > header: 2 No such file or directory
> > error opening image vm-266-disk-1.rbd: 2 No such file or directory
> > ... error?
> > I understand the "rb.x.y"-prefix, the 2 ^ 16hex as block-size. But 
> > the size/count encoding is not intuitive ;)
> > 
> > Besides one file, where I "created" a header and putted it via "rados 
> > put" back into the pool, and got some files
> > back, many of the other images with lost headers have different sizes.
> > 
> > We got bad luck again, too many crashed VM's, too much data-loss...
> > 
> > Comments welcome ;)
> > 
> > Oliver.
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
