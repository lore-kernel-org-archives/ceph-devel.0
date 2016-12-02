From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: disk enclosure LEDs
Date: Fri, 2 Dec 2016 18:05:26 +0000
Message-ID: <BLUPR0201MB1524F8910A0625ECACC4B29AE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
 <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
 <20161202092301.f65vgyjrssujfyrj@suse.de>
 <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
 <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <be5f1672179b4d41b2692a02fe71a7cd@Ex2013-MBX2.supermicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:10287
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752544AbcLBSjT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Dec 2016 13:39:19 -0500
In-Reply-To: <be5f1672179b4d41b2692a02fe71a7cd@Ex2013-MBX2.supermicro.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alan Johnson <alanj@supermicro.com>, Sage Weil <sage@newdream.net>, Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Yin <alexy@supermicro.com>

I agree. For the HW vendors, I think it's Ceph's job to execute some kind o=
f command on the local node (presumably, some kind of shell command). The v=
endor should take over from there.

I'd assume that one version of the shell command would be a simple wrapper =
around libstoragemgmt. So you'd have your choice of either extending libsto=
ragemgmt, or writing a command-line utility that did your special thing (wh=
atever it was).


Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: Alan Johnson [mailto:alanj@supermicro.com]
> Sent: Friday, December 02, 2016 9:57 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil
> <sage@newdream.net>; Lars Marowsky-Bree <lmb@suse.com>
> Cc: Ceph Development <ceph-devel@vger.kernel.org>; Alex Yin
> <alexy@supermicro.com>
> Subject: RE: disk enclosure LEDs
>=20
> As a hardware vendor we would like some sort of API to hook into - we do
> have a proprietary way of identifying failing devices but would rather
> conform to something more standard within the Ceph arena.
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Allen Samuels
> Sent: Friday, December 02, 2016 11:57 AM
> To: Sage Weil; Lars Marowsky-Bree
> Cc: Ceph Development
> Subject: RE: disk enclosure LEDs
>=20
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Friday, December 02, 2016 6:24 AM
> > To: Lars Marowsky-Bree <lmb@suse.com>
> > Cc: Ceph Development <ceph-devel@vger.kernel.org>
> > Subject: Re: disk enclosure LEDs
> >
> > On Fri, 2 Dec 2016, Lars Marowsky-Bree wrote:
> > > On 2016-12-01T00:15:25, John Spray <jspray@redhat.com> wrote:
> > >
> > > > Put another way, I'd like it to be the case that people who want
> > > > to twiddle LEDs can write a ceph-mgr module that does that, rather
> > > > than having to push out a libstoragemgmt-enabled agent to the Ceph
> servers.
> > >
> > > I'm not sure I agree.
> > >
> > > I understand some of the motivation, but the key use cases where I'd
> > > want to "twiddle LEDs" involve enclosures that either don't yet have
> > > an OSD deployed (e.g., where to plug in the new disk), or where the
> > > OSD has failed (and may not even be able to start).
> > >
> > > And I don't want to have to maintain multiple paths for interacting
> > > with the enclosures.
> >
> > I agree with John that it would be great to have ceph-mgr plugins
> > doing this sort of thing.  But the OSD can't be the only path, and I
> > also don't like the idea of multiple paths.
> >
> > The problem is that there needs to be something on the hosts that's
> > doing this, and I don't want to just ignore it and hope some other
> > layer solves it; years have gone by and nobody has done it, and I'd
> > like to avoid a fragmented approach if we can.
> >
> > On the other hand, if we simply make an opinionated choice about some
> > other per-host agent service, like we did in the original Calamari
> > (which used salt and zeromq, IIRC), we'll probably end up offending
> > more users than we please.
> >
> > Perhaps the way forward is to pick *some* external host agent and
> > service to start with and ensure that it is integrated into ceph-mgr
> > in a pluggable way such that we have (1) the osd:device mappings
> > available, (2) a standard API for working with LEDs etc, and (3) a
> > working plugin for twiddling the LEDs, but ensure that other "disk serv=
ices"
> backends can also be used?
>=20
> I think it's important to separate this problem into two pieces: ceph-spe=
cific
> and platform-specific.
>=20
> The ceph-specific part of the problem is to create a single abstraction a=
nd
> mechanism so that upper-level tools (ceph-mgr, GUIs, workflow scripts, et=
c.)
> can manipulation the abstraction without worrying about the
> implementation details. I'm completely with John that ceph-mgr is the rig=
ht
> place for the upper-layer to terminated. Ultimately, we'll have infrastru=
cture
> that ties the physical state of the drives (power up/down, lights on/off,=
 etc.)
> more closely to the operational state of the system -- this is an area wh=
ere
> more standardized automation will remove a significant barrier to wide-
> spread deployments.
>=20
> The platform-specific part definitely should be
> pluggable/configurable/soft/manipulable, etc. It'll be quite some time (i=
f
> ever) before something like libstoragemgmt becomes a reliable, universal,
> standard interface. We can't let that hold back the development of the
> upper-level infrastructure stuff.
>=20
> So, I'd vote for having an API termination in ceph-mgr. Have the mgr cont=
act
> the destination system (the OSD is *NOT* the right path) to perform the
> action. Then do something like invoke a configurable shell script (someth=
ing
> that's configurable) to perform the actual operation.
>=20
>=20
> >
> > sage
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in =
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
