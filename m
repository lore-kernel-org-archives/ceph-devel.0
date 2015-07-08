From: Loic Dachary <loic@dachary.org>
Subject: Re: ansible task progress
Date: Wed, 08 Jul 2015 02:48:47 +0200
Message-ID: <559C736F.1030005@dachary.org>
References: <559C719C.8010707@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OqNdDBJQtNh4fjaHDnxMrORQDA5xQPgOU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46356 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752349AbbGHAsu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jul 2015 20:48:50 -0400
In-Reply-To: <559C719C.8010707@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>, Andrew Schoen <aschoen@redhat.com>
Cc: Dan Mick <dmick@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OqNdDBJQtNh4fjaHDnxMrORQDA5xQPgOU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi again,

The next problem was worked around with

ansible_user: ubuntu

and then I got

http://integration.ceph.dachary.org:8081/ubuntu-2015-07-08_00:36:46-noop-=
master---basic-openstack/4/

2015-07-08 00:41:31,538.538 INFO:teuthology.task.ansible.out:failed: [ovh=
226240.teuthology] =3D> (item=3Dansible_user_ssh_keys) =3D> {"fa\
iled": true, "item": "ansible_user_ssh_keys"}
2015-07-08 00:41:31,539.539 INFO:teuthology.task.ansible.out:
msg: invalid key specified: ansible_user_ssh_keys

hopefully that's enough clues for you to figure out a real fix. Sorry I d=
on't know enough to propose a proper patch.

Cheers

On 08/07/2015 02:41, Loic Dachary wrote:
> Hi Zack & Andrew,
>=20
> With Dan's help we hacked passed the sudo problem with:
>=20
> cat > /tmp/ansible.yaml <<EOF
> overrides:
>   ansible.cephlab:
>     branch: wip-fix-defaults
>     vars:
>       ansible_sudo: true
> interactive-on-error: true
> EOF
>=20
> teuthology-suite --machine-type openstack  --suite-dir $(pwd)/teutholog=
y/test/integration --suite noop /tmp/ansible.yaml
>=20
> with full logs at
>=20
> http://integration.ceph.dachary.org:8081/ubuntu-2015-07-08_00:31:07-noo=
p-master---basic-openstack/3/
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--OqNdDBJQtNh4fjaHDnxMrORQDA5xQPgOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWcc28ACgkQ8dLMyEl6F22NIQCffUZJsJySRYfEi7TzoqrKW01u
OcgAnR7GQMJrQpoFgZqdXTtxwdg9Jrwu
=kxV9
-----END PGP SIGNATURE-----

--OqNdDBJQtNh4fjaHDnxMrORQDA5xQPgOU--
