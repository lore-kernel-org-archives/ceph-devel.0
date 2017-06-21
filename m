From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Sparse file info in filestore not propagated to other OSDs
Date: Wed, 21 Jun 2017 15:46:13 +0200
Message-ID: <898546b4-b9b2-5413-27ab-74534cc77eed@corp.ovh.com>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com>
 <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal>
 <d4bde447-f179-aeca-bac5-636fa40ccba5@corp.ovh.com>
 <415c9590-ab96-01b6-3c49-553b0d9529fa@sadziu.pl>
 <alpine.DEB.2.11.1706141340520.3646@piezo.novalocal>
 <e89cc0ed-14f0-b092-784f-784c8c967e9d@corp.ovh.com>
 <alpine.DEB.2.11.1706211322360.32269@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo302.mail-out.ovh.net ([137.74.110.74]:50166 "EHLO
        1.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdFUNqP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jun 2017 09:46:15 -0400
In-Reply-To: <alpine.DEB.2.11.1706211322360.32269@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?UTF-8?Q?Pawe=c5=82_Sadowski?= <ceph@sadziu.pl>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On 17-06-21 03:24 PM, Sage Weil wrote:
> On Wed, 21 Jun 2017, Piotr Dałek wrote:
>> On 17-06-14 03:44 PM, Sage Weil wrote:
>>> On Wed, 14 Jun 2017, Paweł Sadowski wrote:
>>>> On 04/13/2017 04:23 PM, Piotr Dałek wrote:
>>>>> On 04/06/2017 03:25 PM, Sage Weil wrote:
>>>>>> On Thu, 6 Apr 2017, Piotr Dałek wrote:
>>>>>>> [snip]
>>>>>>
>>>>>> I think the solution here is to use sparse_read during recovery.  The
>>>>>> PushOp data representation already supports it; it's just a matter of
>>>>>> skipping the zeros.  The recovery code could also have an option to
>>>>>> check
>>>>>> for fully-zero regions of the data and turn those into holes as
>>>>>> well.  For
>>>>>> ReplicatedBackend, see build_push_op().
>>>>>
>>>>> So far it turns out that there's even easier solution, we just enabled
>>>>> "filestore seek hole" on some test cluster and that seems to fix the
>>>>> problem for us. We'll see if fiemap works too.
>>>>>
>>>>
>>>> Is it safe to enable "filestore seek hole", are there any tests that
>>>> verifies that everything related to RBD works fine with this enabled?
>>>> Can we make this enabled by default?
>>>
>>> We would need to enable it in the qa environment first.  The risk here is
>>> that users run a broad range of kernels and we are exposing ourselves to
>>> any bugs in any kernel version they may run.  I'd prefer to leave it off
>>> by default.
>>
>> That's a common regression? If not, we could blacklist particular kernels and
>> call it a day.
 >>
>>> We can enable it in the qa suite, though, which covers
>>> centos7 (latest kernel) and ubuntu xenial and trusty.
>>
>> +1. Do you need some particular PR for that?
> 
> Sure.  How about a patch that adds the config option to several of the
> files in qa/suites/rados/thrash/thrashers?

OK.

>>>> I tested on few of our production images and it seems that about 30% is
>>>> sparse. This will be lost on any cluster wide event (add/remove nodes,
>>>> PG grow, recovery).
>>>>
>>>> How this is/will be handled in BlueStore?
>>>
>>> BlueStore exposes the same sparseness metadata that enabling the
>>> filestore seek hole or fiemap options does, so it won't be a problem
>>> there.
>>>
>>> I think the only thing that we could potentially add is zero detection
>>> on writes (so that explicitly writing zeros consumes no space).  We'd
>>> have to be a bit careful measuring the performance impact of that check on
>>> non-zero writes.
>>
>> I saw that RBD (librbd) does that - replacing writes with discards when buffer
>> contains only zeros. Some code that does the same in librados could be added
>> and it shouldn't impact performance much, current implementation of
>> mem_is_zero is fast and shouldn't be a big problem.
> 
> I'd rather not have librados silently translating requests; I think it
> makes more sense to do any zero checking in bluestore.  _do_write_small
> and _do_write_big already break writes into (aligned) chunks; that would
> be an easy place to add the check.

That leaves out filestore.

And while I get your point, doing it on librados level would reduce network 
usage for zeroed out regions as well, and check could be done just once, not 
replica_size times...

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
