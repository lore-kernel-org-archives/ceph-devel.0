From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer branch for v0.94.2 ready for QE
Date: Tue, 26 May 2015 12:39:17 -0400 (EDT)
Message-ID: <1600799032.6345985.1432658357501.JavaMail.zimbra@redhat.com>
References: <5559DE24.4010601@dachary.org> <1094270224.6326426.1432656826948.JavaMail.zimbra@redhat.com> <55649E75.20802@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:59115 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbbEZQkU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 May 2015 12:40:20 -0400
In-Reply-To: <55649E75.20802@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

Loic

There are infrastructure related issues as well as for example the rado=
s suite needs review as many jobs failed.

See for example lines with "need review" notes which I am suggesting to=
 be reviewed by the team leads.

rados run on typica and magna (for example):

http://pulpito-rdu.front.sepia.ceph.com/teuthology-2015-05-15_12:42:53-=
rados-hammer-distro-basic-typica/
http://pulpito.ceph.redhat.com/teuthology-2015-05-11_20:22:13-rados-ham=
mer-distro-basic-magna/

I think it's more efficient to review such results as it feels like amo=
unt of failures is unproportionally high.
=20
Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Abhishek L" <abhi=
shek.lekshmanan@gmail.com>
Sent: Tuesday, May 26, 2015 9:25:25 AM
Subject: Re: hammer branch for v0.94.2 ready for QE

Hi Yuri,

If I'm not mistaken http://tracker.ceph.com/issues/11660 is the last is=
sue blocking v0.94.2. Is there another one I don't see ?

Cheers

On 26/05/2015 18:13, Yuri Weinstein wrote:
> Loic
>=20
> This hammer release QE validation is taking unusually long time and h=
as issues that has to be clarified.=20
>=20
> All test results were summarized in http://tracker.ceph.com/issues/11=
492
>=20
> There are several reasons contributing to slowness of this validation=
, product related as well as infrastructure related, also high amount o=
f tests make turn around time slower as well.
>=20
> I think some suites, e.g. rados and upgrades for example will have to=
 be re-run after issues had been clarified/fixed.
>=20
> rados, krbd, knfs, samba suite test results need reviews by the team =
leads.
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Abhishek L" <ab=
hishek.lekshmanan@gmail.com>
> Sent: Monday, May 18, 2015 5:42:12 AM
> Subject: hammer branch for v0.94.2 ready for QE
>=20
> Hi Yuri,
>=20
> The hammer branch for v0.94.2 as found at https://github.com/ceph/cep=
h/commits/hammer has been approved by Greg, Yehuda, Josh and Sam and is=
 ready for QE. For the record, the head is https://github.com/ceph/ceph=
/commit/63832d4039889b6b704b88b86eaba4aadcfceb2e and the details of the=
 tests run are at http://tracker.ceph.com/issues/11492
>=20
> Note that it has two more commits compared to what you tested before:
>=20
> https://github.com/ceph/ceph/commit/293affe992118ed6e04f685030b2d83a7=
94ca624 fixing http://tracker.ceph.com/issues/11622
> https://github.com/ceph/ceph/commit/a43d24861089a02f3b42061e482e05016=
a0021f6 fixing http://tracker.ceph.com/issues/11604
>=20
> which address two blockers that you listed at http://tracker.ceph.com=
/issues/11492#QE-Validation
>=20
> These two new commits only have influence, directly or indirectly, on=
 rgw. They do not require or deserve a new run of the rados, fs or rbd =
suite because none of them depend on rgw, directly or indirectly.
>=20
> The other two issues listed as blockers are
>=20
> http://tracker.ceph.com/issues/11613#note-4 do not need a backport to=
 hammer
> http://tracker.ceph.com/issues/11591 is a teuthology related issue th=
at can be worked around and does not need to be a blocker for hammer
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
