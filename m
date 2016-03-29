From: Loic Dachary <loic@dachary.org>
Subject: Re: Virtualenv tests still nort running...
Date: Tue, 29 Mar 2016 14:28:36 +0200
Message-ID: <56FA74F4.5040905@dachary.org>
References: <56FA67A8.6050809@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48785 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbcC2M3Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2016 08:29:24 -0400
In-Reply-To: <56FA67A8.6050809@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Willem,

This has undergone various fixes all of them wrong in a context or anot=
her. The last of them is (hopefully ;-) https://github.com/ceph/ceph/pu=
ll/8320

Cheers

On 29/03/2016 13:31, Willem Jan Withagen wrote:
>=20
> Hi,
>=20
> I have rebased to the most recent HEAD before building verything agai=
n.
> But the testrun still is unable to get the virtualenv correct.
>=20
> Suggestions on how to diagnose this?
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> cp -f ./fetch_config ./sample.fetch_config
> cd ./ceph-detect-init ; ../tools/setup-virtualenv.sh ; test -d wheelh=
ouse && export NO_INDEX=3D--no-index ; virtualenv/bin/pip install $NO_I=
NDEX --use-wheel --find-links=3Dfile://$(pwd)/wheelhouse -e .
> /bin/sh: ../tools/setup-virtualenv.sh: not found
> /bin/sh: virtualenv/bin/pip: not found
> Makefile:32259: recipe for target 'ceph-detect-init/virtualenv' faile=
d
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> path for setup-virtual
> ./src/tools/setup-virtualenv.sh
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> cat ./src/tools/setup-virtualenv.sh
> rm -fr virtualenv
> virtualenv virtualenv
> . virtualenv/bin/activate
> # older versions of pip will not install wrap_console scripts
> # when using wheel packages
> pip --log virtualenv/log.txt install --upgrade 'pip >=3D 6.1'
> if test -d wheelhouse ; then
>     export NO_INDEX=3D--no-index
> fi
> pip --log virtualenv/log.txt install $NO_INDEX --use-wheel --find-lin=
ks=3Dfile://$(pwd)/wheelhouse --upgrade di
> stribute
> pip --log virtualenv/log.txt install $NO_INDEX --use-wheel --find-lin=
ks=3Dfile://$(pwd)/wheelhouse 'tox >=3D1.9'
> if test -f requirements.txt ; then
>     pip --log virtualenv/log.txt install $NO_INDEX --use-wheel --find=
-links=3Dfile://$(pwd)/wheelhouse -r requi
> rements.txt
> fi
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Perhaps here the virtualenv paths need to be converted into SHELLVARs=
 as well?
>=20
> --WjW
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
