From: Wido den Hollander <wido@widodh.nl>
Subject: Re: how to protect rbd from multiple simultaneous mapping
Date: Fri, 25 Jan 2013 12:42:34 +0100
Message-ID: <51026FAA.2060405@widodh.nl>
References: <CAE63xUMSqAFGLtm-ObkbYETQtMDdtwLsPAEgMLFtEpM6azfxqA@mail.gmail.com> <5101909D.70501@inktank.com> <CA+jddaN6RhfKV20AV-mnGteYKnYPioGHtDkqDRqgJcOizbySuw@mail.gmail.com> <alpine.DEB.2.00.1301241738290.13935@cobra.newdream.net> <CAE63xUPwAtkv=FEmKac8BUgM+pX0u61+vi_ew8_Zgphf0jttJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:36325 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756841Ab3AYLmb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 06:42:31 -0500
In-Reply-To: <CAE63xUPwAtkv=FEmKac8BUgM+pX0u61+vi_ew8_Zgphf0jttJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Mandell Degerness <mandell@pistoncloud.com>, ceph-devel@vger.kernel.org

On 01/25/2013 11:47 AM, Ugis wrote:
> This could work, thanks!
>
> P.S. Is there a way to tell which client has mapped certain rbd if no
> "rbd lock" is used?

What you could do is this:

$ rbd lock add myimage `hostname`

That way you know which client locked the image.

Wido

> It would be useful to see that info in output of "rbd info <image>".
> Probably attribute for rbd like "max_map_count_allowed" would be
> useful in future - just to make sure rbd is not mapped from multiple
> clients if it must not. I suppose it can actually happen if multiple
> admins work with same rbds from multiple clients and no strict "rbd
> lock add.." procedure is followed.
>
> Ugis
>
>
> 2013/1/25 Sage Weil <sage@inktank.com>:
>> On Thu, 24 Jan 2013, Mandell Degerness wrote:
>>> The advisory locks are nice, but it would be really nice to have the
>>> fencing.  If a node is temporarily off the network and a heartbeat
>>> monitor attempts to bring up a service on a different node, there is
>>> no way to ensure that the first node will not write data to the rbd
>>> after the rbd is mounted on the second node.  It would be nice if, on
>>> seeing that an advisory lock exists, you could tell ceph "Do not
>>> accept data from node X until further notice".
>>
>> Just a reminder: you can use the information from the locks to fence.  The
>> basic process is:
>>
>>   - identify old rbd lock holder (rbd lock list <img>)
>>   - blacklist old owner (ceph osd blacklist add <addr>)
>>   - break old rbd lock (rbd lock remove <img> <lockid> <addr>)
>>   - lock rbd image on new host (rbd lock add <img> <lockid>)
>>   - map rbd image on new host
>>
>> The oddity here is that the old VM can in theory continue to write up
>> until the OSD hears about the blacklist via the internal gossip.  This is
>> okay because the act of the new VM touching any part of the image (and the
>> OSD that stores it) ensures that that OSD gets the blacklist information.
>> So on XFS, for example, the act of replaying the XFS journal ensures that
>> any attempt by the old VM to write to the journal will get EIO.
>>
>> sage
>>
>>
>>
>>>
>>> On Thu, Jan 24, 2013 at 11:50 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
>>>> On 01/24/2013 05:30 AM, Ugis wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I have rbd which contains non-cluster filesystem. If this rbd is
>>>>> mapped+mounted on one host, it should not be mapped+mounted on the
>>>>> other simultaneously.
>>>>> How to protect such rbd from being mapped on the other host?
>>>>>
>>>>> At ceph level the only option is to use "lock add [image-name]
>>>>> [lock-id]" and check for existance of this lock on the other client or
>>>>> is it possible to protect rbd in a way that on other clients "rbd map
>>>>> " command would just fail with something like Permission denied
>>>>> without using arbitrary locks? In other words, can one limit the count
>>>>> of clients that may map certain rbd?
>>>>
>>>>
>>>> This is what the lock commands were added for. The lock add command
>>>> will exit non-zero if the image is already locked, so you can run
>>>> something like:
>>>>
>>>>      rbd lock add [image-name] [lock-id] && rbd map [image-name]
>>>>
>>>> to avoid mapping an image that's in use elsewhere.
>>>>
>>>> The lock-id is user-defined, so you could (for example) use the
>>>> hostname of the machine mapping the image to tell where it's
>>>> in use.
>>>>
>>>> Josh
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

