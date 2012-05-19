From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Designing a cluster guide
Date: Sat, 19 May 2012 10:37:01 +0200
Message-ID: <4FB75BAD.3080709@profihost.ag>
References: <4FABAFE9.5060202@profihost.ag> <4FABC15C.3030500@profihost.ag> <CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44425 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757779Ab2ESIhB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 May 2012 04:37:01 -0400
In-Reply-To: <CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Greg,

Am 17.05.2012 23:27, schrieb Gregory Farnum:
>> It mentions for example "Fast CPU" for the mds system. What does fas=
t
>> mean? Just the speed of one core? Or is ceph designed to use multi c=
ore?
>> Is multi core or more speed important?
> Right now, it's primarily the speed of a single core. The MDS is
> highly threaded but doing most things requires grabbing a big lock.
> How fast is a qualitative rather than quantitative assessment at this
> point, though.
So would you recommand a fast (more ghz) Core i3 instead of a single=20
xeon for this system? (price per ghz is better).

> It depends on what your nodes look like, and what sort of cluster
> you're running. The monitors are pretty lightweight, but they will ad=
d
> *some* load. More important is their disk access patterns =97 they ha=
ve
> to do a lot of syncs. So if they're sharing a machine with some other
> daemon you want them to have an independent disk and to be running a
> new kernel&glibc so that they can use syncfs rather than sync. (The
> only distribution I know for sure does this is Ubuntu 12.04.)
Which kernel and which glibc version supports this? I have searched=20
google but haven't found an exact version. We're using debian lenny=20
squeeze with a custom kernel.

>> Regarding the OSDs is it fine to use an SSD Raid 1 for the journal a=
nd
>> perhaps 22x SATA Disks in a Raid 10 for the FS or is this quite absu=
rd
>> and you should go for 22x SSD Disks in a Raid 6?
> You'll need to do your own failure calculations on this one, I'm
> afraid. Just take note that you'll presumably be limited to the speed
> of your journaling device here.
Yeah that's why i wanted to use a Raid 1 of SSDs for the journaling. Or=
=20
is this still too slow? Another idea was to use only a ramdisk for the=20
journal and backup the files while shutting down to disk and restore=20
them after boot.

> Given that Ceph is going to be doing its own replication, though, I
> wouldn't want to add in another whole layer of replication with raid1=
0
> =97 do you really want to multiply your storage requirements by anoth=
er
> factor of two?
OK correct bad idea.

>> Is it more useful the use a Raid 6 HW Controller or the btrfs raid?
> I would use the hardware controller over btrfs raid for now; it allow=
s
> more flexibility in eg switching to xfs. :)
OK but overall you would recommand running one osd per disk right? So=20
instead of using a Raid 6 with for example 10 disks you would run 6 osd=
s=20
on this machine?

>> Use single socket Xeon for the OSDs or Dual Socket?
> Dual socket servers will be overkill given the setup you're
> describing. Our WAG rule of thumb is 1GHz of modern CPU per OSD
> daemon. You might consider it if you decided you wanted to do an OSD
> per disk instead (that's a more common configuration, but it requires
> more CPU and RAM per disk and we don't know yet which is the better
> choice).
Is there also a rule of thumb for the memory?

My biggest problem with ceph right now is the awful slow speed while=20
doing random reads and writes.

Sequential read and writes are at 200Mb/s (that's pretty good for bonde=
d=20
dual Gbit/s). But random reads and write are only at 0,8 - 1,5 Mb/s=20
which is def. too slow.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
