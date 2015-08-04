From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production
 environment
Date: Tue, 4 Aug 2015 18:51:20 +0200
Message-ID: <55C0ED88.2050102@profihost.ag>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com>
 <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:29208 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbHDQvO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 12:51:14 -0400
In-Reply-To: <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, =?UTF-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, cbt@ceph.com

We've done the splitting several times. The most important thing is to=20
run a ceph version which does not have the linger ops bug.

This is dumpling latest release, giant and hammer. Latest firefly=20
release still has this bug. Which results in wrong watchers and no=20
working snapshots.

Stefan
Am 04.08.2015 um 18:46 schrieb Samuel Just:
> It will cause a large amount of data movement.  Each new pg after the
> split will relocate.  It might be ok if you do it slowly.  Experiment
> on a test cluster.
> -Sam
>
> On Mon, Aug 3, 2015 at 12:57 AM, =E4=B9=94=E5=BB=BA=E5=B3=B0 <scaleqi=
ao@gmail.com> wrote:
>> Hi Cephers,
>>
>> This is a greeting from Jevon. Currently, I'm experiencing an issue =
which
>> suffers me a lot, so I'm writing to ask for your comments/help/sugge=
stions.
>> More details are provided bellow.
>>
>> Issue:
>> I set up a cluster having 24 OSDs and created one pool with 1024 pla=
cement
>> groups on it for a small startup company. The number 1024 was calcul=
ated per
>> the equation 'OSDs * 100'/pool size. The cluster have been running q=
uite
>> well for a long time. But recently, our monitoring system always com=
plains
>> that some disks' usage exceed 85%. I log into the system and find ou=
t that
>> some disks' usage are really very high, but some are not(less than 6=
0%).
>> Each time when the issue happens, I have to manually re-balance the
>> distribution. This is a short-term solution, I'm not willing to do i=
t all
>> the time.
>>
>> Two long-term solutions come in my mind,
>> 1) Ask the customers to expand their clusters by adding more OSDs. B=
ut I
>> think they will ask me to explain the reason of the imbalance data
>> distribution. We've already done some analysis on the environment, w=
e
>> learned that the most imbalance part in the CRUSH is the mapping bet=
ween
>> object and pg. The biggest pg has 613 objects, while the smallest pg=
 only
>> has 226 objects.
>>
>> 2) Increase the number of placement groups. It can be of great help =
for
>> statistically uniform data distribution, but it can also incur signi=
ficant
>> data movement as PGs are effective being split. I just cannot do it =
in our
>> customers' environment before we 100% understand the consequence. So=
 anyone
>> did this under a production environment? How much does this operatio=
n affect
>> the performance of Clients?
>>
>> Any comments/help/suggestions will be highly appreciated.
>>
>> --
>> Best Regards
>> Jevon
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
