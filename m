From: Damien Churchill <damoxc@gmail.com>
Subject: Re: use UUID mount btrfs failed
Date: Wed, 12 Oct 2011 09:38:51 +0100
Message-ID: <CAFtEh-dV==S71J0bf9yLgzp2MCyaOLwUNe8-csUYTinGucUutQ@mail.gmail.com>
References: <CABAwU-Z=VJ4DkVANPyw6ogMyLz1CoGxAWcTGEay0QUOodL+Yiw@mail.gmail.com>
	<CAFtEh-dwema2fWTbX_EHsPuPhK56kDiMqe5xEuev86nPCtHZRA@mail.gmail.com>
	<CABAwU-bS7gZscTkDUDTzBetSZ_v1GgQtcr0rH3VTa8Xj3ETTpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35526 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab1JLIiv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2011 04:38:51 -0400
Received: by pzk1 with SMTP id 1so1060034pzk.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2011 01:38:51 -0700 (PDT)
In-Reply-To: <CABAwU-bS7gZscTkDUDTzBetSZ_v1GgQtcr0rH3VTa8Xj3ETTpA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 12 October 2011 09:22, huang jun <hjwsm1989@gmail.com> wrote:
> 2011/10/12 Damien Churchill <damoxc@gmail.com>:
>> On 12 October 2011 02:22, huang jun <hjwsm1989@gmail.com> wrote:
>>> I use the UUID option to mount the btrfs disk,but i can not success=
=2E
>>> first, the disk is /dev/sdd1
>>> then, i pull out the disk
>>> and after mintues, pushed it again,at this time, it changes to /dev=
/sde1
>>> at this time, if we use /etc/init.d/ceph restart, it will failed, f=
or
>>> the current mount option is likely "/dev/sd** "
>>> but the UUID didn't change.
>>> why i can not mount it successfuly?
>>> BTW, does ceph provides methods to resolve the condition like that?
>>>
>>> the starce file attached.
>>>
>>> thanks!
>>>
>>
>> Hi,
>>
>> I switched to use the symlinks created by udev in /dev/disk/by-id/
>> which contains the hard-disks serial number which will be completely
>> static, even if a new btrfs filesystem is created. This ensures that
>> the same partition on the same disk is always used.
>>
>> Regards,
>> Damien
>>
> can you mount successfully by using the /dev/disk/by-id/ =C2=A0instea=
d of =C2=A0/dev/sd**?
> and how to get the hard-disk serial number? I have tried "udevadm inf=
o
> -a -p $(udevadm info -q path -n $btrfs_devs)", but failed to get it.
> or you should =C2=A0test the condition like that, pull out the disk f=
irst
> and then push it in after few minutes.
>

It's as simple as "ls -l /dev/disk/by-id". They point to the /dev/sd*
devices so just pick the correct one, at least that's how I did it.

Damien
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
