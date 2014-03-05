From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [RFC] add rocksdb support
Date: Wed, 05 Mar 2014 09:23:12 +0100 (CET)
Message-ID: <56c52f05-53b9-438f-b027-a7838238b50f@mailpro>
References: <75674D092A819E4189E91166C74CB90D01320A1F@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:60380 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbaCEIXW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Mar 2014 03:23:22 -0500
In-Reply-To: <75674D092A819E4189E91166C74CB90D01320A1F@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinxin Shu <xinxin.shu@intel.com>
Cc: ceph-devel@vger.kernel.org

>>Hi Alexandre, below is random io test results, almost the same iops.=20

Thanks Xinxin, seem not too bad indeed.  and latencies seem to be a lit=
tle lower than leveldb

(this was with 7,2k disks ? replication 2x or 3x ?)



----- Mail original -----=20

De: "Xinxin Shu" <xinxin.shu@intel.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mardi 4 Mars 2014 09:41:05=20
Objet: RE: [RFC] add rocksdb support=20

Hi Alexandre, below is random io test results, almost the same iops.=20

Rocksdb results=20

ebs_test: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3Dr=
bd, iodepth=3D64=20
fio-2.1.4=20
Starting 1 thread=20
rbd engine: RBD version: 0.1.8=20
Jobs: 1 (f=3D1): [w] [100.0% done] [0KB/23094KB/0KB /s] [0/5773/0 iops]=
 [eta 00m:00s]=20
ebs_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D47154: Tue Mar 4 13:=
48:22 2014=20
write: io=3D3356.2MB, bw=3D17183KB/s, iops=3D4295, runt=3D200004msec=20
slat (usec): min=3D19, max=3D8855, avg=3D134.33, stdev=3D259.00=20
clat (usec): min=3D73, max=3D4397.6K, avg=3D12756.12, stdev=3D79341.35=20
lat (msec): min=3D1, max=3D4397, avg=3D12.89, stdev=3D79.34=20
clat percentiles (usec):=20
| 1.00th=3D[ 1432], 5.00th=3D[ 1752], 10.00th=3D[ 2128], 20.00th=3D[ 34=
08],=20
| 30.00th=3D[ 4768], 40.00th=3D[ 5856], 50.00th=3D[ 6880], 60.00th=3D[ =
7904],=20
| 70.00th=3D[ 8896], 80.00th=3D[10048], 90.00th=3D[11968], 95.00th=3D[1=
4016],=20
| 99.00th=3D[27520], 99.50th=3D[505856], 99.90th=3D[1204224], 99.95th=3D=
[1433600],=20
| 99.99th=3D[2834432]=20
bw (KB /s): min=3D 403, max=3D24392, per=3D100.00%, avg=3D17358.47, std=
ev=3D7446.69=20
lat (usec) : 100=3D0.01%, 250=3D0.01%, 500=3D0.01%, 750=3D0.01%, 1000=3D=
0.01%=20
lat (msec) : 2=3D8.36%, 4=3D15.77%, 10=3D55.27%, 20=3D19.17%, 50=3D0.51=
%=20
lat (msec) : 100=3D0.09%, 250=3D0.16%, 500=3D0.14%, 750=3D0.19%, 1000=3D=
0.15%=20
lat (msec) : 2000=3D0.16%, >=3D2000=3D0.01%=20
cpu : usr=3D18.04%, sys=3D4.15%, ctx=3D1875119, majf=3D0, minf=3D838=20
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D1.1%, 16=3D10.9%, 32=3D65=
=2E9%, >=3D64=3D22.1%=20
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0=
%, >=3D64=3D0.0%=20
complete : 0=3D0.0%, 4=3D97.6%, 8=3D0.4%, 16=3D0.4%, 32=3D0.6%, 64=3D0.=
9%, >=3D64=3D0.0%=20
issued : total=3Dr=3D0/w=3D859165/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20

Run status group 0 (all jobs):=20
WRITE: io=3D3356.2MB, aggrb=3D17182KB/s, minb=3D17182KB/s, maxb=3D17182=
KB/s, mint=3D200004msec, maxt=3D200004msec=20

Disk stats (read/write):=20
sda: ios=3D0/2191, merge=3D0/2904, ticks=3D0/936, in_queue=3D936, util=3D=
0.29%=20

leveldb results:=20

ebs_test: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3Dr=
bd, iodepth=3D64=20
fio-2.1.4=20
Starting 1 thread=20
rbd engine: RBD version: 0.1.8=20
Jobs: 1 (f=3D1): [w] [100.0% done] [0KB/9428KB/0KB /s] [0/2357/0 iops] =
[eta 00m:00s]=20
ebs_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D112425: Tue Mar 4 14=
:54:00 2014=20
write: io=3D3404.9MB, bw=3D17431KB/s, iops=3D4357, runt=3D200016msec=20
slat (usec): min=3D20, max=3D7698, avg=3D114.01, stdev=3D201.06=20
clat (usec): min=3D220, max=3D3278.3K, avg=3D13340.59, stdev=3D76874.35=
=20
lat (msec): min=3D1, max=3D3278, avg=3D13.45, stdev=3D76.87=20
clat percentiles (usec):=20
| 1.00th=3D[ 1400], 5.00th=3D[ 1608], 10.00th=3D[ 1784], 20.00th=3D[ 21=
92],=20
| 30.00th=3D[ 2832], 40.00th=3D[ 3824], 50.00th=3D[ 5024], 60.00th=3D[ =
6240],=20
| 70.00th=3D[ 7456], 80.00th=3D[ 8768], 90.00th=3D[10816], 95.00th=3D[1=
3120],=20
| 99.00th=3D[284672], 99.50th=3D[610304], 99.90th=3D[1089536], 99.95th=3D=
[1286144],=20
| 99.99th=3D[1630208]=20
bw (KB /s): min=3D 24, max=3D25548, per=3D100.00%, avg=3D17606.69, stde=
v=3D6779.23=20
lat (usec) : 250=3D0.01%, 500=3D0.01%, 750=3D0.01%, 1000=3D0.01%=20
lat (msec) : 2=3D15.63%, 4=3D25.94%, 10=3D45.35%, 20=3D10.98%, 50=3D0.4=
4%=20
lat (msec) : 100=3D0.17%, 250=3D0.40%, 500=3D0.42%, 750=3D0.34%, 1000=3D=
0.19%=20
lat (msec) : 2000=3D0.12%, >=3D2000=3D0.01%=20
cpu : usr=3D18.25%, sys=3D4.14%, ctx=3D1887389, majf=3D0, minf=3D742=20
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.5%, 16=3D6.0%, 32=3D55.=
9%, >=3D64=3D37.5%=20
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0=
%, >=3D64=3D0.0%=20
complete : 0=3D0.0%, 4=3D97.8%, 8=3D0.7%, 16=3D0.5%, 32=3D0.5%, 64=3D0.=
5%, >=3D64=3D0.0%=20
issued : total=3Dr=3D0/w=3D871635/d=3D0, short=3Dr=3D0/w=3D0/d=3D0=20

Run status group 0 (all jobs):=20
WRITE: io=3D3404.9MB, aggrb=3D17431KB/s, minb=3D17431KB/s, maxb=3D17431=
KB/s, mint=3D200016msec, maxt=3D200016msec=20

Disk stats (read/write):=20
sda: ios=3D0/2125, merge=3D0/2796, ticks=3D0/708, in_queue=3D708, util=3D=
0.23%=20

-----Original Message-----=20
=46rom: Alexandre DERUMIER [mailto:aderumier@odiso.com]=20
Sent: Tuesday, March 04, 2014 12:49 PM=20
To: Shu, Xinxin=20
Cc: ceph-devel@vger.kernel.org=20
Subject: Re: [RFC] add rocksdb support=20

>>Performance Test=20
>>Attached file is the performance comparison of rocksdb and leveldb on=
 four nodes with 40 osds, using 'rados bench' as the test tool. The per=
formance results is quite promising.=20

Thanks for your work, indeed performance seem to be promising !=20

>>Any comments or suggestions are greatly appreciated.=20

Could you do test with random io write with last fio (with rbd support)=
 ?=20

http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-February/00818=
2.html=20
> The fio command: fio -direct=3D1 -iodepth=3D64 -thread -rw=3Drandwrit=
e=20
>> -ioengine=3Drbd -bs=3D4k -size=3D19G -numjobs=3D1 -runtime=3D100=20
>> -group_reporting -name=3Debs_test -pool=3Dopenstack -rbdname=3Dimage=
=20
>> -clientname=3Dfio -invalidate=3D0=20


----- Mail original -----=20

De: "Xinxin Shu" <xinxin.shu@intel.com>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 3 Mars 2014 03:07:18=20
Objet: [RFC] add rocksdb support=20

Hi all,=20

This patch added rocksdb support for ceph, enabled rocksdb for omap dir=
ectory. Rocksdb source code can be get from link. To use use rocksdb, C=
++11 standard should be enabled, gcc version >=3D 4.7 is required to ge=
t C++11 support. Rocksdb can be installed with instructions described i=
n the INSTALL.md file, and rocksdb header files (include/rocksdb/*) and=
 library (librocksdb.so*) need to be copied to corresponding directorie=
s.=20
To enable rocksdb, add "--with-librocksdb" option to configure. The roc=
ksdb branch is here(https://github.com/xinxinsh/ceph/tree/rocksdb).=20


Performance Test=20
Attached file is the performance comparison of rocksdb and leveldb on f=
our nodes with 40 osds, using 'rados bench' as the test tool. The perfo=
rmance results is quite promising.=20

Any comments or suggestions are greatly appreciated.=20

Rados bench BandWidth(MB/s) Average latency Leveldb rocksdb Leveldb roc=
ksdb write 4 threads 263.762 272.549 0.061 0.059 write 8 threads 449.83=
4 457.811 0.071 0.070 write 16 threads 642.100 638.972 0.100 0.100 writ=
e 32 threads 705.897 717.598 0.181 0.178 write 64 threads 705.011 717.2=
04 0.370 0.362 read 4 threads 873.588 841.704 0.073 0.076 read 8 thread=
s 816.699 818.451 0.078 0.078 read 16 threads 808.810 798.053 0.079 0.0=
80 read 32 threads 798.394 802.796 0.080 0.080 read 64 threads 792.848 =
790.593 0.081 0.081=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
