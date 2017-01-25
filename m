From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: libcrush C API documentation
Date: Wed, 25 Jan 2017 13:25:57 -0500
Message-ID: <20170125182557.GC2432@ultraspiritum.eng.arb.redhat.com>
References: <14e5037f-65c0-51d5-c9bd-0d1302baf144@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752181AbdAYSZ7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Jan 2017 13:25:59 -0500
Content-Disposition: inline
In-Reply-To: <14e5037f-65c0-51d5-c9bd-0d1302baf144@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/01/2017, Loic Dachary wrote:
> Hi Adam,
>=20
> I would be great if you could review the libcrush C API documentation mer=
ge request at http://libcrush.org/main/libcrush/merge_requests/1/diffs. I d=
eliberately documented part of the external functions because some of them =
( crush_make_uniform_bucket for instance ) are support functions for a high=
er level function ( crush_make_bucket for instance ). If you think a functi=
on should be documented and it is not, this is not because it's work in pro=
gress, it's because I may have misjudged it.
>=20
> The unsupported features are undocumented (for instance the tree and stra=
w algorithms). They should probably be compiled out via a #if before the fi=
rst standalone release of the library binary package. But it did not seem t=
o be a good idea to dive into that while documenting.
>=20
> You can skip the review of the struct crush_map fields. Nothing was done =
except changing the existing comments to match Doxygen conventions. There i=
s much to do to improve this. Explaining the tunables is not for the faint =
of heart.
>=20
> The format chosen for the documentation is Doxygen, as we discussed. Than=
ks for suggesting it :-)
>=20
> Cheers

I will be happy to! Do you want me to read for, mostly, technical
coverage etc. or for style and usage and whatnot, too?

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJYiO2vXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jeX0H/1AgviFvByFfjNNwfuQMgHtd
oGIJXdgk6zydSTbr7gvQ9dcnnSHlvziqZq0q0N4sRqbvBoC/ywKGecD6f7Ej6iil
VuiOTcMTp54LVGtwTKKdnNyBgYptTFGOOMlivqpo1elsUrQZ59bvpKRSK1NTQfX3
d3vtbTEeuIPcDFi9GIqqQI12y5uWVj8bkEq42oKRKzJ1fLG31y2y8LhzfQ/UZ4r0
l72TJPx5etlcjSbaWZXMzRVETxzt0FBUthugesn3oxLw3xWC7xKv1I8Vo6/Ui39V
YxLLDZHLYMePgGHXn8suhN85aajMFxzxUc0VL1sRowqJlFwNQkOatR+s2ZOOkm0=
=ALiG
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
