From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Designing a cluster guide
Date: Mon, 21 May 2012 23:22:14 +0200
Message-ID: <CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
References: <4FB75BAD.3080709@profihost.ag>
	<8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
	<CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:62217 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759232Ab2EUVWQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 17:22:16 -0400
Received: by wibhm6 with SMTP id hm6so3094464wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 14:22:15 -0700 (PDT)
In-Reply-To: <CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Tomasz Paszkowski <ss7pro@gmail.com>

Maybe good for journal will be two cheap MLC Intel drives on Sandforce
(320/520), 120GB or 240GB, and HPA changed to 20-30GB only for
separate journaling partitions with hardware RAID1.

I like to test setup like this, but maybe someone have any real life in=
fo ??

On Mon, May 21, 2012 at 5:07 PM, Tomasz Paszkowski <ss7pro@gmail.com> w=
rote:
> Another great thing that should be mentioned is:
> https://github.com/facebook/flashcache/. It gives really huge
> performance improvements for reads/writes (especialy on FunsionIO
> drives) event without using librbd caching :-)
>
>
>
> On Sat, May 19, 2012 at 6:15 PM, Alexandre DERUMIER <aderumier@odiso.=
com> wrote:
>> Hi,
>>
>> For your journal , if you have money, you can use
>>
>> stec zeusram ssd drive. (around 2000=E2=82=AC /8GB / 100000 iops rea=
d/write with 4k block).
>> I'm using them with zfs san, they rocks for journal.
>> http://www.stec-inc.com/product/zeusram.php
>>
>> another interessesting product is ddrdrive
>> http://www.ddrdrive.com/
>>
>> ----- Mail original -----
>>
>> De: "Stefan Priebe" <s.priebe@profihost.ag>
>> =C3=80: "Gregory Farnum" <greg@inktank.com>
>> Cc: ceph-devel@vger.kernel.org
>> Envoy=C3=A9: Samedi 19 Mai 2012 10:37:01
>> Objet: Re: Designing a cluster guide
>>
>> Hi Greg,
>>
>> Am 17.05.2012 23:27, schrieb Gregory Farnum:
>>>> It mentions for example "Fast CPU" for the mds system. What does f=
ast
>>>> mean? Just the speed of one core? Or is ceph designed to use multi=
 core?
>>>> Is multi core or more speed important?
>>> Right now, it's primarily the speed of a single core. The MDS is
>>> highly threaded but doing most things requires grabbing a big lock.
>>> How fast is a qualitative rather than quantitative assessment at th=
is
>>> point, though.
>> So would you recommand a fast (more ghz) Core i3 instead of a single
>> xeon for this system? (price per ghz is better).
>>
>>> It depends on what your nodes look like, and what sort of cluster
>>> you're running. The monitors are pretty lightweight, but they will =
add
>>> *some* load. More important is their disk access patterns =E2=80=94=
 they have
>>> to do a lot of syncs. So if they're sharing a machine with some oth=
er
>>> daemon you want them to have an independent disk and to be running =
a
>>> new kernel&glibc so that they can use syncfs rather than sync. (The
>>> only distribution I know for sure does this is Ubuntu 12.04.)
>> Which kernel and which glibc version supports this? I have searched
>> google but haven't found an exact version. We're using debian lenny
>> squeeze with a custom kernel.
>>
>>>> Regarding the OSDs is it fine to use an SSD Raid 1 for the journal=
 and
>>>> perhaps 22x SATA Disks in a Raid 10 for the FS or is this quite ab=
surd
>>>> and you should go for 22x SSD Disks in a Raid 6?
>>> You'll need to do your own failure calculations on this one, I'm
>>> afraid. Just take note that you'll presumably be limited to the spe=
ed
>>> of your journaling device here.
>> Yeah that's why i wanted to use a Raid 1 of SSDs for the journaling.=
 Or
>> is this still too slow? Another idea was to use only a ramdisk for t=
he
>> journal and backup the files while shutting down to disk and restore
>> them after boot.
>>
>>> Given that Ceph is going to be doing its own replication, though, I
>>> wouldn't want to add in another whole layer of replication with rai=
d10
>>> =E2=80=94 do you really want to multiply your storage requirements =
by another
>>> factor of two?
>> OK correct bad idea.
>>
>>>> Is it more useful the use a Raid 6 HW Controller or the btrfs raid=
?
>>> I would use the hardware controller over btrfs raid for now; it all=
ows
>>> more flexibility in eg switching to xfs. :)
>> OK but overall you would recommand running one osd per disk right? S=
o
>> instead of using a Raid 6 with for example 10 disks you would run 6 =
osds
>> on this machine?
>>
>>>> Use single socket Xeon for the OSDs or Dual Socket?
>>> Dual socket servers will be overkill given the setup you're
>>> describing. Our WAG rule of thumb is 1GHz of modern CPU per OSD
>>> daemon. You might consider it if you decided you wanted to do an OS=
D
>>> per disk instead (that's a more common configuration, but it requir=
es
>>> more CPU and RAM per disk and we don't know yet which is the better
>>> choice).
>> Is there also a rule of thumb for the memory?
>>
>> My biggest problem with ceph right now is the awful slow speed while
>> doing random reads and writes.
>>
>> Sequential read and writes are at 200Mb/s (that's pretty good for bo=
nded
>> dual Gbit/s). But random reads and write are only at 0,8 - 1,5 Mb/s
>> which is def. too slow.
>>
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>>
>> --
>>
>>
>>
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Alexandre D erumier
>> Ing=C3=A9nieur Syst=C3=A8me
>> Fixe : 03 20 68 88 90
>> Fax : 03 20 68 90 81
>> 45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France
>> 12 rue Marivaux 75002 Paris - France
>>
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
> Tomasz Paszkowski
> SS7, Asterisk, SAN, Datacenter, Cloud Computing
> +48500166299
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
