From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: Add dmclock QoS client calls to librados -- request for comments
Date: Tue, 2 Jan 2018 10:26:23 -0500
Message-ID: <89DF14E1-2E9A-49C2-A468-119ED38D7696@redhat.com>
References: <bbba2b97-46cd-132d-59bf-a7e5c4bc387e@redhat.com> <alpine.DEB.2.11.1712191606210.24928@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36479 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeABP0X (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jan 2018 10:26:23 -0500
Received: by mail-io0-f181.google.com with SMTP id i143so29141199ioa.3
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jan 2018 07:26:23 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1712191606210.24928@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

> On Dec 19, 2017, at 11:13 AM, Sage Weil <sage@newdream.net> wrote:
> 
> Hi Eric,
> 
> On Mon, 18 Dec 2017, J. Eric Ivancich wrote:
>> == Units ==
>> 
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
>> 
>> One proposed formula to translate one op into cost would be something
>> along the lines of:
>> 
>>    cost_units = a + b * log(payload_size)
>> 
>> where a and b would have to be chosen or tuned based on the storage
>> back-end.
>> 
>> And that gets us to the units for defining reservation and limit --
>> cost_units per unit of time. Typically these are floating point
>> values, however we do not use floating point types in librados calls
>> because qemu, when calling into librbd, does not save and restore the
>> cpu's floating point mode.
>> 
>> There are two ways of getting appropriate ranges of values given that
>> we need to use integral types for cost_units per unit of time. One is
>> a large time unit in the denominator, such as minutes or even
>> hours. That would leave us with cost_units per minute. We are unsure
>> that the strange unit is the best approach and your feedback would be
>> appreciated.
>> 
>> A standard alternative would be to use a standard time unit, such as
>> seconds, but integers as fixed-point values. So a floating-point value
>> in cost_units per second would be multiplied by, say, 1000 and rounded
>> to get the corresponding integer value.
> 
> I think if payload_size above is bytes, then any reasonable value for 
> cost_units will be a non-tiny integer, and we won't need floating point, 
> right?  E.g., a 4KB write would be (at a minimum) 10, but probably larger 
> if a and b >= 1.  That would let us keep seconds as the time base?

Very good point! As long as the cost is greater than 10 (maybe even much greater than 10) a reservation or limit as low as 1 would be small, and we can avoid both odd time unit denominators and fixed-point and still achieve low settings.

>> == librados Additions ==
>> 
>> The basic idea is that one would be able to create (and destroy) qos
>> profiles and then associate a profile with an ioctx. Ops on the ioctx
>> would use the qos profile associated with it.
>> 
>> typedef void* rados_qos_profile_t; // opaque
>> 
>> // parameters uint64_t in cost_units per time unit as discussed above
>> profile1 = rados_qos_profile_create(reservation, weight, limit);
>> 
>> rados_ioctx_set_qos_profile(ioctx3, profile1);
>> 
>> ...
>> // ops to ioctx3 would now use the specified profile
>> ...
>> 
>> // use the profile just for a particular operation
>> rados_write_op_set_qos_prefile(op1, profile1);
>> 
>> rados_ioctx_set_qos_profile(ioctx3, NULL); // set to default profile
>> 
>> rados_qos_profile_destroy(profile1);
> 
> I would s/destroy/release/, as the profile will be implicitly 
> reference counted (with a ref consumed by the ioctx that is pointing to 
> it).
> 
> It might be useful to add a rados_qos_profile_get_id(handle) that returns 
> the client-local integer id that we're using to identify the profile.  
> This isn't really useful for the application per se, but it will be 
> helpful for debugging purposes perhaps?

Both sound good.

>> == MOSDOp and MOSDOpReply Changes ==
>> 
>> Because the qos_profile would be managed by the ioctx, MOSDOps sent
>> via that ioctx would include the reservation, weight, and limit. At
>> this point we think this would be better than keeping the profiles on
>> the back-end, although it increases the MOSDOp data structure by about
>> 128 bits.
>> 
>> The MOSDOp type already contains dmclock's delta and rho parameters
>> and MOSDOpReply already contains the dmclock phase indicator due to
>> prior work. Given that we're moving towards using cost_unit per
>> time_unit rather than ops per sec, perhaps we should also include the
>> calculated cost in the MOSDOpReply.
> 
> Good idea!

Thank you,

Eric

