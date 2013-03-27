From: Wido den Hollander <wido@42on.com>
Subject: Re: rados_pool_list usage
Date: Wed, 27 Mar 2013 19:24:59 +0100
Message-ID: <5153397B.3010301@42on.com>
References: <5152B4EC.4070700@42on.com> <9B043BA89C1943F989AD6213B2361DD7@inktank.com> <51532F0E.2070705@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:49637 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab3C0SZF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Mar 2013 14:25:05 -0400
In-Reply-To: <51532F0E.2070705@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/27/2013 06:40 PM, Dan Mick wrote:
> It looks like it attempts to behave as documented (somewhat surprisingly
> and fragile-ly, IMO; I would have made it all-or-nothing and return
> nothing in buf if len is too small).
>
> The Python binding retries/resizes until it can return them all.
>
> What do you think is wrong, Wido?
>

Well, I think I kind of misread the description..

I didn't see the @return part of it which confused me about how it works.

There is a typo though: "List objects in a pool"

That should be: "List all pools"

Wido

> On 03/27/2013 08:59 AM, Gregory Farnum wrote:
>>
>>
>> On Wednesday, March 27, 2013 at 1:59 AM, Wido den Hollander wrote:
>>
>>> Hi,
>>>
>>> While working with rados_pool_list I stumbled upon what I think is a
>>> documentation issue.
>>>
>>> librados.h tells me this:
>>>
>>> /**
>>> * List objects in a pool
>>> *
>>> * Gets a list of pool names as NULL-terminated strings. The pool
>>> * names will be placed in the supplied buffer one after another.
>>> * After the last pool name, there will be two 0 bytes in a row.
>>> *
>>> * If len is too short to fit all the pool name entries we need, we
>>> will fill
>>> * as much as we can.
>>> *
>>> * @param cluster cluster handle
>>> * @param buf output buffer
>>> * @param len output buffer length
>>> * @returns length of the buffer we would need to list all pools
>>> */
>>> int rados_pool_list(rados_t cluster, char *buf, size_t len);
>>>
>>> "If len is too short to fit all the pool name entries we need, we will
>>> fill as much as we can."
>>>
>>>  From what I could remember it would return the length required if "len"
>>> isn't long enough. Looking at the Python and PHP bindings (which I
>>> wrote) it seems that is correct.
>>>
>>> It also says: "@returns length of the buffer we would need to list all
>>> pools"
>>>
>>> Docs issue I guess?
>> It certainly returns the amount of space needed; does it not also fill
>> in the given buffer with however many pools it could? (It might not,
>> but those sentences aren't contradictory in my mind.)
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
