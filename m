From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Increasing # Shards vs multi-OSDs per device
Date: Wed, 11 Nov 2015 16:29:49 -0700
Message-ID: <CAANLjFqDv-cR9i_jPSvWGAFjJGyw0QeW1Zgf_m3DtaPf4zFu0g@mail.gmail.com>
References: <3649A15A2562B54294DE14BCE5AC79120B8ED66F@ORSMSX160.amr.corp.intel.com>
	<CAH0kLp8pQW=Ainqm5w7yfBgzSj2AKum125CiqJ+r5k=cvR53Ug@mail.gmail.com>
	<3649A15A2562B54294DE14BCE5AC79120B8EE3BB@ORSMSX160.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35144 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbKKX3v convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 18:29:51 -0500
Received: by vkas68 with SMTP id s68so736020vka.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2015 15:29:49 -0800 (PST)
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120B8EE3BB@ORSMSX160.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Cc: Somnath Roy <its.somenath@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>, Samuel Just <sjust@redhat.com>, Kyle Bader <kbader@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I should have the weighted round robin queue ready in the next few
days. I shaking out a few bugs from converting it from my Hammer patch
and I need to write a test suite, but I can get you the branch before
then. I'd be interested to see what difference there may be as it
would help decide if this is a path to continue pursuing.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Nov 11, 2015 at 3:44 PM, Blinick, Stephen L  wrote:
> Thanks for taking a look!
>
> First, the original slides are on the Ceph slideshare here: http://ww=
w.slideshare.net/Inktank_Ceph/accelerating-cassandra-workloads-on-ceph-=
with-allflash-pcie-ssds    That should show the 1/2/4 parition comparis=
on and the overall performance #=E2=80=99s latency, and data set size. =
  I didn=E2=80=99t provide much context in this quick deck because I me=
ant it to be a companion to that data.
>
> 1 =E2=80=93 I agree we=E2=80=99re a long way from the max DC P3700 4K=
 RR IOPS (460K), and also that is at QD128.   In the future (some day) =
it would be nice though if you could reach that performance with OSD kn=
obs to increase worker threads.   We did try many shards/workers per sh=
ards combination but the real purpose of the presentation was mixed r/w=
 performance and the =E2=80=9CCassandra=E2=80=9D breakdown of IO sizes =
@ 50/50 mix.  Every deviation from the default hurt writes or mixed per=
formance so we were not just working for the highest RandRead #=E2=80=99=
s possible.
>
> 2=E2=80=94We used CBT for all runs, unfortunately our default collect=
l config didn=E2=80=99t grab NVMe stats we=E2=80=99ll fix that as we mo=
ve to Infernalis.. I have NVMe Bandwidth only (from zabbix monitoring).=
  Using IOstat to spot check though the QD, it was always pretty low on=
 the devices, at most 10 with the 4-partition 100% read case.   For 100=
% RR @ QD32:   1 OSD/NVMe =3D 34.4K reads/device.  4 OSD/NVMe =3D 55.5k=
 reads/device (14k per OSD).    What's shown in the other presentation =
is that with 2OSD/NVMe we hit 44K iops/device, and we did go to 8 OSD's=
/device but saw no improvement over 4.
> So, we determined 4 NVMe/OSD is worth doing over 2, and the 4 OSD's t=
o 1 flash device failure boundary closely matches the generally accepte=
d ratio of OSD journals to one device.
>
> 3-- Page cache effects should be negated in these numbers. As you can=
 see in the other presentation we did one run with  2TB of data, which =
showed higher performance (1.35M IOPS).  But the rest of the tests were=
 run with 4.8TB data (replicated twice), and uniform random distributio=
n.  While we  did use 'norandommap' for client performance, the re-refe=
rencing of blocks in that size dataset should be low.   Using IOstat, a=
nd Zabbix, we correlated the host read/write aggregate performance to t=
he device statistics, so confirm that there wasn't object data coming o=
ut of cache.
>
> 4 -- Yeah this multi-partitioning doesn't double or quadruple CPU/Thr=
oughput and performance.  But it has significant improvements to a poin=
t (4, by experimentation, in this cluster).  For SSD's, our team in Sha=
nghai used 2 partitions/SSD for best performance.
>
> 5 -- Good catch, I typed this in quickly when my mic wasn't working t=
his morning :)   In all cases the # of actual worker threads is double =
what is stated on slide #7 in the linked presentation below.  This is b=
ecause every shard by default =3D 2 workers and we did not change that =
in any of the published tests.  When we did lower it to 1 it always hur=
t write performance as well.
>
> 6 -- As you can see in the config, we did increase filestore_op_threa=
ds to 6  (this gave a 15% boost in mixed r/w performance).  Higher than=
 that didn't help.  I'm not sure if it would have helped in the case of=
 20 shards/OSD.
>
> I am still really curious about the scheduler behavior for threads wi=
thin an OSD.     Given the sleep/signal/wakeup mechanism between the ms=
g dispatcher and the worker threads, is it possible that's causing the =
scheduler to bump threads up to a higher priority and somehow breaking =
fairness when there's more runnable threads than CPU's?    Each node he=
re has 72 cpu's (with HT) but as you note 160 worker threads (in additi=
on to the pipe reader/writers and msg dispatchers).
>
> Thanks,
>
> Stephen
>
>
>
>
> From: Somnath Roy [mailto:its.somenath@gmail.com]
> Sent: Wednesday, November 11, 2015 3:02 PM
> To: Blinick, Stephen L
> Cc: ceph-devel@vger.kernel.org; Mark Nelson; Samuel Just; Kyle Bader;=
 Somnath Roy
> Subject: Re: Increasing # Shards vs multi-OSDs per device
>
> Thanks for the data Stephen. Some feedback:
>
> 1. I don't think single OSD is still there to serve 460K read iops ir=
respective of how many shards/threads you are running. I didn't have yo=
ur NVMe data earlier :-)..But, probably for 50/60K SAS SSD iops single =
OSD per drive is good enough. I hope you tried even increasing the shar=
ds/threads to very high value (since you have lot of cpu left) say 40:2=
 or 80:1 (try one configuration with 1 thread/shard , it should reduce =
contention per shard) so ? Or even lower ratio like 10:2  or 20:1 ?
>
> 2. Do you have any data on disk utilization ? It will be good if we a=
re able to understand how better the single disk utilization becomes wh=
en you are running multiple OSDs/drive. I kind of back calculate from y=
our data that , in case of 4 OSds/drive cases each OSD is serving ~14K =
read iops vs ~42K read iops while having one osd/drive. So, this clearl=
y tells that two OSDs/drive should be good enough to serve similar iops=
 in your environment. You are able to extract ~56K iops per drive with =
4 OSDs vs 42K for one OSD case.
>
> 3. The above calculation I have discarded all the cache effect , but,=
 that's not realistic. You have total of 128 GB * 5 =3D 640 GB of RAM. =
What is the total working set of yours ? If you are having lot of cache=
 effect in this run , 4 OSDs (4 XFS) will be having better effect than =
one OSD /drive. This could be a total number of OSD effect in the clust=
er but not so number of OSD needed to saturate a drive.
>
> 4. Also, cpu util wise, you have only 20% more cpu util while you are=
 running 4X more OSDs.
>
> 5.  BTW, worker thread calculation is incorrect , default is 5:2 , so=
, each osd is running with 10 worker threads and total 160 worker threa=
ds for both 4 OSD/drive and 1 osd/drive (20:2).
>
> 6.  Write data is surprising compare to default shard 1 OSD case, may=
 be you need to increase filestore op thrads since you have more data c=
oming to filestore ?
>
> Thanks & Regards
> Somnath
>
> On Wed, Nov 11, 2015 at 12:57 PM, Blinick, Stephen L  wrote:
> Sorry about the microphone issues in the performance meeting today to=
day.   This is a followup to the 11/4 performance meeting where we disc=
ussed increasing the worker thread count in the OSD's vs making multipl=
e OSD's (and partitions/filesystems) per device.     We did the high le=
vel experiment and have some results which I threw into a ppt/pdf, and =
shared them here:
>
> http://www.docdroid.net/UbmvGnH/increasing-shards-vs-multiple-osds.pd=
f.html
>
> Doing 20-shard OSD's vs 4 OSD's per device with default 5 shards yiel=
ded about half of the performance improvement for random 4k reads.  For=
 writes performance is actually worse than just 1 OSD per device and th=
e default # of shards.  The throttles should be large enough for the 20=
-shard use case as they are 10x the defaults, although if you see anyth=
ing we missed let us know.
>
> I had the cluster moved to Infernalis release (with JEMalloc) yesterd=
ay, so hopefully we'll have some early results on the same 5-node clust=
er soon.
>
> Thanks,
>
> Stephen
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWQ89oCRDmVDuy+mK58QAAGm0P/igsFdpIZonJ1rnBDzn1
tMPRpVcKHvL/Yqx9UgkZwXnQ+MZP6nUj/roWzhJFM8OnXIMBg7TKvQLNN1uv
NFNX6noWcQjASrUsFbkJC78xv9GOZeltN/9sE5jDZdjPHqNtP7g9n/au1DZP
qPqlJBQxoF4p1qZUijuX3JXMmLRNNvEpdhicve1gz3WG5CdtZb1p1udPECa1
7InsacCqzc9foRv23wqcnQU/cCQyZWLRDgMSFXb4/b5JErqwAV4WNL/C6oTa
hdAIsaRVlQvhj9PlYI86FYCd0sj/B1TZlRaRBKR/Eup7Yyvlo6y+EaNua7Ou
D7ilYZCBOQ+2HUaM6Dv+SRJogK35nkurkthP1hqZi0TLYpxSefzpzf+TJuvg
r/B2f26ha4lX7i023gPTij+GkpLCTJgymKWqbLHfHsNQN1/fwrgwOJ/5ySNL
TXh1iTT8ulB6GwmkPM9MRlIW6jRCoOpjWXHjE6R7wAVOh/cpLb98ie2cmW+6
sXhCllPFwpHogYJklCW+eI6eZ7T2Y26WMA/BbwVKKlPhcaU35LVym77XeqBI
804tLumsYyBVZVIlpsn1Eqk+tgh6/aNSgMXztDTWjdCVwUhhmLDGuzdDYa+1
EM2bW4+ZIeRnhab662v8muFX8ka/ee/HX43St50LeGRcYIEICsxGSCMXhVdt
kTLC
=3Dcj9z
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
