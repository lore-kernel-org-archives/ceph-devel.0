From: =?utf-8?Q?Edgaras_Luko=C5=A1evi=C4=8Dius?=
	<edgaras.lukosevicius@gmail.com>
Subject: Re: trimming rbd image does not reclaim free space
Date: Tue, 12 May 2015 10:48:47 +0300
Message-ID: <DC28859B-7D5F-4F5A-B4F9-BF5232FFED97@gmail.com>
References: <927CE7A8-9A06-4CC3-A687-87E153070635@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36988 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbbELHs5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 03:48:57 -0400
Received: by widdi4 with SMTP id di4so2884535wid.0
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 00:48:56 -0700 (PDT)
Received: from [192.168.168.7] ([37.157.144.44])
        by mx.google.com with ESMTPSA id u9sm26375627wjx.15.2015.05.12.00.48.54
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 May 2015 00:48:54 -0700 (PDT)
In-Reply-To: <927CE7A8-9A06-4CC3-A687-87E153070635@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Resending commands I=E2=80=99m using to everyone.

# rbd-fuse -p pool -r image /mnt/trim/
# losetup /dev/loop0 /mnt/trim/image
# kpartx -av /dev/loop0
# mount /dev/mapper/loop0p1 /mnt/fstrim/
# fstrim -v /mnt/fstrim/
/mnt/fstrim/: 1.1 TiB (1167710830592 bytes) trimmed

I don=E2=80=99t use qemu, kvm.

Anyone can help with this?


On 11 May 2015, at 14:26, Edgaras Luko=C5=A1evi=C4=8Dius <edgaras.lukos=
evicius@gmail.com> wrote:

> Hello,
>=20
> I have ceph pool (size=3D2) and three RBD images (2TB each) and I hav=
e noticed, that deleting data does not reclaim data on ceph.
> What I have done is mount RBD device as a loopback device loop0, moun=
ted it to a filesystem, ran =E2=80=9Cfstrim=E2=80=9D and got response:
>=20
> /mnt/fstrim/: 1.1 TiB (1167710830592 bytes) trimmed
> /mnt/fstrim/: 1 TiB (1125871489024 bytes) trimmed
> /mnt/fstrim/: 1.1 TiB (1186485440512 bytes) trimmed
>=20
> Now that would be almost perfect if not the fact, that space was not =
reclaimed on ceph itself. Using =E2=80=9Cceph osd df=E2=80=9D I still s=
ee same usage even after waiting few hours and I don=E2=80=99t see any =
action.
>=20
> I=E2=80=99m using ceph v0.94-2 and kernel 3.10
>=20
> What is the proper way to reclaim unused space? I had pool size 3, bu=
t had to lower it to two, to avoid getting my OSDs full.
>=20
> Thanks.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
