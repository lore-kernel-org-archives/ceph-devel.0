From: Matthew Thode <prometheanfire-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [swift][ironic][ceph][radosgw] radosgw "support" in
 python-swiftclient droped for ocata and above
Date: Wed, 9 May 2018 10:22:44 -0500
Message-ID: <20180509152244.75ihypuvaxqv7cw6@gentoo.org>
Reply-To: "OpenStack Development Mailing List \(not for usage questions\)"
 <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7125860115322700976=="
Return-path: <openstack-dev-bounces-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.openstack.org/cgi-bin/mailman/options/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openstack.org/pipermail/openstack-dev/>
List-Post: <mailto:openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Errors-To: openstack-dev-bounces-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
To: openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============7125860115322700976==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mnd6rvx5aqpam7jn"
Content-Disposition: inline


--mnd6rvx5aqpam7jn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

python-swiftclient prior to 3.2.0 seemed to incidentally support radosgw
tempurls.  That is, there was no official support, but it still worked.

In 3.2.0 (specifically the linked commit(s)) tempurls were validated to
require /v1/account/container/object, which does not work with radosgw
as it expects /v1/container/object.  This means that radosgw tempurls
fail to work, which further means that radosgw will stop working for
things like ironic.

I can see the point that swiftclient should not care about ceph not
fully implementing the swift spec and not supporting the radosgw url
syntax, but it seems like a step back.  If this is not fixed then things
like ironic will not work with radosgw for Ocata and above (as that's
when this change was made).  We'd need to wait for either ceph to fix
this and support the account part of the url (probably just dropping it)
or have people fork python-swiftclient to 'fix' it.

I'm not sure what the right answer is...

https://github.com/openstack/python-swiftclient/commit/4c955751d340a8f71a2e=
ebdb3c58d90b36874a66
https://github.com/openstack/ironic/blob/214b694f05d200ac1e2ce6db631546f283=
1c01f7/ironic/common/glance_service/v2/image_service.py#L152-L185

https://bugs.launchpad.net/ironic/+bug/1747384

--=20
Matthew Thode (prometheanfire)

--mnd6rvx5aqpam7jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEExFR3cOKGRpGbcMHPZKN76q4ZpOgFAlrzEkMACgkQZKN76q4Z
pOju0g/9FBoQ5d+9fpr9NSkXIGSGz8MqHf1A58zcJO152cCzRuSf/mzwcdE2r5a+
I/SA6FzQw53ic39oaBn6JCGcvRQitd/OTvezLBbHjuWlWBslg8/XC0p/TuwwwKUh
rXJ5eF0+ltx6ikrwGoi26C6T6gQtM/GRet9R/oDWjvktMqU08eix9mp3MG3OjtRg
rxf198nsiKswmPDDxkEpFFwJOwpjRrH2/g7L8M6HuvlVd1KocaGON7gxx/3LeKqW
x3AeXJend5LCmR41WiuR+JoGsV3hCFqacbdh0uyMHb6eFVVQFZCmJmJaGDCKV0RO
9BfYFIUUwqfVYZIkeiFSCzDtp3GbTluj6yoT00eQnl4pEUNfe+PxtsoBIQg2/P86
WWrghvSAmKjgt3XJ/SWaBNKFj0ofP69159SzI/rN0oBWuHhwPV8mfkEiA5rp9BQb
cA2UAQALtyiwIQujCj7eD02HvrutONxIWk4rmvSpUH+sgxVA7maJuTKqYiH6s7YB
ChApU7u3NruC89XNx/hlHlPAeyex+eMh3qb4nCSGLbx3ECAy+yvlaBNTdOuv/TyT
2NVDVcYHXWgs2ARuyU2lqDPIB3Dme9dnSxoxQg9plypE+cIeTvapdalJOFVcR+KZ
vqOiUKesatiQRbH1emF7GSK1fcDglM3kTgB8A6CVnyUgyW9NgvM=
=opqD
-----END PGP SIGNATURE-----

--mnd6rvx5aqpam7jn--


--===============7125860115322700976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KT3BlblN0YWNrIERldmVsb3BtZW50IE1haWxpbmcgTGlzdCAobm90
IGZvciB1c2FnZSBxdWVzdGlvbnMpClVuc3Vic2NyaWJlOiBPcGVuU3RhY2stZGV2LXJlcXVlc3RA
bGlzdHMub3BlbnN0YWNrLm9yZz9zdWJqZWN0OnVuc3Vic2NyaWJlCmh0dHA6Ly9saXN0cy5vcGVu
c3RhY2sub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9vcGVuc3RhY2stZGV2Cg==

--===============7125860115322700976==--
