From: Loic Dachary <loic@dachary.org>
Subject: Re: jewel pull requests process and timing
Date: Sat, 27 Feb 2016 09:09:16 +0700
Message-ID: <56D1054C.6000001@dachary.org>
References: <CALqRxCzbCH9yQA9=60rGff8_0evzAtsGXDzs0rug0RE5KRd_2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33872 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218AbcB0CJ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Feb 2016 21:09:26 -0500
In-Reply-To: <CALqRxCzbCH9yQA9=60rGff8_0evzAtsGXDzs0rug0RE5KRd_2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


Hi Ken,

On 27/02/2016 04:33, Ken Dreyer wrote:
> Regarding whether pull request should go to master or to jewel first.=
=2E.
>=20
> When do we start doing separate cherry-picks from master into jewel?
> Does that point in time correspond to the first RC version (10.1.0)?

This is also my understanding. We start cherry-picking when we stop mer=
ging the jewel branch back in master, which is about the only thing tha=
t separates X.0.Z from X.1.Z.

But since it's the first time I formulate that, I may be completely wro=
ng ;-)

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
