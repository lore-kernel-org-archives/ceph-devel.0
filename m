From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [Qemu-devel] qemu drive-mirror to rbd storage : no sparse rbd image
Date: Sun, 12 Oct 2014 12:02:42 +0200 (CEST)
Message-ID: <03498fe6-45a9-4b14-88f4-1434e7c50acc@mailpro>
References: <CABYiri_An2fxAJYzxwdDJjFnUF2ME4HjY-jrcWE_jrDi9bshvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:48575 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaJLKCu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Oct 2014 06:02:50 -0400
In-Reply-To: <CABYiri_An2fxAJYzxwdDJjFnUF2ME4HjY-jrcWE_jrDi9bshvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ceph Devel <ceph-devel@vger.kernel.org>, Fam Zheng <famz@redhat.com>

>>Just a wild guess - Alexandre, did you tried detect-zeroes blk option=
=20
>>for mirroring targets?=20

Hi, yes, I have also tried with detect-zeroes (on or discard) with virt=
io and virtio-scsi, doesn't help. (I'm not sure that is implemtend in d=
rive-mirror).

As workaround currently, after drive-mirror, I doing fstrim inside the =
guest (with virtio-scsi + discard),=20
and like this I can free space on rbd storage.



----- Mail original -----=20

De: "Andrey Korolyov" <andrey@xdel.ru>=20
=C3=80: "Fam Zheng" <famz@redhat.com>=20
Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, "qemu-devel" <qemu-deve=
l@nongnu.org>, "Ceph Devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Samedi 11 Octobre 2014 10:30:40=20
Objet: Re: [Qemu-devel] qemu drive-mirror to rbd storage : no sparse rb=
d image=20

On Sat, Oct 11, 2014 at 12:25 PM, Fam Zheng <famz@redhat.com> wrote:=20
> On Sat, 10/11 10:00, Alexandre DERUMIER wrote:=20
>> >>What is the source format? If the zero clusters are actually unall=
ocated in the=20
>> >>source image, drive-mirror will not write those clusters either. I=
=2Ee. with=20
>> >>"drive-mirror sync=3Dtop", both source and target should have the =
same "qemu-img=20
>> >>map" output.=20
>>=20
>> Thanks for your reply,=20
>>=20
>> I had tried drive mirror (sync=3Dfull) with=20
>>=20
>> raw file (sparse) -> rbd (no sparse)=20
>> rbd (sparse) -> rbd (no sparse)=20
>> raw file (sparse) -> qcow2 on ext4 (sparse)=20
>> rbd (sparse) -> raw on ext4 (sparse)=20
>>=20
>> Also I see that I have the same problem with target file format on x=
fs.=20
>>=20
>> raw file (sparse) -> qcow2 on xfs (no sparse)=20
>> rbd (sparse) -> raw on xfs (no sparse)=20
>>=20
>=20
> These don't tell me much. Maybe it's better to show the actual comman=
ds and how=20
> you tell sparse from no sparse?=20
>=20
> Does "qcow2 -> qcow2" work for you on xfs?=20
>=20
>>=20
>> I only have this problem with drive-mirror, qemu-img convert seem to=
 simply skip zero blocks.=20
>>=20
>>=20
>> Or maybe this is because I'm using sync=3Dfull ?=20
>>=20
>> What is the difference between full and top ?=20
>>=20
>> ""sync": what parts of the disk image should be copied to the destin=
ation;=20
>> possibilities include "full" for all the disk, "top" for only the se=
ctors=20
>> allocated in the topmost image".=20
>>=20
>> (what is topmost image ?)=20
>=20
> For "sync=3Dtop", only the clusters allocated in the image itself is =
copied; for=20
> "full", all those clusters allocated in the image itself, and its bac=
king=20
> image, and it's backing's backing image, ..., are copied.=20
>=20
> The image itself, having a backing image or not, is called the topmos=
t image.=20
>=20
> Fam=20
> --=20

Just a wild guess - Alexandre, did you tried detect-zeroes blk option=20
for mirroring targets?=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
