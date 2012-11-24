From: Gregory Farnum <greg@inktank.com>
Subject: Re: RBD fio Performance concerns
Date: Sat, 24 Nov 2012 08:59:40 -0800
Message-ID: <C3AAB7A082E24E9A91242D15EA1D6894@inktank.com>
References: <CAOLwVUmJGZNaZsySsw8eQmLy1ZCha+AAGCp-5i42=mr0aKHMyA@mail.gmail.com>
 <3210b770-431e-44ed-8d86-4610de89dd92@mailpro>
 <CAOLwVUn5EAC4QaWgU+TkodcJea7ayKUANUpfzWUG+cTBunao5g@mail.gmail.com>
 <50ACF8C8.7020908@inktank.com> <50AD02AC.60802@inktank.com>
 <CAOLwVUmkPsPEC12VhWYz2TgH9-uaV-D7MbeQhXEmW7-pKuZ0NA@mail.gmail.com>
 <6F3FA899187F0043BA1827A69DA2F7CC5C7C9A@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64249 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab2KXQ7n convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 11:59:43 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7102739pbc.19
        for <ceph-devel@vger.kernel.org>; Sat, 24 Nov 2012 08:59:43 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5C7C9A@SHSMSX102.ccr.corp.intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Chen=2C_Xiaoxi?= <xiaoxi.chen@intel.com>
Cc: =?utf-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>

On Friday, November 23, 2012 at 5:36 AM, Chen, Xiaoxi wrote:
> Hi Han,
> I have a cluster with 8 nodes(each node with 1 SSD as journal and 3 7=
200 rpm sata disk as data disk), each OSD consist of 1 sata disk togeth=
er with one 30G partition from the SSD.So in total I have 24 OSDs.
> My test method is start 24VMs and 24 RBD volumes, make the VM and vol=
ume 1:1 paired. Then Aiostress is used as test tools.
> In total, I will get ~1000 IOPS for sequential 4K write for each volu=
me and ~60 IOPS for random 4K write. =20
> But there still some strange things on my cluster which I cannot expl=
ain the reason,if I clean the pagecache on ceph clusters BEFORE the tes=
t, performance drops to half. I don=C3=A2=E2=82=AC=E2=84=A2t understand=
 why old pagecache has any connect with write performance
> Xiaoxi

That's because when you dump out the page cache you're clearing out all=
 of the OSD's data directory inodes from cache, so it needs to do a bun=
ch of random IO disk hops to read them in, but normally they'd be in-me=
mory since there aren't that many of them and they're accessed pretty f=
requently. ;)
-Greg

 =20
> =20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of S=C3=83=C2=A9bastien Han
> Sent: 2012=C3=A5=C2=B9=C2=B411=C3=A6=C5=93=CB=8622=C3=A6=E2=80=94=C2=A5=
 5:47
> To: Mark Nelson
> Cc: Alexandre DERUMIER; ceph-devel; Mark Kampe
> Subject: Re: RBD fio Performance concerns
> =20
> Hi Mark,
> =20
> Well the most concerning thing is that I have 2 Ceph clusters and bot=
h of them show better rand than seq...
> I don't have enough background to argue on your assomptions but I cou=
ld try to skrink my test platform to a single OSD and how it performs. =
We keep in touch on that one.
> =20
> But it seems that Alexandre and I have the same results (more rand th=
an seq), he has (at least) one cluster and I have 2. Thus I start to th=
ink that's not an isolated issue.
> =20
> Is it different for you? Do you usually get more seq IOPS from an RBD=
 thant rand?
> =20
> =20
> On Wed, Nov 21, 2012 at 5:34 PM, Mark Nelson <mark.nelson@inktank.com=
 (mailto:mark.nelson@inktank.com)> wrote:
> > Responding to my own message. :)
> > =20
> > Talked to Sage a bit offline about this. I think there are two =20
> > opposing
> > forces:
> > =20
> > On one hand, random IO may be spreading reads/writes out across mor=
e =20
> > OSDs than sequential IO that presumably would be hitting a single O=
SD =20
> > more regularly.
> > =20
> > On the other hand, you'd expect that sequential writes would be =20
> > getting coalesced either at the RBD layer or on the OSD, and that t=
he =20
> > drive/controller/filesystem underneath the OSD would be doing some =
=20
> > kind of readahead or prefetching.
> > =20
> > On the third hand, maybe coalescing/prefetching is in fact happenin=
g =20
> > but we are IOP limited by some per-osd limitation.
> > =20
> > It could be interesting to do the test with a single OSD and see wh=
at =20
> > happens.
> > =20
> > Mark
> > =20
> > =20
> > On 11/21/2012 09:52 AM, Mark Nelson wrote:
> > > =20
> > > Hi Guys,
> > > =20
> > > I'm late to this thread but thought I'd chime in. Crazy that you =
are =20
> > > getting higher performance with random reads/writes vs sequential=
! =20
> > > It would be interesting to see what kind of throughput smallioben=
ch =20
> > > reports (should be packaged in bobtail) and also see if this beha=
vior =20
> > > happens with cephfs. It's still too early in the morning for me =20
> > > right now to come up with a reasonable explanation for what's goi=
ng =20
> > > on. It might be worth running blktrace and seekwatcher to see wha=
t =20
> > > the io patterns on the underlying disk look like in each case. Ma=
ybe =20
> > > something unexpected is going on.
> > > =20
> > > Mark
> > > =20
> > > On 11/19/2012 02:57 PM, S=C3=83=C2=A9bastien Han wrote:
> > > > =20
> > > > Which iodepth did you use for those benchs?
> > > > =20
> > > > =20
> > > > > I really don't understand why I can't get more rand read iops=
 with =20
> > > > > 4K block ...
> > > > =20
> > > > =20
> > > > =20
> > > > =20
> > > > Me neither, hope to get some clarification from the Inktank guy=
s. It =20
> > > > doesn't make any sense to me...
> > > > --
> > > > Bien cordialement.
> > > > S=C3=83=C2=A9bastien HAN.
> > > > =20
> > > > =20
> > > > On Mon, Nov 19, 2012 at 8:11 PM, Alexandre DERUMIER =20
> > > > <aderumier@odiso.com (mailto:aderumier@odiso.com)> wrote:
> > > > > > > =20
> > > > > > > @Alexandre: is it the same for you? or do you always get =
more =20
> > > > > > > IOPS with seq?
> > > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > rand read 4K : 6000 iops
> > > > > seq read 4K : 3500 iops
> > > > > seq read 4M : 31iops (1gigabit client bandwith limit)
> > > > > =20
> > > > > rand write 4k: 6000iops (tmpfs journal) seq write 4k: 1600iop=
s seq =20
> > > > > write 4M : 31iops (1gigabit client bandwith limit)
> > > > > =20
> > > > > =20
> > > > > I really don't understand why I can't get more rand read iops=
 with =20
> > > > > 4K block ...
> > > > > =20
> > > > > I try with high end cpu for client, it doesn't change nothing=
=2E
> > > > > But test cluster use old 8 cores E5420 @ 2.50GHZ (But cpu is =
=20
> > > > > around 15% on cluster during read bench)
> > > > > =20
> > > > > =20
> > > > > ----- Mail original -----
> > > > > =20
> > > > > De: "S=C3=83=C2=A9bastien Han" <han.sebastien@gmail.com (mail=
to:han.sebastien@gmail.com)>
> > > > > =C3=83=E2=82=AC: "Mark Kampe" <mark.kampe@inktank.com (mailto=
:mark.kampe@inktank.com)>
> > > > > Cc: "Alexandre DERUMIER" <aderumier@odiso.com (mailto:aderumi=
er@odiso.com)>, "ceph-devel"
> > > > > <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.or=
g)>
> > > > > Envoy=C3=83=C2=A9: Lundi 19 Novembre 2012 19:03:40
> > > > > Objet: Re: RBD fio Performance concerns
> > > > > =20
> > > > > @Sage, thanks for the info :)
> > > > > @Mark:
> > > > > =20
> > > > > > If you want to do sequential I/O, you should do it buffered=
 (so =20
> > > > > > that the writes can be aggregated) or with a 4M block size =
(very =20
> > > > > > efficient and avoiding object serialization).
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > The original benchmark has been performed with 4M block size.=
 And =20
> > > > > as you can see I still get more IOPS with rand than seq... I =
just =20
> > > > > tried with 4M without direct I/O, still the same. I can print=
 fio =20
> > > > > results if it's needed.
> > > > > =20
> > > > > > We do direct writes for benchmarking, not because it is a =20
> > > > > > reasonable way to do I/O, but because it bypasses the buffe=
r cache =20
> > > > > > and enables us to directly measure cluster I/O throughput (=
which =20
> > > > > > is what we are trying to optimize). Applications should usu=
ally do =20
> > > > > > buffered I/O, to get the (very significant) benefits of cac=
hing =20
> > > > > > and write aggregation.
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > =20
> > > > > I know why I use direct I/O. It's synthetic benchmarks, it's =
far =20
> > > > > away from a real life scenario and how common applications wo=
rks. I =20
> > > > > just try to see the maximum I/O throughput that I can get fro=
m my =20
> > > > > RBD. All my applications use buffered I/O.
> > > > > =20
> > > > > @Alexandre: is it the same for you? or do you always get more=
 IOPS =20
> > > > > with seq?
> > > > > =20
> > > > > Thanks to all of you..
> > > > > =20
> > > > > =20
> > > > > On Mon, Nov 19, 2012 at 5:54 PM, Mark Kampe =20
> > > > > <mark.kampe@inktank.com (mailto:mark.kampe@inktank.com)>
> > > > > wrote:
> > > > > > =20
> > > > > > Recall:
> > > > > > 1. RBD volumes are striped (4M wide) across RADOS objects 2=
=2E =20
> > > > > > distinct writes to a single RADOS object are serialized
> > > > > > =20
> > > > > > Your sequential 4K writes are direct, depth=3D256, so there=
 are (at =20
> > > > > > all times) 256 writes queued to the same object. All of you=
r =20
> > > > > > writes are waiting through a very long line, which is addin=
g =20
> > > > > > horrendous latency.
> > > > > > =20
> > > > > > If you want to do sequential I/O, you should do it buffered=
 (so =20
> > > > > > that the writes can be aggregated) or with a 4M block size =
(very =20
> > > > > > efficient and avoiding object serialization).
> > > > > > =20
> > > > > > We do direct writes for benchmarking, not because it is a =20
> > > > > > reasonable way to do I/O, but because it bypasses the buffe=
r cache =20
> > > > > > and enables us to directly measure cluster I/O throughput (=
which =20
> > > > > > is what we are trying to optimize). Applications should usu=
ally do =20
> > > > > > buffered I/O, to get the (very significant) benefits of cac=
hing =20
> > > > > > and write aggregation.
> > > > > > =20
> > > > > > =20
> > > > > > > That's correct for some of the benchmarks. However even w=
ith 4K =20
> > > > > > > for seq, I still get less IOPS. See below my last fio:
> > > > > > > =20
> > > > > > > # fio rbd-bench.fio
> > > > > > > seq-read: (g=3D0): rw=3Dread, bs=3D4K-4K/4K-4K, ioengine=3D=
libaio, =20
> > > > > > > iodepth=3D256
> > > > > > > rand-read: (g=3D1): rw=3Drandread, bs=3D4K-4K/4K-4K, ioen=
gine=3Dlibaio,
> > > > > > > iodepth=3D256
> > > > > > > seq-write: (g=3D2): rw=3Dwrite, bs=3D4K-4K/4K-4K, ioengin=
e=3Dlibaio,
> > > > > > > iodepth=3D256
> > > > > > > rand-write: (g=3D3): rw=3Drandwrite, bs=3D4K-4K/4K-4K, io=
engine=3Dlibaio,
> > > > > > > iodepth=3D256
> > > > > > > fio 1.59
> > > > > > > Starting 4 processes
> > > > > > > Jobs: 1 (f=3D1): [___w] [57.6% done] [0K/405K /s] [0 /99 =
iops] [eta =20
> > > > > > > 02m:59s]
> > > > > > > seq-read: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D15096 =
read : =20
> > > > > > > io=3D801892KB, bw=3D13353KB/s, iops=3D3338 , runt=3D 6005=
3msec slat =20
> > > > > > > (usec): min=3D8 , max=3D45921 , avg=3D296.69, stdev=3D158=
4.90 clat =20
> > > > > > > (msec): min=3D18 , max=3D133 , avg=3D76.37, stdev=3D16.63=
 lat (msec): =20
> > > > > > > min=3D18 , max=3D133 , avg=3D76.67, stdev=3D16.62 bw (KB/=
s) : min=3D 0, =20
> > > > > > > max=3D14406, per=3D31.89%, avg=3D4258.24,
> > > > > > > stdev=3D6239.06
> > > > > > > cpu : usr=3D0.87%, sys=3D5.57%, ctx=3D165281, majf=3D0, m=
inf=3D279 IO =20
> > > > > > > depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1=
%, 32=3D0.1%,
> > > > > > > > =20
> > > > > > > > =3D64=3D100.0%
> > > > > > > =20
> > > > > > > submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, 64=3D0.0%,
> > > > > > > > =20
> > > > > > > > =3D64=3D0.0%
> > > > > > > =20
> > > > > > > complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, 64=3D0.0%,
> > > > > > > > =20
> > > > > > > > =3D64=3D0.1%
> > > > > > > =20
> > > > > > > issued r/w/d: total=3D200473/0/0, short=3D0/0/0
> > > > > > > =20
> > > > > > > lat (msec): 20=3D0.01%, 50=3D9.46%, 100=3D90.45%, 250=3D0=
=2E10%
> > > > > > > rand-read: (groupid=3D1, jobs=3D1): err=3D 0: pid=3D16846=
 read : =20
> > > > > > > io=3D6376.4MB, bw=3D108814KB/s, iops=3D27203 , runt=3D 60=
005msec slat =20
> > > > > > > (usec): min=3D8 , max=3D12723 , avg=3D33.54, stdev=3D59.8=
7 clat (usec): =20
> > > > > > > min=3D4642 , max=3D55760 , avg=3D9374.10, stdev=3D970.40 =
lat (usec): =20
> > > > > > > min=3D4671 , max=3D55788 , avg=3D9408.00, stdev=3D971.21 =
bw (KB/s) : =20
> > > > > > > min=3D105496, max=3D109136, per=3D100.00%, avg=3D108815.4=
8,
> > > > > > > stdev=3D648.62
> > > > > > > cpu : usr=3D8.26%, sys=3D49.11%, ctx=3D1486259, majf=3D0,=
 minf=3D278 IO =20
> > > > > > > depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1=
%, 32=3D0.1%,
> > > > > > > > =20
> > > > > > > > =3D64=3D100.0%
> > > > > > > =20
> > > > > > > submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, 64=3D0.0%,
> > > > > > > > =20
> > > > > > > > =3D64=3D0.0%
> > > > > > > =20
> > > > > > > complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, 64=3D0.0%,
> > > > > > > > =20
> > > > > > > > =3D64=3D0.1%
> > > > > > > =20
> > > > > > > issued r/w/d: total=3D1632349/0/0, short=3D0/0/0
> > > > > > > =20
> > > > > > > lat (msec): 10=3D83.39%, 20=3D16.56%, 50=3D0.04%, 100=3D0=
=2E01%
> > > > > > > seq-write: (groupid=3D2, jobs=3D1): err=3D 0: pid=3D18653
> > > > > > > write: io=3D44684KB, bw=3D753502 B/s, iops=3D183 , runt=3D=
 60725msec slat =20
> > > > > > > (usec): min=3D8 , max=3D1246.8K, avg=3D5402.76, stdev=3D4=
0024.97 clat =20
> > > > > > > (msec): min=3D25 , max=3D4868 , avg=3D1384.22, stdev=3D47=
0.19 lat (msec): =20
> > > > > > > min=3D25 , max=3D4868 , avg=3D1389.62, stdev=3D470.17 bw =
(KB/s) : min=3D 7, =20
> > > > > > > max=3D 2165, per=3D104.03%, avg=3D764.65,
> > > > > > > stdev=3D353.97
> > > > > > > cpu : usr=3D0.05%, sys=3D0.35%, ctx=3D5478, majf=3D0, min=
f=3D21 IO depths : =20
> > > > > > > 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D0=
=2E3%,
> > > > > > > > =20
> > > > > > > > =3D64=3D99.4%
> > > > > > > =20
> > > > > > > submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, 64=3D0.0%,
> > > > > > > > =20
> > > > > > > > =3D64=3D0.0%
> > > > > > > =20
> > > > > > > complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, 64=3D0.0%,
> > > > > > > > =20
> > > > > > > > =3D64=3D0.1%
> > > > > > > =20
> > > > > > > issued r/w/d: total=3D0/11171/0, short=3D0/0/0
> > > > > > > =20
> > > > > > > lat (msec): 50=3D0.21%, 100=3D0.44%, 250=3D0.97%, 500=3D1=
=2E49%, 750=3D4.60% =20
> > > > > > > lat (msec): 1000=3D12.73%, 2000=3D66.36%, >=3D2000=3D13.2=
0%
> > > > > > > rand-write: (groupid=3D3, jobs=3D1): err=3D 0: pid=3D2044=
6
> > > > > > > write: io=3D208588KB, bw=3D3429.5KB/s, iops=3D857 , runt=3D=
 60822msec =20
> > > > > > > slat (usec): min=3D10 , max=3D1693.9K, avg=3D1148.15, std=
ev=3D15210.37 =20
> > > > > > > clat (msec): min=3D22 , max=3D5639 , avg=3D297.37, stdev=3D=
430.27 lat =20
> > > > > > > (msec): min=3D22 , max=3D5639 , avg=3D298.52, stdev=3D430=
=2E84 bw (KB/s) : =20
> > > > > > > min=3D 0, max=3D 7728, per=3D31.44%, avg=3D1078.21,
> > > > > > > stdev=3D2000.45
> > > > > > > cpu : usr=3D0.34%, sys=3D1.61%, ctx=3D37183, majf=3D0, mi=
nf=3D19 IO depths =20
> > > > > > > : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.1%,
> > > > > > > > =20
> > > > > > > > =3D64=3D99.9%
> > > > > > > =20
> > > > > > > submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, 64=3D0.0%,
> > > > > > > > =20
> > > > > > > > =3D64=3D0.0%
> > > > > > > =20
> > > > > > > complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, 64=3D0.0%,
> > > > > > > > =20
> > > > > > > > =3D64=3D0.1%
> > > > > > > =20
> > > > > > > issued r/w/d: total=3D0/52147/0, short=3D0/0/0
> > > > > > > =20
> > > > > > > lat (msec): 50=3D2.82%, 100=3D25.63%, 250=3D46.12%, 500=3D=
10.36%, =20
> > > > > > > 750=3D5.10% lat (msec): 1000=3D2.91%, 2000=3D5.75%, >=3D2=
000=3D1.33%
> > > > > > > =20
> > > > > > > Run status group 0 (all jobs):
> > > > > > > READ: io=3D801892KB, aggrb=3D13353KB/s, minb=3D13673KB/s,=
 =20
> > > > > > > maxb=3D13673KB/s, mint=3D60053msec, maxt=3D60053msec
> > > > > > > =20
> > > > > > > Run status group 1 (all jobs):
> > > > > > > READ: io=3D6376.4MB, aggrb=3D108814KB/s, minb=3D111425KB/=
s, =20
> > > > > > > maxb=3D111425KB/s, mint=3D60005msec, maxt=3D60005msec
> > > > > > > =20
> > > > > > > Run status group 2 (all jobs):
> > > > > > > WRITE: io=3D44684KB, aggrb=3D735KB/s, minb=3D753KB/s, max=
b=3D753KB/s, =20
> > > > > > > mint=3D60725msec, maxt=3D60725msec
> > > > > > > =20
> > > > > > > Run status group 3 (all jobs):
> > > > > > > WRITE: io=3D208588KB, aggrb=3D3429KB/s, minb=3D3511KB/s, =
maxb=3D3511KB/s, =20
> > > > > > > mint=3D60822msec, maxt=3D60822msec
> > > > > > > =20
> > > > > > > Disk stats (read/write):
> > > > > > > rbd1: ios=3D1832984/63270, merge=3D0/0, ticks=3D16374236/=
17012132, =20
> > > > > > > in_queue=3D33434120, util=3D99.79%
> > > > > > =20
> > > > > =20
> > > > =20
> > > > =20
> > > > =20
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe =20
> > > > ceph-devel" in the body of a message to majordomo@vger.kernel.o=
rg (mailto:majordomo@vger.kernel.org) =20
> > > > More majordomo info at http://vger.kernel.org/majordomo-info.ht=
ml
> > > =20
> > =20
> =20
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at http://vger.kernel.org/majordomo-info.html
> =C2=A2=C3=A9=C3=AC=C2=B9=C2=BB=C2=AE&=C3=9E~=C2=BA&=C2=B6=C2=AC=E2=80=
=93+-=C2=B1=C3=A9=C3=9D=C2=B6=C2=A5=C5=A0w=C2=AE=C5=BE=C3=8B=E2=80=BA=C2=
=B1=C3=8A=C3=A2m=C3=A7=C2=A6^=C2=BD=C3=A9b=C5=BE=C3=98^n=E2=80=A1r=C2=A1=
=C3=B6=C2=A6z=C3=8B?=C3=ABh=E2=84=A2=C2=A8=C3=A8=C2=AD=C3=9A&=C2=A2=C3=B8=
=C2=AEG=C2=AB?=C3=A9h=C2=AE(=C2=AD=C3=A9=C5=A1=C5=BD=C5=A0=C3=9D=C2=A2j=
"?=C3=BA=C2=B6m=C2=A7=C3=BF=C3=AF?=C3=AA=C3=A4z=C2=B9=C3=9E=E2=80=93=C5=
=A0=C3=A0=C3=BEf=C2=A3=C2=A2=C2=B7h=C5=A1=CB=86=C2=A7~=CB=86m=C5=A1



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
