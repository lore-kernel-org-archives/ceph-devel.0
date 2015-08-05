From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production environment
Date: Wed, 5 Aug 2015 13:36:15 +0200
Message-ID: <1E312EE4-1E0F-4AE6-9358-24AC2E0C80A5@schermer.cz>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com> <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com> <B655F3AF-5BCE-4285-BD86-79E4DC666261@altitudedigital.com> <2AC2209D-3738-41A9-BAD3-5E32CC3E7ADC@schermer.cz> <55C186D4.5040000@unitedstack.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3075\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38011 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbHELgS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Aug 2015 07:36:18 -0400
Received: by wibxm9 with SMTP id xm9so62506978wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 05 Aug 2015 04:36:16 -0700 (PDT)
In-Reply-To: <55C186D4.5040000@unitedstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <qiaojianfeng@unitedstack.com>
Cc: Marek Dohojda <mdohojda@altitudedigital.com>, Samuel Just <sjust@redhat.com>, =?utf-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, cbt@ceph.com

Hi,
comments inline.

> On 05 Aug 2015, at 05:45, Jevon Qiao <qiaojianfeng@unitedstack.com> w=
rote:
>=20
> Hi Jan,
>=20
> Thank you for the detailed suggestion. Please see my reply in-line.
> On 5/8/15 01:23, Jan Schermer wrote:
>> I think I wrote about my experience with this about 3 months ago, in=
cluding what techniques I used to minimize impact on production.
>>=20
>> Basicaly we had to
>> 1) increase pg_num in small increments only, bcreating the placement=
 groups themselves caused slowed requests on OSDs
>> 2) increse pgp_num in small increments and then go higher
> So you totally completed the step 1 before jumping into step 2. Have =
you ever tried mixing them together? Increase pg_number, increase pgp_n=
umber, increase pg_number=E2=80=A6

Actually we first increased both to 8192 and then decided to go higher,=
 but that doesn=E2=80=99t matter.
The only reason for this was that the first step took could run unatten=
ded at night without disturbing the workload.*
The second step had to be attended.

* in other words, we didn=E2=80=99t see =E2=80=9Cslow requests=E2=80=9D=
 because of our threshold settings, but while PGs were creating the clu=
ster paused IO for non-trivial amounts of time. I suggest you do this i=
n as small steps as possible, depending on your SLAs.

>> We went from 4096 placement groups up to 16384
>>=20
>> pg_num (the number of on-disk created placement groups) was increase=
d like this:
>> # for i in `seq 4096 64 16384` ; do ceph osd pool set $pool pg_num $=
i ; sleep 60 ; done
>> this ran overnight (and was upped to 128 step during the night)
>>=20
>> Increasing pgp_num was trickier in our case, first because it was he=
avy production and we wanted to minimize the visible impact and second =
because of wildly differing free space on the OSDs.
>> We did it again in steps and waited for the cluster to settle before=
 continuing.
>> Each step upped pgp_num by about 2% and as we got higher (>8192) we =
increased this to much more - the last step was 15360->16384 with the s=
ame impact the initial 4096->4160 had.
> The strategy you adopted looks great. I'll do some experiments on a t=
est cluster to evaluate the real impact in each step
>> The end result is much better but still nowhere near optimal - bigge=
r impact would be upgrading to a newer Ceph release and setting the new=
 tunables because we=E2=80=99re running Dumpling.
>>=20
>> Be aware that PGs cost some space (rough estimate is 5GB per OSD in =
our case), and also quite a bit of memory - each OSD has 1.7-2.0GB RSS =
right now while it only had about 1GB before. That=E2=80=99s a lot of m=
emory and space with higher OSD counts...
> This is a good point. So along with the increment of PGs, we also nee=
d to take the current status of the cluster(the available disk space an=
d memory for each OSD) into account and evaluate whether it is needed t=
o add more resources.

Depends on how much free space you have. We had some OSDs at close to 8=
5% capacity before we started (and other OSD=E2=80=99s at only 30%). Wh=
en increasing the number of PGs the data shuffled greatly - but this de=
pends on what CRUSH rules you have (and what version you are running). =
Newer versions with newer tunables will make this a lot easier I guess.

>> And while I haven=E2=80=99t calculated the number of _objects_ per P=
G, but we have differing numbers of _placement_groups_ per OSD (one OSD=
 hosts 500, another hosts 1300) and this seems to be the cause of poor =
data balancing.
> In our environment, we also encountered the imbalance mapping between=
 PGs and OSD. What kind of bucket algorithm was used in your environmen=
t? Any idea on how to minimize it?

We are using straw because of dumpling. Straw2 should make everything b=
etter :-)

Jan

>=20
> Thanks,
> Jevon
>> Jan
>>=20
>>=20
>>> On 04 Aug 2015, at 18:52, Marek Dohojda <mdohojda@altitudedigital.c=
om> wrote:
>>>=20
>>> I have done this not that long ago.  My original PG estimates were =
wrong and I had to increase them.
>>>=20
>>> After increasing the PG numbers the Ceph rebalanced, and that took =
a while.  To be honest in my case the slowdown wasn=E2=80=99t really vi=
sible, but it took a while.
>>>=20
>>> My strong suggestion to you would be to do it in a long IO time, an=
d be prepared that this willl take quite a long time to accomplish.  Do=
 it slowly  and do not increase multiple pools at once.
>>>=20
>>> It isn=E2=80=99t recommended practice but doable.
>>>=20
>>>=20
>>>=20
>>>> On Aug 4, 2015, at 10:46 AM, Samuel Just <sjust@redhat.com> wrote:
>>>>=20
>>>> It will cause a large amount of data movement.  Each new pg after =
the
>>>> split will relocate.  It might be ok if you do it slowly.  Experim=
ent
>>>> on a test cluster.
>>>> -Sam
>>>>=20
>>>> On Mon, Aug 3, 2015 at 12:57 AM, =E4=B9=94=E5=BB=BA=E5=B3=B0 <scal=
eqiao@gmail.com> wrote:
>>>>> Hi Cephers,
>>>>>=20
>>>>> This is a greeting from Jevon. Currently, I'm experiencing an iss=
ue which
>>>>> suffers me a lot, so I'm writing to ask for your comments/help/su=
ggestions.
>>>>> More details are provided bellow.
>>>>>=20
>>>>> Issue:
>>>>> I set up a cluster having 24 OSDs and created one pool with 1024 =
placement
>>>>> groups on it for a small startup company. The number 1024 was cal=
culated per
>>>>> the equation 'OSDs * 100'/pool size. The cluster have been runnin=
g quite
>>>>> well for a long time. But recently, our monitoring system always =
complains
>>>>> that some disks' usage exceed 85%. I log into the system and find=
 out that
>>>>> some disks' usage are really very high, but some are not(less tha=
n 60%).
>>>>> Each time when the issue happens, I have to manually re-balance t=
he
>>>>> distribution. This is a short-term solution, I'm not willing to d=
o it all
>>>>> the time.
>>>>>=20
>>>>> Two long-term solutions come in my mind,
>>>>> 1) Ask the customers to expand their clusters by adding more OSDs=
=2E But I
>>>>> think they will ask me to explain the reason of the imbalance dat=
a
>>>>> distribution. We've already done some analysis on the environment=
, we
>>>>> learned that the most imbalance part in the CRUSH is the mapping =
between
>>>>> object and pg. The biggest pg has 613 objects, while the smallest=
 pg only
>>>>> has 226 objects.
>>>>>=20
>>>>> 2) Increase the number of placement groups. It can be of great he=
lp for
>>>>> statistically uniform data distribution, but it can also incur si=
gnificant
>>>>> data movement as PGs are effective being split. I just cannot do =
it in our
>>>>> customers' environment before we 100% understand the consequence.=
 So anyone
>>>>> did this under a production environment? How much does this opera=
tion affect
>>>>> the performance of Clients?
>>>>>=20
>>>>> Any comments/help/suggestions will be highly appreciated.
>>>>>=20
>>>>> --
>>>>> Best Regards
>>>>> Jevon
>>>>>=20
>>>>> _______________________________________________
>>>>> ceph-users mailing list
>>>>> ceph-users@lists.ceph.com
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>=20
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
