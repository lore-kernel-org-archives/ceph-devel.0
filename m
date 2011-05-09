From: Sage Weil <sage@newdream.net>
Subject: Re: Unable to Add Monitor
Date: Mon, 9 May 2011 16:57:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105091656030.32068@cobra.newdream.net>
References: <B828A4C02BE12543ACDFCF7EB0C693C67885FC7D23@NC-SVR-09.netelligent.com>
 <BANLkTik5FbaysoFYV-XzKX1T+K8gPAsWzQ@mail.gmail.com>
 <B828A4C02BE12543ACDFCF7EB0C693C67885FC7DC9@NC-SVR-09.netelligent.com>
 <BANLkTim9qp_pgi0H9a93vQtUWrp4eY0H2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1409950804-1304985449=:32068"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55449 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845Ab1EIX4p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2011 19:56:45 -0400
In-Reply-To: <BANLkTim9qp_pgi0H9a93vQtUWrp4eY0H2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Mark Nigh <mnigh@netelligent.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1409950804-1304985449=:32068
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On thing to keep in mind (you may already be, I didn't read this thread=20
carefully) is that adding the second monitor will destroy its quorum. =20
Nothing new will happen until the new one is also brought online. =20

I don't think this should cause the disconnect message you see,=20
though--usually that's a monitor crash.  Was there a stack dump in the=20
logs?

sage


On Mon, 9 May 2011, Gregory Farnum wrote:

> Ah, yeah, it sounds like you broke your mon map by trying to change
> the name of your active monitor. I'm pretty sure to make that work you
> would need to add the monitor under the new name and then remove the
> old name!
>=20
> Let us know if you run into any other trouble, you're probably
> touching a lot of failure conditions here that we don't normally run
> into. :)
> -Greg
>=20
> On Mon, May 9, 2011 at 11:27 AM, Mark Nigh <mnigh@netelligent.com> wrote:
> >
> > On Mon, May 9, 2011 at 7:22 AM, Mark Nigh <mnigh@netelligent.com> wrote=
:
> >> I have been testing Ceph for several months now but with only 2 mds an=
d 1 mon. I would like to test failover between mon so I am trying to add th=
e first (1st) of two (2) mon on the other mds in the cluster.
> >>
> >> I also noticed that the mon naming has been changed from numerics to n=
ames so I am trying to change that also.
> >>
> >> My Process:
> >>
> >> On the first mon, I get an error when issuing this command "ceph mon a=
dd beta 10.6.1.91:6789"
> >>
> >> I receive the following error as it repeats:
> >>
> >> 2011-05-09 09:17:05.500353 7f9248ab0700 -- :/28272 >> 10.6.1.91:6789/0=
 pipe(0x2167010 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> > This error generally means that the daemon can't communicate with its
> > target -- in this case, 10.6.1.91:6789. Do you already have mon.beta
> > in your ceph.conf? It looks like ceph tool is trying to issue its
> > commands to that monitor.
> > You can specify which monitor to connect to using the -m switch:
> > ceph -m 10.6.1.90:6789 mon add beta 10.6.1.91:6789
> > (assuming there that mon.alpha is using address 10.6.1.90:6789).
> >
> > When I run this command on the original monitor it just hangs. If I run=
 the command, "ceph mon add msd1 10.6.1.91:6789, I receive the following me=
ssage:
> >
> > Mds1 is the hostname of the second monitor.
> >
> > 2011-05-09 12:28:01.823280 7ff64926d700 -- 10.6.1.90:0/26252 >> 10.6.1.=
91:6789/0 pipe(0x16168f0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> > 2011-05-09 12:28:07.823488 7ff64d242700 -- 10.6.1.90:0/26252 >> 10.6.1.=
91:6789/0 pipe(0x16168f0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> >
> > When I try to run the service ceph start mon.1 command on the 2nd monit=
or:
> >
> > mon.1 does not exist in monmap
> >
> >> When I try to start the monitor service on beta I get the following er=
ror:
> >>
> >> =3D=3D=3D mon.beta =3D=3D=3D
> >> Starting Ceph mon.beta on mds1...
> >> =A0** WARNING: Ceph is still under heavy development, and is only suit=
able for **
> >> =A0** =A0 =A0 =A0 =A0 =A0testing and review. =A0Do not trust it with i=
mportant data. =A0 =A0 =A0 **
> >> unable to read magic from mon data.. did you run mkcephfs?
> >> failed: ' /usr/bin/cmon -i beta -c /etc/ceph/ceph.conf '
> > Did you follow the directions at
> > http://ceph.newdream.net/wiki/Monitor_cluster_expansion?
> >
> > Yes, I believe it maybe that I tried to change the ceph.conf file from =
mon.0 and mon.1 to mon.alpha and mon.beta as the wiki states. For now, I th=
ought I would revert back to the mon.0 and mon.1 naming convention to elimi=
nate the number of changes.
> >
> > -Greg
> >
> > This transmission and any attached files are privileged, confidential o=
r otherwise the exclusive property of the intended recipient or Netelligent=
 Corporation. If you are not the intended recipient, any disclosure, copyin=
g, distribution or use of any of the information contained in or attached t=
o this transmission is strictly prohibited. If you have received this trans=
mission in error, please contact us immediately by responding to this messa=
ge or by telephone (314-392-6900) and promptly destroy the original transmi=
ssion and its attachments.
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1409950804-1304985449=:32068--
