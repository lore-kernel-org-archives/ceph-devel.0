From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Designing a cluster guide
Date: Sat, 19 May 2012 18:15:22 +0200 (CEST)
Message-ID: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
References: <4FB75BAD.3080709@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:33098 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab2ESQPp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 May 2012 12:15:45 -0400
In-Reply-To: <4FB75BAD.3080709@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Gregory Farnum <greg@inktank.com>

Hi,

=46or your journal , if you have money, you can use

stec zeusram ssd drive. (around 2000=E2=82=AC /8GB / 100000 iops read/w=
rite with 4k block).
I'm using them with zfs san, they rocks for journal.=20
http://www.stec-inc.com/product/zeusram.php

another interessesting product is ddrdrive
http://www.ddrdrive.com/

----- Mail original -----=20

De: "Stefan Priebe" <s.priebe@profihost.ag>=20
=C3=80: "Gregory Farnum" <greg@inktank.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Samedi 19 Mai 2012 10:37:01=20
Objet: Re: Designing a cluster guide=20

Hi Greg,=20

Am 17.05.2012 23:27, schrieb Gregory Farnum:=20
>> It mentions for example "Fast CPU" for the mds system. What does fas=
t=20
>> mean? Just the speed of one core? Or is ceph designed to use multi c=
ore?=20
>> Is multi core or more speed important?=20
> Right now, it's primarily the speed of a single core. The MDS is=20
> highly threaded but doing most things requires grabbing a big lock.=20
> How fast is a qualitative rather than quantitative assessment at this=
=20
> point, though.=20
So would you recommand a fast (more ghz) Core i3 instead of a single=20
xeon for this system? (price per ghz is better).=20

> It depends on what your nodes look like, and what sort of cluster=20
> you're running. The monitors are pretty lightweight, but they will ad=
d=20
> *some* load. More important is their disk access patterns =E2=80=94 t=
hey have=20
> to do a lot of syncs. So if they're sharing a machine with some other=
=20
> daemon you want them to have an independent disk and to be running a=20
> new kernel&glibc so that they can use syncfs rather than sync. (The=20
> only distribution I know for sure does this is Ubuntu 12.04.)=20
Which kernel and which glibc version supports this? I have searched=20
google but haven't found an exact version. We're using debian lenny=20
squeeze with a custom kernel.=20

>> Regarding the OSDs is it fine to use an SSD Raid 1 for the journal a=
nd=20
>> perhaps 22x SATA Disks in a Raid 10 for the FS or is this quite absu=
rd=20
>> and you should go for 22x SSD Disks in a Raid 6?=20
> You'll need to do your own failure calculations on this one, I'm=20
> afraid. Just take note that you'll presumably be limited to the speed=
=20
> of your journaling device here.=20
Yeah that's why i wanted to use a Raid 1 of SSDs for the journaling. Or=
=20
is this still too slow? Another idea was to use only a ramdisk for the=20
journal and backup the files while shutting down to disk and restore=20
them after boot.=20

> Given that Ceph is going to be doing its own replication, though, I=20
> wouldn't want to add in another whole layer of replication with raid1=
0=20
> =E2=80=94 do you really want to multiply your storage requirements by=
 another=20
> factor of two?=20
OK correct bad idea.=20

>> Is it more useful the use a Raid 6 HW Controller or the btrfs raid?=20
> I would use the hardware controller over btrfs raid for now; it allow=
s=20
> more flexibility in eg switching to xfs. :)=20
OK but overall you would recommand running one osd per disk right? So=20
instead of using a Raid 6 with for example 10 disks you would run 6 osd=
s=20
on this machine?=20

>> Use single socket Xeon for the OSDs or Dual Socket?=20
> Dual socket servers will be overkill given the setup you're=20
> describing. Our WAG rule of thumb is 1GHz of modern CPU per OSD=20
> daemon. You might consider it if you decided you wanted to do an OSD=20
> per disk instead (that's a more common configuration, but it requires=
=20
> more CPU and RAM per disk and we don't know yet which is the better=20
> choice).=20
Is there also a rule of thumb for the memory?=20

My biggest problem with ceph right now is the awful slow speed while=20
doing random reads and writes.=20

Sequential read and writes are at 200Mb/s (that's pretty good for bonde=
d=20
dual Gbit/s). But random reads and write are only at 0,8 - 1,5 Mb/s=20
which is def. too slow.=20

Stefan=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
