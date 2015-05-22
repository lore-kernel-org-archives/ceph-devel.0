From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw and the next firefly release v0.80.10
Date: Fri, 22 May 2015 16:02:42 -0400 (EDT)
Message-ID: <245667172.3332927.1432324962079.JavaMail.zimbra@redhat.com>
References: <555F8AE0.6020001@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:58051 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136AbbEVUDr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 16:03:47 -0400
In-Reply-To: <555F8AE0.6020001@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Xinxin Shu <xinxin.shu@intel.com>

Yes.

Thanks,
Yehuda

----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yehuda Sadeh" <yehuda@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Xinxin Shu" <xi=
nxin.shu@intel.com>
> Sent: Friday, May 22, 2015 1:00:32 PM
> Subject: rgw and the next firefly release v0.80.10
>=20
> Hi Yehuda,
>=20
> The next firefly release as found at
> https://github.com/ceph/ceph/tree/firefly
> (68211f695941ee128eb9a7fd0d80b615c0ded6cf) passed the rgw suite
> (http://tracker.ceph.com/issues/11090#rgw). It includes
> https://github.com/ceph/ceph/pull/4697 which is the pull request back=
porting
> the fix for http://tracker.ceph.com/issues/11604 and
> http://tracker.ceph.com/issues/11622 to firefly.
>=20
> Do you think it is ready for QE to start their own round of testing ?
>=20
> Cheers
>=20
> P.S. http://tracker.ceph.com/issues/11090#Release-information has dir=
ect
> links to the pull requests merged into firefly since v0.80.9 in case =
you
> need more context about one of them.
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
>=20
>=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
