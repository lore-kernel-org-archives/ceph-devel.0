From: Wido den Hollander <wido@widodh.nl>
Subject: Re: how to remove/update a RBD device?
Date: Wed, 11 Aug 2010 08:55:35 +0200
Message-ID: <1281509735.2812.8.camel@wido-laptop.pcextreme.nl>
References: <AANLkTinm2C+LrSUPsnf_djAbQS-0VRX8tHw2T1bf2qbR@mail.gmail.com>
	 <1281350298.2246.8.camel@wido-desktop>
	 <AANLkTiniVGoWBLMFaKbrNcni6Q=5nE7WV0Xb=GhrEBx-@mail.gmail.com>
	 <Pine.LNX.4.64.1008101405060.9792@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:50547 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653Ab0HKGzi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Aug 2010 02:55:38 -0400
In-Reply-To: <Pine.LNX.4.64.1008101405060.9792@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Shrinking is ofcourse always a risky operation, but resizing the
blockdev while it is active is not a problem, but i'm not sure if it is
even possible when the blockdev is in use.

When working with iSCSI i always have to unmount the filesystem and then
run: blockdev --rereadpt /dev/sdX to get the new size, i can't run that
command when the blockdev is in use.

For example, XFS, btrfs and ext4 support online resizing (mostly
growing), but still you can't grow the blockdev beneath them when it is
on use.

When using a LV (Logical Volume) underneath the filesystem you can grow
the LV and then online grow the filesystem, but again, you can't grow
the PV (Physical Volume) when it is in use.

Might be that i'm missing something here, but that is my experience when
using iSCSI for the last few years, since iSCSI also gives you block
devices, RBD won't be much different.

Wido

On Tue, 2010-08-10 at 14:07 -0700, Sage Weil wrote:
> On Mon, 9 Aug 2010, Yehuda Sadeh Weinraub wrote:
> > On Mon, Aug 9, 2010 at 3:38 AM, Wido den Hollander <wido@widodh.nl> wrote:
> > > Hi Xiaoguang,
> > >
> > > I don't have a RBD system running at the moment, so i can't check my
> > > commands.
> > >
> > > But when you have /dev/rbd0, you can remove this device with:
> > >
> > > echo 0 > /sys/class/rbd/remove
> > >
> > > There might be a resize option, see:
> > > http://tracker.newdream.net/issues/42
> > >
> > > echo 0 > /sys/class/rbd/refresh
> > >
> > 
> > This will update the list of snapshots, but will not resize a mapped
> > device. For doing that you'll need to remove/add the device.
> > Also, it is highly unrecommended to alter the image while it is
> > mapped, as there is no proper locking and notification mechanism.
> 
> Some file systems (ext3 and btrfs for sure, probably xfs?) can handle 
> online expansion when the underlying block device grows.  Is there 
> anything preventing us from making the rbd refresh allow bdev expansion at 
> least?
> 
> I wonder if something like LVM lets you shrink a mounted bdev?
> 
> sage

