From: huang jun <hjwsm1989@gmail.com>
Subject: Re: use UUID mount btrfs failed
Date: Wed, 12 Oct 2011 16:40:51 +0800
Message-ID: <CABAwU-YKYKORm1gfWQkPeE73SYe_R=-Sg7S3+ZZnusk2miH-Cg@mail.gmail.com>
References: <CABAwU-Z=VJ4DkVANPyw6ogMyLz1CoGxAWcTGEay0QUOodL+Yiw@mail.gmail.com>
	<CAFtEh-dwema2fWTbX_EHsPuPhK56kDiMqe5xEuev86nPCtHZRA@mail.gmail.com>
	<CABAwU-bS7gZscTkDUDTzBetSZ_v1GgQtcr0rH3VTa8Xj3ETTpA@mail.gmail.com>
	<j73j32$6fs$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63155 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab1JLIkw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2011 04:40:52 -0400
Received: by gyb13 with SMTP id 13so452297gyb.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2011 01:40:52 -0700 (PDT)
In-Reply-To: <j73j32$6fs$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

2011/10/12 Thomas Mueller <thomas@chaschperli.ch>:
> On 12.10.2011 10:22, huang jun wrote:
>>
>> 2011/10/12 Damien Churchill<damoxc@gmail.com>:
>>>
>>> On 12 October 2011 02:22, huang jun<hjwsm1989@gmail.com> =A0wrote:
>>>>
>>>> I use the UUID option to mount the btrfs disk,but i can not succes=
s.
>>>> first, the disk is /dev/sdd1
>>>> then, i pull out the disk
>>>> and after mintues, pushed it again,at this time, it changes to /de=
v/sde1
>>>> at this time, if we use /etc/init.d/ceph restart, it will failed, =
for
>>>> the current mount option is likely "/dev/sd** "
>>>> but the UUID didn't change.
>>>> why i can not mount it successfuly?
>>>> BTW, does ceph provides methods to resolve the condition like that=
?
>>>>
>>>> the starce file attached.
>>>>
>>>> thanks!
>>>>
>>>
>>> Hi,
>>>
>>> I switched to use the symlinks created by udev in /dev/disk/by-id/
>>> which contains the hard-disks serial number which will be completel=
y
>>> static, even if a new btrfs filesystem is created. This ensures tha=
t
>>> the same partition on the same disk is always used.
>>>
>>> Regards,
>>> Damien
>>>
>> can you mount successfully by using the /dev/disk/by-id/ =A0instead =
of
>> =A0/dev/sd**?
>> and how to get the hard-disk serial number? I have tried "udevadm in=
fo
>> -a -p $(udevadm info -q path -n $btrfs_devs)", but failed to get it.
>> or you should =A0test the condition like that, pull out the disk fir=
st
>> and then push it in after few minutes.
>>
>> thanks!
>
> for example with smartctl from the smartmontools you can get the s/n.
>
> smartctl -i /dev/sd*
>
> - Thomas
yah,but how can udev know it, and which item should be add in the udev
rules file to match
s/n?
$ udevadm info -a -p /sys/block/sda/sda7
Udevadm info starts with the device specified by the devpath and then
walks up the chain of parent devices. It prints for every device
found, all possible attributes in the udev rules key format.
A rule to match, can be composed by the attributes of the device
and the attributes from one single parent device.

  looking at device '/block/sda/sda7':
    KERNEL=3D=3D"sda7"
    SUBSYSTEM=3D=3D"block"
    DRIVER=3D=3D""
    ATTR{partition}=3D=3D"7"
    ATTR{start}=3D=3D"177903873"
    ATTR{size}=3D=3D"798864192"
    ATTR{alignment_offset}=3D=3D"0"
    ATTR{discard_alignment}=3D=3D"3402497536"
    ATTR{stat}=3D=3D"     432      339     6232     5180   337440     7=
926
40492672  6625648        0   980628  6630664"
    ATTR{inflight}=3D=3D"       0        0"

  looking at parent device '/block/sda':
    KERNELS=3D=3D"sda"
    SUBSYSTEMS=3D=3D"block"
    DRIVERS=3D=3D""
    ATTRS{range}=3D=3D"16"
    ATTRS{ext_range}=3D=3D"256"
    ATTRS{removable}=3D=3D"0"
    ATTRS{ro}=3D=3D"0"
    ATTRS{size}=3D=3D"976773168"
    ATTRS{alignment_offset}=3D=3D"0"
    ATTRS{discard_alignment}=3D=3D"0"
    ATTRS{capability}=3D=3D"50"
    ATTRS{stat}=3D=3D"   59304     9490  2333535   463744   521540
1855677 56765056 22669884        0  1334564 23147264"
    ATTRS{inflight}=3D=3D"       0        0"

thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
