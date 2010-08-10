From: Sage Weil <sage@newdream.net>
Subject: Re: how to remove/update a RBD device?
Date: Tue, 10 Aug 2010 14:07:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008101405060.9792@cobra.newdream.net>
References: <AANLkTinm2C+LrSUPsnf_djAbQS-0VRX8tHw2T1bf2qbR@mail.gmail.com>
 <1281350298.2246.8.camel@wido-desktop> <AANLkTiniVGoWBLMFaKbrNcni6Q=5nE7WV0Xb=GhrEBx-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43121 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169Ab0HJVHJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Aug 2010 17:07:09 -0400
In-Reply-To: <AANLkTiniVGoWBLMFaKbrNcni6Q=5nE7WV0Xb=GhrEBx-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, Xiaoguang Liu <syslxg@gmail.com>, ceph-devel@vger.kernel.org

On Mon, 9 Aug 2010, Yehuda Sadeh Weinraub wrote:
> On Mon, Aug 9, 2010 at 3:38 AM, Wido den Hollander <wido@widodh.nl> wrote:
> > Hi Xiaoguang,
> >
> > I don't have a RBD system running at the moment, so i can't check my
> > commands.
> >
> > But when you have /dev/rbd0, you can remove this device with:
> >
> > echo 0 > /sys/class/rbd/remove
> >
> > There might be a resize option, see:
> > http://tracker.newdream.net/issues/42
> >
> > echo 0 > /sys/class/rbd/refresh
> >
> 
> This will update the list of snapshots, but will not resize a mapped
> device. For doing that you'll need to remove/add the device.
> Also, it is highly unrecommended to alter the image while it is
> mapped, as there is no proper locking and notification mechanism.

Some file systems (ext3 and btrfs for sure, probably xfs?) can handle 
online expansion when the underlying block device grows.  Is there 
anything preventing us from making the rbd refresh allow bdev expansion at 
least?

I wonder if something like LVM lets you shrink a mounted bdev?

sage
