From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw and the next hammer release v0.94.2
Date: Mon, 11 May 2015 13:27:21 -0400 (EDT)
Message-ID: <685374108.12313692.1431365241610.JavaMail.zimbra@redhat.com>
References: <5550A0E3.8000006@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53109 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbbEKR2a convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 13:28:30 -0400
In-Reply-To: <5550A0E3.8000006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>



----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yehuda Sadeh" <yehuda@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Abhishek L" <ab=
hishek.lekshmanan@gmail.com>
> Sent: Monday, May 11, 2015 5:30:27 AM
> Subject: rgw and the next hammer release v0.94.2
>=20
> Hi Yehuda,
>=20
> The next hammer release as found at https://github.com/ceph/ceph/tree=
/hammer
> passed the rgw suite (http://tracker.ceph.com/issues/11492#rgw). Note=
 that
> the hammer branch does not yet include
> https://github.com/ceph/ceph/pull/4568 (it was included in the tests
> though). If https://github.com/ceph/ceph/pull/4568 is merged before Q=
E
> starts their round of testing, it will be in v0.94.2. If it is not me=
rged,
> it will have to wait until v0.94.3 is published. Either way is fine.

I merged it in now.

>=20
> Do you think the hammer branch is ready for QE to start their own rou=
nd of
> testing ?
>=20

Yes.

Thanks,
Yehuda

> Cheers
>=20
> P.S. http://tracker.ceph.com/issues/11492#Release-information has dir=
ect
> links to the pull requests merged into hammer since v0.94.1 in case y=
ou need
> more context about one of them.
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
