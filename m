From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: Running the rbd suite on OpenStack
Date: Wed, 30 Sep 2015 17:48:38 -0400 (EDT)
Message-ID: <1655915087.37685837.1443649718387.JavaMail.zimbra@redhat.com>
References: <560C5583.9070005@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:33407 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbbI3Vtl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Sep 2015 17:49:41 -0400
In-Reply-To: <560C5583.9070005@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Excellent news.

I believe the following should be solved when this OSD fix [1] is merge=
d. That bug was causing wide-spread test failures for RBD in the latest=
 sepia runs.

  http://tracker.ceph.com/issues/13309
  http://tracker.ceph.com/issues/13310

[1] https://github.com/ceph/ceph/pull/6118

--=20

Jason Dillaman=20


----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Jason Dillaman" <dillaman@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, September 30, 2015 5:34:59 PM
> Subject: Running the rbd suite on OpenStack
>=20
> Hi Jason,
>=20
> The hammer rbd suite runs ok. The infernalis rbd suite revealed a few=
 issues
> (the details are at http://tracker.ceph.com/issues/13270):
>=20
> CentOS 7 and Ubuntu 14.04 : http://tracker.ceph.com/issues/13310
>=20
> CentOS 7 specific: http://tracker.ceph.com/issues/13309 and
> http://tracker.ceph.com/issues/13308
>=20
> Note that they also happen when running on a VPS in the Sepia lab whi=
ch is
> convenient for fixing them with no access to an OpenStack tenant.
>=20
> There also is an ansible issue: http://tracker.ceph.com/issues/13305 =
and a
> teuthology issue: http://tracker.ceph.com/issues/13187.
>=20
> One job needs more than the default 40GB disk ( rbd/qemu/{cache/none.=
yaml
> cachepool/none.yaml clusters/fixed-3.yaml fs/btrfs.yaml
> msgr-failures/few.yaml workloads/qemu_xfstests.yaml} ) each OpenStack
> instance is given (http://tracker.ceph.com/issues/13270):
>=20
> I'm not sure which priority these issues should be given so I set the=
m to
> Normal. The goal was to figure out how much work is required on the R=
BD
> suite to make it run solely on OpenStack. All in all it's not too bad=
 :)
>=20
> Cheers
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
