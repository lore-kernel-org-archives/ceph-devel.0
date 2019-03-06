From: Jeff Layton <jlayton-vpEMnDpepFuMZCB2o+C8xQ@public.gmane.org>
Subject: Deploying a Ceph+NFS Server Cluster with Rook
Date: Wed, 06 Mar 2019 14:46:45 -0500
Message-ID: <04463ae0a2005fee74867fd5c90745b980b43b01.camel@poochiereds.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3653910599392374111=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devel-E4mK9TgJ1uitWBMMcue2L4aCUm+kVXi4@public.gmane.org" <devel-E4mK9TgJ1uitWBMMcue2L4aCUm+kVXi4@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============3653910599392374111==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-wf3twI7kA5nG6+svlJHR"


--=-wf3twI7kA5nG6+svlJHR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had several people ask me to put together some instructions on how to
deploy a Ceph+NFS cluster from scratch, and the new functionality in
Ceph and rook.io make this quite easy.

I wrote a Ceph community blog post that walks the reader through the
process:

    https://ceph.com/community/deploying-a-cephnfs-server-cluster-with-rook=
/

I don't think that site has a way to post comments, but I'm happy to
answer questions about it via email.
--=20
Jeff Layton <jlayton-vpEMnDpepFuMZCB2o+C8xQ@public.gmane.org>

--=-wf3twI7kA5nG6+svlJHR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAlyAI6UACgkQAA5oQRlW
ghXpEBAAqbtEURfdDvdRiYT9tx4GhQ8vZ3n/9copksl3E+BRozjstzCgllnVwD32
KXW0TDM22XsrOE36A8V8WHUz25qjpnSi9c+y22zoJjfufY2/lO3tJ9L54th+YGZ6
wKiOwe3ieuAiCWPzfRLchsduLuSB+8sl+JBAtzk5tNLlujjk9LSyCdMVB2Qrn2dZ
h+LtKu5FrRU13HJHB3U17I2l3yEDjU8lQ0DdwxPVaXQDsZEnrwZf+i9k35wNRFWV
SSl/s+PRh8ZhBPu2xQWG/wRo+UH9to8q386TCdmOaWXxUZqVlUBdj0h+ciI4lhFw
KDQyDZecDFvoowMkBO3bb8u4PbsxkCo6H8ORZ4N4dOC4k9T4QlI5AW0o8PA+/s5a
g6/cTWKQmrD9oC54jO+/NDTZLRELb4ApBCX+UwNNi78ePNNksu8RZOfN6XAu9DaS
31U8nSjQXhSCJ8g9QR5K5fPyY2wvfKxMJ9QMz0inb9XyqCgbQiX4QoZjyvrJKLne
ez3HrTFuwTZtSz2GZE4uehNs46tAvFKSLJMU6lcPrdDlcTHK9V/qoQN0k6P7uk5o
XzLc+2RpFxSuIdG1XMgixR3v93nlGPziE1+JiyOAJd2kVAK80anqBkC7dz0YcdLR
O9KDeJVTmsKJvZGr1/s5/SbggBwqFDgpPjJY4dWQGr2TFy+eIYE=
=Mrtu
-----END PGP SIGNATURE-----

--=-wf3twI7kA5nG6+svlJHR--


--===============3653910599392374111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3653910599392374111==--
