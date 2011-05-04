From: tsk <aixt2006@gmail.com>
Subject: Re: How to deal with a single host with several harddisks
Date: Wed, 4 May 2011 19:31:40 +0800
Message-ID: <BANLkTi=xLDW0Tc3aXF-a0jrUtGmP7VfuMQ@mail.gmail.com>
References: <BANLkTi=_sbPhhtmBBXmmFrR5kM6NVTDayg@mail.gmail.com>
	<1304503840.4036.84.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59648 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab1EDLbm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 07:31:42 -0400
Received: by wwa36 with SMTP id 36so1107964wwa.1
        for <ceph-devel@vger.kernel.org>; Wed, 04 May 2011 04:31:40 -0700 (PDT)
In-Reply-To: <1304503840.4036.84.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

2011/5/4 Wido den Hollander <wido@widodh.nl>:
> Hi,
>
> On Wed, 2011-05-04 at 17:37 +0800, tsk wrote:
>> Hi folks,
>>
>>
>> May I know that, =C2=A0if there is 6 harddisk available for btrfs in=
 just a
>> single host, =C2=A0there should be 6 cosd process in the host when t=
he
>> disks are all working?
>
> Yes, that is the way common way.
>
>>
>> A single cosd process can not manage several disks?
>>
>
> Yes and no. A single cosd process simply wants a mount point. If you
> look closer, the init script simply mounts the device specified by
> 'btrfs devs' in the configuration.
>
> You could run LVM, mdadm or even a btrfs multi-disk volume under a
> mountpoint, this way you could have on cosd process per disk.
>
> I would recommend running one cosd process per disk, it takes a bit m=
ore
> memory (about 800M per cosd), but this way Ceph can take the full
> advantage of all the available diskspace.


800M or 80M?
There is 12 disks in my hosts, 1TB each. 10 disks of every host can be
used for ceph.
If one cosd per disk, there will be 10 cosd processes, which need a
lot lot of memory!

I note that new cosd process takes 35M memory, but another cosd which
run 5 days takes 112M memory.  Hoping there is no memory leak.


> If you have multiple hosts I would recommend making a CRUSH map which
> makes sure your data replicas are not stored within the same physical
> machine: http://ceph.newdream.net/wiki/Custom_data_placement_with_CRU=
SH
>
> The newer versions of Ceph will make a basic CRUSH map based on the
> ceph.conf, as far as I know it will prevent saving replicas on the sa=
me
> node. However, I would recommended checking your CRUSH map to make su=
re
> it does.
>
>> How should the ceph.conf be configured for this scenario?
>
> For example:
>
> [osd.0]
> =C2=A0 host =3D node01
> =C2=A0 btrfs devs =3D /dev/sda
>
> [osd.1]
> =C2=A0 host =3D node01
> =C2=A0 btrfs devs =3D /dev/sdb
>
> [osd.2]
> =C2=A0 host =3D node01
> =C2=A0 btrfs devs =3D /dev/sdc
>
> etc, etc
>
> The init script and mkcephfs will then format the specified drives wi=
th
> btrfs and mount it when the OSD starts.
>
> I would also recommend running your journal on a separate drive:
> http://ceph.newdream.net/wiki/Troubleshooting#Performance
>
> Wido
>
>>
>>
>> Thx!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
