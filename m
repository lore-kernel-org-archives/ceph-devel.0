From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: defaults paths #2
Date: Thu, 12 Apr 2012 17:49:54 +0200
Message-ID: <5C3620C3-51B5-44D5-986C-266ADE715F9B@openminds.be>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com> <9B9005B1-9397-4171-8726-A52903B8B8F1@openminds.be> <CAORUGqD_Oe2F-yTS87h5P8oB=OrUTcuZo7BsWo3bqy66VJ1YfA@mail.gmail.com> <720D7ADB-C3E4-4C5E-B308-216D941FDC83@openminds.be> <CAORUGqD06LYcg3-y5BNNt724cvxUm1pkarDx_LoWoPSzx1=f1g@mail.gmail.com> <Pine.LNX.4.64.1204091115310.21531@cobra.newdream.net> <CAORUGqC2M-d4wCHbboMCsozsqQsk5zKhv_fotWZ4hq9MhTb_0A@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from november.openminds.be ([195.47.215.47]:42749 "EHLO
	november.openminds.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934032Ab2DLPt4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 11:49:56 -0400
In-Reply-To: <CAORUGqC2M-d4wCHbboMCsozsqQsk5zKhv_fotWZ4hq9MhTb_0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>


On 09 Apr 2012, at 21:22, Tommi Virtanen wrote:

> On Mon, Apr 9, 2012 at 11:16, Sage Weil <sage@newdream.net> wrote:
>> One thing we need to keep in mind here is that the individual disks are
>> placed in the CRUSH hierarchy based on the host/rack/etc location in the
>> datacenter.  Moving disk around arbitrarily will break the placement
>> constraints if that position isn't also changed.
> 
> Yeah, the location will have to be updated. I tend to think disks
> *will* move, and it's better to cope with it than to think it won't
> happen. All you need is a simple power supply/mobo/raid
> controller/nic/etc failure, if there's any free slots anywhere it's
> probably better to plug the disks in there than waiting for a
> replacement part. I'm working under the assumption that it's better to
> "just bring them up" rather than having an extended osd outage or
> claiming the osd as lost.

I've updated my recipes to support disk moving now (and multi-mon clusters, btw), and have moved from

/var/lib/ceph/osd/$clustername-$id 

to

/var/lib/ceph/osd/$clustername-$uuid

It just isn't pretty to mount a disk in a temp place, check the "whoami" file, and then umount and remount everything on a certain ID. It is all automatically handled, and I think this feels okay.

The disks are detected by the label, which I made "$cluster.ceph". If such a label is detected, the disk is mounted, the whoami file is read, and the OSD is started with the correct parameters. If the whoami file is not present, the OSD is initialized and added to the mons...

Input would be much appreciated - both using chef (one node at a time), and rather "building" a cluster instead of initializing a full cluster at once, makes the setup a bit strange sometimes (I don't know how the amount of pg's is determined, or can be suggested, when creating a cluster).

> Updating the new location for the osd could be something we do even at
> every osd start -- it's a nop if the location is the same as the old
> one. And we can say the host knows where it is, and that information
> is available in /etc or /var/lib/ceph.

I also got to the point where I want to update the location of an OSD when bringing a OSD online.

Adding a new (bare) disk (and OSD) is easy: 

ceph osd crush add 3 osd.3 1 pool=default host=2 rack=1

(with host=2 and rack=1 coming from the node itself, somehow - it would be easy if we could use alfanumerical hostnames in those parameters...)

If there would be a 

ceph osd crush update 3 osd.3 pool=default host=3 rack=2

command, that would solve the whole location problem.

Rgds,
Bernard

> 
> I'll come back to this once it's a little bit more concrete; I'd
> rather not make speculative changes, until I can actual trigger the
> behavior in a test bench.


