From: Jevon Qiao <qiaojianfeng@unitedstack.com>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production
 environment
Date: Wed, 5 Aug 2015 09:43:46 +0800
Message-ID: <55C16A52.4040403@unitedstack.com>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com>
 <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com>
 <B655F3AF-5BCE-4285-BD86-79E4DC666261@altitudedigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpbg298.qq.com ([184.105.67.102]:56882 "EHLO smtpbg298.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbbHEBoA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Aug 2015 21:44:00 -0400
In-Reply-To: <B655F3AF-5BCE-4285-BD86-79E4DC666261@altitudedigital.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marek Dohojda <mdohojda@altitudedigital.com>, Samuel Just <sjust@redhat.com>
Cc: =?UTF-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, cbt@ceph.com

Thank you and Samuel for the prompt response.
On 5/8/15 00:52, Marek Dohojda wrote:
> I have done this not that long ago.  My original PG estimates were wr=
ong and I had to increase them.
>
> After increasing the PG numbers the Ceph rebalanced, and that took a =
while.  To be honest in my case the slowdown wasn=E2=80=99t really visi=
ble, but it took a while.
How many OSDs do you have in your cluster? How much did you adjust the=20
PG numbers?
> My strong suggestion to you would be to do it in a long IO time, and =
be prepared that this willl take quite a long time to accomplish.  Do i=
t slowly  and do not increase multiple pools at once.
Both you and Samuel said to do it slowly, do you mean to adjust the pg=20
numbers step by step rather than doing it in one step? Also, would you=20
please explain 'a long IO time' in details.

Thanks,
Jevon
> It isn=E2=80=99t recommended practice but doable.
>
>
>> On Aug 4, 2015, at 10:46 AM, Samuel Just <sjust@redhat.com> wrote:
>>
>> It will cause a large amount of data movement.  Each new pg after th=
e
>> split will relocate.  It might be ok if you do it slowly.  Experimen=
t
>> on a test cluster.
>> -Sam
>>
>> On Mon, Aug 3, 2015 at 12:57 AM, =E4=B9=94=E5=BB=BA=E5=B3=B0 <scaleq=
iao@gmail.com> wrote:
>>> Hi Cephers,
>>>
>>> This is a greeting from Jevon. Currently, I'm experiencing an issue=
 which
>>> suffers me a lot, so I'm writing to ask for your comments/help/sugg=
estions.
>>> More details are provided bellow.
>>>
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
>>>
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
>>>
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
>>>
>>> Any comments/help/suggestions will be highly appreciated.
>>>
>>> --
>>> Best Regards
>>> Jevon
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.htmlml

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
