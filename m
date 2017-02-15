From: kefu chai <tchaikov@gmail.com>
Subject: Re: OSD has the store locked???
Date: Wed, 15 Feb 2017 10:51:29 +0800
Message-ID: <CAJE9aOMN4T_E2TekdtrJ5YXwcQFRH=bxLSjnUBdsJHbPesoTiQ@mail.gmail.com>
References: <557f1d59-33c5-3da3-926e-f87160da272b@digiware.nl>
 <598746059.1724.1487085785680.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
 <7c322e3d-1c6b-7369-d196-52106dd114e6@digiware.nl> <CAJE9aOOOPrQjphwTkj6+hZ7M8dEw=+5crB_KgOnU2tyXJd9ZKw@mail.gmail.com>
 <1932d5fb-6e0c-6797-7e02-c11cda618dab@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33939 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdBOCva (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 21:51:30 -0500
Received: by mail-ua0-f172.google.com with SMTP id 35so98435018uak.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 18:51:30 -0800 (PST)
In-Reply-To: <1932d5fb-6e0c-6797-7e02-c11cda618dab@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: "wido@42on.com" <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Feb 15, 2017 at 6:58 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 14-2-2017 18:11, kefu chai wrote:
>> On Tue, Feb 14, 2017 at 11:55 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> On 14-2-2017 16:23, wido@42on.com wrote:
>>>>
>>>>
>>>>> Op 14 feb. 2017 om 14:57 heeft Willem Jan Withagen <wjw@digiware.nl> het volgende geschreven:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Running ceph_objectstore_tool.py just about all command get the
>>>>> complaint that "OSD has the store locked".
>>>>>
>>>>
>>>> Is the OSD still running? If so, stop it first.
>>>>
>>>> Wido
>>>>
>>>>> Like:
>>>>> Test --op list variants
>>>>> OSD has the store locked
>>>>> ERROR:Bad exit status 1 from
>>>>> /home/jenkins/workspace/ceph-master/build/bin/ceph-objectstore-tool
>>>>> --data-path /home/jenkins/workspace/ceph-master/build/cot_dir/dev/osd0
>>>>> --op list --format json
>>>>>
>>>>> Why would I get "the store locked"??
>>>
>>> Hi Wido,
>>>
>>> A usual I have to apologize for not supplying all the details.
>>>
>>> This is from my FreeBSD ceph-master jenkins testbot, that runs into this
>>> problem over, over and over.
>>> The tests are serialized, so I'd expect to have no OSDs leftover before
>>> a new test is running.
>>>
>>> ATM there are no OSDs running.
>>>
>>> Who is generating this error:
>>>         ceph_objectstore_tool itself
>>> or      the OSD via one of the com-channels
>>>
>>
>> Willem, this issue is spotted in the jenkins run on github also.
>
> Any fix in sight?
> Or things I can do to help figure it out?

it's already fixed by https://github.com/ceph/ceph/pull/13419.

>
> --WjW
>
>



-- 
Regards
Kefu Chai
