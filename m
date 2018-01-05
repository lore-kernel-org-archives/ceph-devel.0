From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: Add dmclock QoS client calls to librados -- request for comments
Date: Fri, 5 Jan 2018 16:29:50 -0500
Message-ID: <b8f1473d-7bce-cd7c-b29f-1104c7e1deac@redhat.com>
References: <bbba2b97-46cd-132d-59bf-a7e5c4bc387e@redhat.com>
 <c694bf64-3d09-6ea7-e8c9-c7a84ef660c6@gmail.com>
 <A411C74D-32E5-4C3F-B983-14B43920464F@redhat.com>
 <CAJe5RNo-7AtjZzHsm-C1bP8VX2KMz=Awb1yjPwEXLF2LSHqEgg@mail.gmail.com>
 <CAKk8r1AZ0TS3Q1EScSTzfxBFFscqMcCi00VTyO+fYO6C7p34PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34522 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbeAEV3x (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jan 2018 16:29:53 -0500
Received: by mail-oi0-f42.google.com with SMTP id u193so3953968oie.1
        for <ceph-devel@vger.kernel.org>; Fri, 05 Jan 2018 13:29:53 -0800 (PST)
In-Reply-To: <CAKk8r1AZ0TS3Q1EScSTzfxBFFscqMcCi00VTyO+fYO6C7p34PQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Byung Su Park <pbs1108@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>, Mark Nelson <mark.a.nelson@gmail.com>, KIM TAEWOONG <taewoong.kim@sk.com>, =?UTF-8?B?67CV67OR7IiY?= <bspark8@sk.com>

Hi Byung Su and Taewoong,

On 01/04/2018 11:35 PM, Byung Su Park wrote:
> Hi Eric,
> 
> 2018-01-03 22:43 GMT+09:00 김태웅 <isis1054@gmail.com>:
>>
>> 2018-01-03 0:11 GMT+09:00 J. Eric Ivancich <ivancich@redhat.com>:
>>>
>>> Thanks, Mark, for those thoughts.
>>>
>>>> On Dec 19, 2017, at 12:45 PM, Mark Nelson <mark.a.nelson@gmail.com> wrote:
>>>>
>>>> On 12/18/2017 01:04 PM, J. Eric Ivancich wrote:
>>>>> == Units ==
>>>>> One key difference we're considering, however, is changing the unit
>>>>> that reservations and limits are expressed in from ops/sec to
>>>>> something more appropriate for Ceph. Operations have payloads of
>>>>> different sizes and will therefore take different amounts of time, and
>>>>> that should be factored in. We might refer to this as the "cost" of
>>>>> the operation. And the cost is not linear with the size of the
>>>>> payload. For example, a write of 4 MB might only take 20 times as long
>>>>> as a write of 4 KB even though the sizes differ by a factor of
>>>>> 1000. Using cost would allow us to, for example, achieve a fairer
>>>>> prioritization of a client doing many small writes against a client
>>>>> that's doing a few larger writes.
>>>>
>>>> Getting away from ops/s is a good idea imho, and I generally agree here.
>>>
>>> Cool!
>>>
>>>>> One proposed formula to translate one op into cost would be something
>>>>> along the lines of:
>>>>>     cost_units = a + b * log(payload_size)
>>>>> where a and b would have to be chosen or tuned based on the storage
>>>>> back-end.
>>>>
>>>> I guess the idea is that we can generally approximate the curve of both HDDs and solid state storage with this formula by tweaking a and b? I've got a couple of concerns:
>>>
>>> That’s correct.
>>>
>>>> 1) I don't think most users are going to get a and b right.  If anything I suspect we'll end up with a couple of competing values for HDD and SSDs that people will just copy/paste from each other or the mailing list.  I'd much rather that we had hdd/ssd defaults like we do for other options in ceph that get us in the right ballparks and get set automatically based on the disk type.
>>>
>>> I agree; best to have sensible defaults.
>>>
>>>> 2) log() is kind of expensive.  It's not *that* bad, but it's enough that for small NVMe read ops we could start to see it show up in profiles.
>>>>
>>>> http://nicolas.limare.net/pro/notes/2014/12/16_math_speed/
>>>>
>>>> I suspect it might be a good idea to pre-compute the cost_units for the first 64k (or whatever) payload_sizes, especially if that value is 64bit.  It would take minimal memory and I could see it becoming more important as flash becomes more common (especially on ARM and similar CPUs).
>>>
>>> I agree. Rounding to the nearest kb and then doing a table look-up is likely the right way to go and then only doing the full calculation when necessary. We could even consider pre-computing the values for powers-of-2-kb (e.g., 1k, 2k, 4k, 8k, 16k, …. 128k, 256k, …) and rounding each payload to the next highest, assuming it’s not problematic to treat, say, 20k, 25k, and 30k as having the same cost (i.e., same as 32k). Or use a combination of the two approaches — linear table for smaller payloads and exponential table for the larger payloads.
>>
>> Pre-computation to make the cost table seems a good idea. I think that
>> makes us able to use more complicated formulas because the computation
>> is needed only when it is necessary.
>> I wonder if the log function is really needed. In past tests performed
>> on my environment, the cost seemed to be linear to the request size,
>> not log function.
>> According to my observation, the larger the size, the stronger the
>> linearity. Maybe it could be depended on the environment.
>> To cover these various environments, we could change the formula like below.
>> cost_units = a + b * payload_size + c * log(d * payload_size)
>> I'm not sure which term should be removed at this time. The exact form
>> of the formula should be considered with more tests.
>>
> 
> In addition to Taewoong's opinion, the environment in which the I/O
> cost increases linearly with payload_size is the SSD based Ceph
> cluster.
> We also think that we need to add predefined differential values b1
> and b2 for I/O type (read/write) when calculating I/O cost.
> For I/O cost modeling, the following paper can be referred to.
> (https://people.ucsc.edu/~hlitz/papers/reflex.pdf)

Thank you for that reference; I will read it. I'm certainly open to
making the modeling function more complex. In a way you're arguing for
Mark Nelson's idea (see immediately below) of allowing a somewhat
free-form function to be defined. And since such a function would need
to be parsed and likely stored as a computation tree and thereby
interpreted, it argues even further for pre-computing these values in
one or more tables.

>>>> 3) If there were an easy way to express it, it might be nice to just give advanced users the option to write their own function here as an override vs the defaults. ie (not real numbers):
>>>>
>>>> notreal_qos_cost_unit_algorithm = ""
>>>> notreal_qos_cost_unit_algorithm_ssd = "1024 + 0.25*log(payload_size)"
>>>> notreal_qos_cost_unit_algorithm_hdd = "64 + 32*log(payload_size)"
>>>>
>>>> I think this is cleaner than needing to specify hdd_a, hdd_b, ssd_a, ssd_b on nodes with mixed HDD/flash OSDs.
>>>
>>> I’m inclined to go with the more simple implementation, at least for the first take, but certainly open to the more general implementation that you suggest.

...

>>>>> == MOSDOp and MOSDOpReply Changes ==
>>>>> Because the qos_profile would be managed by the ioctx, MOSDOps sent
>>>>> via that ioctx would include the reservation, weight, and limit. At
>>>>> this point we think this would be better than keeping the profiles on
>>>>> the back-end, although it increases the MOSDOp data structure by about
>>>>> 128 bits.
>>>>> The MOSDOp type already contains dmclock's delta and rho parameters
>>>>> and MOSDOpReply already contains the dmclock phase indicator due to
>>>>> prior work. Given that we're moving towards using cost_unit per
>>>>> time_unit rather than ops per sec, perhaps we should also include the
>>>>> calculated cost in the MOSDOpReply.
> 
> Currently, the architecture you suggest is I/O cost calculation and
> profiling on the client side.
> I would like to hear more about why you think about client side
> implementation rather than server side implementation.
> 
> As we already know, the dmClock algorithm already controls the degree
> of request using the delta/rho on the client side and the fair cost
> estimate for each different size/type of IO is required on the server
> side.
> I'd have to think about calculating I/O costs on the server side at least once.

Sorry that wasn't clear. Yes, the cost is calculated on the server-side,
which is why the cost needs to be sent back to the client in the
MOSDOpReply, so the client-side of dmclock would then know how to update
its state correctly to calculate future delta and rho values.

Since you're familiar with the internals of the dmclock library, I'll
add that having the server-side calculate the cost this would make it
difficult (likely impossible) to correctly use the BorrowingTracker. To
use that tracker the client would need to independently calculate the
cost of a request.

Eric
