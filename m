From: kefu chai <tchaikov@gmail.com>
Subject: Re: OSD has the store locked???
Date: Wed, 15 Feb 2017 01:11:21 +0800
Message-ID: <CAJE9aOOOPrQjphwTkj6+hZ7M8dEw=+5crB_KgOnU2tyXJd9ZKw@mail.gmail.com>
References: <557f1d59-33c5-3da3-926e-f87160da272b@digiware.nl>
 <598746059.1724.1487085785680.JavaMail.open-xchange@ox03.mail.pcextreme.nl> <7c322e3d-1c6b-7369-d196-52106dd114e6@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:33889 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbdBNRLX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 12:11:23 -0500
Received: by mail-ua0-f173.google.com with SMTP id 35so90297346uak.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 09:11:22 -0800 (PST)
In-Reply-To: <7c322e3d-1c6b-7369-d196-52106dd114e6@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: "wido@42on.com" <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 14, 2017 at 11:55 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 14-2-2017 16:23, wido@42on.com wrote:
>>
>>
>>> Op 14 feb. 2017 om 14:57 heeft Willem Jan Withagen <wjw@digiware.nl> het volgende geschreven:
>>>
>>> Hi,
>>>
>>> Running ceph_objectstore_tool.py just about all command get the
>>> complaint that "OSD has the store locked".
>>>
>>
>> Is the OSD still running? If so, stop it first.
>>
>> Wido
>>
>>> Like:
>>> Test --op list variants
>>> OSD has the store locked
>>> ERROR:Bad exit status 1 from
>>> /home/jenkins/workspace/ceph-master/build/bin/ceph-objectstore-tool
>>> --data-path /home/jenkins/workspace/ceph-master/build/cot_dir/dev/osd0
>>> --op list --format json
>>>
>>> Why would I get "the store locked"??
>
> Hi Wido,
>
> A usual I have to apologize for not supplying all the details.
>
> This is from my FreeBSD ceph-master jenkins testbot, that runs into this
> problem over, over and over.
> The tests are serialized, so I'd expect to have no OSDs leftover before
> a new test is running.
>
> ATM there are no OSDs running.
>
> Who is generating this error:
>         ceph_objectstore_tool itself
> or      the OSD via one of the com-channels
>

Willem, this issue is spotted in the jenkins run on github also.

> --WjW
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
