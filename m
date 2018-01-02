From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: Add dmclock QoS client calls to librados -- request for comments
Date: Tue, 2 Jan 2018 10:11:45 -0500
Message-ID: <A411C74D-32E5-4C3F-B983-14B43920464F@redhat.com>
References: <bbba2b97-46cd-132d-59bf-a7e5c4bc387e@redhat.com> <c694bf64-3d09-6ea7-e8c9-c7a84ef660c6@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:39149 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbeABPLq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jan 2018 10:11:46 -0500
Received: by mail-io0-f181.google.com with SMTP id g70so36641285ioj.6
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jan 2018 07:11:46 -0800 (PST)
In-Reply-To: <c694bf64-3d09-6ea7-e8c9-c7a84ef660c6@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.a.nelson@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Thanks, Mark, for those thoughts.

> On Dec 19, 2017, at 12:45 PM, Mark Nelson <mark.a.nelson@gmail.com> wrote:
> 
> On 12/18/2017 01:04 PM, J. Eric Ivancich wrote:
>> == Units ==
>> One key difference we're considering, however, is changing the unit
>> that reservations and limits are expressed in from ops/sec to
>> something more appropriate for Ceph. Operations have payloads of
>> different sizes and will therefore take different amounts of time, and
>> that should be factored in. We might refer to this as the "cost" of
>> the operation. And the cost is not linear with the size of the
>> payload. For example, a write of 4 MB might only take 20 times as long
>> as a write of 4 KB even though the sizes differ by a factor of
>> 1000. Using cost would allow us to, for example, achieve a fairer
>> prioritization of a client doing many small writes against a client
>> that's doing a few larger writes.
> 
> Getting away from ops/s is a good idea imho, and I generally agree here.

Cool!

>> One proposed formula to translate one op into cost would be something
>> along the lines of:
>>     cost_units = a + b * log(payload_size)
>> where a and b would have to be chosen or tuned based on the storage
>> back-end.
> 
> I guess the idea is that we can generally approximate the curve of both HDDs and solid state storage with this formula by tweaking a and b? I've got a couple of concerns:

That’s correct.

> 1) I don't think most users are going to get a and b right.  If anything I suspect we'll end up with a couple of competing values for HDD and SSDs that people will just copy/paste from each other or the mailing list.  I'd much rather that we had hdd/ssd defaults like we do for other options in ceph that get us in the right ballparks and get set automatically based on the disk type.

I agree; best to have sensible defaults.

> 2) log() is kind of expensive.  It's not *that* bad, but it's enough that for small NVMe read ops we could start to see it show up in profiles.
> 
> http://nicolas.limare.net/pro/notes/2014/12/16_math_speed/
> 
> I suspect it might be a good idea to pre-compute the cost_units for the first 64k (or whatever) payload_sizes, especially if that value is 64bit.  It would take minimal memory and I could see it becoming more important as flash becomes more common (especially on ARM and similar CPUs).

I agree. Rounding to the nearest kb and then doing a table look-up is likely the right way to go and then only doing the full calculation when necessary. We could even consider pre-computing the values for powers-of-2-kb (e.g., 1k, 2k, 4k, 8k, 16k, …. 128k, 256k, …) and rounding each payload to the next highest, assuming it’s not problematic to treat, say, 20k, 25k, and 30k as having the same cost (i.e., same as 32k). Or use a combination of the two approaches — linear table for smaller payloads and exponential table for the larger payloads.

> 3) If there were an easy way to express it, it might be nice to just give advanced users the option to write their own function here as an override vs the defaults. ie (not real numbers):
> 
> notreal_qos_cost_unit_algorithm = ""
> notreal_qos_cost_unit_algorithm_ssd = "1024 + 0.25*log(payload_size)"
> notreal_qos_cost_unit_algorithm_hdd = "64 + 32*log(payload_size)"
> 
> I think this is cleaner than needing to specify hdd_a, hdd_b, ssd_a, ssd_b on nodes with mixed HDD/flash OSDs.

I’m inclined to go with the more simple implementation, at least for the first take, but certainly open to the more general implementation that you suggest.

>> And that gets us to the units for defining reservation and limit --
>> cost_units per unit of time. Typically these are floating point
>> values, however we do not use floating point types in librados calls
>> because qemu, when calling into librbd, does not save and restore the
>> cpu's floating point mode.
>> There are two ways of getting appropriate ranges of values given that
>> we need to use integral types for cost_units per unit of time. One is
>> a large time unit in the denominator, such as minutes or even
>> hours. That would leave us with cost_units per minute. We are unsure
>> that the strange unit is the best approach and your feedback would be
>> appreciated.
>> A standard alternative would be to use a standard time unit, such as
>> seconds, but integers as fixed-point values. So a floating-point value
>> in cost_units per second would be multiplied by, say, 1000 and rounded
>> to get the corresponding integer value.
> 
> In the 2nd scenario it's just a question of how we handle it internally right?

The client calling into librados would have to do the conversion of floating-point into fixed-point. I’ll reply to Sage’s reply to this thread next, but I think he makes a good point that the number of cost units for typical payload sizes will be (much?) larger than 1, so we might be able to use seconds as are time unit *and* avoid fixed-point math. In other words, I’m now thinking that the caller would simply need to round to an integral value *if* they started with a floating point value.

>> == librados Additions ==
>> The basic idea is that one would be able to create (and destroy) qos
>> profiles and then associate a profile with an ioctx. Ops on the ioctx
>> would use the qos profile associated with it.
>> typedef void* rados_qos_profile_t; // opaque
>> // parameters uint64_t in cost_units per time unit as discussed above
>> profile1 = rados_qos_profile_create(reservation, weight, limit);
>> rados_ioctx_set_qos_profile(ioctx3, profile1);
>> ...
>> // ops to ioctx3 would now use the specified profile
>> ...
>> // use the profile just for a particular operation
>> rados_write_op_set_qos_prefile(op1, profile1);
>> rados_ioctx_set_qos_profile(ioctx3, NULL); // set to default profile
>> rados_qos_profile_destroy(profile1);
>> == MOSDOp and MOSDOpReply Changes ==
>> Because the qos_profile would be managed by the ioctx, MOSDOps sent
>> via that ioctx would include the reservation, weight, and limit. At
>> this point we think this would be better than keeping the profiles on
>> the back-end, although it increases the MOSDOp data structure by about
>> 128 bits.
>> The MOSDOp type already contains dmclock's delta and rho parameters
>> and MOSDOpReply already contains the dmclock phase indicator due to
>> prior work. Given that we're moving towards using cost_unit per
>> time_unit rather than ops per sec, perhaps we should also include the
>> calculated cost in the MOSDOpReply.
> 
> Does it change things at all if we have fast per-calculated values of cost_unit available for a given payload size?

No, that wouldn’t change anything. This value will help the new piece in librados that handles dmclock correctly apportion the work done by each server to ensure fairness across servers. When using “ops” the value was 1. With cost units it gets a little more complex. This would all be internal to librados and the client wouldn’t have to deal with this value.

Eric

