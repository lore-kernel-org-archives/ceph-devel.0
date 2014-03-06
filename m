From: "Shu, Xinxin" <xinxin.shu@intel.com>
Subject: RE: [RFC] add rocksdb support
Date: Thu, 6 Mar 2014 09:18:44 +0000
Message-ID: <75674D092A819E4189E91166C74CB90D0132158E@SHSMSX104.ccr.corp.intel.com>
References: <75674D092A819E4189E91166C74CB90D01320A1F@SHSMSX104.ccr.corp.intel.com>
	<56c52f05-53b9-438f-b027-a7838238b50f@mailpro>,<CACJqLybjX16fzRA+uGq0kh0euQqXd7X5sg404KpLnfNu5m5e7Q@mail.gmail.com>
 <3472A07E6605974CBC9BC573F1BC02E4AE6E5996@CERNXCHG41.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42879 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbaCFJTD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 04:19:03 -0500
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6E5996@CERNXCHG41.cern.ch>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Haomai Wang <haomaiwang@gmail.com>, Alexandre DERUMIER <aderumier@odiso.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I don't get the exact number, but from the size of files , we don't get=
 billions of entries.

-----Original Message-----
=46rom: Andreas Joachim Peters [mailto:Andreas.Joachim.Peters@cern.ch]=20
Sent: Wednesday, March 05, 2014 5:19 PM
To: Haomai Wang; Alexandre DERUMIER
Cc: Shu, Xinxin; ceph-devel@vger.kernel.org
Subject: RE: [RFC] add rocksdb support

To me this numbers look within error bars identical and isn't that expe=
cted?

The main benefit of Rocksdb vs. Leveldb you can see when you create lar=
ge tables going to 1 billion entries.

How many keys did you create per OSD in your Rados benchmarks?

Cheers Andreas.

________________________________________
=46rom: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.=
org] on behalf of Haomai Wang [haomaiwang@gmail.com]
Sent: 05 March 2014 09:31
To: Alexandre DERUMIER
Cc: Xinxin Shu; ceph-devel@vger.kernel.org
Subject: Re: [RFC] add rocksdb support

I think the reason why the little difference between leveldb and rocksd=
b in FileStore is that the main latency cause isn't KeyValueDB backend.

So we may not get enough benefit from rocksdb instead of leveldb by Fil=
eStore.

On Wed, Mar 5, 2014 at 4:23 PM, Alexandre DERUMIER <aderumier@odiso.com=
> wrote:
>>>Hi Alexandre, below is random io test results, almost the same iops.
>
> Thanks Xinxin, seem not too bad indeed.  and latencies seem to be a=20
> little lower than leveldb
>
> (this was with 7,2k disks ? replication 2x or 3x ?)
>
>
>
> ----- Mail original -----
>
> De: "Xinxin Shu" <xinxin.shu@intel.com>
> =C0: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: ceph-devel@vger.kernel.org
> Envoy=E9: Mardi 4 Mars 2014 09:41:05
> Objet: RE: [RFC] add rocksdb support
>
> Hi Alexandre, below is random io test results, almost the same iops.
>
> Rocksdb results
>
> ebs_test: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3D=
rbd,=20
> iodepth=3D64
> fio-2.1.4
> Starting 1 thread
> rbd engine: RBD version: 0.1.8
> Jobs: 1 (f=3D1): [w] [100.0% done] [0KB/23094KB/0KB /s] [0/5773/0 iop=
s]=20
> [eta 00m:00s]
> ebs_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D47154: Tue Mar 4 1=
3:48:22=20
> 2014
> write: io=3D3356.2MB, bw=3D17183KB/s, iops=3D4295, runt=3D200004msec =
slat=20
> (usec): min=3D19, max=3D8855, avg=3D134.33, stdev=3D259.00 clat (usec=
):=20
> min=3D73, max=3D4397.6K, avg=3D12756.12, stdev=3D79341.35 lat (msec):=
 min=3D1,=20
> max=3D4397, avg=3D12.89, stdev=3D79.34 clat percentiles (usec):
> | 1.00th=3D[ 1432], 5.00th=3D[ 1752], 10.00th=3D[ 2128], 20.00th=3D[ =
3408],=20
> | 30.00th=3D[ 4768], 40.00th=3D[ 5856], 50.00th=3D[ 6880], 60.00th=3D=
[ 7904],=20
> | 70.00th=3D[ 8896], 80.00th=3D[10048], 90.00th=3D[11968], 95.00th=3D=
[14016],=20
> | 99.00th=3D[27520], 99.50th=3D[505856], 99.90th=3D[1204224],=20
> | 99.95th=3D[1433600], 99.99th=3D[2834432]
> bw (KB /s): min=3D 403, max=3D24392, per=3D100.00%, avg=3D17358.47,=20
> stdev=3D7446.69 lat (usec) : 100=3D0.01%, 250=3D0.01%, 500=3D0.01%, 7=
50=3D0.01%,=20
> 1000=3D0.01% lat (msec) : 2=3D8.36%, 4=3D15.77%, 10=3D55.27%, 20=3D19=
=2E17%,=20
> 50=3D0.51% lat (msec) : 100=3D0.09%, 250=3D0.16%, 500=3D0.14%, 750=3D=
0.19%,=20
> 1000=3D0.15% lat (msec) : 2000=3D0.16%, >=3D2000=3D0.01% cpu : usr=3D=
18.04%,=20
> sys=3D4.15%, ctx=3D1875119, majf=3D0, minf=3D838 IO depths : 1=3D0.1%=
, 2=3D0.1%,=20
> 4=3D0.1%, 8=3D1.1%, 16=3D10.9%, 32=3D65.9%, >=3D64=3D22.1% submit : 0=
=3D0.0%,=20
> 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0% =
complete :=20
> 0=3D0.0%, 4=3D97.6%, 8=3D0.4%, 16=3D0.4%, 32=3D0.6%, 64=3D0.9%, >=3D6=
4=3D0.0% issued :=20
> total=3Dr=3D0/w=3D859165/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
>
> Run status group 0 (all jobs):
> WRITE: io=3D3356.2MB, aggrb=3D17182KB/s, minb=3D17182KB/s, maxb=3D171=
82KB/s,=20
> mint=3D200004msec, maxt=3D200004msec
>
> Disk stats (read/write):
> sda: ios=3D0/2191, merge=3D0/2904, ticks=3D0/936, in_queue=3D936, uti=
l=3D0.29%
>
> leveldb results:
>
> ebs_test: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3D=
rbd,=20
> iodepth=3D64
> fio-2.1.4
> Starting 1 thread
> rbd engine: RBD version: 0.1.8
> Jobs: 1 (f=3D1): [w] [100.0% done] [0KB/9428KB/0KB /s] [0/2357/0 iops=
]=20
> [eta 00m:00s]
> ebs_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D112425: Tue Mar 4 =
14:54:00=20
> 2014
> write: io=3D3404.9MB, bw=3D17431KB/s, iops=3D4357, runt=3D200016msec =
slat=20
> (usec): min=3D20, max=3D7698, avg=3D114.01, stdev=3D201.06 clat (usec=
):=20
> min=3D220, max=3D3278.3K, avg=3D13340.59, stdev=3D76874.35 lat (msec)=
: min=3D1,=20
> max=3D3278, avg=3D13.45, stdev=3D76.87 clat percentiles (usec):
> | 1.00th=3D[ 1400], 5.00th=3D[ 1608], 10.00th=3D[ 1784], 20.00th=3D[ =
2192],=20
> | 30.00th=3D[ 2832], 40.00th=3D[ 3824], 50.00th=3D[ 5024], 60.00th=3D=
[ 6240],=20
> | 70.00th=3D[ 7456], 80.00th=3D[ 8768], 90.00th=3D[10816], 95.00th=3D=
[13120],=20
> | 99.00th=3D[284672], 99.50th=3D[610304], 99.90th=3D[1089536],=20
> | 99.95th=3D[1286144], 99.99th=3D[1630208]
> bw (KB /s): min=3D 24, max=3D25548, per=3D100.00%, avg=3D17606.69,=20
> stdev=3D6779.23 lat (usec) : 250=3D0.01%, 500=3D0.01%, 750=3D0.01%, 1=
000=3D0.01%=20
> lat (msec) : 2=3D15.63%, 4=3D25.94%, 10=3D45.35%, 20=3D10.98%, 50=3D0=
=2E44% lat=20
> (msec) : 100=3D0.17%, 250=3D0.40%, 500=3D0.42%, 750=3D0.34%, 1000=3D0=
=2E19% lat=20
> (msec) : 2000=3D0.12%, >=3D2000=3D0.01% cpu : usr=3D18.25%, sys=3D4.1=
4%,=20
> ctx=3D1887389, majf=3D0, minf=3D742 IO depths : 1=3D0.1%, 2=3D0.1%, 4=
=3D0.1%,=20
> 8=3D0.5%, 16=3D6.0%, 32=3D55.9%, >=3D64=3D37.5% submit : 0=3D0.0%, 4=3D=
100.0%,=20
> 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0% complete : 0=
=3D0.0%,=20
> 4=3D97.8%, 8=3D0.7%, 16=3D0.5%, 32=3D0.5%, 64=3D0.5%, >=3D64=3D0.0% i=
ssued :=20
> total=3Dr=3D0/w=3D871635/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
>
> Run status group 0 (all jobs):
> WRITE: io=3D3404.9MB, aggrb=3D17431KB/s, minb=3D17431KB/s, maxb=3D174=
31KB/s,=20
> mint=3D200016msec, maxt=3D200016msec
>
> Disk stats (read/write):
> sda: ios=3D0/2125, merge=3D0/2796, ticks=3D0/708, in_queue=3D708, uti=
l=3D0.23%
>
> -----Original Message-----
> From: Alexandre DERUMIER [mailto:aderumier@odiso.com]
> Sent: Tuesday, March 04, 2014 12:49 PM
> To: Shu, Xinxin
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: [RFC] add rocksdb support
>
>>>Performance Test
>>>Attached file is the performance comparison of rocksdb and leveldb o=
n four nodes with 40 osds, using 'rados bench' as the test tool. The pe=
rformance results is quite promising.
>
> Thanks for your work, indeed performance seem to be promising !
>
>>>Any comments or suggestions are greatly appreciated.
>
> Could you do test with random io write with last fio (with rbd suppor=
t) ?
>
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-February/008=
1
> 82.html
>> The fio command: fio -direct=3D1 -iodepth=3D64 -thread -rw=3Drandwri=
te
>>> -ioengine=3Drbd -bs=3D4k -size=3D19G -numjobs=3D1 -runtime=3D100=20
>>> -group_reporting -name=3Debs_test -pool=3Dopenstack -rbdname=3Dimag=
e=20
>>> -clientname=3Dfio -invalidate=3D0
>
>
> ----- Mail original -----
>
> De: "Xinxin Shu" <xinxin.shu@intel.com>
> =C0: ceph-devel@vger.kernel.org
> Envoy=E9: Lundi 3 Mars 2014 03:07:18
> Objet: [RFC] add rocksdb support
>
> Hi all,
>
> This patch added rocksdb support for ceph, enabled rocksdb for omap d=
irectory. Rocksdb source code can be get from link. To use use rocksdb,=
 C++11 standard should be enabled, gcc version >=3D 4.7 is required to =
get C++11 support. Rocksdb can be installed with instructions described=
 in the INSTALL.md file, and rocksdb header files (include/rocksdb/*) a=
nd library (librocksdb.so*) need to be copied to corresponding director=
ies.
> To enable rocksdb, add "--with-librocksdb" option to configure. The r=
ocksdb branch is here(https://github.com/xinxinsh/ceph/tree/rocksdb).
>
>
> Performance Test
> Attached file is the performance comparison of rocksdb and leveldb on=
 four nodes with 40 osds, using 'rados bench' as the test tool. The per=
formance results is quite promising.
>
> Any comments or suggestions are greatly appreciated.
>
> Rados bench BandWidth(MB/s) Average latency Leveldb rocksdb Leveldb=20
> rocksdb write 4 threads 263.762 272.549 0.061 0.059 write 8 threads=20
> 449.834 457.811 0.071 0.070 write 16 threads 642.100 638.972 0.100=20
> 0.100 write 32 threads 705.897 717.598 0.181 0.178 write 64 threads=20
> 705.011 717.204 0.370 0.362 read 4 threads 873.588 841.704 0.073 0.07=
6=20
> read 8 threads 816.699 818.451 0.078 0.078 read 16 threads 808.810=20
> 798.053 0.079 0.080 read 32 threads 798.394 802.796 0.080 0.080 read=20
> 64 threads 792.848 790.593 0.081 0.081
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html



--
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
