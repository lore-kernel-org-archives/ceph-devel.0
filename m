From: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: v12.2.12 Luminous released
Date: Fri, 12 Apr 2019 18:48:51 +0200
Message-ID: <87tvf3tbik.fsf@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6536743736658192627=="
Return-path: <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-announce-ceph.com>,
 <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-announce-ceph.com/>
List-Post: <mailto:ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com>,
 <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "Ceph-announce" <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-a8pt6IJUokc@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============6536743736658192627==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


We are happy to announce the next bugfix release for v12.2.x Luminous
stable release series. We recommend all luminous users to upgrade to
this release. Many thanks to everyone who contributed backports and a
special mention to Yuri for the QE efforts put in to this release.

Notable Changes
=2D--------------
* In 12.2.11 and earlier releases, keyring caps were not checked for validi=
ty,
  so the caps string could be anything. As of 12.2.12, caps strings are
  validated and providing a keyring with an invalid caps string to, e.g.,
  `ceph auth add` will result in an error.

For the complete changelog, please refer to the release blog entry at=20
https://ceph.com/releases/v12-2-12-luminous-released/

Getting ceph:
=2D-----------
* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-12.2.12.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: 1436006594665279fe734b4c15d7e08c13ebd777

=2D-=20
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton,
HRB 21284 (AG N=C3=BCrnberg)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEac9IOI7jdGxe1B8W+fBkHxtl7V8FAlywwXUACgkQ+fBkHxtl
7V/1Iwf/dYe494qzIv5RlxlIKk8T9jfj2mPaFMoiHIRR+YpRR5PypxBltDU5vv/x
ZH0b2usEabgGObR0ArHlyPZYKuOV0R8C1Q4iFd70ZZlqMGo+6ibqzEWfvwE0GpSH
hr1kPL5UKMp5SQSIni7/c/OF7ln0UyshSZ8KX4YNw+5J+AMQfFH59ODhqhYyRL7C
WXa5jEEKZEx/HmVmtqSzWclGtpllG06rntB3CV+05xX0+CQRqYfSQMSixo5qhAbW
fbAnLE3NYggInVYJXuL7dY4+KMs9zkA+MUfEt4GL5eVunVirpOYxSnsAuLmI9ED+
Z3O5oKyxEA/ZeCs/Ngi55xMUCcR4ug==
=ImZ9
-----END PGP SIGNATURE-----
--=-=-=--

--===============6536743736658192627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-announce mailing list
Ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com

--===============6536743736658192627==--
