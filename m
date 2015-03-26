From: Loic Dachary <loic@dachary.org>
Subject: Re: Interpreting rados / print order in teuthology output
Date: Fri, 27 Mar 2015 00:11:32 +0100
Message-ID: <55149224.7050505@dachary.org>
References: <55148BD1.2090800@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Sb7fE6uo7ClWuAe3GAttkqJ0C6TpQVCnx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37445 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753355AbbCZXLe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Mar 2015 19:11:34 -0400
In-Reply-To: <55148BD1.2090800@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zcerza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sb7fE6uo7ClWuAe3GAttkqJ0C6TpQVCnx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks Andrew, Sage & Dmick for the help! The answer is that the rados ta=
sks runs in parallel by default. It is enough to nest it in a sequential =
task to make it sequential. A contrario you can use the parallel task aro=
und a sequential task to run it in the background. The trick is to figure=
 out what tasks are running the background by default and which one do no=
t.

Cheers

On 26/03/2015 23:44, Loic Dachary wrote:
> Hi Zack,
>=20
> I'm trying to figure out why
>=20
>   http://pulpito.ceph.com/loic-2015-03-26_21:18:14-upgrade:firefly-x:st=
ress-split-erasure-code-hammer---basic-multi/822784/
>=20
> failed when the same run succeeded at
>=20
>   http://pulpito.ceph.com/loic-2015-03-26_15:22:43-upgrade:firefly-x:st=
ress-split-erasure-code-hammer---basic-multi/822782/
>=20
> I'm kind of blocked trying to figure out why the print statement is run=
 before the first rados run completes at:
>=20
> 2015-03-26T13:33:38.178 INFO:teuthology.orchestra.run.burnupi31.stderr:=
osds 0,1,2,3,4,5,6,7,8,9,10,11,12,13 instructed to deep-scrub
> 2015-03-26T13:33:38.189 INFO:teuthology.run_tasks:Running task rados...=

> 2015-03-26T13:33:38.209 INFO:tasks.rados:Beginning rados...
> 2015-03-26T13:33:38.210 INFO:teuthology.run_tasks:Running task print...=

> 2015-03-26T13:33:38.210 INFO:teuthology.task.print:**** done rados ec-c=
ache-agent (part 1)
> 2015-03-26T13:33:38.210 INFO:teuthology.run_tasks:Running task install.=
upgrade...
> 2015-03-26T13:33:38.211 INFO:teuthology.task.install:project ceph confi=
g {'osd.0': None} overrides {'sha1': '6994648bc443429dc2edfbb38fbaaa9a19e=
2bdd1'}
> 2015-03-26T13:33:38.211 INFO:teuthology.task.install:extra packages: []=

> 2015-03-26T13:33:38.211 INFO:teuthology.task.install:remote ubuntu@mira=
119.front.sepia.ceph.com config {'sha1': '6994648bc443429dc2edfbb38fbaaa9=
a19e2bdd1'}
> 2015-03-26T13:33:38.212 INFO:teuthology.orchestra.run.mira119:Running: =
'sudo lsb_release -is'
> 2015-03-26T13:33:38.213 INFO:tasks.rados:clients are ['client.0']
> 2015-03-26T13:33:38.213 INFO:tasks.rados:starting run 0 out of 1
> 2015-03-26T13:33:38.214 INFO:teuthology.orchestra.run.burnupi31:Running=
: 'CEPH_CLIENT_ID=3D0 adjust-ulimits ceph-coverage /home/ubuntu/cephtest/=
archive/coverage ceph_test_rados --op read 100 --op write 100 --op delete=
 50 --max-ops 4000 --objects 500 --max-in-flight 16 --size 4000000 --min-=
stride-size 400000 --max-stride-size 800000 --max-seconds 0 --op copy_fro=
m 50 --pool ecbase'
> 2015-03-26T13:33:38.229 INFO:tasks.rados.rados.0.burnupi31.stdout:addin=
g op weight read -> 100
> 2015-03-26T13:33:38.230 INFO:tasks.rados.rados.0.burnupi31.stdout:addin=
g op weight write -> 100
> 2015-03-26T13:33:38.230 INFO:tasks.rados.rados.0.burnupi31.stdout:addin=
g op weight delete -> 50
>=20
> although the config reads:
>=20
> ...
>     - ceph osd pool set eccache target_max_objects 250
> - exec:
>     client.0:
>     - ceph osd deep-scrub '*'
> - rados:
>     clients:
>     - client.0
>     objects: 500
>     op_weights:
>       copy_from: 50
>       delete: 50
>       read: 100
>       write: 100
>     ops: 4000
>     pools:
>     - ecbase
> - print: '**** done rados ec-cache-agent (part 1)'
> - install.upgrade:
>     osd.0: null
> - ceph.restart:
>=20
> ...
>=20
> I'm kind of worried I'll make a fool of myself once more. This time it =
spells "task" and not "tasks" ;-)
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Sb7fE6uo7ClWuAe3GAttkqJ0C6TpQVCnx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUUkiQACgkQ8dLMyEl6F204CQCfd2pfiNo6U2ADuZROmcoipxLK
HBQAoJxEdraAqKlTUgoEpjav86lj5uN7
=wKvm
-----END PGP SIGNATURE-----

--Sb7fE6uo7ClWuAe3GAttkqJ0C6TpQVCnx--
