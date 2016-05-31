From: Loic Dachary <loic@dachary.org>
Subject: Re: dependency on parted: just ceph-osd, or more?
Date: Tue, 31 May 2016 23:43:29 +0200
Message-ID: <574E0581.3030705@dachary.org>
References: <CALqRxCwBRjx8OXceg1j+5dCNNDfKdLksJjnuNcmJFD+t6ZEfPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45158 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbcEaVnd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 17:43:33 -0400
In-Reply-To: <CALqRxCwBRjx8OXceg1j+5dCNNDfKdLksJjnuNcmJFD+t6ZEfPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Ken,

On 31/05/2016 23:06, Ken Dreyer wrote:
> Hi Loic, is there anything in ceph outside of the ceph-osd package
> that requires parted?
>=20
> I'm wondering if we can move the parted dependency to the ceph-osd
> sub-package, http://tracker.ceph.com/issues/16095
>=20
> Among other things, this would make Mon and MDS containers lighter.

I'm sure the mon do not need parted. I'd be surprised if mds need it bu=
t I'm only 99% sure ;-)

Cheers

>=20
> - Ken
> --
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
