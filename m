From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: Add dmclock QoS client calls to librados -- request for comments
Date: Tue, 19 Dec 2017 11:45:01 -0600
Message-ID: <c694bf64-3d09-6ea7-e8c9-c7a84ef660c6@gmail.com>
References: <bbba2b97-46cd-132d-59bf-a7e5c4bc387e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:46737 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdLSRpD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Dec 2017 12:45:03 -0500
Received: by mail-io0-f174.google.com with SMTP id x129so14456021iod.13
        for <ceph-devel@vger.kernel.org>; Tue, 19 Dec 2017 09:45:03 -0800 (PST)
In-Reply-To: <bbba2b97-46cd-132d-59bf-a7e5c4bc387e@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Eric,

This is pretty dense! :) (I have the same problem with emails 
sometimes).  responses inline.

On 12/18/2017 01:04 PM, J. Eric Ivancich wrote:
> We are asking the Ceph community to provide their thoughts on this
> draft proposal for expanding the librados API with calls that would
> allow clients to specify QoS (quality of service) parameters for
> their operations.
> 
> We have an on-going effort to provide Ceph users with more options to
> manage QoS. With the release of Luminous we introduced access to a
> prototype of the mclock QoS algorithm for queuing operations by class
> of operation and either differentiating clients or treating them as a
> unit. Although not yet integrated, the library we're using supports
> dmClock, a distributed version of mClock. Both are documented in
> _mClock: Handling Throughput Variability for Hypervisor IO Scheduling_
> by Gulati, Merchant, and Varman 2010.
> 
> In order to offer greater flexibility, we'd like to move forward with
> providing clients with the ability to use different QoS parameters. We
> are keeping our options open w.r.t. the ultimate set of algorithm(s)
> we'll use. The mClock/dmClock algorithm allows a "client", which we
> can interpret broadly, to set a minimum ops/sec (reservation) and a
> maximum ops/sec (limit). Furthermore a "client" can also define a
> weight (a.k.a.  priority), which is a scalar value to determine
> relative weighting.
> 
> We think reservation, limit, and weight are sufficiently generic that
> we'd be able to use or adapt them other QoS algorithms we may try or
> use in the future.
> 
> [To give you a sense of how broadly we can interpret "client", we
> currently have code that interprets classes of operations (e.g.,
> background replication or background snap-trimming) as a client.]
> 
> == Units ==
> 
> One key difference we're considering, however, is changing the unit
> that reservations and limits are expressed in from ops/sec to
> something more appropriate for Ceph. Operations have payloads of
> different sizes and will therefore take different amounts of time, and
> that should be factored in. We might refer to this as the "cost" of
> the operation. And the cost is not linear with the size of the
> payload. For example, a write of 4 MB might only take 20 times as long
> as a write of 4 KB even though the sizes differ by a factor of
> 1000. Using cost would allow us to, for example, achieve a fairer
> prioritization of a client doing many small writes against a client
> that's doing a few larger writes.

Getting away from ops/s is a good idea imho, and I generally agree here.

> 
> One proposed formula to translate one op into cost would be something
> along the lines of:
> 
>      cost_units = a + b * log(payload_size)
> 
> where a and b would have to be chosen or tuned based on the storage
> back-end.

I guess the idea is that we can generally approximate the curve of both 
HDDs and solid state storage with this formula by tweaking a and b? 
I've got a couple of concerns:

1) I don't think most users are going to get a and b right.  If anything 
I suspect we'll end up with a couple of competing values for HDD and 
SSDs that people will just copy/paste from each other or the mailing 
list.  I'd much rather that we had hdd/ssd defaults like we do for other 
options in ceph that get us in the right ballparks and get set 
automatically based on the disk type.

2) log() is kind of expensive.  It's not *that* bad, but it's enough 
that for small NVMe read ops we could start to see it show up in profiles.

http://nicolas.limare.net/pro/notes/2014/12/16_math_speed/

I suspect it might be a good idea to pre-compute the cost_units for the 
first 64k (or whatever) payload_sizes, especially if that value is 
64bit.  It would take minimal memory and I could see it becoming more 
important as flash becomes more common (especially on ARM and similar CPUs).

3) If there were an easy way to express it, it might be nice to just 
give advanced users the option to write their own function here as an 
override vs the defaults. ie (not real numbers):

notreal_qos_cost_unit_algorithm = ""
notreal_qos_cost_unit_algorithm_ssd = "1024 + 0.25*log(payload_size)"
notreal_qos_cost_unit_algorithm_hdd = "64 + 32*log(payload_size)"

I think this is cleaner than needing to specify hdd_a, hdd_b, ssd_a, 
ssd_b on nodes with mixed HDD/flash OSDs.

> 
> And that gets us to the units for defining reservation and limit --
> cost_units per unit of time. Typically these are floating point
> values, however we do not use floating point types in librados calls
> because qemu, when calling into librbd, does not save and restore the
> cpu's floating point mode.
> 
> There are two ways of getting appropriate ranges of values given that
> we need to use integral types for cost_units per unit of time. One is
> a large time unit in the denominator, such as minutes or even
> hours. That would leave us with cost_units per minute. We are unsure
> that the strange unit is the best approach and your feedback would be
> appreciated.
> 
> A standard alternative would be to use a standard time unit, such as
> seconds, but integers as fixed-point values. So a floating-point value
> in cost_units per second would be multiplied by, say, 1000 and rounded
> to get the corresponding integer value.

In the 2nd scenario it's just a question of how we handle it internally 
right?

> 
> == librados Additions ==
> 
> The basic idea is that one would be able to create (and destroy) qos
> profiles and then associate a profile with an ioctx. Ops on the ioctx
> would use the qos profile associated with it.
> 
> typedef void* rados_qos_profile_t; // opaque
> 
> // parameters uint64_t in cost_units per time unit as discussed above
> profile1 = rados_qos_profile_create(reservation, weight, limit);
> 
> rados_ioctx_set_qos_profile(ioctx3, profile1);
> 
> ...
> // ops to ioctx3 would now use the specified profile
> ...
> 
> // use the profile just for a particular operation
> rados_write_op_set_qos_prefile(op1, profile1);
> 
> rados_ioctx_set_qos_profile(ioctx3, NULL); // set to default profile
> 
> rados_qos_profile_destroy(profile1);
> 
> == MOSDOp and MOSDOpReply Changes ==
> 
> Because the qos_profile would be managed by the ioctx, MOSDOps sent
> via that ioctx would include the reservation, weight, and limit. At
> this point we think this would be better than keeping the profiles on
> the back-end, although it increases the MOSDOp data structure by about
> 128 bits.
> 
> The MOSDOp type already contains dmclock's delta and rho parameters
> and MOSDOpReply already contains the dmclock phase indicator due to
> prior work. Given that we're moving towards using cost_unit per
> time_unit rather than ops per sec, perhaps we should also include the
> calculated cost in the MOSDOpReply.

Does it change things at all if we have fast per-calculated values of 
cost_unit available for a given payload size?

> 
> == Conclusion ==
> 
> So that's what we're thinking about and your own thoughts and feedback
> would be appreciated. Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
