From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Fri, 16 Jan 2015 10:50:22 +0100
Message-ID: <101AEAEE-F428-4425-87CE-A20B3030FF55@enovance.com>
References: <54B7D2D6.4020503@42on.com> <CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com> <alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:49062 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbbAPKKq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 05:10:46 -0500
In-Reply-To: <alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh <yehuda@redhat.com>, Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hum if I understand correctly you=E2=80=99re all more in favour of a co=
nf setting in the ceph.conf;
The problem for me is that this will apply to all the pools by default =
and I=E2=80=99ll have to inject an arg to change this.
Injecting the arg will remove this =E2=80=9Clock" and then all of the s=
udden all the pools become deletable through the lib again (who knows w=
hat users can do simultaneously)

I=E2=80=99m more in favour of a new flag to set to the pool, something =
like:

ceph osd pool set foo protect true
ceph osd pool delete foo foo =E2=80=94yes=E2=80=A6.
ERROR: pool foo is protected against deletion

ceph osd pool delete foo protect false
ceph osd pool delete foo foo =E2=80=94yes=E2=80=A6.
Pool successfully deleted

The good thing with that is that owners of the pool (or admin), will be=
 able to set this flag or remove it.
We stick with the "ceph osd pool delete foo foo =E2=80=94yes=E2=80=A6.=E2=
=80=9D command as well, so we don=E2=80=99t change too much things.

Moreover we can also make use of a config option to protect all new cre=
ated pools by default:

mon protect pool default =3D true

This automatically set the protected flag to a new pool.

What do you think?

> On 15 Jan 2015, at 18:24, Sage Weil <sage@newdream.net> wrote:
>=20
> Then secondary question is whether the cluster should implicitly clea=
r the=20
> allow-delete after some time period (maybe 'pending-delete' would mak=
e=20
> more sense in that case), or whether we deny IO during that period.  =
Seems=20
> perhaps too complicated.


Cheers.
=E2=80=93=E2=80=93=E2=80=93=E2=80=93=20
S=C3=A9bastien Han=20
Cloud Architect=20

"Always give 100%. Unless you're giving blood."

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 11 bis, rue Roqu=C3=A9pine - 75008 Paris
Web : www.enovance.com - Twitter : @enovance=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
