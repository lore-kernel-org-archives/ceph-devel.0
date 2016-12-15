From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Metadata vs UserData caching in BlueStore
Date: Thu, 15 Dec 2016 11:53:19 -0600
Message-ID: <bc3f4e0e-83ef-68ff-e820-06ba888764cb@redhat.com>
References: <ce95a133-7fae-34fc-b493-fbabdc272c55@mirantis.com>
 <7b337443-f6bc-d005-a17b-43bd11481f04@redhat.com>
 <3bd1c476-c00c-2783-1ac7-7eb98e0785b6@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753356AbcLORxW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Dec 2016 12:53:22 -0500
In-Reply-To: <3bd1c476-c00c-2783-1ac7-7eb98e0785b6@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 12/15/2016 11:44 AM, Igor Fedotov wrote:
> On 15.12.2016 20:34, Mark Nelson wrote:
>>
>>
>> On 12/15/2016 11:24 AM, Igor Fedotov wrote:
>>> Sage et al,
>>>
>>> shouldn't we have bluestore_cache_metadata_ratio set to 1 by default? To
>>> concentrate on metadata caching..
>>
>> I would contend that it should be high (we've already bumped it up,
>> I'd go higher still), but isn't 1 a little excessive? Ultimately this
>> should all be automatic based on heuristics imho.
>>
> Well, Mark - what's the use case for user data caching? It means that
> user either retrieves just written data or reads them repeatedly or in
> an unaligned manner. Or there are multiple users working with the same
> object.
> Any of that is IMHO a corner case... That can be handled by using that
> ratio setting if needed.
>
>>>
>>> IMHO Onode caching is much more important and profitable than user data
>>> one. It's rather a client misbehavior to cause cache hit when accessing
>>> user data but it's  highly expected for onode metadata.
>>
>> We should take care not to run into the same problem the kernel does.
>> With too many cached entries things can get slow.  It's another
>> trade-off we need to watch out for.  There may need to be a (hopefully
>> automatically generated) soft limit, and potentially a hard limit.
> Doesn't our cache size limit server that purpose?

I guess I'm thinking of this in the context that eventually we move away 
from all of the user-defined cache/buffer/etc size limits.  Maybe we 
still have hard imposed maximum limits though, I'm not sure.  I guess it 
depends on whether we can make the autotuning smart enough and how 
quickly we start hitting CPU limits with tons of entries in cache.

Mark

>>
>>>
>>> Moreover user data caching is probably already exists at block device
>>> level hence we rather duplicate disk cache....
>>>
>>> What do you think?
>>>
>>> Thanks,
>>>
>>> Igor
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
