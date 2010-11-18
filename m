From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] rbd: replace the rbd sysfs interface
Date: Wed, 17 Nov 2010 17:30:02 -0800
Message-ID: <20101118013002.GC8558@kroah.com>
References: <1289953929-30896-1-git-send-email-yehuda@hq.newdream.net> <20101117171924.GC12050@kroah.com> <AANLkTims_MjBS1SdHkOjOWvGqg1aRABH23MWk8J-E+-Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:35515 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745Ab0KRBc6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Nov 2010 20:32:58 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTims_MjBS1SdHkOjOWvGqg1aRABH23MWk8J-E+-Y@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 17, 2010 at 03:00:17PM -0800, Yehuda Sadeh Weinraub wrote:
> On Wed, Nov 17, 2010 at 9:19 AM, Greg KH <greg@kroah.com> wrote:
> > On Tue, Nov 16, 2010 at 04:32:09PM -0800, Yehuda Sadeh wrote:
> >> Hi Greg,
> >>
> >> Following is the new rbd sysfs interface. It lists devices in their own
> >> subdirectories, as well as their underlying snapshots. Please let us
> >> know if there's any issue you think we missed or did wrong.
> >>
> >> Thanks,
> >> Yehuda
> >>
> >> ---
> >>
> >> The new interface creates directories per mapped image
> >> and under each it creates a subdir per available snapshot.
> >> This allows keeping a cleaner interface within the sysfs
> >> guidelines. The ABI documentation was updated too.
> >>
> >> Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
> >> ---
> >> ?Documentation/ABI/testing/sysfs-class-rbd | ? 83 +++
> >> ?drivers/block/rbd.c ? ? ? ? ? ? ? ? ? ? ? | ?775 +++++++++++++++++------------
> >> ?2 files changed, 547 insertions(+), 311 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-class-rbd b/Documentation/ABI/testing/sysfs-class-rbd
> >> new file mode 100644
> >> index 0000000..4d96618
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-class-rbd
> >> @@ -0,0 +1,83 @@
> >> +What: ? ? ? ? ? ? ? ?/sys/class/rbd/
> >
> > I thought I mentioned that you should not add new classes to the kernel.
> > Please don't do that, make it a bus_type instead.
> 
> 
> Ahmm.. apparently not in the rbd related threads. So moving things
> around and having rbd under /sys/bus we'll have the following:
> 
> /sys/bus/rbd/drivers/rbd/..
>     add - add a device
>     remove - remove a device

These files could go in /sys/bus/rbd/ directly instead of burying under
2 more layers, right?

> 
> /sys/bus/rbd/devices/<id>
>    name
>    pool
>    ...
> 
> /sys/bus/rbd/devices/<id>/snaps/<name>
>     id
>     size
>     ...
> 
> 
> Would this work?

With the change mentioned above, I think that seems sane, do you?

thanks,

greg k-h
