From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Bug in mempool::map?
Date: Thu, 22 Dec 2016 01:55:02 +0300
Message-ID: <89b68d38-bbaa-d0ef-753d-ca2e0676bdd4@mirantis.com>
References: <36219e00-6114-7b9e-f7ca-5190cb545c93@mirantis.com>
 <alpine.DEB.2.11.1612201524400.10615@piezo.novalocal>
 <3117e8a5-e8dd-f323-25ef-dc6756ebb8f0@mirantis.com>
 <alpine.DEB.2.11.1612201824140.10615@piezo.novalocal>
 <aa0fa487-ffed-cc4a-eae0-226ef038f1d4@mirantis.com>
 <alpine.DEB.2.11.1612202010280.10615@piezo.novalocal>
 <00754a82-e01d-09d8-f879-991c3faca025@mirantis.com>
 <alpine.DEB.2.11.1612212055110.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33572 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbcLUWzY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2016 17:55:24 -0500
Received: by mail-lf0-f45.google.com with SMTP id c13so107620391lfg.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Dec 2016 14:55:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612212055110.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>


On 12/22/2016 12:43 AM, Sage Weil wrote:
> On Wed, 21 Dec 2016, Igor Fedotov wrote:
>> On 12/20/2016 11:15 PM, Sage Weil wrote:
>>> It seems like we have a few common cases...
>>>
>>> 1) big blob, single ref (e.g., immutable large object, and then the entire
>>> thing is referenced, modulo the last block).
>>>
>>> 2) tiny blob, single alloc unit.  a counter is sufficient.
>>>
>>> 3) everything else in between...
>>>
>>> We could probably get away with special-case efficient representations of
>>> just 1 and 2?
>> I'd say 1) = entire blob is referenced just once. And 2) = single alloc unit
>> and partially referenced.
>>
>> Then we need at minimum a bit flag for 1), 'int' for 2) and vector<int> for
>> 3).
>>
>> Possible implementations are
>> A.{
>> int standalone_counter;  //this covers 1 & 2, value greater than alloc unit
>> means 1)
>> vector<int> per_au_counters; // and this one for 3 with the first counter
>> stored in standalone_counter
>> }
>> vs.
>> B.{
>> //reuse some blob flag for 1)
>> vector<int> per_au_counters; //for 2) and 3)
>> }
>> vs.
>> C.{
>> vector<int> per_au_counters; //for all cases
>> }
>>
>> A. Saves one allocation for 1 & 2, wastes 4 bytes for 1. Plus requires some
>> simple tricks to use both standalone counter and vector.
>> B. Saves 1 allocation and 4 bytes for 1. Unified counter vector processing but
>> some minor tricks with a flag.
>> C. Needs +1 allocation for 1 & 2. And wastes 4 bytes for 1. Unified counter
>> processing
>>
>> I'd rather prefer B. implementation.
> vector<int> is 24 bytes.  So if we're worried about memory, I think we
Yep, missed that...
> want to have an alternative strategy.  Something like:
>
>   uint8_t au_order;  ///< size of allocation unit (min_alloc_size may change)
Unless we pack the struct this byte field adds +8 bytes to struct size 
for 64-bit build. Another point is heap allocator granularity - most 
probably it will align allocated struct to 8 byte boundaries anyway. 
Hence we can use a full value instead of au_order.

Another concern is min_alloc_size change in general - have we ever 
performed any robust BlueStore testing against this feature?
It looks pretty dangerous and error-prone...

>   union {
>     long *ref_by_au;  ///< dynamically allocated array of bytes per au
>     long ref_in_single_au;  ///< refs if blob is a single au (au_order=0?)
>   }
>
> Something simple like that?
>
> I suspect get_ref/put_ref will get quite a bit simpler and more efficient
> with per-au buckets.
yep.
> Also, for compressed blobs, we can use the ref_in_single_au mode since we
> can't deallocate it piecewise anyway...
+1

Also please note that we'll probably impact our current Onode encoding 
with this change. Spanning blobs need ref counters to be persistent....

Thanks,
Igor
