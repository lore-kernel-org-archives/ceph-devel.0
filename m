From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [ceph-users] rbd_cache, limiting read on high iops around 40k
Date: Tue, 9 Jun 2015 18:47:27 +0200 (CEST)
Message-ID: <1058039366.2034449.1433868447253.JavaMail.zimbra@oxygem.tv>
References: <1684793881.1564583.1433829106394.JavaMail.zimbra@oxygem.tv> <CAMc8nAWo-jnAHS5cLw5gDt57T3vZpiN79vFXc=pz=+Cjm6Ra6A@mail.gmail.com> <959572886.1627596.1433834901443.JavaMail.zimbra@oxygem.tv> <1897614581.1694878.1433838989184.JavaMail.zimbra@oxygem.tv> <5576CFBF.1070405@redhat.com> <1208111516.1790161.1433851367996.JavaMail.zimbra@oxygem.tv> <CAANLjFo5qNmWPdOvVo83W10q7xkww7+vjG3BLKArZ3RqmmaMNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:36308 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbbFIQra convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 12:47:30 -0400
In-Reply-To: <CAANLjFo5qNmWPdOvVo83W10q7xkww7+vjG3BLKArZ3RqmmaMNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, pushpesh sharma <pushpesh.eck@gmail.com>, ceph-users <ceph-users@lists.ceph.com>

Hi Robert,

>>What I found was that Ceph OSDs performed well with either=20
>>tcmalloc or jemalloc (except when RocksDB was built with jemalloc=20
>>instead of tcmalloc, I'm still working to dig into why that might be=20
>>the case).=20
yes,from my test, for osd tcmalloc is a little faster (but very little)=
 than jemalloc.



>>However, I found that tcmalloc with QEMU/KVM was very detrimental to=20
>>small I/O, but provided huge gains in I/O >=3D1MB. Jemalloc was much=20
>>better for QEMU/KVM in the tests that we ran. [1]


Just have done qemu test (4k randread - rbd_cache=3Doff), I don't see s=
peed regression with tcmalloc.
with qemu iothread, tcmalloc have a speed increase over glib
with qemu iothread, jemalloc have a speed decrease

without iothread, jemalloc have a big speed increase

this is with=20
-qemu 2.3
-tcmalloc 2.2.1
-jemmaloc 3.6
-libc6 2.19


qemu : no iothread : glibc    : iops=3D33395
qemu : no-iothread : tcmalloc : iops=3D34516 (+3%)
qemu : no-iothread : jemmaloc : iops=3D42226 (+26%)

qemu : iothread :     glibc   : iops=3D34516
qemu : iothread :    tcmalloc : iops=3D38676 (+12%)
qemu : iothread :    jemmaloc : iops=3D28023 (-19%)


(The benefit of iothreads is that we can scale with more disks in 1vm)


fio results:
------------

qemu : iothread : tcmalloc : iops=3D38676
-----------------------------------------
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioe=
ngine=3Dlibaio, iodepth=3D32
fio-2.1.11
Starting 1 process
Jobs: 1 (f=3D0): [r(1)] [100.0% done] [123.5MB/0KB/0KB /s] [31.6K/0/0 i=
ops] [eta 00m:00s]
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D1265: Tue =
Jun  9 18:16:53 2015
  read : io=3D5120.0MB, bw=3D154707KB/s, iops=3D38676, runt=3D 33889mse=
c
    slat (usec): min=3D1, max=3D715, avg=3D 3.63, stdev=3D 3.42
    clat (usec): min=3D152, max=3D5736, avg=3D822.12, stdev=3D289.34
     lat (usec): min=3D231, max=3D5740, avg=3D826.10, stdev=3D289.08
    clat percentiles (usec):
     |  1.00th=3D[  402],  5.00th=3D[  466], 10.00th=3D[  510], 20.00th=
=3D[  572],
     | 30.00th=3D[  636], 40.00th=3D[  716], 50.00th=3D[  780], 60.00th=
=3D[  852],
     | 70.00th=3D[  932], 80.00th=3D[ 1020], 90.00th=3D[ 1160], 95.00th=
=3D[ 1352],
     | 99.00th=3D[ 1800], 99.50th=3D[ 1944], 99.90th=3D[ 2256], 99.95th=
=3D[ 2448],
     | 99.99th=3D[ 3888]
    bw (KB  /s): min=3D123888, max=3D198584, per=3D100.00%, avg=3D15482=
4.40, stdev=3D16978.03
    lat (usec) : 250=3D0.01%, 500=3D8.91%, 750=3D36.44%, 1000=3D32.63%
    lat (msec) : 2=3D21.65%, 4=3D0.37%, 10=3D0.01%
  cpu          : usr=3D8.29%, sys=3D19.76%, ctx=3D55882, majf=3D0, minf=
=3D39
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, =
64=3D0.0%, >=3D64=3D0.0%
     issued    : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
32

Run status group 0 (all jobs):
   READ: io=3D5120.0MB, aggrb=3D154707KB/s, minb=3D154707KB/s, maxb=3D1=
54707KB/s, mint=3D33889msec, maxt=3D33889msec

Disk stats (read/write):
  vdb: ios=3D1302739/0, merge=3D0/0, ticks=3D934444/0, in_queue=3D93409=
6, util=3D99.77%



qemu : no-iothread : tcmalloc : iops=3D34516
---------------------------------------------
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [163.2MB/0KB/0KB /s] [41.8K/0/0 i=
ops] [eta 00m:00s]
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D896: Tue J=
un  9 18:19:08 2015
  read : io=3D5120.0MB, bw=3D138065KB/s, iops=3D34516, runt=3D 37974mse=
c
    slat (usec): min=3D1, max=3D708, avg=3D 3.98, stdev=3D 3.57
    clat (usec): min=3D208, max=3D11858, avg=3D921.43, stdev=3D333.61
     lat (usec): min=3D266, max=3D11862, avg=3D925.77, stdev=3D333.40
    clat percentiles (usec):
     |  1.00th=3D[  434],  5.00th=3D[  510], 10.00th=3D[  564], 20.00th=
=3D[  652],
     | 30.00th=3D[  732], 40.00th=3D[  812], 50.00th=3D[  876], 60.00th=
=3D[  940],
     | 70.00th=3D[ 1020], 80.00th=3D[ 1112], 90.00th=3D[ 1320], 95.00th=
=3D[ 1576],
     | 99.00th=3D[ 1992], 99.50th=3D[ 2128], 99.90th=3D[ 2736], 99.95th=
=3D[ 3248],
     | 99.99th=3D[ 4320]
    bw (KB  /s): min=3D77312, max=3D185576, per=3D99.74%, avg=3D137709.=
88, stdev=3D16883.77
    lat (usec) : 250=3D0.01%, 500=3D4.36%, 750=3D27.61%, 1000=3D35.60%
    lat (msec) : 2=3D31.49%, 4=3D0.92%, 10=3D0.02%, 20=3D0.01%
  cpu          : usr=3D7.19%, sys=3D19.52%, ctx=3D55903, majf=3D0, minf=
=3D38
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, =
64=3D0.0%, >=3D64=3D0.0%
     issued    : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
32

Run status group 0 (all jobs):
   READ: io=3D5120.0MB, aggrb=3D138064KB/s, minb=3D138064KB/s, maxb=3D1=
38064KB/s, mint=3D37974msec, maxt=3D37974msec

Disk stats (read/write):
  vdb: ios=3D1309902/0, merge=3D0/0, ticks=3D1068768/0, in_queue=3D1068=
396, util=3D99.86%



qemu : iothread : glibc : iops=3D34516
-------------------------------------

rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioe=
ngine=3Dlibaio, iodepth=3D32
fio-2.1.11
Starting 1 process
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [133.4MB/0KB/0KB /s] [34.2K/0/0 i=
ops] [eta 00m:00s]
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D876: Tue J=
un  9 18:24:01 2015
  read : io=3D5120.0MB, bw=3D137786KB/s, iops=3D34446, runt=3D 38051mse=
c
    slat (usec): min=3D1, max=3D496, avg=3D 3.88, stdev=3D 3.66
    clat (usec): min=3D283, max=3D7515, avg=3D923.34, stdev=3D300.28
     lat (usec): min=3D286, max=3D7519, avg=3D927.58, stdev=3D300.02
    clat percentiles (usec):
     |  1.00th=3D[  506],  5.00th=3D[  564], 10.00th=3D[  596], 20.00th=
=3D[  652],
     | 30.00th=3D[  724], 40.00th=3D[  804], 50.00th=3D[  884], 60.00th=
=3D[  964],
     | 70.00th=3D[ 1048], 80.00th=3D[ 1144], 90.00th=3D[ 1304], 95.00th=
=3D[ 1448],
     | 99.00th=3D[ 1896], 99.50th=3D[ 2096], 99.90th=3D[ 2480], 99.95th=
=3D[ 2640],
     | 99.99th=3D[ 3984]
    bw (KB  /s): min=3D102680, max=3D171112, per=3D100.00%, avg=3D13787=
7.78, stdev=3D15521.30
    lat (usec) : 500=3D0.84%, 750=3D32.97%, 1000=3D30.82%
    lat (msec) : 2=3D34.65%, 4=3D0.71%, 10=3D0.01%
  cpu          : usr=3D7.42%, sys=3D19.47%, ctx=3D52455, majf=3D0, minf=
=3D38
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, =
64=3D0.0%, >=3D64=3D0.0%
     issued    : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
32

Run status group 0 (all jobs):
   READ: io=3D5120.0MB, aggrb=3D137785KB/s, minb=3D137785KB/s, maxb=3D1=
37785KB/s, mint=3D38051msec, maxt=3D38051msec

Disk stats (read/write):
  vdb: ios=3D1307426/0, merge=3D0/0, ticks=3D1051416/0, in_queue=3D1050=
972, util=3D99.85%



qemu : no iothread : glibc : iops=3D33395
-----------------------------------------
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioe=
ngine=3Dlibaio, iodepth=3D32
fio-2.1.11
Starting 1 process
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [125.4MB/0KB/0KB /s] [32.9K/0/0 i=
ops] [eta 00m:00s]
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D886: Tue J=
un  9 18:27:18 2015
  read : io=3D5120.0MB, bw=3D133583KB/s, iops=3D33395, runt=3D 39248mse=
c
    slat (usec): min=3D1, max=3D1054, avg=3D 3.86, stdev=3D 4.29
    clat (usec): min=3D139, max=3D12635, avg=3D952.85, stdev=3D335.51
     lat (usec): min=3D303, max=3D12638, avg=3D957.01, stdev=3D335.29
    clat percentiles (usec):
     |  1.00th=3D[  516],  5.00th=3D[  564], 10.00th=3D[  596], 20.00th=
=3D[  652],
     | 30.00th=3D[  724], 40.00th=3D[  820], 50.00th=3D[  924], 60.00th=
=3D[  996],
     | 70.00th=3D[ 1080], 80.00th=3D[ 1176], 90.00th=3D[ 1336], 95.00th=
=3D[ 1528],
     | 99.00th=3D[ 2096], 99.50th=3D[ 2320], 99.90th=3D[ 2672], 99.95th=
=3D[ 2928],
     | 99.99th=3D[ 4832]
    bw (KB  /s): min=3D98136, max=3D171624, per=3D100.00%, avg=3D133682=
=2E64, stdev=3D19121.91
    lat (usec) : 250=3D0.01%, 500=3D0.57%, 750=3D32.57%, 1000=3D26.98%
    lat (msec) : 2=3D38.59%, 4=3D1.28%, 10=3D0.01%, 20=3D0.01%
  cpu          : usr=3D9.24%, sys=3D15.92%, ctx=3D51219, majf=3D0, minf=
=3D38
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, =
64=3D0.0%, >=3D64=3D0.0%
     issued    : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
32

Run status group 0 (all jobs):
   READ: io=3D5120.0MB, aggrb=3D133583KB/s, minb=3D133583KB/s, maxb=3D1=
33583KB/s, mint=3D39248msec, maxt=3D39248msec

Disk stats (read/write):
  vdb: ios=3D1304526/0, merge=3D0/0, ticks=3D1075020/0, in_queue=3D1074=
536, util=3D99.84%



qemu : iothread : jemmaloc : iops=3D28023
----------------------------------------
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioe=
ngine=3Dlibaio, iodepth=3D32
fio-2.1.11
Starting 1 process
Jobs: 1 (f=3D1): [r(1)] [97.9% done] [155.2MB/0KB/0KB /s] [39.1K/0/0 io=
ps] [eta 00m:01s]
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D899: Tue J=
un  9 18:30:26 2015
  read : io=3D5120.0MB, bw=3D112094KB/s, iops=3D28023, runt=3D 46772mse=
c
    slat (usec): min=3D1, max=3D467, avg=3D 4.33, stdev=3D 4.77
    clat (usec): min=3D253, max=3D11307, avg=3D1135.63, stdev=3D346.55
     lat (usec): min=3D256, max=3D11309, avg=3D1140.39, stdev=3D346.22
    clat percentiles (usec):
     |  1.00th=3D[  510],  5.00th=3D[  628], 10.00th=3D[  700], 20.00th=
=3D[  820],
     | 30.00th=3D[  924], 40.00th=3D[ 1032], 50.00th=3D[ 1128], 60.00th=
=3D[ 1224],
     | 70.00th=3D[ 1320], 80.00th=3D[ 1416], 90.00th=3D[ 1560], 95.00th=
=3D[ 1688],
     | 99.00th=3D[ 2096], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=
=3D[ 2832],
     | 99.99th=3D[ 3760]
    bw (KB  /s): min=3D91792, max=3D174416, per=3D99.90%, avg=3D111985.=
27, stdev=3D17381.70
    lat (usec) : 500=3D0.80%, 750=3D13.10%, 1000=3D23.33%
    lat (msec) : 2=3D61.30%, 4=3D1.46%, 10=3D0.01%, 20=3D0.01%
  cpu          : usr=3D7.12%, sys=3D17.43%, ctx=3D54507, majf=3D0, minf=
=3D38
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, =
64=3D0.0%, >=3D64=3D0.0%
     issued    : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
32

Run status group 0 (all jobs):
   READ: io=3D5120.0MB, aggrb=3D112094KB/s, minb=3D112094KB/s, maxb=3D1=
12094KB/s, mint=3D46772msec, maxt=3D46772msec

Disk stats (read/write):
  vdb: ios=3D1309169/0, merge=3D0/0, ticks=3D1305796/0, in_queue=3D1305=
376, util=3D98.68%



qemu : non-iothread : jemmaloc : iops=3D42226
--------------------------------------------
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioe=
ngine=3Dlibaio, iodepth=3D32
fio-2.1.11
Starting 1 process
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.2MB/0KB/0KB /s] [43.9K/0/0 i=
ops] [eta 00m:00s]
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D892: Tue J=
un  9 18:34:11 2015
  read : io=3D5120.0MB, bw=3D177130KB/s, iops=3D44282, runt=3D 29599mse=
c
    slat (usec): min=3D1, max=3D527, avg=3D 3.80, stdev=3D 3.74
    clat (usec): min=3D174, max=3D3841, avg=3D717.08, stdev=3D237.53
     lat (usec): min=3D210, max=3D3844, avg=3D721.23, stdev=3D237.22
    clat percentiles (usec):
     |  1.00th=3D[  354],  5.00th=3D[  422], 10.00th=3D[  462], 20.00th=
=3D[  516],
     | 30.00th=3D[  572], 40.00th=3D[  628], 50.00th=3D[  684], 60.00th=
=3D[  740],
     | 70.00th=3D[  804], 80.00th=3D[  884], 90.00th=3D[ 1004], 95.00th=
=3D[ 1128],
     | 99.00th=3D[ 1544], 99.50th=3D[ 1672], 99.90th=3D[ 1928], 99.95th=
=3D[ 2064],
     | 99.99th=3D[ 2608]
    bw (KB  /s): min=3D138120, max=3D230816, per=3D100.00%, avg=3D17719=
2.14, stdev=3D23440.79
    lat (usec) : 250=3D0.01%, 500=3D16.24%, 750=3D45.93%, 1000=3D27.46%
    lat (msec) : 2=3D10.30%, 4=3D0.07%
  cpu          : usr=3D10.14%, sys=3D23.84%, ctx=3D60938, majf=3D0, min=
f=3D39
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, =
64=3D0.0%, >=3D64=3D0.0%
     issued    : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
32

Run status group 0 (all jobs):
   READ: io=3D5120.0MB, aggrb=3D177130KB/s, minb=3D177130KB/s, maxb=3D1=
77130KB/s, mint=3D29599msec, maxt=3D29599msec

Disk stats (read/write):
  vdb: ios=3D1303992/0, merge=3D0/0, ticks=3D798008/0, in_queue=3D79763=
6, util=3D99.80%



----- Mail original -----
De: "Robert LeBlanc" <robert@leblancnet.us>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger.k=
ernel.org>, "pushpesh sharma" <pushpesh.eck@gmail.com>, "ceph-users" <c=
eph-users@lists.ceph.com>
Envoy=C3=A9: Mardi 9 Juin 2015 18:00:29
Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 40=
k

-----BEGIN PGP SIGNED MESSAGE-----=20
Hash: SHA256=20

I also saw a similar performance increase by using alternative memory=20
allocators. What I found was that Ceph OSDs performed well with either=20
tcmalloc or jemalloc (except when RocksDB was built with jemalloc=20
instead of tcmalloc, I'm still working to dig into why that might be=20
the case).=20

However, I found that tcmalloc with QEMU/KVM was very detrimental to=20
small I/O, but provided huge gains in I/O >=3D1MB. Jemalloc was much=20
better for QEMU/KVM in the tests that we ran. [1]=20

I'm currently looking into I/O bottlenecks around the 16KB range and=20
I'm seeing a lot of time in thread creation and destruction, the=20
memory allocators are quite a bit down the list (both fio with=20
ioengine rbd and on the OSDs). I wonder what the difference can be.=20
I've tried using the async messenger but there wasn't a huge=20
difference. [2]=20

=46urther down the rabbit hole....=20

[1] https://www.mail-archive.com/ceph-users@lists.ceph.com/msg20197.htm=
l=20
[2] https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg23982.ht=
ml=20
-----BEGIN PGP SIGNATURE-----=20
Version: Mailvelope v0.13.1=20
Comment: https://www.mailvelope.com=20

wsFcBAEBCAAQBQJVdw2ZCRDmVDuy+mK58QAA4MwP/1vt65cvTyyVGGSGRrE8=20
unuWjafMHzl486XH+EaVrDVTXFVFOoncJ6kugSpD7yavtCpZNdhsIaTRZguU=20
YpfAppNAJU5biSwNv9QPI7kPP2q2+I7Z8ZkvhcVnkjIythoeNnSjV7zJrw87=20
afq46GhPHqEXdjp3rOB4RRPniOMnub5oU6QRnKn3HPW8Dx9ZqTeCofRDnCY2=20
S695Dt1gzt0ERUOgrUUkt0FQJdkkV6EURcUschngjtEd5727VTLp02HivVl3=20
vDYWxQHPK8oS6Xe8GOW0JjulwiqlYotSlrqSU5FMU5gozbk9zMFPIUW1e+51=20
9ART8Ta2ItMhPWtAhRwwvxgy51exCy9kBc+m+ptKW5XRUXOImGcOQxszPGOO=20
qIIOG1vVG/GBmo/0i6tliqBFYdXmw1qFV7tFiIbisZRH7Q/1NahjYTHqHhu3=20
Dv61T6WrerD+9N6S1Lrz1QYe2Fqa56BHhHSXM82NE86SVxEvUkoGegQU+c7b=20
6rY1JvuJHJzva7+M2XHApYCchCs4a1Yyd1qWB7yThJD57RIyX1TOg0+siV13=20
R+v6wxhQU0vBovH+5oAWmCZaPNT+F0Uvs3xWAxxaIR9r83wMj9qQeBZTKVzQ=20
1aFIi15KqAwOp12yWCmrqKTeXhjwYQNd8viCQCGN7AQyPglmzfbuEHalVjz4=20
oSJX=20
=3Dk281=20
-----END PGP SIGNATURE-----=20
----------------=20
Robert LeBlanc=20
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904 C70E E654 3BB2 FA62 B9F1=20


On Tue, Jun 9, 2015 at 6:02 AM, Alexandre DERUMIER <aderumier@odiso.com=
> wrote:=20
>>>Frankly, I'm a little impressed that without RBD cache we can hit 80=
K=20
>>>IOPS from 1 VM!=20
>=20
> Note that theses result are not in a vm (fio-rbd on host), so in a vm=
 we'll have overhead.=20
> (I'm planning to send results in qemu soon)=20
>=20
>>>How fast are the SSDs in those 3 OSDs?=20
>=20
> Theses results are with datas in buffer memory of osd nodes.=20
>=20
> When reading fulling on ssd (intel s3500),=20
>=20
> For 1 client,=20
>=20
> I'm around 33k iops without cache and 32k iops with cache, with 1 osd=
=2E=20
> I'm around 55k iops without cache and 38k iops with cache, with 3 osd=
=2E=20
>=20
> with multiple clients jobs, I can reach around 70kiops by osd , and 2=
50k iops by osd when datas are in buffer.=20
>=20
> (cpus servers/clients are 2x 10 cores 3,1ghz e5 xeon)=20
>=20
>=20
>=20
> small tip :=20
> I'm using tcmalloc for fio-rbd or rados bench to improve latencies by=
 around 20%=20
>=20
> LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 fio ...=20
> LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 rados bench ...=20
>=20
> as a lot of time is spent in malloc/free=20
>=20
>=20
> (qemu support also tcmalloc since some months , I'll bench it too=20
> https://lists.gnu.org/archive/html/qemu-devel/2015-03/msg05372.html)=20
>=20
>=20
>=20
> I'll try to send full bench results soon, from 1 to 18 ssd osd.=20
>=20
>=20
>=20
>=20
> ----- Mail original -----=20
> De: "Mark Nelson" <mnelson@redhat.com>=20
> =C3=80: "aderumier" <aderumier@odiso.com>, "pushpesh sharma" <pushpes=
h.eck@gmail.com>=20
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-use=
rs@lists.ceph.com>=20
> Envoy=C3=A9: Mardi 9 Juin 2015 13:36:31=20
> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around =
40k=20
>=20
> Hi All,=20
>=20
> In the past we've hit some performance issues with RBD cache that we'=
ve=20
> fixed, but we've never really tried pushing a single VM beyond 40+K r=
ead=20
> IOPS in testing (or at least I never have). I suspect there's a coupl=
e=20
> of possibilities as to why it might be slower, but perhaps joshd can=20
> chime in as he's more familiar with what that code looks like.=20
>=20
> Frankly, I'm a little impressed that without RBD cache we can hit 80K=
=20
> IOPS from 1 VM! How fast are the SSDs in those 3 OSDs?=20
>=20
> Mark=20
>=20
> On 06/09/2015 03:36 AM, Alexandre DERUMIER wrote:=20
>> It's seem that the limit is mainly going in high queue depth (+- > 1=
6)=20
>>=20
>> Here the result in iops with 1client- 4krandread- 3osd - with differ=
ents queue depth size.=20
>> rbd_cache is almost the same than without cache with queue depth <16=
=20
>>=20
>>=20
>> cache=20
>> -----=20
>> qd1: 1651=20
>> qd2: 3482=20
>> qd4: 7958=20
>> qd8: 17912=20
>> qd16: 36020=20
>> qd32: 42765=20
>> qd64: 46169=20
>>=20
>> no cache=20
>> --------=20
>> qd1: 1748=20
>> qd2: 3570=20
>> qd4: 8356=20
>> qd8: 17732=20
>> qd16: 41396=20
>> qd32: 78633=20
>> qd64: 79063=20
>> qd128: 79550=20
>>=20
>>=20
>> ----- Mail original -----=20
>> De: "aderumier" <aderumier@odiso.com>=20
>> =C3=80: "pushpesh sharma" <pushpesh.eck@gmail.com>=20
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-us=
ers@lists.ceph.com>=20
>> Envoy=C3=A9: Mardi 9 Juin 2015 09:28:21=20
>> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around=
 40k=20
>>=20
>> Hi,=20
>>=20
>>>> We tried adding more RBDs to single VM, but no luck.=20
>>=20
>> If you want to scale with more disks in a single qemu vm, you need t=
o use iothread feature from qemu and assign 1 iothread by disk (works w=
ith virtio-blk).=20
>> It's working for me, I can scale with adding more disks.=20
>>=20
>>=20
>> My bench here are done with fio-rbd on host.=20
>> I can scale up to 400k iops with 10clients-rbd_cache=3Doff on a sing=
le host and around 250kiops 10clients-rbdcache=3Don.=20
>>=20
>>=20
>> I just wonder why I don't have performance decrease around 30k iops =
with 1osd.=20
>>=20
>> I'm going to see if this tracker=20
>> http://tracker.ceph.com/issues/11056=20
>>=20
>> could be the cause.=20
>>=20
>> (My master build was done some week ago)=20
>>=20
>>=20
>>=20
>> ----- Mail original -----=20
>> De: "pushpesh sharma" <pushpesh.eck@gmail.com>=20
>> =C3=80: "aderumier" <aderumier@odiso.com>=20
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-us=
ers@lists.ceph.com>=20
>> Envoy=C3=A9: Mardi 9 Juin 2015 09:21:04=20
>> Objet: Re: rbd_cache, limiting read on high iops around 40k=20
>>=20
>> Hi Alexandre,=20
>>=20
>> We have also seen something very similar on Hammer(0.94-1). We were =
doing some benchmarking for VMs hosted on hypervisor (QEMU-KVM, opensta=
ck-juno). Each Ubuntu-VM has a RBD as root disk, and 1 RBD as additiona=
l storage. For some strange reason it was not able to scale 4K- RR iops=
 on each VM beyond 35-40k. We tried adding more RBDs to single VM, but =
no luck. However increasing number of VMs to 4 on a single hypervisor d=
id scale to some extent. After this there was no much benefit we got fr=
om adding more VMs.=20
>>=20
>> Here is the trend we have seen, x-axis is number of hypervisor, each=
 hypervisor has 4 VM, each VM has 1 RBD:-=20
>>=20
>>=20
>>=20
>>=20
>> VDbench is used as benchmarking tool. We were not saturating network=
 and CPUs at OSD nodes. We were not able to saturate CPUs at hypervisor=
s, and that is where we were suspecting of some throttling effect. Howe=
ver we haven't setted any such limits from nova or kvm end. We tried so=
me CPU pinning and other KVM related tuning as well, but no luck.=20
>>=20
>> We tried the same experiment on a bare metal. It was 4K RR IOPs were=
 scaling from 40K(1 RBD) to 180K(4 RBDs). But after that rather than sc=
aling beyond that point the numbers were actually degrading. (Single pi=
pe more congestion effect)=20
>>=20
>> We never suspected that rbd cache enable could be detrimental to per=
formance. It would nice to route cause the problem if that is the case.=
=20
>>=20
>> On Tue, Jun 9, 2015 at 11:21 AM, Alexandre DERUMIER < aderumier@odis=
o.com > wrote:=20
>>=20
>>=20
>> Hi,=20
>>=20
>> I'm doing benchmark (ceph master branch), with randread 4k qdepth=3D=
32,=20
>> and rbd_cache=3Dtrue seem to limit the iops around 40k=20
>>=20
>>=20
>> no cache=20
>> --------=20
>> 1 client - rbd_cache=3Dfalse - 1osd : 38300 iops=20
>> 1 client - rbd_cache=3Dfalse - 2osd : 69073 iops=20
>> 1 client - rbd_cache=3Dfalse - 3osd : 78292 iops=20
>>=20
>>=20
>> cache=20
>> -----=20
>> 1 client - rbd_cache=3Dtrue - 1osd : 38100 iops=20
>> 1 client - rbd_cache=3Dtrue - 2osd : 42457 iops=20
>> 1 client - rbd_cache=3Dtrue - 3osd : 45823 iops=20
>>=20
>>=20
>>=20
>> Is it expected ?=20
>>=20
>>=20
>>=20
>> fio result rbd_cache=3Dfalse 3 osd=20
>> --------------------------------=20
>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, =
ioengine=3Drbd, iodepth=3D32=20
>> fio-2.1.11=20
>> Starting 1 process=20
>> rbd engine: RBD version: 0.1.9=20
>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/0/=
0 iops] [eta 00m:00s]=20
>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113548:=
 Tue Jun 9 07:48:42 2015=20
>> read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292, runt=3D 32698mse=
c=20
>> slat (usec): min=3D5, max=3D530, avg=3D11.77, stdev=3D 6.77=20
>> clat (usec): min=3D70, max=3D2240, avg=3D336.08, stdev=3D94.82=20
>> lat (usec): min=3D101, max=3D2247, avg=3D347.84, stdev=3D95.49=20
>> clat percentiles (usec):=20
>> | 1.00th=3D[ 173], 5.00th=3D[ 209], 10.00th=3D[ 231], 20.00th=3D[ 26=
2],=20
>> | 30.00th=3D[ 282], 40.00th=3D[ 302], 50.00th=3D[ 322], 60.00th=3D[ =
346],=20
>> | 70.00th=3D[ 370], 80.00th=3D[ 402], 90.00th=3D[ 454], 95.00th=3D[ =
506],=20
>> | 99.00th=3D[ 628], 99.50th=3D[ 692], 99.90th=3D[ 860], 99.95th=3D[ =
948],=20
>> | 99.99th=3D[ 1176]=20
>> bw (KB /s): min=3D238856, max=3D360448, per=3D100.00%, avg=3D313402.=
34, stdev=3D25196.21=20
>> lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5.19%, 1=
000=3D0.23%=20
>> lat (msec) : 2=3D0.03%, 4=3D0.01%=20
>> cpu : usr=3D74.48%, sys=3D13.25%, ctx=3D703225, majf=3D0, minf=3D124=
52=20
>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=3D87.0%, 32=3D=
12.1%, >=3D64=3D0.0%=20
>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>> complete : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5%, 32=3D0.4%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>=20
>> Run status group 0 (all jobs):=20
>> READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s, maxb=3D31=
3169KB/s, mint=3D32698msec, maxt=3D32698msec=20
>>=20
>> Disk stats (read/write):=20
>> dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.0=
0%, aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, aggrin_queue=3D0=
, aggrutil=3D0.00%=20
>> sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0.0=
0%=20
>>=20
>>=20
>>=20
>>=20
>> fio result rbd_cache=3Dtrue 3osd=20
>> ------------------------------=20
>>=20
>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, =
ioengine=3Drbd, iodepth=3D32=20
>> fio-2.1.11=20
>> Starting 1 process=20
>> rbd engine: RBD version: 0.1.9=20
>> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/0/=
0 iops] [eta 00m:00s]=20
>> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113389:=
 Tue Jun 9 07:47:30 2015=20
>> read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823, runt=3D 55866mse=
c=20
>> slat (usec): min=3D7, max=3D805, avg=3D21.26, stdev=3D15.84=20
>> clat (usec): min=3D101, max=3D4602, avg=3D478.55, stdev=3D143.73=20
>> lat (usec): min=3D123, max=3D4669, avg=3D499.80, stdev=3D146.03=20
>> clat percentiles (usec):=20
>> | 1.00th=3D[ 227], 5.00th=3D[ 274], 10.00th=3D[ 306], 20.00th=3D[ 35=
0],=20
>> | 30.00th=3D[ 390], 40.00th=3D[ 430], 50.00th=3D[ 470], 60.00th=3D[ =
506],=20
>> | 70.00th=3D[ 548], 80.00th=3D[ 596], 90.00th=3D[ 660], 95.00th=3D[ =
724],=20
>> | 99.00th=3D[ 844], 99.50th=3D[ 908], 99.90th=3D[ 1112], 99.95th=3D[=
 1288],=20
>> | 99.99th=3D[ 2192]=20
>> bw (KB /s): min=3D115280, max=3D204416, per=3D100.00%, avg=3D183315.=
10, stdev=3D15079.93=20
>> lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.48%, 1000=3D3.28%=20
>> lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%=20
>> cpu : usr=3D60.27%, sys=3D12.01%, ctx=3D2995393, majf=3D0, minf=3D14=
100=20
>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=3D81.0%, 32=3D=
5.3%, >=3D64=3D0.0%=20
>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>> complete : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0%, 32=3D4.0%, 64=3D=
0.0%, >=3D64=3D0.0%=20
>> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20
>> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>>=20
>> Run status group 0 (all jobs):=20
>> READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s, maxb=3D18=
3295KB/s, mint=3D55866msec, maxt=3D55866msec=20
>>=20
>> Disk stats (read/write):=20
>> dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_queue=3D8, util=3D0.0=
1%, aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, aggrin_queue=3D8=
, aggrutil=3D0.01%=20
>> sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0.0=
1%=20
>>=20
> _______________________________________________=20
> ceph-users mailing list=20
> ceph-users@lists.ceph.com=20
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
