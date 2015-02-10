From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 12:29:16 -0500 (EST)
Message-ID: <867276671.14905190.1423589356764.JavaMail.zimbra@redhat.com>
References: <54DA3A5B.5050509@dachary.org> <54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com> <54DA3E72.9010600@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:39745 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbbBJRaT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 12:30:19 -0500
In-Reply-To: <54DA3E72.9010600@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


On 10/02/2015 18:19, Yuri Weinstein wrote:>=20
> Loic,
>=20
> The only difference between options if we run suits on merged dumplin=
g vs dumpling-backports first - is time.
> We will have to run suites on the final branch after the merge anyway=
=2E

Could you explain why ? After merging dumpling and dumpling-backports w=
ill be exactly the same.

Loic - I feel that finial QE validation should be done on the code that=
 gets actually released to customers, e.g. dumpling branch after the me=
rge.  I do see your point about branches being identical and ready to c=
hange my mind if you insist.  Does my reasoning make sense?  Please adv=
ice, how we should proceed.


>=20
> Unless I hear otherwise, I will schedule suites to run on dumpling-ba=
ckports first (as you are suggesting, with higher priority) and then as=
suming that we resolved all issues, we will run on the dumpling merged.=
=20
>=20
> Sage, pls correct if this is not what has to be done.
>=20
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, February 10, 2015 9:05:31 AM
> Subject: dumpling integration branch for v0.67.12 ready for QE
>=20
> Hi Yuri,
>=20
> The dumpling integration branch for v0.67.12 as found at https://gith=
ub.com/ceph/ceph/commits/dumpling-backports has been approved by Yehuda=
, Josh and Sam and is ready for QE.=20
>=20
> For the record, the head is https://github.com/ceph/ceph/commit/3944c=
77c404c4a05886fe8276d5d0dd7e4f20410
>=20
> I think it would be best for the QE tests to use the dumpling-backpor=
ts. The alternative would be to merge dumpling-backports into dumpling.=
 However, since testing may take a long time and require more patches, =
it probably is better to not do that iterative process on the dumpling =
branch itself. As it is now, there already are a number of commits in t=
he dumpling branch that should really be in the dumpling-backports: the=
y do not belong to v0.67.11 and are going to be released in v0.67.12. I=
n the future though, the dumpling branch will only receive commits that=
 have been carefully tested and all the integration work will be on the=
 dumpling-backports branch exclusively. So that third parties do not ha=
ve to worry that the dumpling branch contains commits that have not bee=
n tested yet.
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
