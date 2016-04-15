From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw and the next hammer release v0.94.7
Date: Fri, 15 Apr 2016 10:48:41 +0200
Message-ID: <5710AAE9.1020602@dachary.org>
References: <570B8DEE.2020804@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp24.services.sfr.fr ([93.17.128.82]:7246 "EHLO
	smtp24.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbcDOIso (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 04:48:44 -0400
In-Reply-To: <570B8DEE.2020804@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Ping ?

On 11/04/2016 13:43, Loic Dachary wrote:
> Hi Yehuda,
>=20
> The next hammer release as found at https://github.com/ceph/ceph/tree=
/hammer passed most the rgw suite (http://tracker.ceph.com/issues/14692=
#note-46).=20
>=20
> One failure is http://tracker.ceph.com/issues/15316 when seems relate=
d to how ansible installs Amazon::S3
> The other is a valgrind issue which seems new http://pulpito.ceph.com=
/loic-2016-04-06_01:32:41-rgw-hammer-backports---basic-smithi/110829/
>=20
> There are runs of the rgw hammer branch on http://pulpito.ovh.sepia.c=
eph.com:8081/?branch=3Dhammer&suite=3Drgw as well but they are tainted =
by http://tracker.ceph.com/issues/13885 which will hopefully be fixed b=
y https://github.com/ceph/s3-tests/pull/104 for the next round of jewel=
/hammer backports.
>=20
> Do you think the hammer branch is ready for QE to start their own rou=
nd of testing ?
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
