From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Two questions
Date: Wed, 27 Jul 2011 13:05:14 +0200
Message-ID: <CAMwB3Tgyo1ug7tUUkHJAyoct_T6O=pZY1P78_z5FJiO2D10M7g@mail.gmail.com>
References: <8685614628192678277@unknownmsgid>
	<1311750865.2751.4.camel@wido-laptop.pcextreme.nl>
	<CAMwB3Ti66BpfdfwPx3XgmVQv2GAQ_Gc2beHRc6pBcWwphf_bhQ@mail.gmail.com>
	<1311763628.2751.34.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:34590 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab1G0LFP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 07:05:15 -0400
Received: by fxd18 with SMTP id 18so300917fxd.11
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 04:05:14 -0700 (PDT)
In-Reply-To: <1311763628.2751.34.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ok, I will show example:

rados df
pool name                 KB      objects       clones     degraded
  unfound           rd        rd KB           wr        wr KB
=2Elog                  558212            5            0            0
       0            0            0      2844888      2844888
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
sstest              32244226      2841055            0       653353
       0            0            0     17066724     32370391
  total used       324792996      2841071
  total avail    31083452176
  total space    33043244460

It means I have almost 3mln of objects in sstest.

pg_pool 7 'sstest' pg_pool(rep pg_size 3 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 lpg_num 0 lpgp_num 0 last_change 21 owner
0)

3 copies in this pool.

sstest used 32.244.226 KB + log 558.212 KB =3D 32.802.438 KB

Total used is 324.792.996 KB and it's almost 10x more.

2011-07-27 12:57:35.541556    pg v54158: 6986 pgs: 8 active, 6978
active+clean; 32104 MB data, 310 GB used, 29642 GB / 31512 GB avail;

I'am putting files beetwen 4-50KB on RADOS via s3 clilent, and radosgw.


Can you explain that to me on this example from real life ??


2011/7/27 Wido den Hollander <wido@widodh.nl>:
> Hi,
>
> On Wed, 2011-07-27 at 12:19 +0200, S=B3awomir Skowron wrote:
>> Thanks.
>>
>> 2011/7/27 Wido den Hollander <wido@widodh.nl>:
>> > Hi,
>> >
>> > On Wed, 2011-07-27 at 07:58 +0200, S=B3awomir Skowron wrote:
>> >> Hello. I have some questions.
>> >>
>> >> 1. Is there any chance to change default 4MB object size to for
>> >> example 1MB or less ??
>> >
>> > If you are using the filesystem, you can change the stripe-size pe=
r
>> > directory with the "cephfs" tool.
>>
>> Unfortunately i only use rados layer in this case, and i even don't
>> have any mds :) is there any chance to change this in rados layer ??
>
> The RADOS gateway does NOT stripe over multiple objects. If you uploa=
d a
> 1GB object through the RADOS gateway it will be a 1GB object.
>
> Only the RBD (Rados Block Device) and the Ceph filesystem do striping
> over RADOS objects.
>
> RADOS itself doesn't stripe and the RADOS gateway is a almost 1:1
> mapping of pools and objects.
>
> Wido
>
>>
>> >>
>> >> 2. I have create cluster of two mons, and 32 osd (1TB each) on tw=
o
>> >> machines. At this radosgw with apache2 for test. When i putting d=
ata
>> >> from s3 client to rados, everything is ok, but when one of osd is
>> >> going down all s3 clients going to be freeze for some seconds, be=
fore
>> >> ceph sign this osd as down, and then everything is starting worki=
ng
>> >> again wit degraded osd. How can i tune this marking as a down for=
 ms
>> >> or 0 :) and not for seconds freeze ??
>> >
>> > Normally a OSD should be down within about 10 seconds and shouldn'=
t
>> > affect all I/O operations.
>> >
>> > By default it takes 300 seconds before a OSD gets marked as "out",=
 this
>> > is handled by "mon osd down out interval"
>> >
>> > If you want to change the "down" reporting behaviour you could do =
this
>> > with "osd min down reporters" and "osd min down reports". I'm not =
sure
>> > you really want to do this, as the default values should be ok.
>>
>> Ok. I will check this.
>>
>> > Wido
>> >
>> >>
>> >> My setup is debian 6.0, kernel 2.6.37.6 =A0x86_64 and ceph versio=
n
>> >> 0.31-10 from stable repo.
>> >>
>> >> Best regards
>> >>
>> >> Slawomir Skowron
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>> >
>> >
>> >
>>
>
>
>



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
