From: Sylar Shen <kimulaaa@gmail.com>
Subject: Re: How to deal with a single host with several harddisks
Date: Thu, 5 May 2011 00:10:54 +0800
Message-ID: <BANLkTikJQyqvC6MCYFyrV3T5=FZBHFatYQ@mail.gmail.com>
References: <BANLkTi=_sbPhhtmBBXmmFrR5kM6NVTDayg@mail.gmail.com>
	<1304503840.4036.84.camel@wido-laptop.pcextreme.nl>
	<BANLkTi=xLDW0Tc3aXF-a0jrUtGmP7VfuMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55473 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1EDQLG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 12:11:06 -0400
Received: by bwz15 with SMTP id 15so1107800bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 May 2011 09:11:04 -0700 (PDT)
In-Reply-To: <BANLkTi=xLDW0Tc3aXF-a0jrUtGmP7VfuMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Hi,
Recently I have encountered a similar situation just like you did.
I got 20 servers as OSD. Each server has 1T * 12 disks, 8 cores CPU
and 16 GB memory.
I've thought that I can set each disk as a cosd or make disks as a LVM
and run only one cosd on each server.
Or maybe I can set 2 or 3 LVMs on each server.
Then I wonder the differences between them about performance and functi=
onality?
Which way is better for both performance and functionality?

Wido said he recommended running one cosd process per disk because
this way Ceph can take the full advantage of all the available
diskspace
Please forgive my foolishness, I don't quite understand what kind of
full advantages Ceph can take by doing this?
If I use LVM, would there be any possible problems?

Speaking of disks, I found using btrfs did good performance but bad sta=
bility.
While doing performance(read/write speed) test it dropped a lot when
using ext4, is it normal?

Thanks!

2011/5/4 tsk <aixt2006@gmail.com>:
> 2011/5/4 Wido den Hollander <wido@widodh.nl>:
>> Hi,
>>
>> On Wed, 2011-05-04 at 17:37 +0800, tsk wrote:
>>> Hi folks,
>>>
>>>
>>> May I know that, =C2=A0if there is 6 harddisk available for btrfs i=
n just a
>>> single host, =C2=A0there should be 6 cosd process in the host when =
the
>>> disks are all working?
>>
>> Yes, that is the way common way.
>>
>>>
>>> A single cosd process can not manage several disks?
>>>
>>
>> Yes and no. A single cosd process simply wants a mount point. If you
>> look closer, the init script simply mounts the device specified by
>> 'btrfs devs' in the configuration.
>>
>> You could run LVM, mdadm or even a btrfs multi-disk volume under a
>> mountpoint, this way you could have on cosd process per disk.
>>
>> I would recommend running one cosd process per disk, it takes a bit =
more
>> memory (about 800M per cosd), but this way Ceph can take the full
>> advantage of all the available diskspace.
>
>
> 800M or 80M?
> There is 12 disks in my hosts, 1TB each. 10 disks of every host can b=
e
> used for ceph.
> If one cosd per disk, there will be 10 cosd processes, which need a
> lot lot of memory!
>
> I note that new cosd process takes 35M memory, but another cosd which
> run 5 days takes 112M memory. =C2=A0Hoping there is no memory leak.
>
>
>> If you have multiple hosts I would recommend making a CRUSH map whic=
h
>> makes sure your data replicas are not stored within the same physica=
l
>> machine: http://ceph.newdream.net/wiki/Custom_data_placement_with_CR=
USH
>>
>> The newer versions of Ceph will make a basic CRUSH map based on the
>> ceph.conf, as far as I know it will prevent saving replicas on the s=
ame
>> node. However, I would recommended checking your CRUSH map to make s=
ure
>> it does.
>>
>>> How should the ceph.conf be configured for this scenario?
>>
>> For example:
>>
>> [osd.0]
>> =C2=A0 host =3D node01
>> =C2=A0 btrfs devs =3D /dev/sda
>>
>> [osd.1]
>> =C2=A0 host =3D node01
>> =C2=A0 btrfs devs =3D /dev/sdb
>>
>> [osd.2]
>> =C2=A0 host =3D node01
>> =C2=A0 btrfs devs =3D /dev/sdc
>>
>> etc, etc
>>
>> The init script and mkcephfs will then format the specified drives w=
ith
>> btrfs and mount it when the OSD starts.
>>
>> I would also recommend running your journal on a separate drive:
>> http://ceph.newdream.net/wiki/Troubleshooting#Performance
>>
>> Wido
>>
>>>
>>>
>>> Thx!
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Best Regards,
Sylar Shen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
