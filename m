From: Sebastien Han <seb@redhat.com>
Subject: Re: Move RBD Cache on clients from RAM to SSD.
Date: Tue, 16 Jun 2015 11:54:03 +0200
Message-ID: <9F993C58-6380-4132-A87F-850A84A397DB@redhat.com>
References: <557FD76C.9070905@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50352 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572AbbFPJyH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 05:54:07 -0400
In-Reply-To: <557FD76C.9070905@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike <mike.almateia@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is not possible at the moment but long ago a BP was register to al=
low a multiple backend functionality. (can=E2=80=99t find it anymore)
Unfortunately I don=E2=80=99t think this BP got much attention :/

> On 16 Jun 2015, at 09:59, Mike <mike.almateia@gmail.com> wrote:
>=20
> Hello.
>=20
> By now rbd_cache uses RAM, can we store cache on disk (SSD, SSD NVE)?
> In this way I look some benefits:
> * Don't waste a RAM for cache
> * Can make a big cache on SSD: 2-8Gb per cache
> * If you use Cache Tier - don't waste space on them
> * No need addition Ceph servers - use Compute with SSD.
>=20
> Yes it's for write-through and read-only cache strategies mostly.
>=20
> Any ideas? My be I am blind and this idea totally stupid?
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers.
=E2=80=93=E2=80=93=E2=80=93=E2=80=93=20
S=C3=A9bastien Han=20
Senior Cloud Architect=20

"Always give 100%. Unless you're giving blood."

Mail: seb@redhat.com=20
Address: 11 bis, rue Roqu=C3=A9pine - 75008 Paris

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
