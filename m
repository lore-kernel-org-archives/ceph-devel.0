From: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Subject: Re: Don't understand why space usage keeps growing
Date: Tue, 14 Jun 2011 20:25:08 +0200
Message-ID: <BANLkTik_c6F+UvHoETfFxsoONbNiSW1X0w@mail.gmail.com>
References: <BANLkTiny=PO5eq=ok_ad6T94YfAK-Tk=CA@mail.gmail.com>
	<F635901F-428A-4CE4-B478-085234F80281@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55878 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab1FNSZL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2011 14:25:11 -0400
Received: by iyb14 with SMTP id 14so4896494iyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jun 2011 11:25:10 -0700 (PDT)
In-Reply-To: <F635901F-428A-4CE4-B478-085234F80281@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi Greg,

Thank you for your answer. Yes, I'm sure that nothing else is writing
on the mount point but you are right for the bench, I also used this
rados bench : rados bench 30 write -p data in order to test the write
speed.

So I think I have the suspect ! :)
Can I clean it with a special command ?

Regards,
Wilfrid

2011/6/14 Gregory Farnum <gregory.farnum@dreamhost.com>:
> On Jun 11, 2011, at 4:24 PM, Wilfrid Allembrand wrote:
>
>> Hi,
>>
>> So I have my small test cluster with 2 OSD nodes. In each OSD node,
>> there is one disk (5 GB) and one cosd.
>> When I mount the FS on a client, I see it's 10 GB in total. Fine.
>> I copied a small set of multimedia files (135 MB) and that's all. So
>> why do I see the space used is getting higher and higher ?
>>
>> root@client:/mnt/osd$ df -h .
>> Filesystem =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used Avail Use% Mounted on
>> 10.1.56.232:6789:/ =A0 =A0 10G =A05.2G =A03.9G =A057% /mnt/osd
>>
>> and like 2 hours later :
>>
>> root@client:/mnt/osd$ df -h .
>> Filesystem =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used Avail Use% Mounted on
>> 10.1.56.232:6789:/ =A0 =A0 10G =A06.8G =A02.3G =A076% /mnt/osd
>>
>>
>> I'm using btrfs to store the files and I made no creation/modificati=
on
>> of files; i just run some bench with "ceph osd tell [12] bench"
>> Does the bench create files and do note delete them ?
> The OSD bench that you're invoking definitely does delete files. You =
shouldn't be seeing large growth like that with your ceph.conf, though.
>
> Are you sure there's nothing else accessing your mount and doing writ=
es to it? What I'd expect to see from 135MB of writes is ~570MB used (1=
35MB written on each OSD, for the replication, doubled because you've g=
ot a 512MB journal recording the data too; and then plus a little bit e=
xtra for the MDS journaling and data).
>
> You're not using the rados bench, are you? That one doesn't clean up =
after itself.
>
>
>>
>> Extract of ceph -w :
>> root@test2:/data/mon1# ceph -w
>> 2011-06-11 19:16:09.186416 7fbefd01e700 -- :/14931 >>
>> 10.1.56.233:6789/0 pipe(0x1e58540 sd=3D4 pgs=3D0 cs=3D0 l=3D0).fault=
 first
>> fault
>> 2011-06-11 19:16:12.191439 =A0 =A0pg v1990: 594 pgs: 594 active+clea=
n;
>> 2066 MB data, 6906 MB used, 2286 MB / 10240 MB avail
>> 2011-06-11 19:16:12.193479 =A0 mds e48: 1/1/1 up {0=3Dtest4=3Dup:act=
ive}, 1 up:standby
>> 2011-06-11 19:16:12.193551 =A0 osd e44: 2 osds: 2 up, 2 in
>> 2011-06-11 19:16:12.193658 =A0 log 2011-06-12 00:55:42.389017 osd2
>> 10.1.56.237:6800/1744 307 : [INF] bench: wrote 1024 MB in blocks of
>> 4096 KB in 12.438478 sec at 84300 KB/sec
>> 2011-06-11 19:16:12.193757 =A0 mon e1: 3 mons at
>> {0=3D10.1.56.231:6789/0,1=3D10.1.56.232:6789/0,2=3D10.1.56.233:6789/=
0}
>>
>>
>> Attached is my ceph.conf
>>
>> Thanks !
>> Wilfrid
>> <ceph.conf>
>
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
