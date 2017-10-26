From: Karol Mroz <kmroz@suse.de>
Subject: Re: 12.2.2 status
Date: Thu, 26 Oct 2017 15:48:08 -0700
Message-ID: <FCD206E6-9E88-478C-9230-D0FAD0F8BA4F@suse.de>
References: <87fua6c4xy.fsf@suse.com>
 <CADRKj5RuqjfQQoK+ri+WLqh07O9snWvsKSfr+83GmmRtBYiBHw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2D632F31-45DE-4E8D-84FD-9E9D357ADF1D";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50411 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932400AbdJZWsP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 26 Oct 2017 18:48:15 -0400
In-Reply-To: <CADRKj5RuqjfQQoK+ri+WLqh07O9snWvsKSfr+83GmmRtBYiBHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, cbodley@redhat.com
Cc: Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Matt Benjamin <mbenjamin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>


--Apple-Mail=_2D632F31-45DE-4E8D-84FD-9E9D357ADF1D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

+CC Casey

Hi Yehuda and Casey,


> On Oct 26, 2017, at 9:50 AM, Yehuda Sadeh-Weinraub <yehuda@redhat.com> =
wrote:
[=E2=80=A6]
>=20
> I'd be happy to see these fixed:
> http://tracker.ceph.com/issues/21819

Opened backport ticket http://tracker.ceph.com/issues/21937
https://github.com/ceph/ceph/pull/18539


> http://tracker.ceph.com/issues/21735

Opened backport ticket http://tracker.ceph.com/issues/21938
Final commit of https://github.com/ceph/ceph/pull/18198 appears =
dependent on at least: cbb84cb13db and 53526d5050a in master.  Please =
advise.

>=20
> however, these are not in master yet, need validation.
>=20
> This one is ready I think:
> http://tracker.ceph.com/issues/21500

Opened: http://tracker.ceph.com/issues/21939
https://github.com/ceph/ceph/pull/18569
  - Still need https://github.com/ceph/s3-tests/pull/189 backported to =
ceph-luminous branch of s3tests

Regards,
Karol Mroz
kmroz@suse.de




--Apple-Mail=_2D632F31-45DE-4E8D-84FD-9E9D357ADF1D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE8+xsF/Gq4ohtXtiEKnbxtOGDNq0FAlnyZigACgkQKnbxtOGD
Nq0n4Qf/aIlFNozsTXOZAn1CpNoeC/+JI/LYrstUJ+bmkJ8Q00fSlyAwKj/nRZE6
DO/QXhpi+CUDkXwSEhegTax11fnm4xXZEh4CIN9Bl/QI1x5z9/9UUStDkI79DuMR
nROqM2D598KL0kSb8Em7u+7Efe9K9YteD/oZjnOD/HAPYKR39zSJRzBjNDAhVl1g
HBkGckvbSnox6A70EeqMk026Lqv9TJS5lO0ikaUlBqP2MTNCjZiMyHSHRqztgC7/
ySFevHaRzRefuAMgL4952YgnMVi+OSyUedfybxVe9dDcf7sO90jBocLxu+W1YiQ8
pK47fmG9X8XARllaVKI9bo4HXIwKuw==
=sM8B
-----END PGP SIGNATURE-----

--Apple-Mail=_2D632F31-45DE-4E8D-84FD-9E9D357ADF1D--
