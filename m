From: Byung Su Park <pbs1108@gmail.com>
Subject: Re: Add dmclock QoS client calls to librados -- request for comments
Date: Fri, 5 Jan 2018 13:35:49 +0900
Message-ID: <CAKk8r1AZ0TS3Q1EScSTzfxBFFscqMcCi00VTyO+fYO6C7p34PQ@mail.gmail.com>
References: <bbba2b97-46cd-132d-59bf-a7e5c4bc387e@redhat.com>
 <c694bf64-3d09-6ea7-e8c9-c7a84ef660c6@gmail.com> <A411C74D-32E5-4C3F-B983-14B43920464F@redhat.com>
 <CAJe5RNo-7AtjZzHsm-C1bP8VX2KMz=Awb1yjPwEXLF2LSHqEgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33855 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbeAEEfv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jan 2018 23:35:51 -0500
Received: by mail-io0-f176.google.com with SMTP id q188so4506684iod.1
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jan 2018 20:35:51 -0800 (PST)
In-Reply-To: <CAJe5RNo-7AtjZzHsm-C1bP8VX2KMz=Awb1yjPwEXLF2LSHqEgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>, Mark Nelson <mark.a.nelson@gmail.com>, KIM TAEWOONG <taewoong.kim@sk.com>, =?UTF-8?B?67CV67OR7IiY?= <bspark8@sk.com>

Hi Eric,

2018-01-03 22:43 GMT+09:00 =EA=B9=80=ED=83=9C=EC=9B=85 <isis1054@gmail.com>=
:
>
> 2018-01-03 0:11 GMT+09:00 J. Eric Ivancich <ivancich@redhat.com>:
> >
> > Thanks, Mark, for those thoughts.
> >
> > > On Dec 19, 2017, at 12:45 PM, Mark Nelson <mark.a.nelson@gmail.com> w=
rote:
> > >
> > > On 12/18/2017 01:04 PM, J. Eric Ivancich wrote:
> > >> =3D=3D Units =3D=3D
> > >> One key difference we're considering, however, is changing the unit
> > >> that reservations and limits are expressed in from ops/sec to
> > >> something more appropriate for Ceph. Operations have payloads of
> > >> different sizes and will therefore take different amounts of time, a=
nd
> > >> that should be factored in. We might refer to this as the "cost" of
> > >> the operation. And the cost is not linear with the size of the
> > >> payload. For example, a write of 4 MB might only take 20 times as lo=
ng
> > >> as a write of 4 KB even though the sizes differ by a factor of
> > >> 1000. Using cost would allow us to, for example, achieve a fairer
> > >> prioritization of a client doing many small writes against a client
> > >> that's doing a few larger writes.
> > >
> > > Getting away from ops/s is a good idea imho, and I generally agree he=
re.
> >
> > Cool!
> >
> > >> One proposed formula to translate one op into cost would be somethin=
g
> > >> along the lines of:
> > >>     cost_units =3D a + b * log(payload_size)
> > >> where a and b would have to be chosen or tuned based on the storage
> > >> back-end.
> > >
> > > I guess the idea is that we can generally approximate the curve of bo=
th HDDs and solid state storage with this formula by tweaking a and b? I've=
 got a couple of concerns:
> >
> > That=E2=80=99s correct.
> >
> > > 1) I don't think most users are going to get a and b right.  If anyth=
ing I suspect we'll end up with a couple of competing values for HDD and SS=
Ds that people will just copy/paste from each other or the mailing list.  I=
'd much rather that we had hdd/ssd defaults like we do for other options in=
 ceph that get us in the right ballparks and get set automatically based on=
 the disk type.
> >
> > I agree; best to have sensible defaults.
> >
> > > 2) log() is kind of expensive.  It's not *that* bad, but it's enough =
that for small NVMe read ops we could start to see it show up in profiles.
> > >
> > > http://nicolas.limare.net/pro/notes/2014/12/16_math_speed/
> > >
> > > I suspect it might be a good idea to pre-compute the cost_units for t=
he first 64k (or whatever) payload_sizes, especially if that value is 64bit=
.  It would take minimal memory and I could see it becoming more important =
as flash becomes more common (especially on ARM and similar CPUs).
> >
> > I agree. Rounding to the nearest kb and then doing a table look-up is l=
ikely the right way to go and then only doing the full calculation when nec=
essary. We could even consider pre-computing the values for powers-of-2-kb =
(e.g., 1k, 2k, 4k, 8k, 16k, =E2=80=A6. 128k, 256k, =E2=80=A6) and rounding =
each payload to the next highest, assuming it=E2=80=99s not problematic to =
treat, say, 20k, 25k, and 30k as having the same cost (i.e., same as 32k). =
Or use a combination of the two approaches =E2=80=94 linear table for small=
er payloads and exponential table for the larger payloads.
>
> Pre-computation to make the cost table seems a good idea. I think that
> makes us able to use more complicated formulas because the computation
> is needed only when it is necessary.
> I wonder if the log function is really needed. In past tests performed
> on my environment, the cost seemed to be linear to the request size,
> not log function.
> According to my observation, the larger the size, the stronger the
> linearity. Maybe it could be depended on the environment.
> To cover these various environments, we could change the formula like bel=
ow.
> cost_units =3D a + b * payload_size + c * log(d * payload_size)
> I'm not sure which term should be removed at this time. The exact form
> of the formula should be considered with more tests.
>

In addition to Taewoong's opinion, the environment in which the I/O
cost increases linearly with payload_size is the SSD based Ceph
cluster.
We also think that we need to add predefined differential values b1
and b2 for I/O type (read/write) when calculating I/O cost.
For I/O cost modeling, the following paper can be referred to.
(https://people.ucsc.edu/~hlitz/papers/reflex.pdf)

> >
> > > 3) If there were an easy way to express it, it might be nice to just =
give advanced users the option to write their own function here as an overr=
ide vs the defaults. ie (not real numbers):
> > >
> > > notreal_qos_cost_unit_algorithm =3D ""
> > > notreal_qos_cost_unit_algorithm_ssd =3D "1024 + 0.25*log(payload_size=
)"
> > > notreal_qos_cost_unit_algorithm_hdd =3D "64 + 32*log(payload_size)"
> > >
> > > I think this is cleaner than needing to specify hdd_a, hdd_b, ssd_a, =
ssd_b on nodes with mixed HDD/flash OSDs.
> >
> > I=E2=80=99m inclined to go with the more simple implementation, at leas=
t for the first take, but certainly open to the more general implementation=
 that you suggest.
> >
> > >> And that gets us to the units for defining reservation and limit --
> > >> cost_units per unit of time. Typically these are floating point
> > >> values, however we do not use floating point types in librados calls
> > >> because qemu, when calling into librbd, does not save and restore th=
e
> > >> cpu's floating point mode.
> > >> There are two ways of getting appropriate ranges of values given tha=
t
> > >> we need to use integral types for cost_units per unit of time. One i=
s
> > >> a large time unit in the denominator, such as minutes or even
> > >> hours. That would leave us with cost_units per minute. We are unsure
> > >> that the strange unit is the best approach and your feedback would b=
e
> > >> appreciated.
> > >> A standard alternative would be to use a standard time unit, such as
> > >> seconds, but integers as fixed-point values. So a floating-point val=
ue
> > >> in cost_units per second would be multiplied by, say, 1000 and round=
ed
> > >> to get the corresponding integer value.
> > >
> > > In the 2nd scenario it's just a question of how we handle it internal=
ly right?
> >
> > The client calling into librados would have to do the conversion of flo=
ating-point into fixed-point. I=E2=80=99ll reply to Sage=E2=80=99s reply to=
 this thread next, but I think he makes a good point that the number of cos=
t units for typical payload sizes will be (much?) larger than 1, so we migh=
t be able to use seconds as are time unit *and* avoid fixed-point math. In =
other words, I=E2=80=99m now thinking that the caller would simply need to =
round to an integral value *if* they started with a floating point value.
> >
> > >> =3D=3D librados Additions =3D=3D
> > >> The basic idea is that one would be able to create (and destroy) qos
> > >> profiles and then associate a profile with an ioctx. Ops on the ioct=
x
> > >> would use the qos profile associated with it.
> > >> typedef void* rados_qos_profile_t; // opaque
> > >> // parameters uint64_t in cost_units per time unit as discussed abov=
e
> > >> profile1 =3D rados_qos_profile_create(reservation, weight, limit);
> > >> rados_ioctx_set_qos_profile(ioctx3, profile1);
> > >> ...
> > >> // ops to ioctx3 would now use the specified profile
> > >> ...
> > >> // use the profile just for a particular operation
> > >> rados_write_op_set_qos_prefile(op1, profile1);
> > >> rados_ioctx_set_qos_profile(ioctx3, NULL); // set to default profile
> > >> rados_qos_profile_destroy(profile1);
> > >> =3D=3D MOSDOp and MOSDOpReply Changes =3D=3D
> > >> Because the qos_profile would be managed by the ioctx, MOSDOps sent
> > >> via that ioctx would include the reservation, weight, and limit. At
> > >> this point we think this would be better than keeping the profiles o=
n
> > >> the back-end, although it increases the MOSDOp data structure by abo=
ut
> > >> 128 bits.
> > >> The MOSDOp type already contains dmclock's delta and rho parameters
> > >> and MOSDOpReply already contains the dmclock phase indicator due to
> > >> prior work. Given that we're moving towards using cost_unit per
> > >> time_unit rather than ops per sec, perhaps we should also include th=
e
> > >> calculated cost in the MOSDOpReply.

Currently, the architecture you suggest is I/O cost calculation and
profiling on the client side.
I would like to hear more about why you think about client side
implementation rather than server side implementation.

As we already know, the dmClock algorithm already controls the degree
of request using the delta/rho on the client side and the fair cost
estimate for each different size/type of IO is required on the server
side.
I'd have to think about calculating I/O costs on the server side at least o=
nce.

Thank you.

> > >
> > > Does it change things at all if we have fast per-calculated values of=
 cost_unit available for a given payload size?
> >
> > No, that wouldn=E2=80=99t change anything. This value will help the new=
 piece in librados that handles dmclock correctly apportion the work done b=
y each server to ensure fairness across servers. When using =E2=80=9Cops=E2=
=80=9D the value was 1. With cost units it gets a little more complex. This=
 would all be internal to librados and the client wouldn=E2=80=99t have to =
deal with this value.
> >
> > Eric
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
