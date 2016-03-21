From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: RGW placement multi data pool support
Date: Mon, 21 Mar 2016 16:04:30 -0400 (EDT)
Message-ID: <79716852.71877577.1458590670353.JavaMail.zimbra@redhat.com>
References: <56EBE15D.6020906@xtaotech.com> <1575158130.71872660.1458590078846.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:52851 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474AbcCUUEb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 16:04:31 -0400
In-Reply-To: <1575158130.71872660.1458590078846.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yang Honggang <joseph.yang@xtaotech.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Javen Wu <javen.wu@xtaotech.com>, Daniel Gryniewicz <dang@redhat.com>

(clarifying, this is refactoring specific to rgw by Dan, not cluster-le=
vel placement)

----- Original Message -----
> From: "Matt Benjamin" <mbenjamin@redhat.com>
> To: "Yang Honggang" <joseph.yang@xtaotech.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Javen Wu" <javen.wu@x=
taotech.com>, "Daniel Gryniewicz"
> <dang@redhat.com>
> Sent: Monday, March 21, 2016 3:54:38 PM
> Subject: Re: RGW placement multi data pool support
>=20
> Hi,
>=20
> In-progress work (planned for Kraken) will make storage layout more c=
leanly
> abstract, and so should make this kind of thing less intrusive to bui=
ld.
>=20
> Matt
>=20
> ----- Original Message -----
> > From: "Yang Honggang" <joseph.yang@xtaotech.com>
> > To: "ceph-devel" <ceph-devel@vger.kernel.org>
> > Cc: "Javen Wu" <javen.wu@xtaotech.com>
> > Sent: Friday, March 18, 2016 7:07:09 AM
> > Subject: RGW placement multi data pool support
> >=20
> > Hello,
> >=20
> > In the current RGW implementation, only one =E2=80=98data pool=E2=80=
=99 is allowed in the
> > placement target. So the size of a bucket is limited by the backend=
 pool
> > size. We can add osds into the backend pool, but it would trigger P=
G data
> > rebalance. Also, we might have to do PG split when the OSD count is=
 close
> > to the pre-defined PG number, however, it would trigger data rebala=
nce as
> > well. We try to avoid data rebalance as many as we can by adding mu=
ltiple
> > pools into one placement target. Then a scheduler between pools of =
a
> > placement target is needed.
> >=20
> > I have a immature proposal would like to discuss with you. We can e=
xtend
> > placement's data pool to a pool list. When a new object is created =
through
> > RGW, we can choose one data pool from placement's data pool list. I=
n order
> > to do that, the pool ID need to be added into the bucket index for =
each
> > object.
> >=20
> > How do you guys think?
> >=20
> > thx,
> >=20
> > Joseph
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>=20
> http://www.redhat.com/en/technologies/storage
>=20
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
