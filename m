From: Gregory Farnum <greg@inktank.com>
Subject: Re: Designing a cluster guide
Date: Thu, 17 May 2012 14:27:26 -0700
Message-ID: <CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
References: <4FABAFE9.5060202@profihost.ag>
	<4FABC15C.3030500@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64470 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370Ab2EQV11 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 17:27:27 -0400
Received: by lbbgm6 with SMTP id gm6so1622843lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 14:27:26 -0700 (PDT)
In-Reply-To: <4FABC15C.3030500@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

Sorry this got left for so long...

On Thu, May 10, 2012 at 6:23 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hi,
>
> the "Designing a cluster guide"
> http://wiki.ceph.com/wiki/Designing_a_cluster is pretty good but it
> still leaves some questions unanswered.
>
> It mentions for example "Fast CPU" for the mds system. What does fast
> mean? Just the speed of one core? Or is ceph designed to use multi co=
re?
> Is multi core or more speed important?
Right now, it's primarily the speed of a single core. The MDS is
highly threaded but doing most things requires grabbing a big lock.
How fast is a qualitative rather than quantitative assessment at this
point, though.

> The Cluster Design Recommendations mentions to seperate all Daemons o=
n
> dedicated machines. Is this also for the MON useful? As they're so
> leightweight why not running them on the OSDs?
It depends on what your nodes look like, and what sort of cluster
you're running. The monitors are pretty lightweight, but they will add
*some* load. More important is their disk access patterns =97 they have
to do a lot of syncs. So if they're sharing a machine with some other
daemon you want them to have an independent disk and to be running a
new kernel&glibc so that they can use syncfs rather than sync. (The
only distribution I know for sure does this is Ubuntu 12.04.)

> Regarding the OSDs is it fine to use an SSD Raid 1 for the journal an=
d
> perhaps 22x SATA Disks in a Raid 10 for the FS or is this quite absur=
d
> and you should go for 22x SSD Disks in a Raid 6?
You'll need to do your own failure calculations on this one, I'm
afraid. Just take note that you'll presumably be limited to the speed
of your journaling device here.
Given that Ceph is going to be doing its own replication, though, I
wouldn't want to add in another whole layer of replication with raid10
=97 do you really want to multiply your storage requirements by another
factor of two?
> Is it more useful the use a Raid 6 HW Controller or the btrfs raid?
I would use the hardware controller over btrfs raid for now; it allows
more flexibility in eg switching to xfs. :)

> Use single socket Xeon for the OSDs or Dual Socket?
Dual socket servers will be overkill given the setup you're
describing. Our WAG rule of thumb is 1GHz of modern CPU per OSD
daemon. You might consider it if you decided you wanted to do an OSD
per disk instead (that's a more common configuration, but it requires
more CPU and RAM per disk and we don't know yet which is the better
choice).
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
