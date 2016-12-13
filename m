From: Varada Kari <varada.kari@gmail.com>
Subject: Re: Reshard is not stabilizing in latest master
Date: Tue, 13 Dec 2016 20:36:57 +0530
Message-ID: <CABbLZY3XBBj0wfekJfOacd4DteMqdCVP1Q2J_SzeRSybXyUQLg@mail.gmail.com>
References: <DM2PR02MB398ED2929DBD480C2CCFC88F4840@DM2PR02MB398.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1612090059480.32281@piezo.novalocal> <BY2PR02MB396DC43832DA107A62066B0F4870@BY2PR02MB396.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1612121738050.25581@piezo.novalocal> <8276d3ed-f169-b4d8-5301-f3d25347b502@mirantis.com>
 <BY2PR02MB396968E5056460170608E6BF4980@BY2PR02MB396.namprd02.prod.outlook.com>
 <2abd6172-75bf-2b42-0a5a-33eeb24da648@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36326 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbcLMPHA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 10:07:00 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so18839485wma.3
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 07:07:00 -0800 (PST)
In-Reply-To: <2abd6172-75bf-2b42-0a5a-33eeb24da648@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Somnath might be using some of config params to expedite the sharding
like max_blob_size etc.. along with some more configs. He shared them
in the call yesterday.

Varada

On Tue, Dec 13, 2016 at 7:13 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> Any changes in shards serialization or general encoding infra since that
> time?
>
> shard min/max size changes?
>
>
>
> On 12.12.2016 21:03, Somnath Roy wrote:
>>
>> Make sense , but, any idea why it is showing up now as it is not happening
>> with old master ? What possibly I did to reproduce it, just curious.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
>> Sent: Monday, December 12, 2016 9:46 AM
>> To: Sage Weil; Somnath Roy
>> Cc: ceph-devel
>> Subject: Re: Reshard is not stabilizing in latest master
>>
>> yeah, I've got the same explanation 10 min ago.
>> PR is ready too:
>> https://github.com/ceph/ceph/pull/12447
>>
>> On 12.12.2016 20:39, Sage Weil wrote:
>>>
>>> On Fri, 9 Dec 2016, Somnath Roy wrote:
>>>>
>>>> Sage,
>>>> Please find it in the following location , it's a zipped file.
>>>>
>>>> https://drive.google.com/open?id=0B7W-S0z_ymMJd0V1XzVhQWR4ak0
>>>>
>>>>
>>>> What I found that the following shard length always comes below
>>>> bluestore_extent_map_shard_min_size and triggering reshard.
>>>>
>>>> 2016-12-08 20:07:56.950527 7fe9140f7700 20
>>>> bluestore.extentmap(0x557183546d48) update shard 0x3ff000 is 25 bytes
>>>> (was 25) from 1 extents
>>>
>>> All of the instances are at offset 0x3ff000, which is right at the end
>>> of the object.  I think we just need some special case code to handle
>>> when the last little bit ends up being small, and pull it into the
>>> previous shard (probably).
>>>
>>> sage
>>>
>>>
>>>> Thanks & Regards
>>>> Somnath
>>>>
>>>> -----Original Message-----
>>>> From: Sage Weil [mailto:sweil@redhat.com]
>>>> Sent: Thursday, December 08, 2016 5:00 PM
>>>> To: Somnath Roy
>>>> Cc: ceph-devel
>>>> Subject: Re: Reshard is not stabilizing in latest master
>>>>
>>>> On Thu, 8 Dec 2016, Somnath Roy wrote:
>>>>>
>>>>> Sage,
>>>>> I am seeing reshard is not stabilizing even after I precondition an
>>>>> image with 4K seq. It was happening with 2 weeks old master. Anything change
>>>>> on that part of the code base recently ? Otherwise I need to debug.
>>>>
>>>> Nope.  If you have a cluster where it isn't stabilizing just turn on
>>>> debug bluestore = 20 for a minute and send me the log.
>>>>
>>>> sage
>>>> PLEASE NOTE: The information contained in this electronic mail message
>>>> is intended only for the use of the designated recipient(s) named above. If
>>>> the reader of this message is not the intended recipient, you are hereby
>>>> notified that you have received this message in error and that any review,
>>>> dissemination, distribution, or copying of this message is strictly
>>>> prohibited. If you have received this communication in error, please notify
>>>> the sender by telephone or e-mail (as shown above) immediately and destroy
>>>> any and all copies of this message in your possession (whether hard copies
>>>> or electronically stored copies).
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
