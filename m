From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH 2/3] ec: make use of added aligned buffers
Date: Mon, 15 Sep 2014 19:20:29 +0200
Message-ID: <54171FDD.4070701@dachary.org>
References: <1410796508-28711-1-git-send-email-j@jannau.net> <1410796508-28711-2-git-send-email-j@jannau.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CpMEPvnmSojArg235v13mejEr0E1G275C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52544 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753996AbaIORUg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Sep 2014 13:20:36 -0400
In-Reply-To: <1410796508-28711-2-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CpMEPvnmSojArg235v13mejEr0E1G275C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Janne,

See below:

On 15/09/2014 17:55, Janne Grunau wrote:
> Requiring page aligned buffers and realigning the input if necessary
> creates measurable oberhead. ceph_erasure_code_benchmark is ~30% faster=

> with this change for technique=3Dreed_sol_van,k=3D2,m=3D1.
>=20
> Also prevents a misaligned buffer when bufferlist::c_str(bufferlist)
> has to allocate a new buffer to provide continuous one. See bug #9408
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  src/erasure-code/ErasureCode.cc | 46 +++++++++++++++++++++++++--------=
--------
>  src/erasure-code/ErasureCode.h  |  3 ++-
>  2 files changed, 30 insertions(+), 19 deletions(-)
>=20
> diff --git a/src/erasure-code/ErasureCode.cc b/src/erasure-code/Erasure=
Code.cc
> index 5953f49..078f60b 100644
> --- a/src/erasure-code/ErasureCode.cc
> +++ b/src/erasure-code/ErasureCode.cc
> @@ -54,22 +54,38 @@ int ErasureCode::minimum_to_decode_with_cost(const =
set<int> &want_to_read,
>  }
> =20
>  int ErasureCode::encode_prepare(const bufferlist &raw,
> -                                bufferlist *prepared) const
> +                                map<int, bufferlist> &encoded) const
>  {
>    unsigned int k =3D get_data_chunk_count();
>    unsigned int m =3D get_chunk_count() - k;
>    unsigned blocksize =3D get_chunk_size(raw.length());
> -  unsigned padded_length =3D blocksize * k;
> -  *prepared =3D raw;
> -  if (padded_length - raw.length() > 0) {
> -    bufferptr pad(padded_length - raw.length());
> -    pad.zero();
> -    prepared->push_back(pad);
> +  unsigned pad_len =3D blocksize * k - raw.length();
> +
> +  bufferlist prepared =3D raw;
> +
> +  if (!prepared.is_aligned()) {
> +    prepared.rebuild_aligned();
> +  }
> +
> +  for (unsigned int i =3D 0; i < k - !!pad_len; i++) {
> +    int chunk_index =3D chunk_mapping.size() > 0 ? chunk_mapping[i] : =
i;
> +    bufferlist &chunk =3D encoded[chunk_index];
> +    chunk.substr_of(prepared, i * blocksize, blocksize);
> +  }

It is possible for more than one chunk to be padding. It's a border case =
but... for instance with alignment =3D 16, k=3D12 and in of length 1550 y=
ou end up with two padding chunks because the blocksize is 144.

> +  if (pad_len > 0) {
> +    int chunk_index =3D chunk_mapping.size() > 0 ? chunk_mapping[k - 1=
] : k - 1;
> +    bufferlist &chunk =3D encoded[chunk_index];
> +    bufferptr padded(buffer::create_aligned(blocksize));
> +    raw.copy((k - 1) * blocksize, blocksize - pad_len, padded.c_str())=
;
> +    padded.zero(blocksize - pad_len, pad_len);
> +    chunk.push_back(padded);
>    }
> -  unsigned coding_length =3D blocksize * m;
> -  bufferptr coding(buffer::create_page_aligned(coding_length));
> -  prepared->push_back(coding);
> -  prepared->rebuild_page_aligned();
> +  for (unsigned int i =3D k; i < k + m; i++) {
> +    int chunk_index =3D chunk_mapping.size() > 0 ? chunk_mapping[i] : =
i;
> +    bufferlist &chunk =3D encoded[chunk_index];
> +    chunk.push_back(buffer::create_aligned(blocksize));
> +  }
> +
>    return 0;
>  }
> =20
> @@ -80,15 +96,9 @@ int ErasureCode::encode(const set<int> &want_to_enco=
de,
>    unsigned int k =3D get_data_chunk_count();
>    unsigned int m =3D get_chunk_count() - k;
>    bufferlist out;
> -  int err =3D encode_prepare(in, &out);
> +  int err =3D encode_prepare(in, *encoded);
>    if (err)
>      return err;
> -  unsigned blocksize =3D get_chunk_size(in.length());
> -  for (unsigned int i =3D 0; i < k + m; i++) {
> -    int chunk_index =3D chunk_mapping.size() > 0 ? chunk_mapping[i] : =
i;
> -    bufferlist &chunk =3D (*encoded)[chunk_index];
> -    chunk.substr_of(out, i * blocksize, blocksize);
> -  }
>    encode_chunks(want_to_encode, encoded);
>    for (unsigned int i =3D 0; i < k + m; i++) {
>      if (want_to_encode.count(i) =3D=3D 0)
> diff --git a/src/erasure-code/ErasureCode.h b/src/erasure-code/ErasureC=
ode.h
> index 7aaea95..62aa383 100644
> --- a/src/erasure-code/ErasureCode.h
> +++ b/src/erasure-code/ErasureCode.h
> @@ -46,7 +46,8 @@ namespace ceph {
>                                              const map<int, int> &avail=
able,
>                                              set<int> *minimum);
> =20
> -    int encode_prepare(const bufferlist &raw, bufferlist *prepared) co=
nst;
> +    int encode_prepare(const bufferlist &raw,
> +                       map<int, bufferlist> &encoded) const;
> =20
>      virtual int encode(const set<int> &want_to_encode,
>                         const bufferlist &in,
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--CpMEPvnmSojArg235v13mejEr0E1G275C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQXH90ACgkQ8dLMyEl6F20l6gCgnVisDJh6a8R94fOTlFwsyW3n
Rr8An15Wh2ar0OgQEmUsLJlteIpD7a79
=ai4T
-----END PGP SIGNATURE-----

--CpMEPvnmSojArg235v13mejEr0E1G275C--
