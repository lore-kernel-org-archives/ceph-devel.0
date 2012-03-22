From: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Subject: Re: How can I mount my Ceph cluster?
Date: Thu, 22 Mar 2012 11:59:16 +0800
Message-ID: <CALwGbPKTy29a6iVFaK2o42kpdsJbW+M8p2x2cdwUeFr3Tnvteg@mail.gmail.com>
References: <CALwGbPKR4M3khtKRCG_=UgOXFV5rVjrV6GdbQg5moLQiFU4vcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41783 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab2CVD7Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 23:59:16 -0400
Received: by iagz16 with SMTP id z16so2530256iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 20:59:16 -0700 (PDT)
In-Reply-To: <CALwGbPKR4M3khtKRCG_=UgOXFV5rVjrV6GdbQg5moLQiFU4vcA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Some complement to the question.

root@deltamaster-ceph-1:~# mount -t ceph deltamaster-ceph-1:/ /mnt/ceph
mount error 5 =3D Input/output error
root@deltamaster-ceph-1:~# mount -t ceph 127.0.0.1:/ /mnt/ceph
mount error 22 =3D Invalid argument

root@deltamaster-ceph-1:~# dmesg
[11418.006004] libceph: mon0 127.0.1.1:6789 connection failed
[11428.000875] libceph: mon0 127.0.1.1:6789 connection failed
[11438.032138] libceph: mon0 127.0.1.1:6789 connection failed
[11448.032778] libceph: mon0 127.0.1.1:6789 connection failed
[11458.065876] libceph: mon0 127.0.1.1:6789 connection failed
[11468.064890] libceph: mon0 127.0.1.1:6789 connection failed
[11503.432922] libceph: client0 fsid 543def81-c4a6-4a5b-a533-f79b54588c=
76
[11503.433580] libceph: no secret set (for auth_x protocol)
[11503.433585] libceph: error -22 on auth protocol 2 init


On Thu, Mar 22, 2012 at 10:39 AM, =E8=83=A1=E7=80=9A=E6=A3=AE <softrank=
=2Enet@gmail.com> wrote:
> I've written my config file at follow:
>
> [global]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0auth supported =3D cephx
> =C2=A0 =C2=A0 =C2=A0 =C2=A0keyring =3D /etc/ceph/$name.keyring
>
> [mon]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mon data =3D /srv/mon.$id
>
> [mds]
>
> [osd]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0osd data =3D /srv/osd.$id
> =C2=A0 =C2=A0 =C2=A0 =C2=A0osd journal =3D /srv/osd.$id.journal
> =C2=A0 =C2=A0 =C2=A0 =C2=A0osd journal size =3D 1000
>
> [mon.a]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D deltamaster-ceph-1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mon addr =3D 127.0.0.1:6789
>
> [osd.0]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D deltamaster-ceph-1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0btrfs devs =3D /dev/sda6
>
> ...And start ceph
>
> =3D=3D=3D mon.a =3D=3D=3D
> mon.a: running...
> =3D=3D=3D osd.0 =3D=3D=3D
> osd.0: running...
> Filesystem =C2=A0 =C2=A0 1K-blocks =C2=A0 =C2=A0Used Available Use% M=
ounted on
> /dev/sda7 =C2=A0 =C2=A0 =C2=A0 15790076 4157688 =C2=A010840172 =C2=A0=
28% /
> udev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0505100 =C2=A0 =C2=
=A0 =C2=A0 4 =C2=A0 =C2=A0505096 =C2=A0 1% /dev
> tmpfs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 204960 =C2=A0 =C2=A0 =
828 =C2=A0 =C2=A0204132 =C2=A0 1% /run
> none =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05120 =C2=A0=
 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A05120 =C2=A0 0% /run/lock
> none =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0512400 =C2=A0 =C2=
=A0 200 =C2=A0 =C2=A0512200 =C2=A0 1% /run/shm
> /dev/sda1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 192534 =C2=A0 33580 =C2=A0 =C2=A0=
149226 =C2=A019% /boot
> /dev/sda6 =C2=A0 =C2=A0 =C2=A0 =C2=A02928640 =C2=A0 =C2=A01256 =C2=A0=
 2607104 =C2=A0 1% /srv/osd.0
> kernel/fs/ceph/ceph.ko
> kernel/net/ceph/libceph.ko
>
> Is it correct to type "mount -t ceph 127.0.0.1:/ /mnt/ceph"?
> Why it tells me "source mount path was not specified"?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
