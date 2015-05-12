From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: trimming rbd image does not reclaim free space
Date: Tue, 12 May 2015 11:48:22 +0300
Message-ID: <CAOi1vP-iC1JpY5PfoHA--0G+awjpdoSgHx4vGayf2EawcPkxYg@mail.gmail.com>
References: <927CE7A8-9A06-4CC3-A687-87E153070635@gmail.com>
	<DC28859B-7D5F-4F5A-B4F9-BF5232FFED97@gmail.com>
	<5551B520.6070706@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34338 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbbELIsX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 04:48:23 -0400
Received: by wgic8 with SMTP id c8so569289wgi.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 01:48:22 -0700 (PDT)
In-Reply-To: <5551B520.6070706@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: =?UTF-8?Q?Edgaras_Luko=C5=A1evi=C4=8Dius?= <edgaras.lukosevicius@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 12, 2015 at 11:09 AM, Wido den Hollander <wido@42on.com> wr=
ote:
> On 05/12/2015 09:48 AM, Edgaras Luko=C5=A1evi=C4=8Dius wrote:
>> Resending commands I=E2=80=99m using to everyone.
>>
>> # rbd-fuse -p pool -r image /mnt/trim/
>> # losetup /dev/loop0 /mnt/trim/image
>> # kpartx -av /dev/loop0
>> # mount /dev/mapper/loop0p1 /mnt/fstrim/
>> # fstrim -v /mnt/fstrim/
>> /mnt/fstrim/: 1.1 TiB (1167710830592 bytes) trimmed
>>
>> I don=E2=80=99t use qemu, kvm.
>>
>
> I think that kernel 3.10 doesn't support TRIM yet. Afaik it was
> implemented in kernel 3.18 of 3.19
>
> Wido
>
>> Anyone can help with this?

This is rbd-fuse, not kernel client.  I wanted to take a look, but
haven't had a chance yet.  rbd-fuse probably just doesn't support
trimming.  AFAIR discard requests to a loop device are translated into
hole punches on the underlying file, and rbd-fuse doesn't seem to
provide ->fallocate() callback.  It wouldn't be hard to add though,
I can take a shot at it later.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
