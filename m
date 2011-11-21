From: Andre Noll <maan@tuebingen.mpg.de>
Subject: Re: v0.38 released
Date: Mon, 21 Nov 2011 19:06:56 +0100
Message-ID: <20111121180656.GO13394@systemlinux.org>
References: <20111115164254.GJ13394@systemlinux.org>
 <CAF3hT9AA5zgTsbHb-Gxn5BTeMG+=krGdO2NtRFcHTR_k_3dKgw@mail.gmail.com>
 <20111116095614.GK13394@systemlinux.org>
 <CAORUGqCGRAK+x4Opzsw4hmjw2gKPWzxSvuVdx4A-2uR4mqQFZg@mail.gmail.com>
 <20111117103524.GL13394@systemlinux.org>
 <CAORUGqA2HJQFXM01mq29TcSTK9p7OxLDGa9s85OfkbgWALnu7w@mail.gmail.com>
 <20111118150157.GM13394@systemlinux.org>
 <CAORUGqBNus_UuYOvkjcAtsbz+S1AKbafB1utwqAyq=sB7j8g9w@mail.gmail.com>
 <20111121173254.GN13394@systemlinux.org>
 <CAORUGqAWBbY2VS=X2fFq1PNyjJUYD50=-S=BctaALE6Xn+dEtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WU3I8Do+sziGY3UL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([79.140.41.46]:38887 "EHLO
	v3-1046.systemlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab1KUSFH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2011 13:05:07 -0500
Content-Disposition: inline
In-Reply-To: <CAORUGqAWBbY2VS=X2fFq1PNyjJUYD50=-S=BctaALE6Xn+dEtw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


--WU3I8Do+sziGY3UL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 21, 09:36, Tommi Virtanen wrote
> I agree, and that's a big part of the reasons for choosing the
> toolchain I did! All the docs from http://ceph.newdream.net/docs are
> in the doc/ directory of the source tree.
>=20
> > Should I prepare something and post a request for inclusion to the
> > web pages on this mailing list, or do you want me to edit the web
> > documentation directly?
>=20
> Submit it like you would submit a code change.

OK, will do so. I'll start with the list of OSD subcommands from
the old wiki and try to improve on this. As soon I have something to
present I'll send an RFC-style patch series to the list. This will
likely contain questions on certain subcommands, and I'll include
the relevant parts of any replies in subsequent versions of the
patch series.

Thanks
Andre
--=20
Max Planck Institute for Developmental Biology
Spemannstrasse 35, 72076 T=C3=BCbingen, Germany
Phone: (+049) 7071 601 829

--WU3I8Do+sziGY3UL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEARECAAYFAk7Kk0AACgkQWto1QDEAkw9dAQCY4/9ut70aBxOsXQmP7wYXRcY8
tgCeKPTbFG/nJfMgoIQ5tqMDXypxxaw=
=IrB3
-----END PGP SIGNATURE-----

--WU3I8Do+sziGY3UL--
