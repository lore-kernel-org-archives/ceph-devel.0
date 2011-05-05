From: huang jun <hjwsm1989@gmail.com>
Subject: Re: How to deal with a single host with several harddisks
Date: Thu, 5 May 2011 22:21:49 +0800
Message-ID: <BANLkTikrrrgjJm3x2WzxjZc97FgmM_H5Hg@mail.gmail.com>
References: <BANLkTi=_sbPhhtmBBXmmFrR5kM6NVTDayg@mail.gmail.com>
	<1304503840.4036.84.camel@wido-laptop.pcextreme.nl>
	<BANLkTi=xLDW0Tc3aXF-a0jrUtGmP7VfuMQ@mail.gmail.com>
	<BANLkTikJQyqvC6MCYFyrV3T5=FZBHFatYQ@mail.gmail.com>
	<1304526943.4036.117.camel@wido-laptop.pcextreme.nl>
	<BANLkTikQk9YgAsuTmDP3fu+5tA41_ChpEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42559 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab1EEOVv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 10:21:51 -0400
Received: by wya21 with SMTP id 21so1651314wya.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2011 07:21:50 -0700 (PDT)
In-Reply-To: <BANLkTikQk9YgAsuTmDP3fu+5tA41_ChpEA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: Wido den Hollander <wido@widodh.nl>, Sylar Shen <kimulaaa@gmail.com>, tsk <aixt2006@gmail.com>, ceph-devel@vger.kernel.org

Hi,all
I also have similar confusions.
I do test the performace of ceph's multi-cosd on the same machine.
run 2 osds  and 4 osds  on the same machine respectively,but the reult
confused me a lot.
there is no much difference between the two tests,and in 4 osds
condition, i use "iostat -d 1 100" ,all disk's write rates adds up to
about 40MB/s,but the ext3 is 130-150MB/s.
I don't know why this accur.
by the way, my fs client,mon and mds are also run on the same machine
togther with osds,does this make any difference?
all answers will be appreciated!
thanks!

2011/5/5 DongJin Lee <dongjin.lee@auckland.ac.nz>:
> Hi,
> I also have various similar questions.
> Anyone done the performance test with
> 1 cosd, 2 cosd, ... N cosd? (one cosd per disk)
> I don't see it scaling linearly, it kind of tails off, so per-disk mb=
/s drops.
> Definitely fewer cosd makes better performance, whether it is due to =
a
> bug or message passing, but again the tradeoff is the potential data
> loss like Wido just said.
> Wido when you mean small boxes with few disks, is it for data loss
> consideration or performance?
>
> With a fast cpu, link, and two boxes with all same spec.
> - first test is run 2 cosd with just a single box
> - second test is run 1cosd each with two box
> So total cosd/disk is the same. The only benefit from two box is the
> ram, which is doubled
>
> What performance do you expect, particularly for random-read?
> If two box config did improve compared to single box, then it must be
> for the ram,
> then why not install that ram into the first box and not use the
> second box, and if this improved even more than the before,
> all we are getting out of is, single machine with the most ram wins.
>
> And how are you benchmarking as you increase the number of disk,
> e.g., if you have 1 cosd/disk and benchmark based on say, 10gb,
> then when you are to benchmark 10 cosd/disks, then shouldn't you be
> benchmarking 100gb to make it fair?
> the same applies to the amount of ram, so when you increase the node
> (ram increase) shouldn't you be testing bigger fileset?
> I've been trying to work this matrix out, and so basically going
> labor-intesive way to do every config one by one.
>
> Thanks all.
>
> On Thu, May 5, 2011 at 4:35 AM, Wido den Hollander <wido@widodh.nl> w=
rote:
>> Hi,
>> On Thu, 2011-05-05 at 00:10 +0800, Sylar Shen wrote:
>>> Hi,
>>> Recently I have encountered a similar situation just like you did.
>>> I got 20 servers as OSD. Each server has 1T * 12 disks, 8 cores CPU
>>> and 16 GB memory.
>>> I've thought that I can set each disk as a cosd or make disks as a =
LVM
>>> and run only one cosd on each server.
>>> Or maybe I can set 2 or 3 LVMs on each server.
>>> Then I wonder the differences between them about performance and fu=
nctionality?
>>> Which way is better for both performance and functionality?
>>
>> Yes, you could make a LVM "stripe" over all the disks with just one =
cosd
>> process. 2 or 3 VG's would also be possible, that's not the problem.
>>
>> This would reduce the memory usage.
>>
>>>
>>> Wido said he recommended running one cosd process per disk because
>>> this way Ceph can take the full advantage of all the available
>>> diskspace
>>> Please forgive my foolishness, I don't quite understand what kind o=
f
>>> full advantages Ceph can take by doing this?
>>> If I use LVM, would there be any possible problems?
>>
>> If you would run 12 disks in one machine, I wouldn't recommend runni=
ng
>> in a stripe setup, if just one disk fails, you would loose 12TB of d=
ata!
>>
>> Sure, you could start up the array again with a fresh disk, but you
>> would then have to resync a lot of data (12TB at max).
>>
>> You could also run RAID-5 over those 12 disks and run one OSD on top=
 of
>> it, but then you would start wasting disk space, since you are alrea=
dy
>> replicating all your data with RADOS/Ceph, why waste space to RAID-5=
?
>>
>> If you would run one OSD per disk you would only loose 1TB of data w=
hen
>> a disk fails, when you replace the disk you'd only have to re-sync 1=
TB
>> of data.
>>
>> That's what I meant about Ceph taking the full advantage of the
>> available disk space when you have one cosd per disk.
>>
>> Also, I wouldn't run 12 disks in one machine, IMHO I would stick to
>> small boxes with 4 ~ 6 disks and have a LOT of them.
>>
>>>
>>> Speaking of disks, I found using btrfs did good performance but bad=
 stability.
>>> While doing performance(read/write speed) test it dropped a lot whe=
n
>>> using ext4, is it normal?
>>
>> btrfs is still under development, so I'd recommend using a recent ke=
rnel
>> like the .38 or upcoming .39
>>
>> Running on ext4 is indeed a bit slower.
>>
>> Wido
>>
>>>
>>> Thanks!
>>>
>>> 2011/5/4 tsk <aixt2006@gmail.com>:
>>> > 2011/5/4 Wido den Hollander <wido@widodh.nl>:
>>> >> Hi,
>>> >>
>>> >> On Wed, 2011-05-04 at 17:37 +0800, tsk wrote:
>>> >>> Hi folks,
>>> >>>
>>> >>>
>>> >>> May I know that, =A0if there is 6 harddisk available for btrfs =
in just a
>>> >>> single host, =A0there should be 6 cosd process in the host when=
 the
>>> >>> disks are all working?
>>> >>
>>> >> Yes, that is the way common way.
>>> >>
>>> >>>
>>> >>> A single cosd process can not manage several disks?
>>> >>>
>>> >>
>>> >> Yes and no. A single cosd process simply wants a mount point. If=
 you
>>> >> look closer, the init script simply mounts the device specified =
by
>>> >> 'btrfs devs' in the configuration.
>>> >>
>>> >> You could run LVM, mdadm or even a btrfs multi-disk volume under=
 a
>>> >> mountpoint, this way you could have on cosd process per disk.
>>> >>
>>> >> I would recommend running one cosd process per disk, it takes a =
bit more
>>> >> memory (about 800M per cosd), but this way Ceph can take the ful=
l
>>> >> advantage of all the available diskspace.
>>> >
>>> >
>>> > 800M or 80M?
>>> > There is 12 disks in my hosts, 1TB each. 10 disks of every host c=
an be
>>> > used for ceph.
>>> > If one cosd per disk, there will be 10 cosd processes, which need=
 a
>>> > lot lot of memory!
>>> >
>>> > I note that new cosd process takes 35M memory, but another cosd w=
hich
>>> > run 5 days takes 112M memory. =A0Hoping there is no memory leak.
>>> >
>>> >
>>> >> If you have multiple hosts I would recommend making a CRUSH map =
which
>>> >> makes sure your data replicas are not stored within the same phy=
sical
>>> >> machine: http://ceph.newdream.net/wiki/Custom_data_placement_wit=
h_CRUSH
>>> >>
>>> >> The newer versions of Ceph will make a basic CRUSH map based on =
the
>>> >> ceph.conf, as far as I know it will prevent saving replicas on t=
he same
>>> >> node. However, I would recommended checking your CRUSH map to ma=
ke sure
>>> >> it does.
>>> >>
>>> >>> How should the ceph.conf be configured for this scenario?
>>> >>
>>> >> For example:
>>> >>
>>> >> [osd.0]
>>> >> =A0 host =3D node01
>>> >> =A0 btrfs devs =3D /dev/sda
>>> >>
>>> >> [osd.1]
>>> >> =A0 host =3D node01
>>> >> =A0 btrfs devs =3D /dev/sdb
>>> >>
>>> >> [osd.2]
>>> >> =A0 host =3D node01
>>> >> =A0 btrfs devs =3D /dev/sdc
>>> >>
>>> >> etc, etc
>>> >>
>>> >> The init script and mkcephfs will then format the specified driv=
es with
>>> >> btrfs and mount it when the OSD starts.
>>> >>
>>> >> I would also recommend running your journal on a separate drive:
>>> >> http://ceph.newdream.net/wiki/Troubleshooting#Performance
>>> >>
>>> >> Wido
>>> >>
>>> >>>
>>> >>>
>>> >>> Thx!
>>> >>> --
>>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>>> >>> the body of a message to majordomo@vger.kernel.org
>>> >>> More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>> >>
>>> >>
>>> >>
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>>> >
>>>
>>>
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
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
