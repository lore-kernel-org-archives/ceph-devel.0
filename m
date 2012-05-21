From: Gregory Farnum <greg@inktank.com>
Subject: Re: Designing a cluster guide
Date: Mon, 21 May 2012 11:13:10 -0700
Message-ID: <CAPYLRzj8Ozv_L1FSONbR0Kovn_hdXz9YN5bXnAskgdv0s4COvQ@mail.gmail.com>
References: <4FABAFE9.5060202@profihost.ag>
	<4FABC15C.3030500@profihost.ag>
	<CAPYLRzgTWLcbZHHpVs0j=WZokXfh8CGLcTUF6nkV1CCYiSs1DQ@mail.gmail.com>
	<4FB75BAD.3080709@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53188 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758394Ab2EUSNM convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 May 2012 14:13:12 -0400
Received: by lahd3 with SMTP id d3so3693229lah.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 11:13:10 -0700 (PDT)
In-Reply-To: <4FB75BAD.3080709@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On Sat, May 19, 2012 at 1:37 AM, Stefan Priebe <s.priebe@profihost.ag> =
wrote:
> Hi Greg,
>
> Am 17.05.2012 23:27, schrieb Gregory Farnum:
>
>>> It mentions for example "Fast CPU" for the mds system. What does fa=
st
>>> mean? Just the speed of one core? Or is ceph designed to use multi =
core?
>>> Is multi core or more speed important?
>>
>> Right now, it's primarily the speed of a single core. The MDS is
>> highly threaded but doing most things requires grabbing a big lock.
>> How fast is a qualitative rather than quantitative assessment at thi=
s
>> point, though.
>
> So would you recommand a fast (more ghz) Core i3 instead of a single =
xeon
> for this system? (price per ghz is better).

If that's all the MDS is doing there, probably? (It would also depend
on cache sizes and things; I don't have a good sense for how that
impacts the MDS' performance.)

>> It depends on what your nodes look like, and what sort of cluster
>> you're running. The monitors are pretty lightweight, but they will a=
dd
>> *some* load. More important is their disk access patterns =97 they h=
ave
>> to do a lot of syncs. So if they're sharing a machine with some othe=
r
>> daemon you want them to have an independent disk and to be running a
>> new kernel&glibc so that they can use syncfs rather than sync. (The
>> only distribution I know for sure does this is Ubuntu 12.04.)
>
> Which kernel and which glibc version supports this? I have searched g=
oogle
> but haven't found an exact version. We're using debian lenny squeeze =
with a
> custom kernel.

syncfs is in Linux 2.6.39; I'm not sure about glibc but from a quick
web search it looks like it might have appeared in glibc 2.15?

>>> Regarding the OSDs is it fine to use an SSD Raid 1 for the journal =
and
>>> perhaps 22x SATA Disks in a Raid 10 for the FS or is this quite abs=
urd
>>> and you should go for 22x SSD Disks in a Raid 6?
>>
>> You'll need to do your own failure calculations on this one, I'm
>> afraid. Just take note that you'll presumably be limited to the spee=
d
>> of your journaling device here.
>
> Yeah that's why i wanted to use a Raid 1 of SSDs for the journaling. =
Or is
> this still too slow? Another idea was to use only a ramdisk for the j=
ournal
> and backup the files while shutting down to disk and restore them aft=
er
> boot.

Well, RAID1 isn't going to make it any faster than just the single
SSD, is why I pointed that out.
I wouldn't recommend using a ramdisk for the journal =97=A0that will
guarantee local data loss in the event the server doesn't shut down
properly, and if it happens to several servers at once you get a good
chance of losing client writes.

>>> Is it more useful the use a Raid 6 HW Controller or the btrfs raid?
>>
>> I would use the hardware controller over btrfs raid for now; it allo=
ws
>> more flexibility in eg switching to xfs. :)
>
> OK but overall you would recommand running one osd per disk right? So
> instead of using a Raid 6 with for example 10 disks you would run 6 o=
sds on
> this machine?
Right now all the production systems I'm involved in are using 1 OSD
per disk, but honestly we don't know if that's the right answer or
not. It's a tradeoff =97 more OSDs increases cpu and memory requirement=
s
(per storage space) but also localizes failure a bit more.

>>> Use single socket Xeon for the OSDs or Dual Socket?
>>
>> Dual socket servers will be overkill given the setup you're
>> describing. Our WAG rule of thumb is 1GHz of modern CPU per OSD
>> daemon. You might consider it if you decided you wanted to do an OSD
>> per disk instead (that's a more common configuration, but it require=
s
>> more CPU and RAM per disk and we don't know yet which is the better
>> choice).
>
> Is there also a rule of thumb for the memory?
About 200MB per daemon right now, plus however much you want the page
cache to be able to use. :) This might go up a bit during peering, but
under normal operation it shouldn't be more than another couple
hundred MB.

> My biggest problem with ceph right now is the awful slow speed while =
doing
> random reads and writes.
>
> Sequential read and writes are at 200Mb/s (that's pretty good for bon=
ded
> dual Gbit/s). But random reads and write are only at 0,8 - 1,5 Mb/s w=
hich is
> def. too slow.
Hmm. I'm not super-familiar where our random IO performance is right
now (and lots of other people seem to have advice on journaling
devices :), but that's about in line with what you get from a hard
disk normally. Unless you've designed your application very carefully
(lots and lots of parallel IO), an individual client doing synchronous
random IO is unlikely to be able to get much faster than a regular
drive.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
