From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 4/4] qemu/rbd: improve rbd device specification
Date: Tue, 15 Nov 2011 17:05:27 -0700
Message-ID: <4EC2FE47.60501@redhat.com>
References: <4EAEFED2.70808@redhat.com> <3bd8191e8040b4ebe95d31200373539be7ba6e95.1320110364.git.josh.durgin@dreamhost.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig75749FA7FB0D5569EDF3912D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30439 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757659Ab1KPAFf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Nov 2011 19:05:35 -0500
In-Reply-To: <3bd8191e8040b4ebe95d31200373539be7ba6e95.1320110364.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75749FA7FB0D5569EDF3912D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/31/2011 07:29 PM, Josh Durgin wrote:
> From: Sage Weil <sage@newdream.net>

Sorry for letting my review of this slip 2 weeks.

>=20
> This improves the support for qemu rbd devices by adding support for a =
few
> key features (e.g., authentication) and cleaning up the way in which
> rbd configuration options are passed to qemu.
>=20
> An <auth> member of the disk source xml specifies how librbd should
> authenticate. The username attribute is the Ceph/RBD user to authentica=
te as.
> The usage or uuid attributes specify which secret to use. Usage is an
> arbitrary identifier local to libvirt.
>=20
> The old RBD support relied on setting an environment variable to
> communicate information to qemu/librbd.  Instead, pass those options
> explicitly to qemu.  Update the qemu argument parsing and tests
> accordingly.
>=20
> Signed-off-by: Sage Weil <sage@newdream.net>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> ---
>=20
> Changes since v4:
> * fixes memory management issues
> * keep older rbd command line parsing and test case
> * check qemuAddRBDHost return values
> * use more efficient virBuffer functions

Looks like you got all my review points.

ACK and pushed, although I do have some questions that may deserve
followup patches:

> +static int
> +qemuBuildRBDString(virConnectPtr conn,
> +                   virDomainDiskDefPtr disk,
> +                   virBufferPtr opt)
> +{
> +    int i, ret =3D 0;
> +    virSecretPtr sec =3D NULL;
> +    char *secret =3D NULL;
> +    size_t secret_size;
> +
> +    virBufferAsprintf(opt, "rbd:%s", disk->src);
> +    if (disk->auth.username) {
> +        virBufferEscape(opt, ":", ":id=3D%s", disk->auth.username);

This results in ambiguous output if disk->auth.username can end in a
single backslash (since then, you would have \: when combined with the
next part of the option, making it look like the next ":mon_host=3D"
option is instead a continuation of the ":id=3D" username).  Should we be=

escaping backslash as well as colon?  Or should virBufferEscape be
taught to always escape backslash in addition to whatever characters
were passed in to its 'toescape' argument?

> +        if (sec) {
> +            char *base64 =3D NULL;
> +
> +            secret =3D (char *)conn->secretDriver->getValue(sec, &secr=
et_size, 0,
> +                                                          VIR_SECRET_G=
ET_VALUE_INTERNAL_CALL);
> +            if (secret =3D=3D NULL) {
> +                qemuReportError(VIR_ERR_INTERNAL_ERROR,
> +                                _("could not get the value of the secr=
et for username %s"),
> +                                disk->auth.username);
> +                goto error;
> +            }
> +            /* qemu/librbd wants it base64 encoded */
> +            base64_encode_alloc(secret, secret_size, &base64);
> +            if (!base64) {
> +                virReportOOMError();
> +                goto error;
> +            }
> +            virBufferEscape(opt, ":", ":key=3D%s:auth_supported=3Dceph=
x none",
> +                            base64);
> +            VIR_FREE(base64);

The command line that we pass to qemu gets logged.  But what happens if
the secret was marked as ephemeral - could we be violating the premise
of not exposing passwords to too broad an audience?  Or are we already
safe in that the log entries created by virCommand can only be exposed
to users that already can get at the secret information by other means?

Maybe this means we should we be adding capabilities into virCommand to
prevent the logging of the actual secret (whether base64-encoded or
otherwise), and instead log an alternate string?  That is, should
virCommand be tracking parallel argv arrays; the real array passed to
exec() but never logged, and the alternate array (normally matching the
real one, but which can differ in this particular case of passing an
argument that contains a password)?

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig75749FA7FB0D5569EDF3912D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJOwv5IAAoJEKeha0olJ0NqabYH/j24tIGaGKcjeerDaat15yxv
ihMXamU8lcnWmrAoLZpLptjeDP4clAS2L5psHGgubOLfM3AvQfpb7f7E2M3P8dwL
iKZlGjw/K5qAzHLn5cZ8tsPgbSJ29U7K4fUWqvOUcZPLRaCPJ5ZHP63WPz7H5ijV
Pks/1lFzIiI5Xo+zm203lHzxSNaFhW/GFgbLUhk+1r66CeXZ8L2twyN1C9kVXZ7V
9q2rcyJHVSp1250wk8nU7jSWCKaHy5bTIzPFY0f874J5Ap93lgMIkp43LXLnCt8R
rnzvFlqSB4DQiHWkpigIou2vesTY04i2yVHGWOXv13Ly4Mlh+Q2+wwJ6GhKGs44=
=SuPv
-----END PGP SIGNATURE-----

--------------enig75749FA7FB0D5569EDF3912D--
