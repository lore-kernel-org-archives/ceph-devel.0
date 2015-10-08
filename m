From: Loic Dachary <loic@dachary.org>
Subject: Re: CephFS and the next hammer release v0.94.4
Date: Thu, 08 Oct 2015 23:34:41 +0200
Message-ID: <5616E171.7090102@dachary.org>
References: <5613E5CA.2060903@dachary.org> <CAJ4mKGZ3GRVwRMdpM3cqEi2gKELVkjDpxoE08ggPyvMCeM9r9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CqVk3DS3TdNUV4n2KlpGAm0Ei0EXa9wwi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39612 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755491AbbJHVeo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Oct 2015 17:34:44 -0400
In-Reply-To: <CAJ4mKGZ3GRVwRMdpM3cqEi2gKELVkjDpxoE08ggPyvMCeM9r9g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CqVk3DS3TdNUV4n2KlpGAm0Ei0EXa9wwi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/10/2015 22:50, Gregory Farnum wrote:
> On Tue, Oct 6, 2015 at 8:16 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Greg,
>>
>> The next hammer release as found at https://github.com/ceph/ceph/tree/=
hammer passed the fs suite (http://tracker.ceph.com/issues/12701#note-66)=
=2E Do you think the hammer branch is ready for QE to start their own rou=
nd of testing ?
>>
>> Cheers
>>
>> P.S. http://tracker.ceph.com/issues/12701#Release-information has dire=
ct links to the pull requests merged into hammer since v0.94.3 in case yo=
u need more context about one of them.
>=20
> I don't see any FS patches in that list. The only thing I'm aware of
> which CephFS would like to see backported is
> https://github.com/ceph/ceph/pull/5885, which isn't in that list but
> has been merged since...would it be difficult to add that one?

It will be in the v0.94.4 release.

Thanks !

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--CqVk3DS3TdNUV4n2KlpGAm0Ei0EXa9wwi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYW4XEACgkQ8dLMyEl6F200TwCfUPWXpmEFoE6thCxoEwQ/CL1V
6nUAn1eSbmsaTnViEJYle1IbR9Y76BZi
=ayGd
-----END PGP SIGNATURE-----

--CqVk3DS3TdNUV4n2KlpGAm0Ei0EXa9wwi--
