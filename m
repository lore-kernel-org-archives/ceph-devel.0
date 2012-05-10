From: Calvin Morrow <calvin.morrow@gmail.com>
Subject: Re: slow performance even when using SSDs
Date: Thu, 10 May 2012 12:24:16 -0600
Message-ID: <CADxhoDRB1i8Knj97ROKvFgFvh63hD4EW+OT3A6YAY+dYvDZ0hg@mail.gmail.com>
References: <4FABAFE9.5060202@profihost.ag>
	<4FABBE23.4030608@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34711 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab2EJSYR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 14:24:17 -0400
Received: by wgbdr13 with SMTP id dr13so1729949wgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 11:24:16 -0700 (PDT)
In-Reply-To: <4FABBE23.4030608@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

I was getting roughly the same results of your tmpfs test using
spinning disks for OSDs with a 160GB Intel 320 SSD being used for the
journal.  Theoretically the 520 SSD should give better performance
than my 320s.

Keep in mind that even with balance-alb, multiple GigE connections
will only be used if there are multiple TCP sessions being used by
Ceph.

You don't mention it in your email, but if you're using kernel 3.4+
you'll want to make sure your create your btrfs filesystem using the
large node & leaf size (Big Metadata - I've heard recommendations of
32k instead of default 4k) so your performance doesn't degrade over
time.

I'm curious what speed you're getting from dd in a streaming write.
You might try running a "dd if=3D/dev/zero of=3D<intel ssd partition>
bs=3D128k count=3Dsomething" to see what the SSD will spit out without
Ceph in the picture.

Calvin

On Thu, May 10, 2012 at 7:09 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> OK, here some retests. I had the SDDs conected to an old Raid control=
ler
> even i did used them as JBODs (oops).
>
> Here are two new Tests (using kernel 3.4-rc6) it would be great if
> someone could tell me if they're fine or bad.
>
> New tests with all 3 SSDs connected to the mainboard.
>
> #~ rados -p rbd bench 60 write
> Total time run: =A0 =A0 =A0 =A060.342419
> Total writes made: =A0 =A0 2021
> Write size: =A0 =A0 =A0 =A0 =A0 =A04194304
> Bandwidth (MB/sec): =A0 =A0133.969
>
> Average Latency: =A0 =A0 =A0 0.477476
> Max latency: =A0 =A0 =A0 =A0 =A0 0.942029
> Min latency: =A0 =A0 =A0 =A0 =A0 0.109467
>
> #~ rados -p rbd bench 60 write -b 4096
> Total time run: =A0 =A0 =A0 =A060.726326
> Total writes made: =A0 =A0 59026
> Write size: =A0 =A0 =A0 =A0 =A0 =A04096
> Bandwidth (MB/sec): =A0 =A03.797
>
> Average Latency: =A0 =A0 =A0 0.016459
> Max latency: =A0 =A0 =A0 =A0 =A0 0.874841
> Min latency: =A0 =A0 =A0 =A0 =A0 0.002392
>
> Another test with only osd on the disk and the journal in memory / tm=
pfs:
> #~ rados -p rbd bench 60 write
> Total time run: =A0 =A0 =A0 =A060.513240
> Total writes made: =A0 =A0 2555
> Write size: =A0 =A0 =A0 =A0 =A0 =A04194304
> Bandwidth (MB/sec): =A0 =A0168.889
>
> Average Latency: =A0 =A0 =A0 0.378775
> Max latency: =A0 =A0 =A0 =A0 =A0 4.59233
> Min latency: =A0 =A0 =A0 =A0 =A0 0.055179
>
> #~ rados -p rbd bench 60 write -b 4096
> Total time run: =A0 =A0 =A0 =A060.116260
> Total writes made: =A0 =A0 281903
> Write size: =A0 =A0 =A0 =A0 =A0 =A04096
> Bandwidth (MB/sec): =A0 =A018.318
>
> Average Latency: =A0 =A0 =A0 0.00341067
> Max latency: =A0 =A0 =A0 =A0 =A0 0.720486
> Min latency: =A0 =A0 =A0 =A0 =A0 0.000602
>
> Another problem i have is i'm always getting:
> "2012-05-10 15:05:22.140027 mon.0 192.168.0.100:6789/0 19 : [WRN]
> message from mon.2 was stamped 0.109244s in the future, clocks not
> synchronized"
>
> even on all systems ntp is running fine.
>
> Stefan
>
> Am 10.05.2012 14:09, schrieb Stefan Priebe - Profihost AG:
>> Dear List,
>>
>> i'm doing a testsetup with ceph v0.46 and wanted to know how fast ce=
ph is.
>>
>> my testsetup:
>> 3 servers with Intel Xeon X3440, 180GB SSD Intel 520 Series, 4GB RAM=
, 2x
>> 1Gbit/s LAN each
>>
>> All 3 are running as mon a-c and osd 0-2. Two of them are also runni=
ng
>> as mds.2 and mds.3 (has 8GB RAM instead of 4GB).
>>
>> All machines run ceph v0.46 and vanilla Linux Kernel v3.0.30 and all=
 of
>> them use btrfs on the ssd which serves /srv/{osd,mon}.X. All of them=
 use
>> eth0+eth1 as bond0 (mode 6).
>>
>> This gives me:
>> rados -p rbd bench 60 write
>>
>> ...
>> Total time run: =A0 =A0 =A0 =A061.465323
>> Total writes made: =A0 =A0 776
>> Write size: =A0 =A0 =A0 =A0 =A0 =A04194304
>> Bandwidth (MB/sec): =A0 =A050.500
>>
>> Average Latency: =A0 =A0 =A0 1.2654
>> Max latency: =A0 =A0 =A0 =A0 =A0 2.77124
>> Min latency: =A0 =A0 =A0 =A0 =A0 0.170936
>>
>> Shouldn't it be at least 100MB/s? (1Gbit/s / 8)
>>
>> And rados -p rbd bench 60 write -b 4096 gives pretty bad results:
>> Total time run: =A0 =A0 =A0 =A060.221130
>> Total writes made: =A0 =A0 6401
>> Write size: =A0 =A0 =A0 =A0 =A0 =A04096
>> Bandwidth (MB/sec): =A0 =A00.415
>>
>> Average Latency: =A0 =A0 =A0 0.150525
>> Max latency: =A0 =A0 =A0 =A0 =A0 1.12647
>> Min latency: =A0 =A0 =A0 =A0 =A0 0.026599
>>
>> All btrfs ssds are also mounted with noatime.
>>
>> Thanks for your help!
>>
>> Greets Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
