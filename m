From: Loic Dachary <loic@dachary.org>
Subject: Re: A question on coredumps in unittests
Date: Tue, 12 Apr 2016 12:03:25 +0200
Message-ID: <570CC7ED.4060405@dachary.org>
References: <570CC221.2040603@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp23.services.sfr.fr ([93.17.128.22]:38684 "EHLO
	smtp23.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238AbcDLKDb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 06:03:31 -0400
In-Reply-To: <570CC221.2040603@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

IIRC there needs to be a pattern defined for where core are to be found=
=2E For instance teuthology/task/internal.py has                 'sudo'=
, 'sysctl', '-w', 'kernel.core_pattern=3D{adir}/coredump/%t.%p.core'.fo=
rmat(adir=3Darchive_dir),

I hope that helps

On 12/04/2016 11:38, Willem Jan Withagen wrote:
> Hi Loic,
>=20
> You have written a lot of the unittests, so it seems.
>=20
> I'm having the issue that under FreeBSD the cores are left behind fro=
m
> the EXPECT_DAETH tests.
> But under CentOS7 no cores are left behind.
> And 'ulimit -c unlimited' does not help to get cores
>=20
> Is there anything particular why this is the case...
> Google tests suggest that it is the programs responsability to cleanu=
p
> after itself.
>=20
> And would there be any objections to adding code like:
>=20
>     ret =3D RUN_ALL_TESTS();
>     if (ret =3D=3D 0) {
>         char core [30];
>         strncpy(core, argv[0], 19);
>         core[19] =3D '\0';
>         strcat(core, ".core");
>         ::unlink(core);
>         free(core);
>     }
>     return ret;
>=20
> to the tests
>=20
> Thanx,
> --WjW
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
