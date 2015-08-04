From: Ketor D <d.ketor@gmail.com>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production environment
Date: Wed, 5 Aug 2015 03:16:48 +0800
Message-ID: <CAM9_UU8Mxycvk91NSrFSMQ5=jDxaXcajzB7CTGDZ2sJJ0YW7-w@mail.gmail.com>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com>
 <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com> <55C0ED88.2050102@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34669 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbbHDTRS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 15:17:18 -0400
Received: by obre1 with SMTP id e1so14841541obr.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 12:17:17 -0700 (PDT)
In-Reply-To: <55C0ED88.2050102@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Samuel Just <sjust@redhat.com>, =?UTF-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, cbt@ceph.com

Hi Stefan,
      Could you describe more about the linger ops bug?
      I'm runing Firefly as you say still has this bug.

Thanks!

On Wed, Aug 5, 2015 at 12:51 AM, Stefan Priebe <s.priebe@profihost.ag> =
wrote:
> We've done the splitting several times. The most important thing is t=
o run a
> ceph version which does not have the linger ops bug.
>
> This is dumpling latest release, giant and hammer. Latest firefly rel=
ease
> still has this bug. Which results in wrong watchers and no working
> snapshots.
>
> Stefan
>
> Am 04.08.2015 um 18:46 schrieb Samuel Just:
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
>>>
>>> Hi Cephers,
>>>
>>> This is a greeting from Jevon. Currently, I'm experiencing an issue=
 which
>>> suffers me a lot, so I'm writing to ask for your
>>> comments/help/suggestions.
>>> More details are provided bellow.
>>>
>>> Issue:
>>> I set up a cluster having 24 OSDs and created one pool with 1024
>>> placement
>>> groups on it for a small startup company. The number 1024 was calcu=
lated
>>> per
>>> the equation 'OSDs * 100'/pool size. The cluster have been running =
quite
>>> well for a long time. But recently, our monitoring system always
>>> complains
>>> that some disks' usage exceed 85%. I log into the system and find o=
ut
>>> that
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
>>> statistically uniform data distribution, but it can also incur
>>> significant
>>> data movement as PGs are effective being split. I just cannot do it=
 in
>>> our
>>> customers' environment before we 100% understand the consequence. S=
o
>>> anyone
>>> did this under a production environment? How much does this operati=
on
>>> affect
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
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
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
