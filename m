From: Loic Dachary <loic@dachary.org>
Subject: Re: OpenStack and ceph integration with puppet
Date: Wed, 09 Oct 2013 22:46:26 +0100
Message-ID: <5255CEB2.8080809@dachary.org>
References: <525413DE.9090405@dachary.org> <57ED724085B72141BB091CF1314E471F01769708@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WPXHtju0ejWJn1Q3oBPJAJlLFdNuvlF1H"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58676 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab3JIVq3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Oct 2013 17:46:29 -0400
In-Reply-To: <57ED724085B72141BB091CF1314E471F01769708@xmb-rcd-x15.cisco.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Don Talton (dotalton)" <dotalton@cisco.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Dan Bode <bodepd@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WPXHtju0ejWJn1Q3oBPJAJlLFdNuvlF1H
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 08/10/2013 16:20, Don Talton (dotalton) wrote:> Hi Loic,=20
>=20

> We utilize stackforge's puppet modules to do our heavy lifting, includi=
ng p-openstack, p-cinder, p-glance. There are dependency chains so that s=
ervices will be restarted after configuration changes are made. Since man=
y of our customers don't allow their baremetal  nodes Internet access, we=
've added the packages to our APT repo to avoid the version issues with u=
sing either stock or public packages.
>=20
> You can probably find some other useful code the https://github.com/Cis=
coSystems/ repo, including what is needed to cohabitate MON/OSD nodes wit=
h OpenStack service nodes (https://github.com/CiscoSystems/puppet-coe/tre=
e/grizzly/manifests/ceph) and more. The primary orchestration is in grizz=
ly-manifests. You can see HOWTOs for different deployment scenarios here:=
 http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installation.=20
>=20
> Hope this helps some!

It does and it's great that all this is documented :-) Although there are=
 a few modules around, re-using ceph-deploy seems to be the preferred met=
hod. I wonder what Alfredo would suggest. From a previous discussion we h=
ad I think he will suggest to use ceph-disk directly + cli / rest call in=
stead. Looking at=20

https://github.com/ceph/ceph-deploy/blob/master/ceph_deploy/new.py
https://github.com/ceph/ceph-deploy/blob/master/ceph_deploy/mon.py
etc.

the layer provided by ceph-deploy is indeed thin. But is it something tha=
t needs to be duplicated in a puppet module ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--WPXHtju0ejWJn1Q3oBPJAJlLFdNuvlF1H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJVzrMACgkQ8dLMyEl6F20AWgCgxTOLPjyJiaALdMOrvRLB0i6M
1+QAn3xg/tNYtTu7QfOCYqO6IGm0s18Y
=+Arh
-----END PGP SIGNATURE-----

--WPXHtju0ejWJn1Q3oBPJAJlLFdNuvlF1H--
