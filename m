From: =?UTF-8?B?6rmA7YOc7JuF?= <isis1054@gmail.com>
Subject: Re: Add dmclock QoS client calls to librados -- request for comments
Date: Wed, 3 Jan 2018 22:43:06 +0900
Message-ID: <CAJe5RNo-7AtjZzHsm-C1bP8VX2KMz=Awb1yjPwEXLF2LSHqEgg@mail.gmail.com>
References: <bbba2b97-46cd-132d-59bf-a7e5c4bc387e@redhat.com>
 <c694bf64-3d09-6ea7-e8c9-c7a84ef660c6@gmail.com> <A411C74D-32E5-4C3F-B983-14B43920464F@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:34554 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbeACNnI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jan 2018 08:43:08 -0500
Received: by mail-it0-f43.google.com with SMTP id m11so14050551iti.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jan 2018 05:43:07 -0800 (PST)
In-Reply-To: <A411C74D-32E5-4C3F-B983-14B43920464F@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>, KIM TAEWOONG <taewoong.kim@sk.com>, bspark8@sk.com
Cc: Mark Nelson <mark.a.nelson@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

2018-01-03 0:11 GMT+09:00 J. Eric Ivancich <ivancich@redhat.com>:
>
> Thanks, Mark, for those thoughts.
>
> > On Dec 19, 2017, at 12:45 PM, Mark Nelson <mark.a.nelson@gmail.com> wro=
te:
> >
> > On 12/18/2017 01:04 PM, J. Eric Ivancich wrote:
> >> =3D=3D Units =3D=3D
> >> One key difference we're considering, however, is changing the unit
> >> that reservations and limits are expressed in from ops/sec to
> >> something more appropriate for Ceph. Operations have payloads of
> >> different sizes and will therefore take different amounts of time, and
> >> that should be factored in. We might refer to this as the "cost" of
> >> the operation. And the cost is not linear with the size of the
> >> payload. For example, a write of 4 MB might only take 20 times as long
> >> as a write of 4 KB even though the sizes differ by a factor of
> >> 1000. Using cost would allow us to, for example, achieve a fairer
> >> prioritization of a client doing many small writes against a client
> >> that's doing a few larger writes.
> >
> > Getting away from ops/s is a good idea imho, and I generally agree here=
.
>
> Cool!
>
> >> One proposed formula to translate one op into cost would be something
> >> along the lines of:
> >>     cost_units =3D a + b * log(payload_size)
> >> where a and b would have to be chosen or tuned based on the storage
> >> back-end.
> >
> > I guess the idea is that we can generally approximate the curve of both=
 HDDs and solid state storage with this formula by tweaking a and b? I've g=
ot a couple of concerns:
>
> That=E2=80=99s correct.
>
> > 1) I don't think most users are going to get a and b right.  If anythin=
g I suspect we'll end up with a couple of competing values for HDD and SSDs=
 that people will just copy/paste from each other or the mailing list.  I'd=
 much rather that we had hdd/ssd defaults like we do for other options in c=
eph that get us in the right ballparks and get set automatically based on t=
he disk type.
>
> I agree; best to have sensible defaults.
>
> > 2) log() is kind of expensive.  It's not *that* bad, but it's enough th=
at for small NVMe read ops we could start to see it show up in profiles.
> >
> > http://nicolas.limare.net/pro/notes/2014/12/16_math_speed/
> >
> > I suspect it might be a good idea to pre-compute the cost_units for the=
 first 64k (or whatever) payload_sizes, especially if that value is 64bit. =
 It would take minimal memory and I could see it becoming more important as=
 flash becomes more common (especially on ARM and similar CPUs).
>
> I agree. Rounding to the nearest kb and then doing a table look-up is lik=
ely the right way to go and then only doing the full calculation when neces=
sary. We could even consider pre-computing the values for powers-of-2-kb (e=
.g., 1k, 2k, 4k, 8k, 16k, =E2=80=A6. 128k, 256k, =E2=80=A6) and rounding ea=
ch payload to the next highest, assuming it=E2=80=99s not problematic to tr=
eat, say, 20k, 25k, and 30k as having the same cost (i.e., same as 32k). Or=
 use a combination of the two approaches =E2=80=94 linear table for smaller=
 payloads and exponential table for the larger payloads.

Pre-computation to make the cost table seems a good idea. I think that
makes us able to use more complicated formulas because the computation
is needed only when it is necessary.
I wonder if the log function is really needed. In past tests performed
on my environment, the cost seemed to be linear to the request size,
not log function.
According to my observation, the larger the size, the stronger the
linearity. Maybe it could be depended on the environment.
To cover these various environments, we could change the formula like below=
.
cost_units =3D a + b * payload_size + c * log(d * payload_size)
I'm not sure which term should be removed at this time. The exact form
of the formula should be considered with more tests.

>
> > 3) If there were an easy way to express it, it might be nice to just gi=
ve advanced users the option to write their own function here as an overrid=
e vs the defaults. ie (not real numbers):
> >
> > notreal_qos_cost_unit_algorithm =3D ""
> > notreal_qos_cost_unit_algorithm_ssd =3D "1024 + 0.25*log(payload_size)"
> > notreal_qos_cost_unit_algorithm_hdd =3D "64 + 32*log(payload_size)"
> >
> > I think this is cleaner than needing to specify hdd_a, hdd_b, ssd_a, ss=
d_b on nodes with mixed HDD/flash OSDs.
>
> I=E2=80=99m inclined to go with the more simple implementation, at least =
for the first take, but certainly open to the more general implementation t=
hat you suggest.
>
> >> And that gets us to the units for defining reservation and limit --
> >> cost_units per unit of time. Typically these are floating point
> >> values, however we do not use floating point types in librados calls
> >> because qemu, when calling into librbd, does not save and restore the
> >> cpu's floating point mode.
> >> There are two ways of getting appropriate ranges of values given that
> >> we need to use integral types for cost_units per unit of time. One is
> >> a large time unit in the denominator, such as minutes or even
> >> hours. That would leave us with cost_units per minute. We are unsure
> >> that the strange unit is the best approach and your feedback would be
> >> appreciated.
> >> A standard alternative would be to use a standard time unit, such as
> >> seconds, but integers as fixed-point values. So a floating-point value
> >> in cost_units per second would be multiplied by, say, 1000 and rounded
> >> to get the corresponding integer value.
> >
> > In the 2nd scenario it's just a question of how we handle it internally=
 right?
>
> The client calling into librados would have to do the conversion of float=
ing-point into fixed-point. I=E2=80=99ll reply to Sage=E2=80=99s reply to t=
his thread next, but I think he makes a good point that the number of cost =
units for typical payload sizes will be (much?) larger than 1, so we might =
be able to use seconds as are time unit *and* avoid fixed-point math. In ot=
her words, I=E2=80=99m now thinking that the caller would simply need to ro=
und to an integral value *if* they started with a floating point value.
>
> >> =3D=3D librados Additions =3D=3D
> >> The basic idea is that one would be able to create (and destroy) qos
> >> profiles and then associate a profile with an ioctx. Ops on the ioctx
> >> would use the qos profile associated with it.
> >> typedef void* rados_qos_profile_t; // opaque
> >> // parameters uint64_t in cost_units per time unit as discussed above
> >> profile1 =3D rados_qos_profile_create(reservation, weight, limit);
> >> rados_ioctx_set_qos_profile(ioctx3, profile1);
> >> ...
> >> // ops to ioctx3 would now use the specified profile
> >> ...
> >> // use the profile just for a particular operation
> >> rados_write_op_set_qos_prefile(op1, profile1);
> >> rados_ioctx_set_qos_profile(ioctx3, NULL); // set to default profile
> >> rados_qos_profile_destroy(profile1);
> >> =3D=3D MOSDOp and MOSDOpReply Changes =3D=3D
> >> Because the qos_profile would be managed by the ioctx, MOSDOps sent
> >> via that ioctx would include the reservation, weight, and limit. At
> >> this point we think this would be better than keeping the profiles on
> >> the back-end, although it increases the MOSDOp data structure by about
> >> 128 bits.
> >> The MOSDOp type already contains dmclock's delta and rho parameters
> >> and MOSDOpReply already contains the dmclock phase indicator due to
> >> prior work. Given that we're moving towards using cost_unit per
> >> time_unit rather than ops per sec, perhaps we should also include the
> >> calculated cost in the MOSDOpReply.
> >
> > Does it change things at all if we have fast per-calculated values of c=
ost_unit available for a given payload size?
>
> No, that wouldn=E2=80=99t change anything. This value will help the new p=
iece in librados that handles dmclock correctly apportion the work done by =
each server to ensure fairness across servers. When using =E2=80=9Cops=E2=
=80=9D the value was 1. With cost units it gets a little more complex. This=
 would all be internal to librados and the client wouldn=E2=80=99t have to =
deal with this value.
>
> Eric
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
