From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-mds jewel backports leak
Date: Wed, 6 Jul 2016 13:53:01 +0200
Message-ID: <577CF11D.8010600@dachary.org>
References: <577CE2B4.6010505@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58297 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbcGFLxM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jul 2016 07:53:12 -0400
In-Reply-To: <577CE2B4.6010505@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

To be precise, the backports that are related to CephFS and in the jewe=
l-backports branch are:

https://github.com/ceph/ceph/pull/9405/files
https://github.com/ceph/ceph/pull/9547/files
https://github.com/ceph/ceph/pull/9558/files
https://github.com/ceph/ceph/pull/9559/files
https://github.com/ceph/ceph/pull/9560/files
https://github.com/ceph/ceph/pull/9562/files

On 06/07/2016 12:51, Loic Dachary wrote:
> Hi John,
>=20
> While testing the CephFS jewel backports found in the jewel-backports=
 branch, we ran into a memory leak that consistently happen:
>=20
> http://pulpito.ceph.com/loic-2016-06-16_02:28:14-fs-jewel-backports--=
-basic-smithi/263842
>=20
> and that is not present in the jewel branch
>=20
> http://pulpito.ceph.com/loic-2016-06-28_23:43:39-fs-jewel---basic-smi=
thi/282493/
>=20
> Meaning one of the backports is doing something wrong. Or there is a =
backport fixing the leak that is missing.
>=20
> This one looks interesting to me
>=20
> https://github.com/ceph/ceph/commit/37b7b09ee19ad64362c2faf63461353c0=
3a36ada
>=20
> There also are related to leaks but I'm not so sure.
>=20
> https://github.com/ceph/ceph/commit/89f74c98ea43df46291c8bec890b3a75c=
7ce38b4
> https://github.com/ceph/ceph/commit/4c52bf9ed47d52510536ebc34bd6c56ad=
ba1df53
>=20
> If you have ideas on how to approach this and save random exploration=
 time, it would be most welcome. If not, I'll get it eventually, no wor=
ries :-)
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
