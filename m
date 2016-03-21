From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: RGW placement multi data pool support
Date: Mon, 21 Mar 2016 15:54:38 -0400 (EDT)
Message-ID: <1575158130.71872660.1458590078846.JavaMail.zimbra@redhat.com>
References: <56EBE15D.6020906@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:47768 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398AbcCUTym convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 15:54:42 -0400
In-Reply-To: <56EBE15D.6020906@xtaotech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yang Honggang <joseph.yang@xtaotech.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Javen Wu <javen.wu@xtaotech.com>, Daniel Gryniewicz <dang@redhat.com>

Hi,

In-progress work (planned for Kraken) will make storage layout more cle=
anly abstract, and so should make this kind of thing less intrusive to =
build. =20

Matt

----- Original Message -----
> From: "Yang Honggang" <joseph.yang@xtaotech.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Cc: "Javen Wu" <javen.wu@xtaotech.com>
> Sent: Friday, March 18, 2016 7:07:09 AM
> Subject: RGW placement multi data pool support
>=20
> Hello,
>=20
> In the current RGW implementation, only one =E2=80=98data pool=E2=80=99=
 is allowed in the
> placement target. So the size of a bucket is limited by the backend p=
ool
> size. We can add osds into the backend pool, but it would trigger PG =
data
> rebalance. Also, we might have to do PG split when the OSD count is c=
lose
> to the pre-defined PG number, however, it would trigger data rebalanc=
e as
> well. We try to avoid data rebalance as many as we can by adding mult=
iple
> pools into one placement target. Then a scheduler between pools of a
> placement target is needed.
>=20
> I have a immature proposal would like to discuss with you. We can ext=
end
> placement's data pool to a pool list. When a new object is created th=
rough
> RGW, we can choose one data pool from placement's data pool list. In =
order
> to do that, the pool ID need to be added into the bucket index for ea=
ch
> object.
>=20
> How do you guys think?
>=20
> thx,
>=20
> Joseph
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
