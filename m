From: Wido den Hollander <wido@42on.com>
Subject: Re: trimming rbd image does not reclaim free space
Date: Tue, 12 May 2015 10:09:04 +0200
Message-ID: <5551B520.6070706@42on.com>
References: <927CE7A8-9A06-4CC3-A687-87E153070635@gmail.com> <DC28859B-7D5F-4F5A-B4F9-BF5232FFED97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:43393 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932093AbbELIJM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 May 2015 04:09:12 -0400
In-Reply-To: <DC28859B-7D5F-4F5A-B4F9-BF5232FFED97@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?RWRnYXJhcyBMdWtvxaFldmnEjWl1cw==?= <edgaras.lukosevicius@gmail.com>, ceph-devel@vger.kernel.org

On 05/12/2015 09:48 AM, Edgaras Luko=C5=A1evi=C4=8Dius wrote:
> Resending commands I=E2=80=99m using to everyone.
>=20
> # rbd-fuse -p pool -r image /mnt/trim/
> # losetup /dev/loop0 /mnt/trim/image
> # kpartx -av /dev/loop0
> # mount /dev/mapper/loop0p1 /mnt/fstrim/
> # fstrim -v /mnt/fstrim/
> /mnt/fstrim/: 1.1 TiB (1167710830592 bytes) trimmed
>=20
> I don=E2=80=99t use qemu, kvm.
>=20

I think that kernel 3.10 doesn't support TRIM yet. Afaik it was
implemented in kernel 3.18 of 3.19

Wido

> Anyone can help with this?
>=20
>=20
> On 11 May 2015, at 14:26, Edgaras Luko=C5=A1evi=C4=8Dius <edgaras.luk=
osevicius@gmail.com> wrote:
>=20
>> Hello,
>>
>> I have ceph pool (size=3D2) and three RBD images (2TB each) and I ha=
ve noticed, that deleting data does not reclaim data on ceph.
>> What I have done is mount RBD device as a loopback device loop0, mou=
nted it to a filesystem, ran =E2=80=9Cfstrim=E2=80=9D and got response:
>>
>> /mnt/fstrim/: 1.1 TiB (1167710830592 bytes) trimmed
>> /mnt/fstrim/: 1 TiB (1125871489024 bytes) trimmed
>> /mnt/fstrim/: 1.1 TiB (1186485440512 bytes) trimmed
>>
>> Now that would be almost perfect if not the fact, that space was not=
 reclaimed on ceph itself. Using =E2=80=9Cceph osd df=E2=80=9D I still =
see same usage even after waiting few hours and I don=E2=80=99t see any=
 action.
>>
>> I=E2=80=99m using ceph v0.94-2 and kernel 3.10
>>
>> What is the proper way to reclaim unused space? I had pool size 3, b=
ut had to lower it to two, to avoid getting my OSDs full.
>>
>> Thanks.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
