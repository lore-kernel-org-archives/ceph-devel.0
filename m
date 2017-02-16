From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5] RBD: Add support readv,writev for rbd
Date: Thu, 16 Feb 2017 09:45:16 -0600
Message-ID: <93735d39-fc9d-dc1e-b374-24627ab91e62@redhat.com>
References: <20170216084318.11122-1-jazeltq@gmail.com>
 <20170216090002.12511-1-jazeltq@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iFLioXxR9JVvgjBIxPCrdARqU0wF6H8ov"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932276AbdBPPpT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Feb 2017 10:45:19 -0500
In-Reply-To: <20170216090002.12511-1-jazeltq@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jazeltq@gmail.com, jdurgin@redhat.com, jcody@redhat.com, dillaman@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org
Cc: tianqing <tianqing@unitedstack.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iFLioXxR9JVvgjBIxPCrdARqU0wF6H8ov
Content-Type: multipart/mixed; boundary="6VVKEw8ccidfmTalB97LDLFLXSeqmRS2C";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: jazeltq@gmail.com, jdurgin@redhat.com, jcody@redhat.com,
 dillaman@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org
Cc: tianqing <tianqing@unitedstack.com>, ceph-devel@vger.kernel.org,
 qemu-devel@nongnu.org
Message-ID: <93735d39-fc9d-dc1e-b374-24627ab91e62@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5] RBD: Add support readv,writev for rbd
References: <20170216084318.11122-1-jazeltq@gmail.com>
 <20170216090002.12511-1-jazeltq@gmail.com>
In-Reply-To: <20170216090002.12511-1-jazeltq@gmail.com>

--6VVKEw8ccidfmTalB97LDLFLXSeqmRS2C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/16/2017 03:00 AM, jazeltq@gmail.com wrote:
> From: tianqing <tianqing@unitedstack.com>
>=20
> Rbd can do readv and writev directly, so wo do not need to transform
> iov to buf or vice versa any more.

In general, we prefer new revisions of a patch series to be sent as a
new top-level thread, rather than buried in-reply-to the earlier
revision, as nesting can mess up some of the automated tooling that
tests whether a patch will introduce problems.

>=20
> Signed-off-by: tianqing <tianqing@unitedstack.com>
> ---
>  block/rbd.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index a57b3e3..75ae1d6 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -47,7 +47,7 @@
>   */
> =20
>  /* rbd_aio_discard added in 0.1.2 */
> -#if LIBRBD_VERSION_CODE >=3D LIBRBD_VERSION(0, 1, 2)
> +#if LIBRBD_VERSION_CODE >=3D LIBRBD_VERSION(12, 0, 0)

Does the comment need updating, too?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6VVKEw8ccidfmTalB97LDLFLXSeqmRS2C--

--iFLioXxR9JVvgjBIxPCrdARqU0wF6H8ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpckMAAoJEKeha0olJ0Nq+dIH/07V/6SENl0JGS+lIauXrLI6
EpZbDbRYstY57RYBkVWvNVe6ifvn59GOxTJ3IRC6SAeIN3i9woQoJq24D7g/cbgo
eiHW/IhFRFDfrQjkQnst6169DTHr9IqMZrEeXXxJ5V1J92cPMAXFoB9xjyCmsqix
B5GQCylOVid+ujk1IFgt97OeW5ojAvJwNKYV3hcUoqGSRmy/351X9TUg7JKXdRO0
Lphvilv0u3ukILi04g5ThaUuCo0wlgjqfgC2twtTO2PmELRfveliN4656ryRXcks
3HNV1zTTGN0NyeelXxfjlDug7QqKQbVg/aUFn6/COSSz3GBNDR5IxZWFVRpd6IE=
=i1gc
-----END PGP SIGNATURE-----

--iFLioXxR9JVvgjBIxPCrdARqU0wF6H8ov--
