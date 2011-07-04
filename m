From: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Subject: Re: Servers with 40+ disks : to group or not to group ?
Date: Mon, 4 Jul 2011 21:19:01 +0200
Message-ID: <CAJ_6VAd_rP0AvRmj6D93+R0jXLzbw5YFzmDU+0J0DdM_A_YoUA@mail.gmail.com>
References: <CAJ_6VAejmSA+c61Q5Uj0NNJcTZs0vS=k7VQcEG_VPdD5W4bu5Q@mail.gmail.com>
	<1309801611.2518.9.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61351 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab1GDTTD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 15:19:03 -0400
Received: by gyh3 with SMTP id 3so2030009gyh.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2011 12:19:01 -0700 (PDT)
In-Reply-To: <1309801611.2518.9.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hi, thanks Wido for your answers.

2011/7/4 Wido den Hollander <wido@widodh.nl>:
> Hi,
>
> On Sat, 2011-07-02 at 15:30 +0200, Wilfrid Allembrand wrote:
>> Hi everyone,
>>
>> I'm trying to figure out what is the best OSD solution with an
>> infrastructure made up of servers with a lot a disks in each. Say, f=
or
>> exemple you have 4+ nodes like Sun Fire X4500 (code-named Thumper).
>> Each node is 48 disks.
>>
>> What are the pros and cons to build a ceph cluster with btrfs on tha=
t
>> kind of high density hardware, considering the different scenarios f=
or
>> each server :
>> - 1 OSD daemon per disk, so 48 osd daemons per server
>
> That would be the best option in terms of available storage, you woul=
d
> get the maximum available storage, but you would need a LOT of RAM an=
d
> CPU power.
>
> I'm running 10 nodes with 4 OSD's each on Atoms with 4GB of RAM, that=
 is
> pretty heavy for those machines, especially when you start to have a =
lot
> of PGs (Placement Groups) and objects. Recovery then start to take a =
lot
> of time and memory.

Yes, I think I'll give it a try with RAM between 24 and 48G per
server. But how about CPU ? I guess a mobo with 2 sockets should be
enough (let's say with 2 or cores per socket).


>> - make 3 btrfs pools of 16 disks, so 3 osd daemons per server
>> - make 3 raid 5 or 6 volumes, so 3 osd daemons per server
>
> You could try making btrfs pools of 12 or 16 disks, whatever you like=
,
> but you would then add a SPoF, if for some reason btrfs fails (bugs o=
r
> so) you could loose a lot of data, recovering that could saturate the
> rest of your cluster.
>
> Using software RAID is a second option, but still, adding even an ext=
ra
> layer?
>
> Running less OSD's would mean less memory overhead, but if it really
> matters? I'm not sure. The more data and PGs you start to add, the mo=
re
> it will start to stress your OSDs.
>
> The number of PGs is influenced by the number of OSDs, so running les=
s
> OSDs means less PGs, but how much of a difference it makes? Not sure.
>
>
>>
>> From a performance and management point of view, will you recommand =
a
>> lot of small servers of a few numbers of thumper's like servers ?
>
> >From what I know, get a lot of small machines with lets say 4 to 8
> disks. If one fails the impact on the cluster will be much smaller an=
d
> recovery will take less time.
>
> Think about it, you have 3 "thumpers" with each 48TB of storage and o=
ne
> fails, that is going to be a heavy recovery.

But as the data will be replicated to another node, we can run the
recovery in background, isn't it ? Does the recovery occurs when we
replace the failed node with a new valid one or does it occur on the
"surviving nodes of the cluster" immediatly after the failure ?
Perhaps we could be able to set the recovery/smartfail process with a
priority (low/normal/high) and thus controlling the CPU+IO impact ?

> Wido
>
>>
>> All the best,
>> Wilfrid
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
