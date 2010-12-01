From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] rbd: replace the rbd sysfs interface
Date: Wed, 1 Dec 2010 12:08:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012011203290.8183@cobra.newdream.net>
References: <AANLkTims_MjBS1SdHkOjOWvGqg1aRABH23MWk8J-E+-Y@mail.gmail.com>
 <20101118013002.GC8558@kroah.com> <AANLkTi=7z40CNBUmfVUEa68J+1R=7nbn9d8vM7ETpajA@mail.gmail.com>
 <20101119020820.GB18767@kroah.com> <AANLkTim4p=tpaQG_XDE5Vk0YAypYCegAguYNKRg-LeDF@mail.gmail.com>
 <20101123001410.GA31294@kroah.com> <AANLkTi=n9aJ_8VAcyOXQxxeprWzerZLf0H+ryHZs7O04@mail.gmail.com>
 <20101123005838.GB29289@kroah.com> <1290558233.1792.73.camel@yehudasa-desktop>
 <Pine.LNX.4.64.1012011117460.8183@cobra.newdream.net> <20101201194751.GA1171@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55458 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526Ab0LAUDg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Dec 2010 15:03:36 -0500
In-Reply-To: <20101201194751.GA1171@kroah.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 1 Dec 2010, Greg KH wrote:
> >  /sys/bus/rbd/{add,remove}
> >  /sys/bus/rbd/devices/<devid>/                 <-- struct device
> >  /sys/bus/rbd/devices/<devid>/{some dev attrs}
> >  /sys/bus/rbd/devices/<devid>/snap_<snapid>/   <-- struct device
> >  /sys/bus/rbd/devices/<devid>/snap_<snapid>/{some snap attrs}
> > 
> > This works, and I is (I hope) using struct device properly.  The only 
> > problem, purely from a user interface standpoint, is that the snaps are 
> > mixed in with attributes, so anybody wanting to iterate over snaps needs 
> > to do something crufty like
> > 
> >  $ for snap in `ls /sys/bus/rbd/devices/$id | grep ^snap_ | cut -c 6-`; do ...
> 
> What's wrong with:
> 	for snap in `ls /sys/bus/rbd/devices/$id/snap_*`; do ...
> instead?

Yeah, it's really the 'cut -c 6-' bit that I was hoping to avoid.  But it 
snaps/ simply doesn't map onto the sysfs paradigm cleanly, that's fine.

That being the case, can we get an Acked-by on the current approach/patch?  
Then I can send something Linus and let him decide what to do for .37.

Thanks!
sage




> 
> And you would be using libudev ideally for a .c file, and iterating over
> the devices is pretty trivial that way from what I have seen.
> 
> > Adding an intermediate snaps/ subdir would let them instead do
> > 
> >  $ for snap in `ls /sys/bus/rbd/devices/$id/snaps/`; do ...
> > 
> > without worrying about the (arbitrarily named) snaps from colliding with 
> > device attributes.  Assuming that is a preferable interface, is the 
> > "right" way to do that to make "snaps" a struct device?  Or is there a 
> > good reason why that is not preferable?
> 
> It's not preferable as that "snaps" directory is a "blank" in the device
> tree, not showing the heiarchy properly.  You can't walk the devices
> back from the devices in snaps/ to the parent properly (i.e. you would
> get stuck at the snaps/ directory as it's not a struct device, but a
> random kobject.
> 
> Hope this helps,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
