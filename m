From: Bryan Stillwell <bstillwell@photobucket.com>
Subject: Re: Adjusting replicas on argonaut
Date: Tue, 8 Jan 2013 15:58:26 -0700
Message-ID: <CADAfL_h5K9ttYpoO-Ad=1wg99qRAvvHcQucTtk669E+9eBmi2A@mail.gmail.com>
References: <CADAfL_gk43_CQsEWY7Nn0uibLneGox5cdUj0g_1+LWOUNWth+g@mail.gmail.com>
	<CAPYLRzi=po0r6Om=EA-rosffvkpGV38PbHee8mxg96kLKMhxnw@mail.gmail.com>
	<CADAfL_j-XJgjWUOGFczk941wdTTNdFoM=DTZzYWOqrHjaTxHKA@mail.gmail.com>
	<CAPYLRzhVZ-TMO63ihqOyh7e92JsxnpRm-d7bdmmH6gxhK3-KAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:54486 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236Ab3AHW61 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 17:58:27 -0500
Received: by mail-ob0-f178.google.com with SMTP id eh20so1488462obb.9
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 14:58:26 -0800 (PST)
In-Reply-To: <CAPYLRzhVZ-TMO63ihqOyh7e92JsxnpRm-d7bdmmH6gxhK3-KAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I appreciate you giving more detail on this.  I plan on expanding the
test cluster to 5 servers soon, so I'll just wait until then before
changing the number of replicas.

Thanks,
Bryan

On Tue, Jan 8, 2013 at 3:49 PM, Gregory Farnum <greg@inktank.com> wrote:
> Yep! The "step chooseleaf firstn 0 type host" means "choose n nodes of
> type host, and select a leaf under each one of them", where n is the
> pool size. You only have two hosts so it can't do more than 2 with
> that rule type.
> You could do "step chooseleaf firstn 0 type device", but that won't
> guarantee a segregation across hosts, unfortunately. CRUSH isn't great
> at dealing with situations where you want your number of copies to be
> equal to or greater than your total failure domain counts. You can
> make it work if you're willing to hardcode some stuff but it's not
> real pleasant.
> -Greg
>
> On Tue, Jan 8, 2013 at 2:28 PM, Bryan Stillwell
> <bstillwell@photobucket.com> wrote:
>> That would make sense.  Here's what the metadata rule looks like:
>>
>> rule metadata {
>>         ruleset 1
>>         type replicated
>>         min_size 2
>>         max_size 10
>>         step take default
>>         step chooseleaf firstn 0 type host
>>         step emit
>> }
>>
>> On Tue, Jan 8, 2013 at 3:23 PM, Gregory Farnum <greg@inktank.com> wrote:
>>> What are your CRUSH rules? Depending on how you set this cluster up,
>>> it might not be placing more than one replica in a single host, and
>>> you've only got two hosts so it couldn't satisfy your request for 3
>>> copies.
>>> -Greg
>>>
>>> On Tue, Jan 8, 2013 at 2:11 PM, Bryan Stillwell
>>> <bstillwell@photobucket.com> wrote:
>>>> I tried increasing the number of metadata replicas from 2 to 3 on my
>>>> test cluster with the following command:
>>>>
>>>> ceph osd pool set metadata size 3
>>>>
>>>>
>>>> Afterwards it appears that all the metadata placement groups switch to
>>>> a degraded state and doesn't seem to be attempting to recover:
>>>>
>>>> 2013-01-08 14:49:37.352735 mon.0 [INF] pgmap v156393: 1920 pgs: 1280
>>>> active+clean, 640 active+degraded; 903 GB data, 1820 GB used, 2829 GB
>>>> / 4650 GB avail; 1255/486359 degraded (0.258%)
>>>>
>>>>
>>>> Does anything need to be done after increasing the number of replicas?
>>>>
>>>> Here's what the OSD tree looks like:
>>>>
>>>> root@a1:~# ceph osd tree
>>>> dumped osdmap tree epoch 1303
>>>> # id    weight  type name       up/down reweight
>>>> -1      4.99557 pool default
>>>> -3      4.99557         rack unknownrack
>>>> -2      2.49779                 host b1
>>>> 0       0.499557                                osd.0   up      1
>>>> 1       0.499557                                osd.1   up      1
>>>> 2       0.499557                                osd.2   up      1
>>>> 3       0.499557                                osd.3   up      1
>>>> 4       0.499557                                osd.4   up      1
>>>> -4      2.49779                 host b2
>>>> 5       0.499557                                osd.5   up      1
>>>> 6       0.499557                                osd.6   up      1
>>>> 7       0.499557                                osd.7   up      1
>>>> 8       0.499557                                osd.8   up      1
>>>> 9       0.499557                                osd.9   up      1
>>>>
>>>>
>>>> Thanks,
>>>> Bryan
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>>
>>
>> Bryan Stillwell
>> SYSTEM ADMINISTRATOR
>>
>> E: bstillwell@photobucket.com
>> O: 303.228.5109
>> M: 970.310.6085



-- 


Bryan Stillwell
SYSTEM ADMINISTRATOR

E: bstillwell@photobucket.com
O: 303.228.5109
M: 970.310.6085
