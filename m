From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: [ceph-users] Ceph write performance and my Dell R515's
Date: Sun, 22 Sep 2013 07:40:24 -0500
Message-ID: <523EE538.3020101@inktank.com>
References: <cb37eba1f3b24d5190cc6195c5ab8ad7@onqbne-ex01.onq.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34198 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab3IVMkd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Sep 2013 08:40:33 -0400
Received: by mail-ie0-f176.google.com with SMTP id as1so4407182iec.21
        for <ceph-devel@vger.kernel.org>; Sun, 22 Sep 2013 05:40:32 -0700 (PDT)
In-Reply-To: <cb37eba1f3b24d5190cc6195c5ab8ad7@onqbne-ex01.onq.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/22/2013 03:12 AM, Quenten Grasso wrote:
>
> Hi All,
>
> I=92m finding my write performance is less than I would have expected=
=2E=20
> After spending some considerable amount of time testing several=20
> different configurations I can never seems to break over ~360mb/s=20
> write even when using tmpfs for journaling.
>
> So I=92ve purchased 3x Dell R515=92s with 1 x AMD 6C CPU with 12 x 3T=
B SAS=20
> & 2 x 100GB Intel DC S3700 SSD=92s & 32GB Ram with the Perc H710p Rai=
d=20
> controller and Dual Port 10GBE Network Cards.
>
> So first up I realise the SSD=92s were a mistake, I should have bough=
t=20
> the 200GB Ones as they have considerably better write though put of=20
> ~375 Mb/s vs 200 Mb/s
>
> So to our Nodes Configuration,
>
> 2 x 3TB disks in Raid1 for OS/MON & 1 partition for OSD, 12 Disks in =
a=20
> Single each in a Raid0 (like a JBOD Fashion) with a 1MB Stripe size,
>
> (Stripe size this part was particularly important because I found the=
=20
> stripe size matters considerably even on a single disk raid0. contrar=
y=20
> to what you might read on the internet)
>
> Also each disk is configured with (write back cache) is enabled and=20
> (read head) disabled.
>
> For Networking, All nodes are connected via LACP bond with L3 hashing=
=20
> and using iperf I can get up to 16gbit/s tx and rx between the nodes.
>
> OS: Ubuntu 12.04.3 LTS w/ Kernel 3.10.12-031012-generic (had to=20
> upgrade kernel due to 10Gbit Intel NIC=92s driver issues)
>
> So this gives me 11 OSD=92s & 2 SSD=92s Per Node.
>

I'm a bit leery about that 1 OSD on the RAID1. It may be fine, but you=20
definitely will want to do some investigation to make sure that OSD=20
isn't holding the other ones back. iostat or collectl might be useful,=20
along with the ceph osd admin socket and the dump_ops_in_flight and=20
dump_historic_ops commands.

> Next I=92ve tried several different configurations which I=92ll brief=
ly=20
> describe 2 of which below,
>
> 1)Cluster Configuration 1,
>
> 33 OSD=92s with 6x SSD=92s as Journals, w/ 15GB Journals on SSD.
>
> # ceph osd pool create benchmark1 1800 1800
>
> # rados bench -p benchmark1 180 write --no-cleanup
>
> --------------------------------------------------
>
> Maintaining 16 concurrent writes of 4194304 bytes for up to 180=20
> seconds or 0 objects
>
> Total time run: 180.250417
>
> Total writes made: 10152
>
> Write size: 4194304
>
> Bandwidth (MB/sec): 225.287
>
> Stddev Bandwidth: 35.0897
>
> Max bandwidth (MB/sec): 312
>
> Min bandwidth (MB/sec): 0
>
> Average Latency: 0.284054
>
> Stddev Latency: 0.199075
>
> Max latency: 1.46791
>
> Min latency: 0.038512
>
> --------------------------------------------------
>

What was your pool replication set to?

> # rados bench -p benchmark1 180 seq
>
> -------------------------------------------------
>
> Total time run: 43.782554
>
> Total reads made: 10120
>
> Read size: 4194304
>
> Bandwidth (MB/sec): 924.569
>
> Average Latency: 0.0691903
>
> Max latency: 0.262542
>
> Min latency: 0.015756
>
> -------------------------------------------------
>
> In this configuration I found my write performance suffers a lot to=20
> the SSD=92s seem to be a bottleneck and my write performance using ra=
dos=20
> bench was around 224-230mb/s
>
> 2)Cluster Configuration 2,
>
> 33 OSD=92s with 1Gbyte Journals on tmpfs.
>
> # ceph osd pool create benchmark1 1800 1800
>
> # rados bench -p benchmark1 180 write --no-cleanup
>
> --------------------------------------------------
>
> Maintaining 16 concurrent writes of 4194304 bytes for up to 180=20
> seconds or 0 objects
>
> Total time run: 180.044669
>
> Total writes made: 15328
>
> Write size: 4194304
>
> Bandwidth (MB/sec): 340.538
>
> Stddev Bandwidth: 26.6096
>
> Max bandwidth (MB/sec): 380
>
> Min bandwidth (MB/sec): 0
>
> Average Latency: 0.187916
>
> Stddev Latency: 0.0102989
>
> Max latency: 0.336581
>
> Min latency: 0.034475
>
> --------------------------------------------------
>

Definitely low, especially with journals on tmpfs. :( How are the CPUs=20
doing at this point? We have some R515s in our lab, and they definitely=
=20
are slow too. Ours have 7 OSD disks and 1 Dell branded SSD (usually=20
unused) each and can do about ~150MB/s writes per system. It's actually=
=20
a puzzle we've been trying to solve for quite some time.

Some thoughts:

Could the expander backplane be having issues due to having to tunnel=20
STP for the SATA SSDs (or potentially be causing expander wide resets)?=
=20
Could the H700 (and apparently H710) be doing something unusual that th=
e=20
stock LSI firmware handles better? We replaced the H700 with an Areca=20
1880 and definitely saw changes in performance (better large IO=20
throughput and worse IOPS), but the performance was still much lower=20
than in a supermicro node with no expanders in the backplane using=20
either an LSI 2208 or Areca 1880.

Things you might want to try:

- single node tests, and if you have an alternate controller you can=20
try, seeing if that works better.
- removing the S3700s from the chassis entirely and retry the tmpfs=20
journal tests.
- Since the H710 is SAS2208 based, you may be able to use megacli to se=
t=20
it into JBOD mode and see if that works any better (it may if you are=20
using SSD or tmpfs backed journals).

MegaCli -AdpSetProp -EnableJBOD -val -aN|-a0,1,2|-aALL
MegaCli -PDMakeJBOD -PhysDrv[E0:S0,E1:S1,...] -aN|-a0,1,2|-aALL

> # rados bench -p benchmark1 180 seq
>
> -------------------------------------------------
>
> Total time run: 76.481303
>
> Total reads made: 15328
>
> Read size: 4194304
>
> Bandwidth (MB/sec): 801.660
>
> Average Latency: 0.079814
>
> Max latency: 0.317827
>
> Min latency: 0.016857
>
> -------------------------------------------------
>
> Now it seems there is no bottleneck for journaling as we are using=20
> tmpfs, however still less then what I would expect write speed the sa=
s=20
> disks are barely busy via iostat..
>
> So I thought it might be a disk bus throughput issue.
>
> Next I completed some dd tests=85
>
> This below is in a script dd-x.sh which executes the 11 readers or=20
> writers at once.
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.0/ddfile bs=3D32k count=3D100k o=
flag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.1/ddfile bs=3D32k count=3D100k o=
flag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.2/ddfile bs=3D32k count=3D100k o=
flag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.3/ddfile bs=3D32k count=3D100k o=
flag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.4/ddfile bs=3D32k count=3D100k o=
flag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.5/ddfile bs=3D32k count=3D100k o=
flag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.6/ddfile bs=3D32k count=3D100k o=
flag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.7/ddfile bs=3D32k count=3D100k o=
flag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.8/ddfile bs=3D32k count=3D100k o=
flag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.9/ddfile bs=3D32k count=3D100k o=
flag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.10/ddfile bs=3D32k count=3D100k=20
> oflag=3Ddirect &
>
> this gives me aggregated write throughput of around 1,135 MB/s Write.
>
> Simular script now to test reads,
>
> dd if=3D/srv/ceph/osd.0/ddfile of=3D/dev/null bs=3D32k count=3D100k i=
flag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.1/ddfile of=3D/dev/null bs=3D32k count=3D100k i=
flag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.2/ddfile of=3D/dev/null bs=3D32k count=3D100k i=
flag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.3/ddfile of=3D/dev/null bs=3D32k count=3D100k i=
flag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.4/ddfile of=3D/dev/null bs=3D32k count=3D100k i=
flag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.5/ddfile of=3D/dev/null bs=3D32k count=3D100k i=
flag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.6/ddfile of=3D/dev/null bs=3D32k count=3D100k i=
flag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.7/ddfile of=3D/dev/null bs=3D32k count=3D100k i=
flag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.8/ddfile of=3D/dev/null bs=3D32k count=3D100k i=
flag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.9/ddfile of=3D/dev/null bs=3D32k count=3D100k i=
flag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.10/ddfile of=3D/dev/null bs=3D32k count=3D100k=20
> iflag=3Ddirect &
>
> this gives me aggregated read throughput of around 1,382 MB/s Read.
>
> Next I=92ll lower the block size to show the results,
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.0/ddfile bs=3D4k count=3D100k of=
lag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.1/ddfile bs=3D4k count=3D100k of=
lag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.2/ddfile bs=3D4k count=3D100k of=
lag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.3/ddfile bs=3D4k count=3D100k of=
lag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.4/ddfile bs=3D4k count=3D100k of=
lag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.5/ddfile bs=3D4k count=3D100k of=
lag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.6/ddfile bs=3D4k count=3D100k of=
lag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.7/ddfile bs=3D4k count=3D100k of=
lag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.8/ddfile bs=3D4k count=3D100k of=
lag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.9/ddfile bs=3D4k count=3D100k of=
lag=3Ddirect &
>
> dd if=3D/dev/zero of=3D/srv/ceph/osd.10/ddfile bs=3D4k count=3D100k o=
flag=3Ddirect &
>
> this gives me aggregated write throughput of around 300 MB/s Write.
>
> dd if=3D/srv/ceph/osd.0/ddfile of=3D/dev/null bs=3D4k count=3D100k if=
lag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.1/ddfile of=3D/dev/null bs=3D4k count=3D100k if=
lag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.2/ddfile of=3D/dev/null bs=3D4k count=3D100k if=
lag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.3/ddfile of=3D/dev/null bs=3D4k count=3D100k if=
lag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.4/ddfile of=3D/dev/null bs=3D4k count=3D100k if=
lag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.5/ddfile of=3D/dev/null bs=3D4k count=3D100k if=
lag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.6/ddfile of=3D/dev/null bs=3D4k count=3D100k if=
lag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.7/ddfile of=3D/dev/null bs=3D4k count=3D100k if=
lag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.8/ddfile of=3D/dev/null bs=3D4k count=3D100k if=
lag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.9/ddfile of=3D/dev/null bs=3D4k count=3D100k if=
lag=3Ddirect &
>
> dd if=3D/srv/ceph/osd.10/ddfile of=3D/dev/null bs=3D4k count=3D100k i=
flag=3Ddirect &
>
> this gives me aggregated read throughput of around 430 MB/s Read,
>
> This is my ceph.conf, only difference between the configs is the=20
> journal dio =3D false
>
> ----------------
>
> [global]
>
> auth cluster required =3D cephx
>
> auth service required =3D cephx
>
> auth client required =3D cephx
>
> public network =3D 10.100.96.0/24
>
> cluster network =3D 10.100.128.0/24
>
> journal dio =3D false
>
> [mon]
>
> mon data =3D /var/ceph/mon.$id
>
> [mon.a]
>
> host =3D rbd01
>
> mon addr =3D 10.100.96.10:6789
>
> [mon.b]
>
> host =3D rbd02
>
> mon addr =3D 10.100.96.11:6789
>
> [mon.c]
>
> host =3D rbd03
>
> mon addr =3D 10.100.96.12:6789
>
> [osd]
>
> osd data =3D /srv/ceph/osd.$id
>
> osd journal size =3D 1000
>
> osd mkfs type =3D xfs
>
> osd mkfs options xfs =3D "-f"
>
> osd mount options xfs =3D=20
> "rw,noexec,nodev,noatime,nodiratime,barrier=3D0,inode64,logbufs=3D8,l=
ogbsize=3D256k"
>
> [osd.0]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sda5
>
> [osd.1]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdb2
>
> [osd.2]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdc2
>
> [osd.3]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdd2
>
> [osd.4]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sde2
>
> [osd.5]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdf2
>
> [osd.6]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdg2
>
> [osd.7]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdh2
>
> [osd.8]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdi2
>
> [osd.9]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdj2
>
> [osd.10]
>
> host =3D rbd01
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdk2
>
> [osd.11]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sda5
>
> [osd.12]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdb2
>
> [osd.13]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdc2
>
> [osd.14]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdd2
>
> [osd.15]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sde2
>
> [osd.16]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdf2
>
> [osd.17]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdg2
>
> [osd.18]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdh2
>
> [osd.19]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdi2
>
> [osd.20]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdj2
>
> [osd.21]
>
> host =3D rbd02
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdk2
>
> [osd.22]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sda5
>
> [osd.23]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdb2
>
> [osd.24]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdc2
>
> [osd.25]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdd2
>
> [osd.26]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sde2
>
> [osd.27]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdf2
>
> [osd.28]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdg2
>
> [osd.29]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdh2
>
> [osd.30]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdi2
>
> [osd.31]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdj2
>
> [osd.32]
>
> host =3D rbd03
>
> osd journal =3D /tmp/tmpfs/osd.$id
>
> devs =3D /dev/sdk2
>
> ---------------------
>
> Any Ideas?
>
> Cheers,
>
> Quenten
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
