From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: radosgw and the next giant release v0.87.2
Date: Wed, 15 Apr 2015 12:16:22 -0400 (EDT)
Message-ID: <1796922641.219521.1429114582431.JavaMail.zimbra@redhat.com>
References: <552E32B0.6040101@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:34062 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbDOQR1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 12:17:27 -0400
In-Reply-To: <552E32B0.6040101@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>



----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yehuda Sadeh" <yehuda@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Abhishek L" <ab=
hishek.lekshmanan@gmail.com>
> Sent: Wednesday, April 15, 2015 2:43:12 AM
> Subject: radosgw and the next giant release v0.87.2
>=20
> Hi Yehuda,
>=20
> The next giant release as found at https://github.com/ceph/ceph/tree/=
giant
> passed the rgw suite (http://tracker.ceph.com/issues/11153#rgw). One =
run had
> a transient failure (http://tracker.ceph.com/issues/11259) that did n=
ot
> repeat. You will also find traces of failed run because of
> http://tracker.ceph.com/issues/11180 but that was resolved by backpor=
ting
> https://github.com/ceph/ceph-qa-suite/pull/375.
>=20
> Do you think it is ready for QE to start their own round of testing ?

Yes.

>=20
> Note that it will be the last giant release.
>=20
> Cheers
>=20
> P.S. http://tracker.ceph.com/issues/11153#Release-information has dir=
ect
> links to the pull requests merged into giant since v0.87.1 in case yo=
u need
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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
