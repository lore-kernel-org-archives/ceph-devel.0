From: Sage Weil <sage@newdream.net>
Subject: Re: RBD stall when creating and listing images
Date: Sat, 21 Apr 2012 21:34:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204212132530.29786@cobra.newdream.net>
References: <4F929964.8000506@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35552 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2DVEel (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Apr 2012 00:34:41 -0400
In-Reply-To: <4F929964.8000506@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 21 Apr 2012, Wido den Hollander wrote:
> Hi,
> 
> I was just playing with my libvirt driver and I noticed a stall.
> 
> On one host I had running:
> 
> for i in {0..8192}; do rbd create --size 64 image-$i; echo "created image-$i";
> done
> 
> And on the other host I was running a pool-refresh in libvirt.
> 
> As I was tailing the libvirt log I noticed that it had stalled, so I checked
> my other terminal and saw that the creation of new images had also stalled.
> 
> This situation persisted for about ~20 seconds and then everything started to
> continue.
> 
> At the moment of the stall libvirt was calling rbd_list and was not doing any
> rbd_stat yet.
> 
> I'm trying to reproduce it here, but I wonder if there is a logical
> explanation for this situation?
> 
> I'm running 0.44 on my cluster and 0.45 on the client btw.

Nothing comes to mind.. unless libvirt is doing something silly on 
pool-refresh and actually modifies each image header (which would make 
users stop and refresh).

If you can reproduce this with some logs (ideally the stalling client), 
I'd love to see what's going on.

sage
