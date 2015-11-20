From: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: journal alignment
Date: Fri, 20 Nov 2015 08:42:29 +0000
Message-ID: <d742f6275e1645cdb02b0bad23110eec@R01UKEXCASM115.r01.fujitsu.local>
References: <019801d1236e$206f12e0$614d38a0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.143]:14093 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1162067AbbKTItK convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Nov 2015 03:49:10 -0500
In-Reply-To: <019801d1236e$206f12e0$614d38a0$@com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: changtao381 <changtao381@163.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of changtao381
> Sent: Friday, November 20, 2015 9:33 AM
>=20
> HI All,
>=20
> Why it is needed an entry of journal t is aligned  by  CEPH_PAGE_MASK=
 ?  For
> it causes the data of journal write are amplified by 2X for small io
>=20
> For example write io size 4096 bytes, it may write 8192 bytes
>=20
> prepare_single_write 2 will write 98304 : seq 24 len 4324 -> 8192 (he=
ad 40
> pre_pad 0 ebl 4324 post_pad 3788 tail 40) (ebl alignment -1)
>=20
> Thanks!

It is a direct-IO+async IO requirement (writing on page-size boundary w=
hich is incidentally also a multiply of sector size).

With best regards / Pozdrawiam
Piotr Da=B3ek

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
