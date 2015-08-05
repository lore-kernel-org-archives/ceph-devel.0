From: Jevon Qiao <qiaojianfeng@unitedstack.com>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production
 environment
Date: Wed, 5 Aug 2015 09:50:39 +0800
Message-ID: <55C16BEF.20907@unitedstack.com>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com>
 <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com>
 <55C0ED88.2050102@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpbgsg3.qq.com ([54.179.177.220]:37104 "EHLO smtpbgsg3.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbbHEBu7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Aug 2015 21:50:59 -0400
In-Reply-To: <55C0ED88.2050102@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>, Samuel Just <sjust@redhat.com>, =?UTF-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, cbt@ceph.com

Got it, thank you for the suggestion.

Regards,
Jevon
On 5/8/15 00:51, Stefan Priebe wrote:
> We've done the splitting several times. The most important thing is t=
o=20
> run a ceph version which does not have the linger ops bug.
>
> This is dumpling latest release, giant and hammer. Latest firefly=20
> release still has this bug. Which results in wrong watchers and no=20
> working snapshots.
>
> Stefan
> Am 04.08.2015 um 18:46 schrieb Samuel Just:
>> It will cause a large amount of data movement.  Each new pg after th=
e
>> split will relocate.  It might be ok if you do it slowly. Experiment
>> on a test cluster.
>> -Sam
>>
>> On Mon, Aug 3, 2015 at 12:57 AM, =E4=B9=94=E5=BB=BA=E5=B3=B0 <scaleq=
iao@gmail.com> wrote:
>>> Hi Cephers,
>>>
>>> This is a greeting from Jevon. Currently, I'm experiencing an issue=
=20
>>> which
>>> suffers me a lot, so I'm writing to ask for your=20
>>> comments/help/suggestions.
>>> More details are provided bellow.
>>>
>>> Issue:
>>> I set up a cluster having 24 OSDs and created one pool with 1024=20
>>> placement
>>> groups on it for a small startup company. The number 1024 was=20
>>> calculated per
>>> the equation 'OSDs * 100'/pool size. The cluster have been running=20
>>> quite
>>> well for a long time. But recently, our monitoring system always=20
>>> complains
>>> that some disks' usage exceed 85%. I log into the system and find=20
>>> out that
>>> some disks' usage are really very high, but some are not(less than=20
>>> 60%).
>>> Each time when the issue happens, I have to manually re-balance the
>>> distribution. This is a short-term solution, I'm not willing to do=20
>>> it all
>>> the time.
>>>
>>> Two long-term solutions come in my mind,
>>> 1) Ask the customers to expand their clusters by adding more OSDs.=20
>>> But I
>>> think they will ask me to explain the reason of the imbalance data
>>> distribution. We've already done some analysis on the environment, =
we
>>> learned that the most imbalance part in the CRUSH is the mapping=20
>>> between
>>> object and pg. The biggest pg has 613 objects, while the smallest p=
g=20
>>> only
>>> has 226 objects.
>>>
>>> 2) Increase the number of placement groups. It can be of great help=
 for
>>> statistically uniform data distribution, but it can also incur=20
>>> significant
>>> data movement as PGs are effective being split. I just cannot do it=
=20
>>> in our
>>> customers' environment before we 100% understand the consequence. S=
o=20
>>> anyone
>>> did this under a production environment? How much does this=20
>>> operation affect
>>> the performance of Clients?
>>>
>>> Any comments/help/suggestions will be highly appreciated.
>>>
>>> --=20
>>> Best Regards
>>> Jevon
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
