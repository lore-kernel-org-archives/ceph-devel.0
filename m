From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Two questions
Date: Thu, 28 Jul 2011 11:51:33 +0200
Message-ID: <CAMwB3TgHx1f_dWWGbDg4uEJyFEZc5vNgPsKVYELaK_X5nKez=Q@mail.gmail.com>
References: <8685614628192678277@unknownmsgid>
	<1311750865.2751.4.camel@wido-laptop.pcextreme.nl>
	<CAMwB3Ti66BpfdfwPx3XgmVQv2GAQ_Gc2beHRc6pBcWwphf_bhQ@mail.gmail.com>
	<1311763628.2751.34.camel@wido-laptop.pcextreme.nl>
	<CAMwB3Tgyo1ug7tUUkHJAyoct_T6O=pZY1P78_z5FJiO2D10M7g@mail.gmail.com>
	<CAF3hT9BbWvztQE=Mn3NW5OQ9ktHAe0AoW6m0aC9WqfyY1b7jBQ@mail.gmail.com>
	<-4123305127044475997@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52597 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab1G1Jve convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 05:51:34 -0400
Received: by fxh19 with SMTP id 19so1108182fxh.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 02:51:33 -0700 (PDT)
In-Reply-To: <-4123305127044475997@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2011/7/28 S=C5=82awomir Skowron <szibis@gmail.com>:
> Dnia 27 lip 2011 o godz. 18:15 Gregory Farnum
> <gregory.farnum@dreamhost.com> napisa=C5=82(a):
>
>> 2011/7/27 S=C5=82awomir Skowron <szibis@gmail.com>:
>>> Ok, I will show example:
>>>
>>> rados df
>>> pool name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 K=
B =C2=A0 =C2=A0 =C2=A0objects =C2=A0 =C2=A0 =C2=A0 clones =C2=A0 =C2=A0=
 degraded
>>> =C2=A0unfound =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rd =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rd KB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wr =C2=A0 =C2=A0 =C2=
=A0 =C2=A0wr KB
>>> .log =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
558212 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>> =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A02844888 =C2=
=A0 =C2=A0 =C2=A02844888
>>> .pool =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0
>>> =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A08 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08
>>> .rgw =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0
>>> =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>> .users =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>> =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01
>>> .users.email =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>> =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01
>>> .users.uid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>> =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A02 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02
>>> data =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0
>>> =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>> metadata =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>> =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>> rbd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00
>>> =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>> sstest =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032244226 =C2=
=A0 =C2=A0 =C2=A02841055 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 653353
>>> =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 17066724 =C2=A0 =C2=
=A0 32370391
>>> =C2=A0total used =C2=A0 =C2=A0 =C2=A0 324792996 =C2=A0 =C2=A0 =C2=A0=
2841071
>>> =C2=A0total avail =C2=A0 =C2=A031083452176
>>> =C2=A0total space =C2=A0 =C2=A033043244460
>>>
>>> It means I have almost 3mln of objects in sstest.
>>>
>>> pg_pool 7 'sstest' pg_pool(rep pg_size 3 crush_ruleset 0 object_has=
h
>>> rjenkins pg_num 8 pgp_num 8 lpg_num 0 lpgp_num 0 last_change 21 own=
er
>>> 0)
>>>
>>> 3 copies in this pool.
>>>
>>> sstest used 32.244.226 KB + log 558.212 KB =3D 32.802.438 KB
>>>
>>> Total used is 324.792.996 KB and it's almost 10x more.
>>>
>>> 2011-07-27 12:57:35.541556 =C2=A0 =C2=A0pg v54158: 6986 pgs: 8 acti=
ve, 6978
>>> active+clean; 32104 MB data, 310 GB used, 29642 GB / 31512 GB avail=
;
>>>
>>> I'am putting files beetwen 4-50KB on RADOS via s3 clilent, and rado=
sgw.
>>>
>>>
>>> Can you explain that to me on this example from real life ??
>>
>> Hmm, what underlying filesystem are you using? Do you have any loggi=
ng
>> enabled, and what disk is it logging to? Are all your OSDs running
>> under the same OS, or are they in virtual machines?
>
> I use ext4. I have loging enabled in osd and mon for most everything =
in 20.
> Every osd is running on same version of debian 6 booted from network.
> In my testing case i use two machines and they are using the same
> configuration and system.
> They are not a VM's.
>
>> If I remember correctly, that "total used" count is generated by
>> looking at df or something for the drives in question -- if there's
>> other data on the same drive as the OSD, it'll get (admittedly
>> incorrectly) counted as part of the "total used" by RADOS even if
>> RADOS can't touch it.

When you write this i check something and i think it is what you sugges=
t.

Because of my test before i mount ext4 filesystems in /data/osd.(osd
id), but /data was a symlink to /var/data/ and i think total used
space was higher by a size of var, and there are logs, lots of logs
:). Ceph produce many logs in such verbosity. Tell me if im wrong.

Now its look like this, and it's looks better :)

2011-07-28 11:44:08.227278    pg v110939: 6986 pgs: 8 active, 6978
active+clean; 42441 MB data, 223 GB used, 29457 GB / 31240 GB avail

rados df
pool name                 KB      objects       clones     degraded
  unfound           rd        rd KB           wr        wr KB
=2Elog                  694273            6            0            0
       0            0            0      3539909      3539909
=2Epool                      1            1            0            0
       0            0            0            8            8
=2Ergw                       0            6            0            0
       0            0            0            1            0
=2Eusers                     1            1            0            0
       0            0            0            1            1
=2Eusers.email               1            1            0            0
       0            0            0            1            1
=2Eusers.uid                 2            2            0            0
       0            1            0            2            2
data                       0            0            0            0
       0            0            0            0            0
metadata                   0            0            0            0
       0            0            0            0            0
rbd                        0            0            0            0
       0            0            0            0            0
sstest              42766318      3483690            0            0
       0            0            0     20922736     42892546
  total used       234415408      3483707
  total avail    30888365376
  total space    32757780072

>> -Greg
>
> Every machine setup is same and looks like this:
>
> 2 x 300GB SAS -> hardware RAID1 -> root filesystem and ceph logs in
> /var/log/(osd,mon)
> 12 x 2TB SATA -> hardware RAID5 + 1 Spare -> 16 x 1TB (raid usable
> space is bigger) ceph osd mounted as ext4 in /data/osd.(osd id)
>
> For test only i run journal in the same lun as the osd, because two
> SAS drives is not enough, but in real scenario system will run on one
> SAS drive for OS, journals on one SSD, and rest on SATA drives, or
> system and journals on RAID 1 SSD drives.
>
> If i count journals on two machines it 32 x 512MB, and its only 16GB
> more in rados df in calculation. Where is more ??
>
> With regards
> Slawomir Skowron
>



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
