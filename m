From: Sage Weil <sage@inktank.com>
Subject: Re: limit of maximum number of rbd devices that can be mapped
Date: Fri, 2 Nov 2012 04:22:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1211020416410.19983@cobra.newdream.net>
References: <CAP5wSLc0fGo03Sh0mric3pb_yNkOY=0bEkMHR0Nmq2u8F0nJAw@mail.gmail.com> <507F66F1.4000509@inktank.com> <5093A78D.4060409@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50073 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab2KBLWP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 07:22:15 -0400
In-Reply-To: <5093A78D.4060409@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny@bisect.de>
Cc: Alex Elder <elder@inktank.com>, Christian Huang <ythuang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 2 Nov 2012, Danny Al-Gaaf wrote:
> Am 18.10.2012 04:18, schrieb Alex Elder:
> > On 10/17/2012 09:15 PM, Christian Huang wrote:
> >> Hi,
> >>     what is the maximum number of rbd devices that can be mapped on a
> >> single host?
> >>     we recently did a test to mount a large number of rbd devices and
> >> hit a wall around 230
> >>     with the following message
> > 
> > That sounds about right.  We were just discussing this earlier
> > this week.  It's limited at the moment by the number of major
> > device numbers available on the system, and I think you found
> > that limit.  We would obviously like to have a solution for
> > this but we've only just started considering options.
> 
> Any news on this? We have seen the same issues here.
> 
> IMO the RBD code should to something similar to some other block drivers:
> 
> 1) reserve a major block number for RBD in general (or use the number
> returned from the register_blkdev call, if there is no number we can
> reserve in general for RBD, see [1])
> 
> 2) Use this major number for all RBDs on this machine and handle each
> new RBD via different minor numbers.
> 
> If we can agree on this I would take a look into it and send a patch.

We should probably do what SCSI does, where the minor for each device 
jumps by 16 to leave room for partitions.

There was a thread on this a couple of weeks ago that mmy slow internet is 
preventing me from finding... :)

sage
