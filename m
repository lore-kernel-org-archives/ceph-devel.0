From: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Subject: Running on disks that lose their head
Date: Wed, 06 Nov 2013 08:32:29 +0800
Message-ID: <52798E1D.9090807@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0276280618=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0276280618==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lmcAITC30F70flkIOG12wmQfi922jCbOg"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lmcAITC30F70flkIOG12wmQfi922jCbOg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

People from Western Digital suggested ways to better take advantage of th=
e disk error reporting. They gave two examples that struck my imagination=
=2E First there are errors that look like the disk is dying ( read / writ=
e failures ) but it's only a transient problem and the driver should be a=
ble to make the difference by properly interpreting the available informa=
tion. They said that the prolonged life you get if you don't decommission=
 a disk that only has a transient error is significant. The second exampl=
e is when one head out of ten fails : disks can keep working with the nin=
e remaining heads. Losing 1/10 of the disk is likely to result in a full =
re-install of the Ceph osd. But, again, the disk could keep going after t=
hat, with 9/10 of its original capacity. And Ceph is good at handling osd=
 failures.

All this is news to me and sounds really cool. But I'm sure there are peo=
ple who already know about it and I'm eager to hear their opinion :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--lmcAITC30F70flkIOG12wmQfi922jCbOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlJ5jh0ACgkQ8dLMyEl6F210bQCY0jmiTY0sTWIOG6ZsYirT8YA6
zACeLSGVU8/pMS+qvYucCygY9UrEYyI=
=RFWX
-----END PGP SIGNATURE-----

--lmcAITC30F70flkIOG12wmQfi922jCbOg--

--===============0276280618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0276280618==--
