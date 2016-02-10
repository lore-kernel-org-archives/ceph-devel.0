From: Loic Dachary <loic@dachary.org>
Subject: Re: Changing code in a subproject ceph-erasure-code-corpus
Date: Wed, 10 Feb 2016 18:31:15 +0700
Message-ID: <56BB1F83.3090304@dachary.org>
References: <56BB1BFA.6040603@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55145 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbcBJLbZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 06:31:25 -0500
In-Reply-To: <56BB1BFA.6040603@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, ceph-devel@vger.kernel.org

Hi,

You can submit a patch against https://github.com/ceph/ceph-erasure-cod=
e-corpus

Cheers

On 10/02/2016 18:16, Willem Jan Withagen wrote:
> Hi,
>=20
> I have  one-line change in the erasure-code subproject.
> but git status reports:
>   modified:   ceph-erasure-code-corpus (modified content)
>=20
> So that change is not going to make it in my pull...
> But it is influencing my tests, and I keep fixing it after
> every fetch of the tree
>=20
> It is in
> ./ceph-erasure-code-corpus/v0.92-988/non-regression.sh:25
>=20
> and it replaces
>     TMP=3D$(mktemp --directory)
> by
>     TMP=3D$(mktemp -d)
>=20
> So how do get something like this commited?
>=20
> Thanx,
> --WjW
>=20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
