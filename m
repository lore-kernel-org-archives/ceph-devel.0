From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production environment
Date: Tue, 4 Aug 2015 19:23:20 +0200
Message-ID: <2AC2209D-3738-41A9-BAD3-5E32CC3E7ADC@schermer.cz>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com> <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com> <B655F3AF-5BCE-4285-BD86-79E4DC666261@altitudedigital.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3073\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33901 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbbHDRXY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 13:23:24 -0400
Received: by wibud3 with SMTP id ud3so186558906wib.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 10:23:22 -0700 (PDT)
In-Reply-To: <B655F3AF-5BCE-4285-BD86-79E4DC666261@altitudedigital.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marek Dohojda <mdohojda@altitudedigital.com>
Cc: Samuel Just <sjust@redhat.com>, =?utf-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, cbt@ceph.com

I think I wrote about my experience with this about 3 months ago, inclu=
ding what techniques I used to minimize impact on production.

Basicaly we had to
1) increase pg_num in small increments only, bcreating the placement gr=
oups themselves caused slowed requests on OSDs
2) increse pgp_num in small increments and then go higher

We went from 4096 placement groups up to 16384

pg_num (the number of on-disk created placement groups) was increased l=
ike this:
# for i in `seq 4096 64 16384` ; do ceph osd pool set $pool pg_num $i ;=
 sleep 60 ; done
this ran overnight (and was upped to 128 step during the night)

Increasing pgp_num was trickier in our case, first because it was heavy=
 production and we wanted to minimize the visible impact and second bec=
ause of wildly differing free space on the OSDs.
We did it again in steps and waited for the cluster to settle before co=
ntinuing.
Each step upped pgp_num by about 2% and as we got higher (>8192) we inc=
reased this to much more - the last step was 15360->16384 with the same=
 impact the initial 4096->4160 had.

The end result is much better but still nowhere near optimal - bigger i=
mpact would be upgrading to a newer Ceph release and setting the new tu=
nables because we=E2=80=99re running Dumpling.

Be aware that PGs cost some space (rough estimate is 5GB per OSD in our=
 case), and also quite a bit of memory - each OSD has 1.7-2.0GB RSS rig=
ht now while it only had about 1GB before. That=E2=80=99s a lot of memo=
ry and space with higher OSD counts...

And while I haven=E2=80=99t calculated the number of _objects_ per PG, =
but we have differing numbers of _placement_groups_ per OSD (one OSD ho=
sts 500, another hosts 1300) and this seems to be the cause of poor dat=
a balancing.

Jan


> On 04 Aug 2015, at 18:52, Marek Dohojda <mdohojda@altitudedigital.com=
> wrote:
>=20
> I have done this not that long ago.  My original PG estimates were wr=
ong and I had to increase them. =20
>=20
> After increasing the PG numbers the Ceph rebalanced, and that took a =
while.  To be honest in my case the slowdown wasn=E2=80=99t really visi=
ble, but it took a while. =20
>=20
> My strong suggestion to you would be to do it in a long IO time, and =
be prepared that this willl take quite a long time to accomplish.  Do i=
t slowly  and do not increase multiple pools at once.=20
>=20
> It isn=E2=80=99t recommended practice but doable.
>=20
>=20
>=20
>> On Aug 4, 2015, at 10:46 AM, Samuel Just <sjust@redhat.com> wrote:
>>=20
>> It will cause a large amount of data movement.  Each new pg after th=
e
>> split will relocate.  It might be ok if you do it slowly.  Experimen=
t
>> on a test cluster.
>> -Sam
>>=20
>> On Mon, Aug 3, 2015 at 12:57 AM, =E4=B9=94=E5=BB=BA=E5=B3=B0 <scaleq=
iao@gmail.com> wrote:
>>> Hi Cephers,
>>>=20
>>> This is a greeting from Jevon. Currently, I'm experiencing an issue=
 which
>>> suffers me a lot, so I'm writing to ask for your comments/help/sugg=
estions.
>>> More details are provided bellow.
>>>=20
>>> Issue:
>>> I set up a cluster having 24 OSDs and created one pool with 1024 pl=
acement
>>> groups on it for a small startup company. The number 1024 was calcu=
lated per
>>> the equation 'OSDs * 100'/pool size. The cluster have been running =
quite
>>> well for a long time. But recently, our monitoring system always co=
mplains
>>> that some disks' usage exceed 85%. I log into the system and find o=
ut that
>>> some disks' usage are really very high, but some are not(less than =
60%).
>>> Each time when the issue happens, I have to manually re-balance the
>>> distribution. This is a short-term solution, I'm not willing to do =
it all
>>> the time.
>>>=20
>>> Two long-term solutions come in my mind,
>>> 1) Ask the customers to expand their clusters by adding more OSDs. =
But I
>>> think they will ask me to explain the reason of the imbalance data
>>> distribution. We've already done some analysis on the environment, =
we
>>> learned that the most imbalance part in the CRUSH is the mapping be=
tween
>>> object and pg. The biggest pg has 613 objects, while the smallest p=
g only
>>> has 226 objects.
>>>=20
>>> 2) Increase the number of placement groups. It can be of great help=
 for
>>> statistically uniform data distribution, but it can also incur sign=
ificant
>>> data movement as PGs are effective being split. I just cannot do it=
 in our
>>> customers' environment before we 100% understand the consequence. S=
o anyone
>>> did this under a production environment? How much does this operati=
on affect
>>> the performance of Clients?
>>>=20
>>> Any comments/help/suggestions will be highly appreciated.
>>>=20
>>> --
>>> Best Regards
>>> Jevon
>>>=20
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>=20
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
