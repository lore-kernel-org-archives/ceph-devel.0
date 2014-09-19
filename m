From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH v2 2/3] ec: use 32-byte aligned buffers
Date: Fri, 19 Sep 2014 11:47:22 +0200
Message-ID: <541BFBAA.9070108@dachary.org>
References: <1410796508-28711-1-git-send-email-j@jannau.net> <1411036435-18860-1-git-send-email-j@jannau.net> <1411036435-18860-3-git-send-email-j@jannau.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oHtMhaqwHj2JVHA5TnO93tDv2OroPT8Vw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55700 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751336AbaISJr3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 05:47:29 -0400
In-Reply-To: <1411036435-18860-3-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oHtMhaqwHj2JVHA5TnO93tDv2OroPT8Vw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Janne,

This looks good ! The 32 byte aligned buffer applies to the diff related =
to buffer.h though, could you update the title ? I tend to prefer erasure=
-code over ec : it is easier to grep / search ;-)

Cheers

On 18/09/2014 12:33, Janne Grunau wrote:
> Requiring page aligned buffers and realigning the input if necessary
> creates measurable oberhead. ceph_erasure_code_benchmark is ~30% faster=

> with this change for technique=3Dreed_sol_van,k=3D2,m=3D1.
>=20
> Also prevents a misaligned buffer when bufferlist::c_str(bufferlist)
> has to allocate a new buffer to provide continuous one. See bug #9408
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  src/erasure-code/ErasureCode.cc | 57 ++++++++++++++++++++++++++++-----=
--------
>  src/erasure-code/ErasureCode.h  |  3 ++-
>  2 files changed, 41 insertions(+), 19 deletions(-)
>=20
> diff --git a/src/erasure-code/ErasureCode.cc b/src/erasure-code/Erasure=
Code.cc
> index 5953f49..7aa5235 100644
> --- a/src/erasure-code/ErasureCode.cc
> +++ b/src/erasure-code/ErasureCode.cc
> @@ -54,22 +54,49 @@ int ErasureCode::minimum_to_decode_with_cost(const =
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
> +  unsigned padded_chunks =3D k - raw.length() / blocksize;
> +  bufferlist prepared =3D raw;
> +
> +  if (!prepared.is_aligned()) {
> +    // splice padded chunks off to make the rebuild faster
> +    if (padded_chunks)
> +      prepared.splice((k - padded_chunks) * blocksize,
> +                      padded_chunks * blocksize - pad_len);
> +    prepared.rebuild_aligned();
> +  }
> +
> +  for (unsigned int i =3D 0; i < k - padded_chunks; i++) {
> +    int chunk_index =3D chunk_mapping.size() > 0 ? chunk_mapping[i] : =
i;
> +    bufferlist &chunk =3D encoded[chunk_index];
> +    chunk.substr_of(prepared, i * blocksize, blocksize);
> +  }
> +  if (padded_chunks) {
> +    unsigned remainder =3D raw.length() - (k - padded_chunks) * blocks=
ize;
> +    bufferlist padded;
> +    bufferptr buf(buffer::create_aligned(padded_chunks * blocksize));
> +
> +    raw.copy((k - padded_chunks) * blocksize, remainder, buf.c_str());=

> +    buf.zero(remainder, pad_len);
> +    padded.push_back(buf);
> +
> +    for (unsigned int i =3D k - padded_chunks; i < k; i++) {
> +      int chunk_index =3D chunk_mapping.size() > 0 ? chunk_mapping[i] =
: i;
> +      bufferlist &chunk =3D encoded[chunk_index];
> +      chunk.substr_of(padded, (i - (k - padded_chunks)) * blocksize, b=
locksize);
> +    }
> +  }
> +  for (unsigned int i =3D k; i < k + m; i++) {
> +    int chunk_index =3D chunk_mapping.size() > 0 ? chunk_mapping[i] : =
i;
> +    bufferlist &chunk =3D encoded[chunk_index];
> +    chunk.push_back(buffer::create_aligned(blocksize));
>    }
> -  unsigned coding_length =3D blocksize * m;
> -  bufferptr coding(buffer::create_page_aligned(coding_length));
> -  prepared->push_back(coding);
> -  prepared->rebuild_page_aligned();
> +
>    return 0;
>  }
> =20
> @@ -80,15 +107,9 @@ int ErasureCode::encode(const set<int> &want_to_enc=
ode,
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


--oHtMhaqwHj2JVHA5TnO93tDv2OroPT8Vw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQb+6oACgkQ8dLMyEl6F23r4QCeLXkK2D+i5h8l8qfSvBvVcPKn
SiIAoK4vXXbe3KtA4KgYY/PL9kE5yFp9
=4QR2
-----END PGP SIGNATURE-----

--oHtMhaqwHj2JVHA5TnO93tDv2OroPT8Vw--
