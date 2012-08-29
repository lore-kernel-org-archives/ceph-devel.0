From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Unable to set pg_num property of pool "data"
Date: Wed, 29 Aug 2012 15:42:26 +0200
Message-ID: <503E1C42.6040408@widodh.nl>
References: <CAGfy=6n9X87iOwJjT3n3WuBRSxmUS6LnL27v0H10=SJ4YG5f0w@mail.gmail.com> <503DE638.9020002@widodh.nl> <CAGfy=6m-hhwvG4CabDdUy=04ejkDHrnkPqyUCrOkEzETUEd8Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:59698 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab2H2Nm2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 09:42:28 -0400
In-Reply-To: <CAGfy=6m-hhwvG4CabDdUy=04ejkDHrnkPqyUCrOkEzETUEd8Uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

CC back to the list.

On 08/29/2012 12:15 PM, hemant surale wrote:
> $  ceph osd dump -o -|grep pg_num
>
> pg_pool 0 'data' pg_pool(rep pg_size 1 crush_ruleset 0 object_hash
> rjenkins pg_num 200 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 78
> owner 0)

So you are trying to decrease the number of PGs.

Now, I'm not sure if that is supported. But why would you want to do this?

Wido

> pg_pool 1 'metadata' pg_pool(rep pg_size 1 crush_ruleset 1 object_hash
> rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 39
> owner 0)
> pg_pool 2 'rbd' pg_pool(rep pg_size 1 crush_ruleset 2 object_hash
> rjenkins pg_num 192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 41
> owner 0)
>   wrote 1108 byte payload to -
>
>
>
> ----------------------------------------------------------------------------------------------------------------------
> On Wed, Aug 29, 2012 at 3:21 PM, Wido den Hollander <wido@widodh.nl> wrote:
>> On 08/29/2012 11:42 AM, hemant surale wrote:
>>>
>>> Hi Ceph Community ,
>>>        I am facing problem while I am explicitly  trying to set
>>> "pg_number" of "data" pool.
>>>
>>>
>>> --------------------------------------------------------------------------------------------------------------------
>>> root@third-virtual-machine:~# ceph osd pool set data pg_num 100
>>> 2012-08-29 15:08:52.388446 mon <- [osd,pool,set,data,pg_num,100]
>>> 2012-08-29 15:08:52.388924 mon0 -> 'specified pg_num 100 <= current 200'
>>> (-22)
>>>
>>
>> Could you show us the output of the following command?
>>
>> $ ceph osd dump -o -|grep pg_num
>>
>> It seems like you are trying to decrease the number of PGs?
>>
>>
>>>
>>> root@third-virtual-machine:~# ceph osd pool get data pg_num
>>> 2012-08-29 15:09:04.788365 mon <- [osd,pool,get,data,pg_num]
>>> 2012-08-29 15:09:04.788833 mon0 -> 'PG_NUM: 200' (0)
>>>
>>>
>>> -----------------------------------------------------------------------------------------------------------------
>>> Why is it not working to set pg_number to 100. The cmd is executed
>>> while ceph is running.
>>> (ceph v. 0.36, ubuntu 11.10)
>>>
>>
>> I recommend upgrading to Ubuntu 12.04.1 with Ceph 0.48.1
>>
>> Wido
>>
>>>
>>> Regards,
>>> hemant surale.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>

