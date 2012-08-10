From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more
 flexible
Date: Thu, 9 Aug 2012 18:53:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208091845090.8611@cobra.newdream.net>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de> <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com> <5023E96E.30209@sandia.gov> <CADvuQRG9DrG6irjuD8ZZcAz_grgS=9i6M6GDV0-gYWfAyje4uw@mail.gmail.com> <5023ED56.9070102@bisect.de>
 <CADvuQRHf=_nQetqmghUp7Mbe-QtcfOYfkdRkTJQhbBpzSGXDRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56830 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab2HJBx7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 21:53:59 -0400
In-Reply-To: <CADvuQRHf=_nQetqmghUp7Mbe-QtcfOYfkdRkTJQhbBpzSGXDRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Danny Kukawka <danny.kukawka@bisect.de>, ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

On Thu, 9 Aug 2012, Tommi Virtanen wrote:
> On Thu, Aug 9, 2012 at 10:03 AM, Danny Kukawka <danny.kukawka@bisect.de> wrote:
> > So you mean chef?! Will there be an alternative to simply setup a
> > cluster from console?
> >
> > We (SUSE) are already working on an own chef ceph cookbook. But from
> > what I've seen till now it's really hard and more laborious to initially
> > setup a cluster with chef than with mkcephfs.
> 
> I've written about this on the mailing list several times. We see a
> lot of demand for Chef, but don't want to tie our hands -- Canonical
> is working on Juju Charms, and I would like to see a mkcephfs
> replacement that relies on just SSH connections from a workstation
> node. We've made an explicit effort to improve the product as a whole,
> and to make the Chef cookbook as thin as possible.
> 
> For some reason, the threading is broken on the archive, but this is a
> fragment of the most recent thread that talked about this:
> 
> http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/8263/focus=8265

I think the real question is whether the planned "mkcephfs 2.0" is going 
to capture the equivalent functionality of being able to enumerate up 
front which osds will exist and which disks/journals they will use, and to 
bring them up.  Assuming it will (IMHO it needs to), can we make that 
compatible with the current way that mkcephfs is invoked (i.e., a 
ceph.conf file and a few command line args)?  Not everyone (and I daresay 
probably a minority) of users will be using Chef/Juju/Puppet/whatever, 
regardless of whether or not we feel that is the right way to do things 
and try to push them in that direction.

In any case, since the new osd hotplugging stuff isn't available now and 
is probably still a sprint or two off, I think we should consider applying 
this patch.  We aren't recommending btrfs across the board, and cluster 
bringup is currently painful on ext4/xfs/etc.  And, Danny already did the 
work.  :)

sage
