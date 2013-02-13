From: Sage Weil <sage@inktank.com>
Subject: Re: rbd export speed limit
Date: Wed, 13 Feb 2013 12:21:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302131220570.20247@cobra.newdream.net>
References: <511AA47B.3020309@profihost.ag> <CABYiri_QzZaOeXp5Rcys3HZRRwF2nexh4GvmA5WMFw9Z+GVZjQ@mail.gmail.com> <511B46A2.4060107@profihost.ag> <alpine.DEB.2.00.1302130812090.23349@cobra.newdream.net> <511BE8AC.3090600@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60413 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab3BMUVo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 15:21:44 -0500
In-Reply-To: <511BE8AC.3090600@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Andrey Korolyov <andrey@xdel.ru>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 13 Feb 2013, Stefan Priebe wrote:
> Hi,
> 
> first sorry i got this totally wrong. The speed is not correct and i mixed
> this with another operation going on at the same time.
> 
> The problem isn't the rbd export in my case it the fstrim issued on all VMs.
> 
> This results in writes up to 400Mb/s per OSD and then results in aborted /
> hanging task in VMs. Is it possible to give trim commands lower priority?

Is that 400Mb or MB?  Measured over the network, or on the disk itself?

I'm wondering if this is a lack of punch support on the kernel..

sage

> 
> Greets,
> Stefan
> Am 13.02.2013 17:13, schrieb Sage Weil:
> > On Wed, 13 Feb 2013, Stefan Priebe - Profihost AG wrote:
> > > Hi,
> > > Am 12.02.2013 21:45, schrieb Andrey Korolyov:
> > > > you may be interested in throttle(1) as a side solution with stdout
> > > > export option.
> > > What's throttle? Never seen this. Wouldn't it be possible to use tc?
> > > 
> > > > By the way, on which interconnect you have manage to
> > > > get such speeds,
> > > Bonded Intel 2x 10GBE
> > > 
> > > > if you mean 'commited' bytes(e.g. not almost empty
> > > > allocated image)?
> > > Yes commited images.
> > 
> > FWIW I'm pretty sure the rbd export is doing a single IO at a time
> > (reading one chunk, 4MB by default).  Are there lots of them in parallel,
> > or is a single export operation significantly affecting performance?
> > That would be a bit surprising to me..
> > 
> > sage
> > 
> 
> 
