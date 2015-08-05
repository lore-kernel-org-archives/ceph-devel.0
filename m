From: Jevon Qiao <qiaojianfeng@unitedstack.com>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production
 environment
Date: Wed, 5 Aug 2015 11:45:24 +0800
Message-ID: <55C186D4.5040000@unitedstack.com>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com>
 <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com>
 <B655F3AF-5BCE-4285-BD86-79E4DC666261@altitudedigital.com>
 <2AC2209D-3738-41A9-BAD3-5E32CC3E7ADC@schermer.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpproxy21.qq.com ([184.105.206.83]:43200 "EHLO
	smtpproxy21.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbHEDqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 23:46:38 -0400
In-Reply-To: <2AC2209D-3738-41A9-BAD3-5E32CC3E7ADC@schermer.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Schermer <jan@schermer.cz>, Marek Dohojda <mdohojda@altitudedigital.com>
Cc: Samuel Just <sjust@redhat.com>, =?UTF-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, cbt@ceph.com

Hi Jan,

Thank you for the detailed suggestion. Please see my reply in-line.
On 5/8/15 01:23, Jan Schermer wrote:
> I think I wrote about my experience with this about 3 months ago, inc=
luding what techniques I used to minimize impact on production.
>
> Basicaly we had to
> 1) increase pg_num in small increments only, bcreating the placement =
groups themselves caused slowed requests on OSDs
> 2) increse pgp_num in small increments and then go higher
So you totally completed the step 1 before jumping into step 2. Have yo=
u=20
ever tried mixing them together? Increase pg_number, increase=20
pgp_number, increase pg_number...
> We went from 4096 placement groups up to 16384
>
> pg_num (the number of on-disk created placement groups) was increased=
 like this:
> # for i in `seq 4096 64 16384` ; do ceph osd pool set $pool pg_num $i=
 ; sleep 60 ; done
> this ran overnight (and was upped to 128 step during the night)
>
> Increasing pgp_num was trickier in our case, first because it was hea=
vy production and we wanted to minimize the visible impact and second b=
ecause of wildly differing free space on the OSDs.
> We did it again in steps and waited for the cluster to settle before =
continuing.
> Each step upped pgp_num by about 2% and as we got higher (>8192) we i=
ncreased this to much more - the last step was 15360->16384 with the sa=
me impact the initial 4096->4160 had.
The strategy you adopted looks great. I'll do some experiments on a tes=
t=20
cluster to evaluate the real impact in each step.
> The end result is much better but still nowhere near optimal - bigger=
 impact would be upgrading to a newer Ceph release and setting the new =
tunables because we=E2=80=99re running Dumpling.
>
> Be aware that PGs cost some space (rough estimate is 5GB per OSD in o=
ur case), and also quite a bit of memory - each OSD has 1.7-2.0GB RSS r=
ight now while it only had about 1GB before. That=E2=80=99s a lot of me=
mory and space with higher OSD counts...
This is a good point. So along with the increment of PGs, we also need=20
to take the current status of the cluster(the available disk space and=20
memory for each OSD) into account and evaluate whether it is needed to=20
add more resources.
> And while I haven=E2=80=99t calculated the number of _objects_ per PG=
, but we have differing numbers of _placement_groups_ per OSD (one OSD =
hosts 500, another hosts 1300) and this seems to be the cause of poor d=
ata balancing.
In our environment, we also encountered the imbalance mapping between=20
PGs and OSD. What kind of bucket algorithm was used in your environment=
?=20
Any idea on how to minimize it?

Thanks,
Jevon
> Jan
>
>
>> On 04 Aug 2015, at 18:52, Marek Dohojda <mdohojda@altitudedigital.co=
m> wrote:
>>
>> I have done this not that long ago.  My original PG estimates were w=
rong and I had to increase them.
>>
>> After increasing the PG numbers the Ceph rebalanced, and that took a=
 while.  To be honest in my case the slowdown wasn=E2=80=99t really vis=
ible, but it took a while.
>>
>> My strong suggestion to you would be to do it in a long IO time, and=
 be prepared that this willl take quite a long time to accomplish.  Do =
it slowly  and do not increase multiple pools at once.
>>
>> It isn=E2=80=99t recommended practice but doable.
>>
>>
>>
>>> On Aug 4, 2015, at 10:46 AM, Samuel Just <sjust@redhat.com> wrote:
>>>
>>> It will cause a large amount of data movement.  Each new pg after t=
he
>>> split will relocate.  It might be ok if you do it slowly.  Experime=
nt
>>> on a test cluster.
>>> -Sam
>>>
>>> On Mon, Aug 3, 2015 at 12:57 AM, =E4=B9=94=E5=BB=BA=E5=B3=B0 <scale=
qiao@gmail.com> wrote:
>>>> Hi Cephers,
>>>>
>>>> This is a greeting from Jevon. Currently, I'm experiencing an issu=
e which
>>>> suffers me a lot, so I'm writing to ask for your comments/help/sug=
gestions.
>>>> More details are provided bellow.
>>>>
>>>> Issue:
>>>> I set up a cluster having 24 OSDs and created one pool with 1024 p=
lacement
>>>> groups on it for a small startup company. The number 1024 was calc=
ulated per
>>>> the equation 'OSDs * 100'/pool size. The cluster have been running=
 quite
>>>> well for a long time. But recently, our monitoring system always c=
omplains
>>>> that some disks' usage exceed 85%. I log into the system and find =
out that
>>>> some disks' usage are really very high, but some are not(less than=
 60%).
>>>> Each time when the issue happens, I have to manually re-balance th=
e
>>>> distribution. This is a short-term solution, I'm not willing to do=
 it all
>>>> the time.
>>>>
>>>> Two long-term solutions come in my mind,
>>>> 1) Ask the customers to expand their clusters by adding more OSDs.=
 But I
>>>> think they will ask me to explain the reason of the imbalance data
>>>> distribution. We've already done some analysis on the environment,=
 we
>>>> learned that the most imbalance part in the CRUSH is the mapping b=
etween
>>>> object and pg. The biggest pg has 613 objects, while the smallest =
pg only
>>>> has 226 objects.
>>>>
>>>> 2) Increase the number of placement groups. It can be of great hel=
p for
>>>> statistically uniform data distribution, but it can also incur sig=
nificant
>>>> data movement as PGs are effective being split. I just cannot do i=
t in our
>>>> customers' environment before we 100% understand the consequence. =
So anyone
>>>> did this under a production environment? How much does this operat=
ion affect
>>>> the performance of Clients?
>>>>
>>>> Any comments/help/suggestions will be highly appreciated.
>>>>
>>>> --
>>>> Best Regards
>>>> Jevon
>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
