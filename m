From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: crush devices class types
Date: Wed, 28 Jun 2017 10:54:41 -0700
Message-ID: <CAFMfnwrcSKSCmGpZWiF1kV+cHsg=jiBS4Wda+vsG3ANCZ4iFvw@mail.gmail.com>
References: <e5fad669-da68-1287-7025-9c5e48d67601@dachary.org>
 <1971303930.7861.1485178720341@ox.pcextreme.nl> <alpine.DEB.2.11.1701231428190.3654@piezo.novalocal>
 <372c7fcb-8697-28ea-0d7c-1efc29fc21cf@dachary.org> <alpine.DEB.2.11.1702022047070.3654@piezo.novalocal>
 <927948137.9157.1486119167160@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34334 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbdF1Ryn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 13:54:43 -0400
Received: by mail-yw0-f169.google.com with SMTP id l21so19078934ywb.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jun 2017 10:54:43 -0700 (PDT)
In-Reply-To: <927948137.9157.1486119167160@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

I like John's idea of getting configuration specific to a class from
the monitors, but I think I've thought of a situation where it would
be desirable to have a local configuration like Wido's. On some of the
really high end flash configurations we have two network adaptors,
each on their own NUMA node, with a distinct IP address. This is an
operations nightmare, because each OSD needs it's own definition that
points to the appropriate IP.

[class.numa.1]
cluster_network =3D 10.1.0.0/24

[class.numa.2]
cluster_network =3D 10.1.1.0/24

Maybe it doesn't make sense for "classes" to be used this way, because
I can't think of a reason you would want a pool to only use the left
half of every machine, but using the "classes" as a form of "label"
could be make this sort of configuration more approachable.

[label.numa.1]
cluster_network =3D 10.1.0.0/24

[label.numa.2]
cluster_network =3D 10.1.1.0/24

Perhaps we have a pluggable system for applying "labels" to OSDs, and
the "class" of an OSD is dictated by possession of some combination of
labels. Example labels:

mfg: [intel|samsung|sandisk|micron]
numa: [1,2]
bus: [sata,sas,nvme]
rotational: [0,1]
type: [rust,2dnand,3dnand,xpoint]
over_provisioning: [1.1,1.2,1.3]

Then you could create a "gpssd" classifier that includes OSDs with:

bus =3D sas
rotational =3D 0

And a "piops" classifier that includes OSDs with:

bus: nvme
over_provisioning: 1.3



On Fri, Feb 3, 2017 at 2:52 AM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 2 februari 2017 om 21:57 schreef Sage Weil <sage@newdream.net>:
>>
>>
>> Hi everyone,
>>
>> I made more updates to http://pad.ceph.com/p/crush-types after the CDM
>> discussion yesterday:
>>
>> - consolidated notes into a single proposal
>> - use otherwise illegal character (e.g., ~) as separater for generated
>> buckets.  This avoids ambiguity with user-defined buckets.
>> - class-id $class $id properties for each bucket.  This allows us to
>> preserve the derivative bucket ids across a decompile->compile cycle so
>> that data does not move (the bucket id is one of many inputs into crush'=
s
>> hash during placement).
>> - simpler rule syntax:
>>
>>     rule ssd {
>>             ruleset 1
>>             step take default class ssd
>>             step chooseleaf firstn 0 type host
>>             step emit
>>     }
>>
>> My rationale here is that we don't want to make this a separate 'step'
>> call since steps map to underlying crush rule step ops, and this is a
>> directive only to the compiler.  Making it an optional step argument see=
ms
>> like the cleanest way to do that.
>>
>> Any other comments before we kick this off?
>>
>
> No, looks good to me! Like combining the class into the 'step'.
>
> Would be very nice to have this in L!
>
> What would be interesting as well is if OSD daemons could somehow access =
this while parsing their configuration.
>
> Eg
>
> [class.ssd]
>   osd_op_threads =3D 16
>
> [class.hdd]
>    osd_max_backfills =3D 1
>
> That way you can keep configuration generic and makes config management a=
 lot easier.
>
> Wido
>
>> Thanks!
>> sage
>>
>>
>> On Mon, 23 Jan 2017, Loic Dachary wrote:
>>
>> > Hi Wido,
>> >
>> > Updated http://pad.ceph.com/p/crush-types with your proposal for the r=
ule syntax
>> >
>> > Cheers
>> >
>> > On 01/23/2017 03:29 PM, Sage Weil wrote:
>> > > On Mon, 23 Jan 2017, Wido den Hollander wrote:
>> > >>> Op 22 januari 2017 om 17:44 schreef Loic Dachary <loic@dachary.org=
>:
>> > >>>
>> > >>>
>> > >>> Hi Sage,
>> > >>>
>> > >>> You proposed an improvement to the crush map to address different =
device types (SSD, HDD, etc.)[1]. When learning how to create a crush map, =
I was indeed confused by the tricks required to create SSD only pools. Afte=
r years of practice it feels more natural :-)
>> > >>>
>> > >>> The source of my confusion was mostly because I had to use a hiera=
rchical description to describe something that is not organized hierarchica=
lly. "The rack contains hosts that contain devices" is intuitive. "The rack=
 contains hosts that contain ssd that contain devices" is counter intuitive=
. Changing:
>> > >>>
>> > >>>     # devices
>> > >>>     device 0 osd.0
>> > >>>     device 1 osd.1
>> > >>>     device 2 osd.2
>> > >>>     device 3 osd.3
>> > >>>
>> > >>> into:
>> > >>>
>> > >>>     # devices
>> > >>>     device 0 osd.0 ssd
>> > >>>     device 1 osd.1 ssd
>> > >>>     device 2 osd.2 hdd
>> > >>>     device 3 osd.3 hdd
>> > >>>
>> > >>> where ssd/hdd is the device class would be much better. However, u=
sing the device class like so:
>> > >>>
>> > >>>     rule ssd {
>> > >>>             ruleset 1
>> > >>>             type replicated
>> > >>>             min_size 1
>> > >>>             max_size 10
>> > >>>             step take default:ssd
>> > >>>             step chooseleaf firstn 0 type host
>> > >>>             step emit
>> > >>>     }
>> > >>>
>> > >>> looks arcane. Since the goal is to simplify the description for th=
e first time user, maybe we could have something like:
>> > >>>
>> > >>>     rule ssd {
>> > >>>             ruleset 1
>> > >>>             type replicated
>> > >>>             min_size 1
>> > >>>             max_size 10
>> > >>>             device class =3D ssd
>> > >>
>> > >> Would that be sane?
>> > >>
>> > >> Why not:
>> > >>
>> > >> step set-class ssd
>> > >> step take default
>> > >> step chooseleaf firstn 0 type host
>> > >> step emit
>> > >>
>> > >> Since it's a 'step' you take, am I right?
>> > >
>> > > Good idea... a step is a cleaner way to extend the syntax!
>> > >
>> > > sage
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> > > the body of a message to majordomo@vger.kernel.org
>> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > >
>> >
>> > --
>> > Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20

Kyle Bader
