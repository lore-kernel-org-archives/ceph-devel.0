From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: firefly branch for v0.80.10 ready for QE
Date: Fri, 5 Jun 2015 10:54:58 -0400 (EDT)
Message-ID: <1372965780.14838160.1433516098283.JavaMail.zimbra@redhat.com>
References: <5568915D.3040005@dachary.org> <557167D0.40201@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:40118 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbbFEO4C convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 10:56:02 -0400
In-Reply-To: <557167D0.40201@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Xinxin Shu <xinxin.shu@intel.com>

Loic

Thx for the heads up.

Would that touch only the "rgw" suite?

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Xinxin Shu" <xinx=
in.shu@intel.com>
Sent: Friday, June 5, 2015 2:11:44 AM
Subject: Re: firefly branch for v0.80.10 ready for QE

Hi Yuri,

A month passed since this mail was sent and the firefly branch has a fe=
w additional commits. All but one (https://github.com/ceph/ceph/pull/48=
29 with more information at http://tracker.ceph.com/issues/11890) have =
been tested. This exception seems harmless but I thought you should kno=
w.=20

=46or the record, the head of the firefly branch now is https://github.=
com/ceph/ceph/commit/d0f9c5f47024f53b4eccea2e0fde9b7844746362 and http:=
//tracker.ceph.com/issues/11090#Release-information has been updated ac=
cordingly.

Cheers

On 29/05/2015 18:18, Loic Dachary wrote:> Hi Yuri,
>=20
> The firefly branch for v0.80.10 as found at https://github.com/ceph/c=
eph/commits/firefly has been approved by Greg, Yehuda, Josh and Sam and=
 is ready for QE. For the record, the head is https://github.com/ceph/c=
eph/commit/071c94385ee71b86c5ed8363d56cf299da1aa7b3 and the details of =
the tests run are at http://tracker.ceph.com/issues/11090
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
