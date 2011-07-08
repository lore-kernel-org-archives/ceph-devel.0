From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Verification of Crush Rules
Date: Fri, 8 Jul 2011 09:54:33 -0700
Message-ID: <CAORUGqAO_4LXWNdwA6QDULW8_iOquZJoZWSyK0MuYe6UhSZA4A@mail.gmail.com>
References: <Acw7IKpx9Yu6iYnGQImpH7qRPPNevQ==> <B828A4C02BE12543ACDFCF7EB0C693C678862E5E48@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45924 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1GHQyy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2011 12:54:54 -0400
Received: by eyx24 with SMTP id 24so727010eyx.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2011 09:54:53 -0700 (PDT)
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C678862E5E48@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 5, 2011 at 07:34, Mark Nigh <mnigh@netelligent.com> wrote:
> I have created a cluster with 2 nodes and 6 osds each.
>
> I would like to verify if my pgs are being placed on the correct node=
s based on my crushmap. I would like to make sure that my replication (=
x2, default) is not placed on the same host. Osd.0 through 5 is on host=
0 and osd.6 through osd.11 is on host1.
=2E..
> The end of "ceph pg dump -o -" shows the following which doesn't look=
 correct.
>
> osdstat kbused =C2=A0kbavail kb =C2=A0 =C2=A0 =C2=A0hb in =C2=A0 hb o=
ut
> 0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =
0 =C2=A0 =C2=A0 =C2=A0 [] =C2=A0 =C2=A0 =C2=A0[]
> 1 =C2=A0 =C2=A0 =C2=A0 393884 =C2=A02927750484 =C2=A0 =C2=A0 =C2=A029=
30265540 =C2=A0 =C2=A0 =C2=A0[0,2,3,4,5] =C2=A0 =C2=A0 [0,2,3,4,5]
> 2 =C2=A0 =C2=A0 =C2=A0 304580 =C2=A02927838884 =C2=A0 =C2=A0 =C2=A029=
30265540 =C2=A0 =C2=A0 =C2=A0[0,1,3,4,5] =C2=A0 =C2=A0 [0,1,3,4,5]
> 3 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =
0 =C2=A0 =C2=A0 =C2=A0 [] =C2=A0 =C2=A0 =C2=A0[]
> 4 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =
0 =C2=A0 =C2=A0 =C2=A0 [] =C2=A0 =C2=A0 =C2=A0[]
> 5 =C2=A0 =C2=A0 =C2=A0 158908 =C2=A02927983588 =C2=A0 =C2=A0 =C2=A029=
30265540 =C2=A0 =C2=A0 =C2=A0[0,1,2,3,4] =C2=A0 =C2=A0 [0,1,2,3,4]
> 6 =C2=A0 =C2=A0 =C2=A0 496 =C2=A0 =C2=A0 2892788952 =C2=A0 =C2=A0 =C2=
=A02894914980 =C2=A0 =C2=A0 =C2=A0[] =C2=A0 =C2=A0 =C2=A0[]
> 7 =C2=A0 =C2=A0 =C2=A0 504 =C2=A0 =C2=A0 2928139544 =C2=A0 =C2=A0 =C2=
=A02930265540 =C2=A0 =C2=A0 =C2=A0[] =C2=A0 =C2=A0 =C2=A0[]
> 8 =C2=A0 =C2=A0 =C2=A0 504 =C2=A0 =C2=A0 2928139544 =C2=A0 =C2=A0 =C2=
=A02930265540 =C2=A0 =C2=A0 =C2=A0[] =C2=A0 =C2=A0 =C2=A0[]
> 9 =C2=A0 =C2=A0 =C2=A0 504 =C2=A0 =C2=A0 2928139544 =C2=A0 =C2=A0 =C2=
=A02930265540 =C2=A0 =C2=A0 =C2=A0[] =C2=A0 =C2=A0 =C2=A0[]
> 10 =C2=A0 =C2=A0 =C2=A0504 =C2=A0 =C2=A0 2928139544 =C2=A0 =C2=A0 =C2=
=A02930265540 =C2=A0 =C2=A0 =C2=A0[] =C2=A0 =C2=A0 =C2=A0[]
> 11 =C2=A0 =C2=A0 =C2=A0504 =C2=A0 =C2=A0 2928139544 =C2=A0 =C2=A0 =C2=
=A02930265540 =C2=A0 =C2=A0 =C2=A0[] =C2=A0 =C2=A0 =C2=A0[]
> =C2=A0sum =C2=A0 =C2=A0860388 =C2=A026317059628 =C2=A0 =C2=A0 2633703=
9300

Yes, that looks like a bunch of your osds are not doing much. Some of
them seem be failing (6-11, see "hb in" later), some seem to just be
getting no objects assigned to them (0, 3, 4) -- I'm not sure if the
kbavail=3D=3D0 is a symptom of an actual problem, or just so because no
pg's got assigned to the osd by your crushmap.

You can test a crush config by simulating the data placement:

ceph osd getcrushmap -o crushmap
crushtool -i crushmap --test

Here's example output from my two-osd test cluster with perfect balanci=
ng:

devices weights (hex): [10000,10000]
rule 0 (data), x =3D 0..9999
 device 0:	10000
 device 1:	10000
 num results 2:	10000
rule 1 (metadata), x =3D 0..9999
 device 0:	10000
 device 1:	10000
 num results 2:	10000
rule 2 (rbd), x =3D 0..9999
 device 0:	10000
 device 1:	10000
 num results 2:	10000

Note that this doesn't consider any of the operational aspects of the
cluster, such as nodes being unreachable, full or overloaded.

> Which brings me to a couple of questions.
>
> 1. what is "hb in" and "hb out"?

It's the status of the hearbeat, whether the OSDs see each other (both
incoming and outgoing, as it's not necessarily symmetric). In your
output, OSDs 0-5 see each other; nobody sees osds 6-11 and they don't
report seeing any other OSDs.

You said that OSDs 6-11 are on the second machine; it seems that
machine is not able to talk to the monitors.

> 2. The original crush map examples shows "type device". The new versi=
ons of ceph show the first type as osds? I changed my back to device, b=
ut how do you define an osd or this automatically done for you. I mean =
by "define" is the section in the crush map that shows all the devices,=
 device 0 device0.

As far as I know, the bucket type strings are pretty much arbitrary,
and you use whatever makes sense for your deployment. For example, if
you had only one osd per host, then having a both bucket types host
and osd would be unnecessary. It's just describing your physical
deployment, e.g. row/rack/machine/osd, so the crush rules can control
placement e.g. across racks.

> 3. In the new default crushmap, there is a domain bucket. What is tha=
t intended for? Host?

The default crushmap, being automatically generated, has no knowledge
of the physical layout. For example, a lot of test clusters are fully
on a single host. Hence, it uses a vague word domain as the type of
the upper level bucket. If you customize, you know better, and can use
a more descriptive word.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
