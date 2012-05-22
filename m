From: Gregory Farnum <greg@inktank.com>
Subject: Re: Designing a cluster guide
Date: Mon, 21 May 2012 17:30:14 -0700
Message-ID: <CAPYLRzgyyW5N894X1T=-gNyRdPmu-+VDr0=NuuLVEs93nGJZbw@mail.gmail.com>
References: <4FB75BAD.3080709@profihost.ag>
	<8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
	<CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com>
	<CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
	<7111C6286D862F43B94FD6291D8989158644DD@EX01.onqtel.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45211 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150Ab2EVAaQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 20:30:16 -0400
Received: by lbbgm6 with SMTP id gm6so3877186lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 17:30:14 -0700 (PDT)
In-Reply-To: <7111C6286D862F43B94FD6291D8989158644DD@EX01.onqtel.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Quenten Grasso <QGrasso@onq.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, May 21, 2012 at 4:52 PM, Quenten Grasso <QGrasso@onq.com.au> wr=
ote:
> Hi All,
>
>
> I've been thinking about this issue myself past few days, and an idea=
 I've come up with is running 16 x 2.5" 15K 72/146GB Disks,
> in raid 10 inside a 2U Server with JBOD's attached to the server for =
actual storage.
>
> Can someone help clarify this one,
>
> Once the data is written to the (journal disk) and then read from the=
 (journal disk) then written to the (storage disk) once this is complet=
e this is considered a successful write by the client?
> Or
> Once the data is written to the (journal disk) is this considered suc=
cessful by the client?
This one =E2=80=94=C2=A0the write is considered "safe" once it is on-di=
sk on all
OSDs currently responsible for hosting the object.

Every time anybody mentions RAID10 I have to remind them of the
storage amplification that entails, though. Are you sure you want that
on top of (well, underneath, really) Ceph's own replication?

> Or
> Once the data is written to the (journal disk) and written to the (st=
orage disk) at the same time, once complete this is considered a succes=
sful write by the client? (if this is the case SSD's may not be so usef=
ul)
>
>
> Pros
> Quite fast Write throughput to the journal disks,
> No write wareout of SSD's
> RAID 10 with 1GB Cache Controller also helps improve things (if reall=
y keen you could use a cachecade as well)
>
>
> Cons
> Not as fast as SSD's
> More rackspace required per server.
>
>
> Regards,
> Quenten
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Slawomir Skowron
> Sent: Tuesday, 22 May 2012 7:22 AM
> To: ceph-devel@vger.kernel.org
> Cc: Tomasz Paszkowski
> Subject: Re: Designing a cluster guide
>
> Maybe good for journal will be two cheap MLC Intel drives on Sandforc=
e
> (320/520), 120GB or 240GB, and HPA changed to 20-30GB only for
> separate journaling partitions with hardware RAID1.
>
> I like to test setup like this, but maybe someone have any real life =
info ??
>
> On Mon, May 21, 2012 at 5:07 PM, Tomasz Paszkowski <ss7pro@gmail.com>=
 wrote:
>> Another great thing that should be mentioned is:
>> https://github.com/facebook/flashcache/. It gives really huge
>> performance improvements for reads/writes (especialy on FunsionIO
>> drives) event without using librbd caching :-)
>>
>>
>>
>> On Sat, May 19, 2012 at 6:15 PM, Alexandre DERUMIER <aderumier@odiso=
=2Ecom> wrote:
>>> Hi,
>>>
>>> For your journal , if you have money, you can use
>>>
>>> stec zeusram ssd drive. (around 2000=E2=82=AC /8GB / 100000 iops re=
ad/write with 4k block).
>>> I'm using them with zfs san, they rocks for journal.
>>> http://www.stec-inc.com/product/zeusram.php
>>>
>>> another interessesting product is ddrdrive
>>> http://www.ddrdrive.com/
>>>
>>> ----- Mail original -----
>>>
>>> De: "Stefan Priebe" <s.priebe@profihost.ag>
>>> =C3=80: "Gregory Farnum" <greg@inktank.com>
>>> Cc: ceph-devel@vger.kernel.org
>>> Envoy=C3=A9: Samedi 19 Mai 2012 10:37:01
>>> Objet: Re: Designing a cluster guide
>>>
>>> Hi Greg,
>>>
>>> Am 17.05.2012 23:27, schrieb Gregory Farnum:
>>>>> It mentions for example "Fast CPU" for the mds system. What does =
fast
>>>>> mean? Just the speed of one core? Or is ceph designed to use mult=
i core?
>>>>> Is multi core or more speed important?
>>>> Right now, it's primarily the speed of a single core. The MDS is
>>>> highly threaded but doing most things requires grabbing a big lock=
=2E
>>>> How fast is a qualitative rather than quantitative assessment at t=
his
>>>> point, though.
>>> So would you recommand a fast (more ghz) Core i3 instead of a singl=
e
>>> xeon for this system? (price per ghz is better).
>>>
>>>> It depends on what your nodes look like, and what sort of cluster
>>>> you're running. The monitors are pretty lightweight, but they will=
 add
>>>> *some* load. More important is their disk access patterns =E2=80=94=
 they have
>>>> to do a lot of syncs. So if they're sharing a machine with some ot=
her
>>>> daemon you want them to have an independent disk and to be running=
 a
>>>> new kernel&glibc so that they can use syncfs rather than sync. (Th=
e
>>>> only distribution I know for sure does this is Ubuntu 12.04.)
>>> Which kernel and which glibc version supports this? I have searched
>>> google but haven't found an exact version. We're using debian lenny
>>> squeeze with a custom kernel.
>>>
>>>>> Regarding the OSDs is it fine to use an SSD Raid 1 for the journa=
l and
>>>>> perhaps 22x SATA Disks in a Raid 10 for the FS or is this quite a=
bsurd
>>>>> and you should go for 22x SSD Disks in a Raid 6?
>>>> You'll need to do your own failure calculations on this one, I'm
>>>> afraid. Just take note that you'll presumably be limited to the sp=
eed
>>>> of your journaling device here.
>>> Yeah that's why i wanted to use a Raid 1 of SSDs for the journaling=
=2E Or
>>> is this still too slow? Another idea was to use only a ramdisk for =
the
>>> journal and backup the files while shutting down to disk and restor=
e
>>> them after boot.
>>>
>>>> Given that Ceph is going to be doing its own replication, though, =
I
>>>> wouldn't want to add in another whole layer of replication with ra=
id10
>>>> =E2=80=94 do you really want to multiply your storage requirements=
 by another
>>>> factor of two?
>>> OK correct bad idea.
>>>
>>>>> Is it more useful the use a Raid 6 HW Controller or the btrfs rai=
d?
>>>> I would use the hardware controller over btrfs raid for now; it al=
lows
>>>> more flexibility in eg switching to xfs. :)
>>> OK but overall you would recommand running one osd per disk right? =
So
>>> instead of using a Raid 6 with for example 10 disks you would run 6=
 osds
>>> on this machine?
>>>
>>>>> Use single socket Xeon for the OSDs or Dual Socket?
>>>> Dual socket servers will be overkill given the setup you're
>>>> describing. Our WAG rule of thumb is 1GHz of modern CPU per OSD
>>>> daemon. You might consider it if you decided you wanted to do an O=
SD
>>>> per disk instead (that's a more common configuration, but it requi=
res
>>>> more CPU and RAM per disk and we don't know yet which is the bette=
r
>>>> choice).
>>> Is there also a rule of thumb for the memory?
>>>
>>> My biggest problem with ceph right now is the awful slow speed whil=
e
>>> doing random reads and writes.
>>>
>>> Sequential read and writes are at 200Mb/s (that's pretty good for b=
onded
>>> dual Gbit/s). But random reads and write are only at 0,8 - 1,5 Mb/s
>>> which is def. too slow.
>>>
>>> Stefan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>>
>>> --
>>>
>>>
>>>
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Alexandre D erumier
>>> Ing=C3=A9nieur Syst=C3=A8me
>>> Fixe : 03 20 68 88 90
>>> Fax : 03 20 68 90 81
>>> 45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France
>>> 12 rue Marivaux 75002 Paris - France
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>
>>
>>
>> --
>> Tomasz Paszkowski
>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>> +48500166299
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
>
> --
> -----
> Pozdrawiam
>
> S=C5=82awek "sZiBis" Skowron
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
