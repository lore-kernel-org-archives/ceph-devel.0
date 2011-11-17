From: Andre Noll <maan@systemlinux.org>
Subject: Re: v0.38 released
Date: Thu, 17 Nov 2011 11:35:24 +0100
Message-ID: <20111117103524.GL13394@systemlinux.org>
References: <Pine.LNX.4.64.1111102113260.27241@cobra.newdream.net>
 <20111115164254.GJ13394@systemlinux.org>
 <CAF3hT9AA5zgTsbHb-Gxn5BTeMG+=krGdO2NtRFcHTR_k_3dKgw@mail.gmail.com>
 <20111116095614.GK13394@systemlinux.org>
 <CAORUGqCGRAK+x4Opzsw4hmjw2gKPWzxSvuVdx4A-2uR4mqQFZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jITzwD3HDGXid3BE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([79.140.41.46]:33313 "EHLO
	v3-1046.systemlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237Ab1KQKdh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Nov 2011 05:33:37 -0500
Content-Disposition: inline
In-Reply-To: <CAORUGqCGRAK+x4Opzsw4hmjw2gKPWzxSvuVdx4A-2uR4mqQFZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


--jITzwD3HDGXid3BE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 10:04, Tommi Virtanen wrote:
> On Wed, Nov 16, 2011 at 01:56, Andre Noll <maan@systemlinux.org> wrote:
> >> 2) I wouldn't expect your OSDs to have become so unbalanced that one
> >> of them hits 95% full when the cluster's only at 84% capacity.
> >
> > This seems to be due to the fact that roughly the same amount of data
> > was written to each file system despite of the different file system
> > sizes. Hence only 60% disk space is used on the two 800G file systems.
>=20
> That would be it. You probably want to set the weights of your OSDs
> according to their storage capacity, otherwise the smaller ones will
> get filled first.
>=20
> http://ceph.newdream.net/wiki/Monitor_commands#reweight

I was under the impression that equal weights on all osds means to
fill up all file systems by the same percentage, i.e. that file system
sizes are already taken care of.

But apparently this is not the case.  So one has to set the weights
manually according to the available disk space.

Thanks for enlightening me.
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--jITzwD3HDGXid3BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7E42wACgkQWto1QDEAkw+0xACdEbNAE1b7iXVwY3W0bCVV/wZg
ISYAn2/PiERREl2G+Y89sJfcpulUYaVb
=1nvA
-----END PGP SIGNATURE-----

--jITzwD3HDGXid3BE--
