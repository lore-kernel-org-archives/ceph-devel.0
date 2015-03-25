From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology call for help
Date: Wed, 25 Mar 2015 17:32:39 +0100
Message-ID: <5512E327.4030505@dachary.org>
References: <5512CC20.6030202@dachary.org> <558522744.2839705.1427300756297.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="t2usqpUwTpE5hOEAIrB6k1P1x9ixXcR3V"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36523 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752577AbbCYQcm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Mar 2015 12:32:42 -0400
In-Reply-To: <558522744.2839705.1427300756297.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t2usqpUwTpE5hOEAIrB6k1P1x9ixXcR3V
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/03/2015 17:25, Zack Cerza wrote:
> Hey Loic,
>=20
> Your fragment is definitely included. See:
>=20
> http://qa-proxy.ceph.com/teuthology/loic-2015-03-25_12:05:20-upgrade:gi=
ant-x:stress-split-erasure-code-hammer---basic-vps/820668/orig.config.yam=
l

I got confused because I was looking at the 'All details' section of
http://pulpito.ceph.com/loic-2015-03-25_12:05:20-upgrade:giant-x:stress-s=
plit-erasure-code-hammer---basic-vps/820668/
which does not show it.

> description: upgrade:giant-x:stress-split-erasure-code/{0-cluster/start=
=2Eyaml 1-giant-install/giant.yaml
>   2-partial-upgrade/firsthalf.yaml 3-thrash/default.yaml 4-mon/mona.yam=
l 5-workload/ec-rados-default.yaml
>   6-next-mon/monb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3D=
jerasure-k=3D3-m=3D1.yaml
>   distros/ubuntu_14.04.yaml}
> [...]
> task:
> - rados:
>     clients:
>     - client.0
>     ec_pool: true
>     objects: 50
>     op_weights:
>       append: 100
>       copy_from: 50
>       delete: 50
>       read: 100
>       rmattr: 25
>       rollback: 50
>       setattr: 25
>       snap_create: 50
>       snap_remove: 50
>       write: 0
>     ops: 4000
> - print: '**** done rados ec task'
> tasks:
> - chef: null
> - clock.check: null
> - install:
>     branch: giant
> - print: '**** done install giant'
> [...]
>=20
>=20
> The issue is that 5-workload/ec-rados-default.yaml uses the word 'task'=
 instead of 'tasks'.

Indeed... thanks !

>=20
> Zack
>=20
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Zack Cerza" <zcerza@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, March 25, 2015 7:54:24 AM
> Subject: teuthology call for help
>=20
> Hi Zack,
>=20
> I'm blocked with http://pulpito.ceph.com/loic-2015-03-25_12:05:20-upgra=
de:giant-x:stress-split-erasure-code-hammer---basic-vps/820668/ and need =
your help.
>=20
> Do you understand why 5-workload/ec-rados-default.yaml is not included =
? It's like it does not exist. But it does :-)
>=20
> Thanks in advance !
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--t2usqpUwTpE5hOEAIrB6k1P1x9ixXcR3V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUS4ycACgkQ8dLMyEl6F23TFgCfQmY5brOADcVMMXQKjy8FhMBx
Bz8AmwYVj9r3rZQ8H8Cjw/PUxXxxT1Mz
=1puk
-----END PGP SIGNATURE-----

--t2usqpUwTpE5hOEAIrB6k1P1x9ixXcR3V--
