From: Sage Weil <sage@newdream.net>
Subject: Re: Log files with 0.45
Date: Fri, 20 Apr 2012 13:21:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204201317480.27669@cobra.newdream.net>
References: <4F8E48C3.7040309@bisect.de> <4A32F0EAF810462DA627FE3E06945B65@dreamhost.com>
 <CAPud5_6M_f2eSz4dMT7QGXVpdbtc3Q_sPD-byAYL0Y+JQ0bAVA@mail.gmail.com>
 <CADxhoDSjfQBoUNWwiKFzj=Hjm2C6cvacbR1si48Ad+_sta9KMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1450143406-1334953310=:27669"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41524 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab2DTUVv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Apr 2012 16:21:51 -0400
In-Reply-To: <CADxhoDSjfQBoUNWwiKFzj=Hjm2C6cvacbR1si48Ad+_sta9KMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Calvin Morrow <calvin.morrow@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1450143406-1334953310=:27669
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 20 Apr 2012, Calvin Morrow wrote:
> I'm seeing the same.  < 12 hours with 6 OSDs resulted in ~18 GB of
> logs.  I had to change my log rotate config to compress based on size
> instead of once a day or I ended up with a full root partition.
>=20
> I would love to know if there's a better way to handle it.

This will be fixed in 0.46. You can also cherry-pick=20
ac874a62533c3845f9e68201bfd4f7020332da24 from the stable branch to fix=20
this.

You can also set 'debug optracker =3D 0' to turn this down.

sage



>=20
> Calvin
>=20
> On Fri, Apr 20, 2012 at 5:05 PM, Nick Bartos <nick@pistoncloud.com> wrote=
:
> > Is there a recommended log config for production systems? =A0I'm also
> > trying to decrease the verbosity in 0.45, using the options specified
> > here: =A0http://ceph.newdream.net/wiki/Debugging. =A0Setting them down =
to
> > '1' doesn't end the insane log sprawl I'm seeing.
> >
> > On Tue, Apr 17, 2012 at 10:09 PM, Greg Farnum
> > <gregory.farnum@dreamhost.com> wrote:
> >> On Tuesday, April 17, 2012 at 9:53 PM, Danny Kukawka wrote:
> >>> Hi,
> >>>
> >>> did something change with the default log levels for OSDs on v0.45? W=
ith
> >>> 0.43 and IIRC also 0.44* the logfiles had a acceptable size, but now =
I
> >>> get by default ~3Gbyte per OSD over 12 hours without any change in th=
e
> >>> config file.
> >>>
> >>> Danny
> >> I think some extra event notifications got stuck in the logs for OSD o=
perations; they're nice for debugging but may well have a log level higher =
than they should. They should be easy to compress a lot, though!
> >>
> >> Can you comment on this, Sam?
> >> -Greg
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1450143406-1334953310=:27669--
