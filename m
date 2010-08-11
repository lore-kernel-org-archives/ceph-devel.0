From: Sage Weil <sage@newdream.net>
Subject: Re: cosd dying after start
Date: Wed, 11 Aug 2010 13:15:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008111311440.6194@cobra.newdream.net>
References: <AANLkTi=zkYni8xgp5aMQ6Q52RmDnu3eAqZ-8-DO-_6n_@mail.gmail.com>
 <AANLkTi=_kCreuSdkywt2xgcPrHebR6tBODvNnguhXFrU@mail.gmail.com>
 <Pine.LNX.4.64.1008101358280.9792@cobra.newdream.net>
 <AANLkTi=rYmFBg=SR-XBeCqu2V67tH9Fw1g7H3Rq7TE4V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-580354808-1281557518=:6194"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40866 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383Ab0HKUPg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Aug 2010 16:15:36 -0400
In-Reply-To: <AANLkTi=rYmFBg=SR-XBeCqu2V67tH9Fw1g7H3Rq7TE4V@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1008111313120.6194@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-580354808-1281557518=:6194
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1008111313121.6194@cobra.newdream.net>

On Wed, 11 Aug 2010, Christian Brunner wrote:

> 2010/8/10 Sage Weil <sage@newdream.net>:
> > On Tue, 10 Aug 2010, Christian Brunner wrote:
> >
> >> After a bit more debuging I've found out that there seems to be a file
> >> missing from the filestore:
> >>
> >> 10.08.10_18:14:07.862190 7f568d3e5710 filestore(/ceph/osd/osd02)
> >> getattr /ceph/osd/osd02/current/3.f2_head/rb.0.1d6.00000000000e_head
> >> '_' =3D -2
> >
> > There was a bug last week in the kernel client rbd branch that was
> > improperly encoding osd write operation payloads. =A0Can you check that=
 your
> > rbd client is running 79c49720, which fixes it?
>=20
> I'm not using the kernel client. - The problem started after a crash
> of the cosd. If you want me to, I can try to analyse the coredump.

Just getting a backtrace from the core would be helpful.  And in the=20
do_osd_op frame, 'p osd_op.data._len', 'p bp.off'. =20

> > That error above was probably just because that object hadn't been writ=
ten
> > yet, and isn't a fatal error. =A0There is a 'scrub' function that verif=
ies
> > that most of the osd metadata is in order and replication is accurate:
> > 'ceph osd scrub <osdnum>' and watch 'ceph -w' to see the success or err=
or
> > messages go by for each pg (or tail $mon_data/log on any monitor)
>=20
> I was not able to start the osd, so the scrub didn't run either. Every
> time I tried to start it, it died with the message
> "terminate called after throwing an instance of
> 'ceph::buffer::end_of_buffer*'" after 3 seconds.
>=20
> The only thing that worked was to set up a whole new filesystem.

From=20the log it looks like that was from some client resending the=20
(malfomred?) request.  I think killing the clients should have worked as=20
well in this case.

Thanks!
sage
--557981400-580354808-1281557518=:6194--
