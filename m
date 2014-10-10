From: Loic Dachary <loic@dachary.org>
Subject: Re: rados.py: add tmap_to_omap method
Date: Fri, 10 Oct 2014 08:51:34 +0200
Message-ID: <543781F6.2020702@dachary.org>
References: <ork348a2mc.fsf@free.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3dTTSQqmMrtSLXFJsxlTFuFqbDdsTegvp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41658 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751254AbaJJGvm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 02:51:42 -0400
In-Reply-To: <ork348a2mc.fsf@free.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3dTTSQqmMrtSLXFJsxlTFuFqbDdsTegvp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

This patch is improving

http://tracker.ceph.com/issues/9532

which is part of

http://tracker.ceph.com/issues/6114

But I do not know the answer to the bool question ;-)

Cheers

On 10/10/2014 07:57, Alexandre Oliva wrote:
> I wanted to script a tmap_to_omap conversion of a few million dirs, but=

> running the rados program for each inode would have made it take too
> long, so I wrote the attached python script, that I'm now running in
> multiple copies in parallel with GNU parallel.
>=20
> Before it would run, however, I found out python bindings of rados's
> tmap_to_omap hadn't been implemented.  It might have been because it
> takes a bool argument, and I couldn't find out how to pass it as such.
>=20
> I ended up forcing the bool argument to False and passing it as an int
> 0.  This could fail on machines whose ABIs pass bools differently from
> ints, but IIRC bools are just aliases to char in C, at least within GCC=
,
> and since char is promoted to int for argument passing, passing an int
> should work, especially if it's zero.  For nonzero values, endianness
> could matter if the argument is passed on the stack, so I settled for
> forcing it to zero.
>=20
> If anyone knows better, please let me know.
>=20
>=20
>=20
>=20
> ---
>=20
> Add tmap_to_omap method to rados python bindings, without the bool
> argument: it is forced to false.
>=20
> Signed-off-by: Alexandre Oliva <oliva@gnu.org>
> ---
>  src/pybind/rados.py |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/src/pybind/rados.py b/src/pybind/rados.py
> index 93e5040..a2394aa 100644
> --- a/src/pybind/rados.py
> +++ b/src/pybind/rados.py
> @@ -1438,6 +1438,24 @@ returned %d, but should return zero on success."=
 % (self.name, ret))
>              raise make_ex(ret, "Failed to stat %r" % key)
>          return psize.value, time.localtime(pmtime.value)
> =20
> +    def tmap_to_omap(self, key):
> +        """
> +        Convert a dir from tmap to omap.
> +
> +        :param key: the name of the object to convert
> +        :type key: str
> +
> +        :raises: :class:`TypeError`
> +        :raises: :class:`Error`
> +        :returns: int - 0 on success, otherwise raises an error
> +        """
> +        self.require_ioctx_open()
> +        ret =3D run_in_thread(self.librados.rados_tmap_to_omap,
> +                            (self.io, c_char_p(key), c_int(0)))
> +        if ret < 0:
> +            raise make_ex(ret, "Failed to convert %s from tmap to omap=
" % key)
> +        return 0
> +
>      def get_xattr(self, key, xattr_name):
>          """
>          Get the value of an extended attribute on an object.
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--3dTTSQqmMrtSLXFJsxlTFuFqbDdsTegvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ3gfYACgkQ8dLMyEl6F22FmwCaAufH33rldJUax59uwdE+NSTN
WfsAoJSOkehXQ0AAZvH0ji4faZ1Q+V8L
=AH+0
-----END PGP SIGNATURE-----

--3dTTSQqmMrtSLXFJsxlTFuFqbDdsTegvp--
