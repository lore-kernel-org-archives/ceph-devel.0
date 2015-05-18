From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer branch for v0.94.2 ready for QE
Date: Mon, 18 May 2015 11:40:48 -0400 (EDT)
Message-ID: <407490935.792561.1431963648850.JavaMail.zimbra@redhat.com>
References: <5559DE24.4010601@dachary.org> <792948484.778464.1431962588587.JavaMail.zimbra@redhat.com> <555A064C.9070905@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:54404 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbERPlw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 May 2015 11:41:52 -0400
In-Reply-To: <555A064C.9070905@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

Yes issues are specific to hammer.

They are found in parts of rados suite, I am wondering if since we incr=
eased the amount of tests in it we ever saw them passed.=20

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Abhishek L" <abhi=
shek.lekshmanan@gmail.com>
Sent: Monday, May 18, 2015 8:33:32 AM
Subject: Re: hammer branch for v0.94.2 ready for QE

Hi,

On 18/05/2015 17:23, Yuri Weinstein wrote:
> Loic
>=20
> Thanks for the update.
>=20
> There were some issues logged over weekend that were not noted in htt=
p://tracker.ceph.com/issues/11492
>=20
> http://tracker.ceph.com/issues/11661
> http://tracker.ceph.com/issues/11660

Are they specific to hammer ?

> environment related:
>=20
> http://tracker.ceph.com/issues/11546
> http://tracker.ceph.com/issues/11659
> http://tracker.ceph.com/issues/11662
>=20
> Also, I see rgw latest run with 27 failures http://pulpito.ceph.com/t=
euthology-2015-05-12_17:42:50-rgw-hammer-distro-basic-multi/

All of which because of environmental problems:

 Failed to fetch package version from http://gitbuilder.ceph.com/ceph-d=
eb-precise-x86_64-notcmalloc/sha1/b69fb89122d6f989152a29124cc7ed54b5e4d=
43b/version

Cheers

>=20
> I will continue QE validation meanwhile.
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
