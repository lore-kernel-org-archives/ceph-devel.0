From: "changtao381" <changtao381@163.com>
Subject: =?UTF-8?Q?=E7=AD=94=E5=A4=8D:_journal_alignment?=
Date: Fri, 20 Nov 2015 17:12:25 +0800
Message-ID: <023e01d12373$941f1050$bc5d30f0$@com>
References: <019801d1236e$206f12e0$614d38a0$@com> <d742f6275e1645cdb02b0bad23110eec@R01UKEXCASM115.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-13.163.com ([220.181.12.13]:56644 "EHLO m12-13.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933930AbbKTJMl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 04:12:41 -0500
In-Reply-To: <d742f6275e1645cdb02b0bad23110eec@R01UKEXCASM115.r01.fujitsu.local>
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Piotr.Dalek@ts.fujitsu.com, haomaiwang@gmail.com, ceph-devel@vger.kernel.org

Hi All,

Thanks for you apply!

If directioIO + async IO requirement that alignment, it shouldn't align=
ed by PAGE for each journal entry.
=46or it may write many entries of journal once time

So it should do alignment after [prepare_multi_write] rather than do it=
 each in [prepare_single_write] ? Am I right?

-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: Piotr.Dalek@ts.fujitsu.com [mailto:Piotr.D=
alek@ts.fujitsu.com]=20
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B411=E6=9C=8820=E6=97=A5=
 16:42
=E6=94=B6=E4=BB=B6=E4=BA=BA: changtao381; ceph-devel@vger.kernel.org
=E4=B8=BB=E9=A2=98: RE: journal alignment

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
Piotr Da=C5=82ek


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
