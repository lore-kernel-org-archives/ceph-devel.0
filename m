From: Wido den Hollander <wido@42on.com>
Subject: Re: Will the number of objects that have ever existed be infinite?
Date: Sat, 23 May 2015 10:55:38 +0200
Message-ID: <5560408A.5000906@42on.com>
References: <CAPS90kgipTtHpamtsT6C3ZBugn4djmDW7jXrveEf9FjKY1yoUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:46875 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbbEWIzm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 23 May 2015 04:55:42 -0400
In-Reply-To: <CAPS90kgipTtHpamtsT6C3ZBugn4djmDW7jXrveEf9FjKY1yoUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5p2O5rKb5Lym?= <lpl6338236@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/23/2015 08:58 AM, =E6=9D=8E=E6=B2=9B=E4=BC=A6 wrote:
> Hello!
>=20
> I'm a GSoC student this year and my job is to introduce Missing Rate
> Curve (or reuse distance exactly) of objects into OSD. Now I'm trying
> to find a proper algorithm to implement but there is a problem: Shoul=
d
> I take the number of objects tracked in an OSD as infinite or
> constant?
>=20

A OSD doesn't track on a per-object basis, but it keeps track of
Placement Groups (PGs). A OSD can have a X number of PGs.

Technically the number of PGs might be infinite, but in practice you ar=
e
bound to CPU and Memory limits.

So I would be careful with the word "infinite", since nothing is really
infinite, eg size of a int/long might be the limitation for something.

But in theory there is no object or PG limit per OSD.

> The point is that there is an algorithm that use hash to sample only
> constant number of references to do the analysis and is proved to be
> accurate, which makes it possible to do online MRC construction. That
> accuracy is supported by the fact that the memory addresses is
> bounded, while objects can be deleted and created again and again in
> Ceph. Is is reasonable to think that an OSD only serves bounded numbe=
r
> of objects in its life time (or the time period that we want to
> compute MRC)?
>=20
> Any other comment about this project is also welcomed :)
>=20


--=20
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
