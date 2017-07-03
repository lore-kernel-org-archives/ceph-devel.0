From: Lenz Grimmer <lenz-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: dropping filestore+btrfs testing for luminous
Date: Mon, 3 Jul 2017 09:19:12 +0200
Message-ID: <1ff4c0e4-5107-e829-626e-353e24708ba9@grimmer.com>
References: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
	<c4cf8858-6c29-4ec7-7ffa-479781258569@grimmer.com>
	<alpine.DEB.2.11.1706301642570.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0169632545=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1706301642570.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0169632545==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xOQD97ccFM0TKmkMptJEQakaPHbIF9MlF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xOQD97ccFM0TKmkMptJEQakaPHbIF9MlF
Content-Type: multipart/mixed; boundary="fLVndJ5S3alltilhrL1qRbx5BKbOXO0rI";
 protected-headers="v1"
From: Lenz Grimmer <lenz-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
Message-ID: <1ff4c0e4-5107-e829-626e-353e24708ba9-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [ceph-users] dropping filestore+btrfs testing for luminous
References: <alpine.DEB.2.11.1706300314120.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
 <c4cf8858-6c29-4ec7-7ffa-479781258569-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>
 <alpine.DEB.2.11.1706301642570.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1706301642570.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>

--fLVndJ5S3alltilhrL1qRbx5BKbOXO0rI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On 06/30/2017 06:48 PM, Sage Weil wrote:

> Ah, crap.  This is what happens when devs don't read their own=20
> documetnation.  I recommend against btrfs every time it ever comes
> up, the downstream distributions all support only xfs, but yes, it
> looks like the docs never got updated... despite the xfs focus being
> 5ish years old now.
>> I'll submit a PR to clean this up, but

Thanks!

>> Simply disabling the tests while keeping the code in the
>> distribution is setting up users who happen to be using Btrfs for
>> failure.
>=20
> I don't think we can wait *another* cycle (year) to stop testing
> this.
>=20
> We can, however,
>=20
> - prominently feature this in the luminous release notes, and
>=20
> - require the 'enable experimental unrecoverable data corrupting
> features =3D btrfs' in order to use it, so that users are explicitly
> opting in to luminous+btrfs territory.
>=20
> The only good(ish) news is that we aren't touching FileStore if we
> can help it, so it less likely to regress than other things.  And
> we'll continue testing filestore+btrfs on jewel for some time.
>=20
> Is that good enough?
Sounds good to me. Along with updating the wording in the documentation
this helps to set clear expectations.

Thanks!

Lenz


--fLVndJ5S3alltilhrL1qRbx5BKbOXO0rI--

--xOQD97ccFM0TKmkMptJEQakaPHbIF9MlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iFgEARECABgFAllZ7/ARHGxlbnpAZ3JpbW1lci5jb20ACgkQSVDhKrJykfKjzACe
Ll3m3xuIWXTvNlYajW8MSTfjGPwAniD5WHrrPwJlK9Tgdafsbw8Yh1EA
=lR92
-----END PGP SIGNATURE-----

--xOQD97ccFM0TKmkMptJEQakaPHbIF9MlF--

--===============0169632545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0169632545==--
