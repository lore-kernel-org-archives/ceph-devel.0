From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: disk enclosure LEDs
Date: Fri, 2 Dec 2016 16:57:22 +0000
Message-ID: <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
 <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
 <20161202092301.f65vgyjrssujfyrj@suse.de>
 <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0047.outbound.protection.outlook.com ([104.47.33.47]:1472
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751639AbcLBQ5Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Dec 2016 11:57:24 -0500
In-Reply-To: <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Friday, December 02, 2016 6:24 AM
> To: Lars Marowsky-Bree <lmb@suse.com>
> Cc: Ceph Development <ceph-devel@vger.kernel.org>
> Subject: Re: disk enclosure LEDs
>=20
> On Fri, 2 Dec 2016, Lars Marowsky-Bree wrote:
> > On 2016-12-01T00:15:25, John Spray <jspray@redhat.com> wrote:
> >
> > > Put another way, I'd like it to be the case that people who want to
> > > twiddle LEDs can write a ceph-mgr module that does that, rather than
> > > having to push out a libstoragemgmt-enabled agent to the Ceph servers=
.
> >
> > I'm not sure I agree.
> >
> > I understand some of the motivation, but the key use cases where I'd
> > want to "twiddle LEDs" involve enclosures that either don't yet have
> > an OSD deployed (e.g., where to plug in the new disk), or where the
> > OSD has failed (and may not even be able to start).
> >
> > And I don't want to have to maintain multiple paths for interacting
> > with the enclosures.
>=20
> I agree with John that it would be great to have ceph-mgr plugins doing t=
his
> sort of thing.  But the OSD can't be the only path, and I also don't like=
 the idea
> of multiple paths.
>=20
> The problem is that there needs to be something on the hosts that's doing
> this, and I don't want to just ignore it and hope some other layer solves=
 it;
> years have gone by and nobody has done it, and I'd like to avoid a
> fragmented approach if we can.
>=20
> On the other hand, if we simply make an opinionated choice about some
> other per-host agent service, like we did in the original Calamari (which=
 used
> salt and zeromq, IIRC), we'll probably end up offending more users than w=
e
> please.
>=20
> Perhaps the way forward is to pick *some* external host agent and service
> to start with and ensure that it is integrated into ceph-mgr in a pluggab=
le way
> such that we have (1) the osd:device mappings available, (2) a standard A=
PI
> for working with LEDs etc, and (3) a working plugin for twiddling the LED=
s, but
> ensure that other "disk services" backends can also be used?

I think it's important to separate this problem into two pieces: ceph-speci=
fic and platform-specific.

The ceph-specific part of the problem is to create a single abstraction and=
 mechanism so that upper-level tools (ceph-mgr, GUIs, workflow scripts, etc=
.) can manipulation the abstraction without worrying about the implementati=
on details. I'm completely with John that ceph-mgr is the right place for t=
he upper-layer to terminated. Ultimately, we'll have infrastructure that ti=
es the physical state of the drives (power up/down, lights on/off, etc.) mo=
re closely to the operational state of the system -- this is an area where =
more standardized automation will remove a significant barrier to wide-spre=
ad deployments.

The platform-specific part definitely should be pluggable/configurable/soft=
/manipulable, etc. It'll be quite some time (if ever) before something like=
 libstoragemgmt becomes a reliable, universal, standard interface. We can't=
 let that hold back the development of the upper-level infrastructure stuff=
.

So, I'd vote for having an API termination in ceph-mgr. Have the mgr contac=
t the destination system (the OSD is *NOT* the right path) to perform the a=
ction. Then do something like invoke a configurable shell script (something=
 that's configurable) to perform the actual operation.=20

=20
>=20
> sage
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
