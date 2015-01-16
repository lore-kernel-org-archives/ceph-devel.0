From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: upcoming release giant v0.87.1 : leads feedback needed
Date: Fri, 16 Jan 2015 07:46:25 +0100 (CET)
Message-ID: <1922521912.4341991.1421390785245.JavaMail.zimbra@oxygem.tv>
References: <54B7E6DC.8010905@dachary.org> <54B7F2DF.9060003@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:40473 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbbAPGq1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 01:46:27 -0500
In-Reply-To: <461708302.4341990.1421390777959.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Loic,

>>Well, this is a little embarassing but here it is : there won't be a =
point release for giant. I'll update the redmine tickets to remove the =
"giant" backport targets as well as the github milestone list according=
ly.=20

Is the planned to update only "longterm" support releases ? (dumpling,f=
irefly,hammer,...) ?



----- Mail original -----
De: "Loic Dachary" <loic@dachary.org>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Jeudi 15 Janvier 2015 18:03:27
Objet: Re: upcoming release giant v0.87.1 : leads feedback needed

Hi Again,=20

Well, this is a little embarassing but here it is : there won't be a po=
int release for giant. I'll update the redmine tickets to remove the "g=
iant" backport targets as well as the github milestone list accordingly=
=2E=20

Sorry for the noise.=20

On 15/01/2015 17:12, Loic Dachary wrote:=20
> Hi Ceph,=20
>=20
> The https://github.com/ceph/ceph/tree/giant-backports branch was test=
ed with the rgw, rados and rbd suites. The results of each suite have b=
een analyzed and summarized in http://tracker.ceph.com/issues/10501. Th=
e next steps are either:=20
>=20
> a) Yehuda for rgw, Josh for rbd and Sam for rados all agree that the =
errors are unrelated to the backports=20
> b) The https://github.com/ceph/ceph/tree/giant-backports branch is gi=
ven to QE for final tests and merge into giant=20
>=20
> OR=20
>=20
> a) At least of the lead thinks more work is needed to stabilize the g=
iant branch=20
> b) A new set of tests will be run and analyzed after adding/removing =
one or more backports to/from the https://github.com/ceph/ceph/tree/gia=
nt-backports branch=20
>=20
> The description of http://tracker.ceph.com/issues/10501 shows a detai=
led list of all commits / issues that are in the giant backport branch.=
 To get a global view of what the next giant point release will be, the=
 description also includes the commits that have already been merged in=
 the giant branch. The list of pull requests that are candidate for inc=
lusion in the giant release but have not been included in the integrati=
on branch are also listed: maybe one of them could contribute to resolv=
e a problem found during the tests. And finally all redmine issues that=
 have been marked to be backported to giant but do not yet have a candi=
date pull request are listed: this is the backport backlog so to speak =
;-)=20
>=20
> Cheers=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
