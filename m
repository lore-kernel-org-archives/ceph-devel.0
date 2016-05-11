From: Gris Ge <fge@redhat.com>
Subject: Re: Introducing libstoragemgmt as a Ceph dependency
Date: Wed, 11 May 2016 14:34:25 +0800
Message-ID: <20160511063425.GC2683@redhat.com>
References: <TU4PR84MB0032768F74C89DF30F93BE0BCC7A0@TU4PR84MB0032.NAMPRD84.PROD.OUTLOOK.COM>
 <alpine.DEB.2.11.1605031412580.26967@cpach.fuggernut.com>
 <TU4PR84MB00326FE52F4342863273CFA4CC7A0@TU4PR84MB0032.NAMPRD84.PROD.OUTLOOK.COM>
 <5732D0A1.7020209@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59694 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbcEKGec (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 May 2016 02:34:32 -0400
Content-Disposition: inline
In-Reply-To: <5732D0A1.7020209@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: "Handzik, Joseph" <joseph.t.handzik@hpe.com>, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "tasleson@redhat.com" <tasleson@redhat.com>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2016 at 04:26:41PM +1000, Tim Serong wrote:
> On 05/04/2016 04:22 AM, Handzik, Joseph wrote:
> > [...]
> >> I'm giving all the above for context, but what I really need to know=
=20
> >> from the ceph-devel community is: Does anyone have any concerns with=
=20
> >> adding libstoragemgmt as a Ceph dependency? It would only work for the=
=20
> >> standard Linux flavors and distros (Rhel and Centos, OpenSuse and=20
> >> SLES, Debian and Ubuntu). The features I'm adding would be no-ops or=
=20
> >> disabled for other distros unless someone in the community finds a way=
=20
> >> to distribute libstoragemgmt for their operating environment or finds=
=20
> >> an adequate replacement for the functionality. It's also worth noting=
=20
> >> that I'm completely dependent on the previously mentioned 1.3 release=
=20
> >> of libstoragemgmt, which is why I've waited on this for a while (the=
=20
> >> blueprint was initially intended for Jewel).
> >=20
> > The current distros upstream currently buidls on are:
> >=20
> >  centos 7
> >  ubuntu 16.04
> >  ubuntu 14.04
> >  debian 8 (jessie)
> >=20
> > Other packages are all down downstream (e.g., opensuse and sles).
> >=20
> > Anyway, is libstoragemgt available for the above?
> >=20
> > [JH] - I'm seeing packages for both 16.04 and 14.04, along with Debian =
Jessie and Centos7. I think my biggest challenge will be figuring out *exac=
tly* when the 1.3 release of libstoragemgmt is available for all these dist=
ros. I don't plan to submit a pull until I can confirm that.
>=20
> Speaking for a downstream, a quick search shows we've got libstoragemgmt
> 1.2.x (not 1.3) on the current latest versions of openSUSE and SLES.
Hi Tim,

We are doing some final tests before tag libstoragemgmt release
1.3.

For openSUSE and SLES, I will submit this branch back via OBS once
released:
https://build.opensuse.org/package/show/home:cathay4t:branches:Base:System/=
libstoragemgmt

Best regards.
>=20
> Regards,
>=20
> Tim
> --=20
> Tim Serong

--=20
Gris Ge

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMtJxAAoJEGzN5Y/kHij/PbUP/33N27hLHhvsOFNJBnNQhCHR
IdoTAdPrvV2jvRmp7MXclA2TSSqXua2EwlVwBw3h/aW8Nb34hFNzwmgaM94UoA7I
+0cLUQF4/Vj0iKSOGEaMyviTpGs/+gWi3tr+9Z0d+WVoVhAQBy9/0wSZGDvzfDAO
YXc+ISDygJHh2IfudXUsHE/YgJKU+W4KcnOD/IvM09Rqvy4TNgNuc2ecAzw9GRYX
QKEQRXrQ5131NHlGcIwOBLd5I0xulFvA4LLQ0hkTeUfe1/2dMd+1HIF6zzJrM3lU
jkmhTMdYzbC4GQEp7vrzBQRqylepwk3gHDA2XFlwBJGY7HztlR3NwkKUDzkRHKRK
J1f2ULH0T9jMZQP4YDvUW3vVKtxgPnF9/9oaN1PONOIoBJf+dsBzNzHlvvc1ea1H
exfa7TIx6YiDCeYv0NNJ4mwP1ouoqlzjGBG95Alkn1pm5u8kU4xti9m43UlvhjFg
t4asdybg+JRPIGCkgsr/Rrg4KYZPlK66djsyiqNrcSIFRi2ytCIV/4bsQlnjJeza
TXyp8nSPnpjp5nAkMcslc2v10EFMxJ64UjtPh+Ht7REjrf6Kqitm7wiTfj9O9bel
vmSTzjvalvbyNl8k49qqtYOKsCos6muS4Q+0oqlS4CSwVNrB8EqFdLiUMOY1B6SY
Pk2hjwaKM2810HwTE0tO
=/aaH
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
