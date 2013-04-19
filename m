From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: bug in rbd rename command?
Date: Fri, 19 Apr 2013 22:34:18 +0200
Message-ID: <5171AA4A.9080403@profihost.ag>
References: <5170F217.9020105@profihost.ag> <5171A883.2040006@inktank.com> <5171A917.6040704@profihost.ag> <alpine.DEB.2.00.1304191332560.13036@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:58761 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab3DSUeS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 16:34:18 -0400
In-Reply-To: <alpine.DEB.2.00.1304191332560.13036@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Am 19.04.2013 22:33, schrieb Sage Weil:
> I think we can make the --dest-pool default to --pool instead of rbd...
> that's easy enough, right?

Yes ;-) it doesn't hurt me but i've seen some people getting confused..

> sage
>
> On Fri, 19 Apr 2013, Stefan Priebe wrote:
>
>> Am 19.04.2013 22:26, schrieb Dan Mick:
>>> It's arguable, but we wanted to treat source and destination pools
>>> separately in general.
>>>
>>> Note that you can also specify images as POOLNAME/a and POOLNAME/b.
>> Sure i know that. But then -p does not make sense at all. Nobody want to use:
>> rbd -p POOLFORA rename a POOLFORB/b
>>
>> Wouldn't it be constant to expand this for b? I mean renaming from poola to
>> poolb isn't supported anyway ;-)
>>
>> Greets,
>> Stefan
>>
>>> On 04/19/2013 12:28 AM, Stefan Priebe - Profihost AG wrote:
>>>> Hi,
>>>>
>>>> if i issue rbd -p POOLNAME ... rename a b
>>>>
>>>> It uses the POOL for a but not for b.
>>>>
>>>> Output is then:
>>>> rbd: mv/rename across pools not supported
>>>> source pool: vmstorssd1 dest pool: rbd
>>>>
>>>> Shouldn't it use the pool provided by -p for both?
>>>>
>>>> Stefan
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
