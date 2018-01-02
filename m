From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Add dmclock QoS client calls to librados -- request for comments
Date: Tue, 2 Jan 2018 09:58:27 -0800
Message-ID: <CAJ4mKGZMKtR+kF59wRzOipAeyhH6C1wm1fx=hCFcC6gSUswT8w@mail.gmail.com>
References: <bbba2b97-46cd-132d-59bf-a7e5c4bc387e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:41776 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbeABR63 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jan 2018 12:58:29 -0500
Received: by mail-it0-f51.google.com with SMTP id x28so39541157ita.0
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jan 2018 09:58:28 -0800 (PST)
In-Reply-To: <bbba2b97-46cd-132d-59bf-a7e5c4bc387e@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Dec 18, 2017 at 11:04 AM, J. Eric Ivancich <ivancich@redhat.com> wrote:
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

I'm sure we'll need to convert to a different type of rate limiter, so
this is good. I suspect we'll want to experiment with the right ways
to convert costs to a single dimension, though — and it will probably
vary quite a lot depending on the underlying storage medium. I'd be
careful about embedding a cost function into the code and instead make
it a function that can be updated (or even configured by the cluster
admin).

>
> One proposed formula to translate one op into cost would be something
> along the lines of:
>
>     cost_units = a + b * log(payload_size)
>
> where a and b would have to be chosen or tuned based on the storage
> back-end.
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

So this sounds like QoS will be *entirely* set up and configured by the client?

I can understand the appeal of that, but we've at least discussed the
possibility in the past of this being cryptographically secured and
part of the cephx caps. The problem with secured QoS is that it's not
entirely clear how we'd share the amount of used reservation across
the OSDs involved. (Presumably they'd periodically send the client
back signed tickets, and the client would share those, and the OSDs
would adjust local reservations from that usage, but of course that's
hand-waving a ton.) It would be very sad if our librados interface
wasn't designed with a future secured QoS in mind. (And doing it on
the IoCtx would seem to preclude that?)
-Greg

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
>
> == Conclusion ==
>
> So that's what we're thinking about and your own thoughts and feedback
> would be appreciated. Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
