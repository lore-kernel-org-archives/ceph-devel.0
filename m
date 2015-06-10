From: Irek Fasikhov <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: rbd_cache, limiting read on high iops around 40k
Date: Wed, 10 Jun 2015 08:21:42 +0300
Message-ID: <CAF-rypxjbsH3GdUG474OgSZVjdzKyf_0n8-zAkAuGhk83TXQhA@mail.gmail.com>
References: <1684793881.1564583.1433829106394.JavaMail.zimbra@oxygem.tv>
	<CAMc8nAWo-jnAHS5cLw5gDt57T3vZpiN79vFXc=pz=+Cjm6Ra6A@mail.gmail.com>
	<959572886.1627596.1433834901443.JavaMail.zimbra@oxygem.tv>
	<1897614581.1694878.1433838989184.JavaMail.zimbra@oxygem.tv>
	<5576CFBF.1070405@redhat.com>
	<1208111516.1790161.1433851367996.JavaMail.zimbra@oxygem.tv>
	<CAANLjFo5qNmWPdOvVo83W10q7xkww7+vjG3BLKArZ3RqmmaMNg@mail.gmail.com>
	<1058039366.2034449.1433868447253.JavaMail.zimbra@oxygem.tv>
	<284297771.2095666.1433909407567.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2106350416=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <284297771.2095666.1433909407567.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pushpesh sharma <pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2106350416==
Content-Type: multipart/alternative; boundary=001a1134d8b0142e700518230e78

--001a1134d8b0142e700518230e78
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, Alexandre.

Very good work!
Do you have a rpm-file?
Thanks.

2015-06-10 7:10 GMT+03:00 Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>:

> Hi,
>
> I have tested qemu with last tcmalloc 2.4, and the improvement is huge
> with iothread: 50k iops (+45%) !
>
>
>
> qemu : no iothread : glibc : iops=3D33395
> qemu : no-iothread : tcmalloc (2.2.1) : iops=3D34516 (+3%)
> qemu : no-iothread : jemmaloc : iops=3D42226 (+26%)
> qemu : no-iothread : tcmalloc (2.4) : iops=3D35974 (+7%)
>
>
> qemu : iothread : glibc : iops=3D34516
> qemu : iothread : tcmalloc : iops=3D38676 (+12%)
> qemu : iothread : jemmaloc : iops=3D28023 (-19%)
> qemu : iothread : tcmalloc (2.4) : iops=3D50276 (+45%)
>
>
>
>
>
> qemu : iothread : tcmalloc (2.4) : iops=3D50276 (+45%)
> ------------------------------------------------------
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> fio-2.1.11
> Starting 1 process
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [214.7MB/0KB/0KB /s] [54.1K/0/0 iop=
s]
> [eta 00m:00s]
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D894: Wed Jun=
 10
> 05:54:24 2015
>   read : io=3D5120.0MB, bw=3D201108KB/s, iops=3D50276, runt=3D 26070msec
>     slat (usec): min=3D1, max=3D1136, avg=3D 3.54, stdev=3D 3.58
>     clat (usec): min=3D128, max=3D6262, avg=3D631.41, stdev=3D197.71
>      lat (usec): min=3D149, max=3D6265, avg=3D635.27, stdev=3D197.40
>     clat percentiles (usec):
>      |  1.00th=3D[  318],  5.00th=3D[  378], 10.00th=3D[  418], 20.00th=
=3D[  474],
>      | 30.00th=3D[  516], 40.00th=3D[  564], 50.00th=3D[  612], 60.00th=
=3D[  652],
>      | 70.00th=3D[  700], 80.00th=3D[  756], 90.00th=3D[  860], 95.00th=
=3D[  980],
>      | 99.00th=3D[ 1272], 99.50th=3D[ 1384], 99.90th=3D[ 1688], 99.95th=
=3D[ 1896],
>      | 99.99th=3D[ 3760]
>     bw (KB  /s): min=3D145608, max=3D249688, per=3D100.00%, avg=3D201108.=
00,
> stdev=3D21718.87
>     lat (usec) : 250=3D0.04%, 500=3D25.84%, 750=3D53.00%, 1000=3D16.63%
>     lat (msec) : 2=3D4.46%, 4=3D0.03%, 10=3D0.01%
>   cpu          : usr=3D9.73%, sys=3D24.93%, ctx=3D66417, majf=3D0, minf=
=3D38
>   IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%,
> >=3D64=3D0.0%
>      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
> >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=
=3D0.0%,
> >=3D64=3D0.0%
>      issued    : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
>    READ: io=3D5120.0MB, aggrb=3D201107KB/s, minb=3D201107KB/s, maxb=3D201=
107KB/s,
> mint=3D26070msec, maxt=3D26070msec
>
> Disk stats (read/write):
>   vdb: ios=3D1302555/0, merge=3D0/0, ticks=3D715176/0, in_queue=3D714840,
> util=3D99.73%
>
>
>
>
>
>
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> fio-2.1.11
> Starting 1 process
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [158.7MB/0KB/0KB /s] [40.6K/0/0 iop=
s]
> [eta 00m:00s]
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D889: Wed Jun=
 10
> 06:05:06 2015
>   read : io=3D5120.0MB, bw=3D143897KB/s, iops=3D35974, runt=3D 36435msec
>     slat (usec): min=3D1, max=3D710, avg=3D 3.31, stdev=3D 3.35
>     clat (usec): min=3D191, max=3D4740, avg=3D884.66, stdev=3D315.65
>      lat (usec): min=3D289, max=3D4743, avg=3D888.31, stdev=3D315.51
>     clat percentiles (usec):
>      |  1.00th=3D[  462],  5.00th=3D[  516], 10.00th=3D[  548], 20.00th=
=3D[  596],
>      | 30.00th=3D[  652], 40.00th=3D[  764], 50.00th=3D[  868], 60.00th=
=3D[  940],
>      | 70.00th=3D[ 1004], 80.00th=3D[ 1096], 90.00th=3D[ 1256], 95.00th=
=3D[ 1416],
>      | 99.00th=3D[ 2024], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=
=3D[ 2640],
>      | 99.99th=3D[ 3632]
>     bw (KB  /s): min=3D98352, max=3D177328, per=3D99.91%, avg=3D143772.11=
,
> stdev=3D21782.39
>     lat (usec) : 250=3D0.01%, 500=3D3.48%, 750=3D35.69%, 1000=3D30.01%
>     lat (msec) : 2=3D29.74%, 4=3D1.07%, 10=3D0.01%
>   cpu          : usr=3D7.10%, sys=3D16.90%, ctx=3D54855, majf=3D0, minf=
=3D38
>   IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
100.0%,
> >=3D64=3D0.0%
>      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%,
> >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=
=3D0.0%,
> >=3D64=3D0.0%
>      issued    : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
>    READ: io=3D5120.0MB, aggrb=3D143896KB/s, minb=3D143896KB/s, maxb=3D143=
896KB/s,
> mint=3D36435msec, maxt=3D36435msec
>
> Disk stats (read/write):
>   vdb: ios=3D1301357/0, merge=3D0/0, ticks=3D1033036/0, in_queue=3D103271=
6,
> util=3D99.85%
>
>
> ----- Mail original -----
> De: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> =C3=80: "Robert LeBlanc" <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
> Cc: "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel" <
> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pushpesh sharma" <pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
> "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> Envoy=C3=A9: Mardi 9 Juin 2015 18:47:27
> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 40k
>
> Hi Robert,
>
> >>What I found was that Ceph OSDs performed well with either
> >>tcmalloc or jemalloc (except when RocksDB was built with jemalloc
> >>instead of tcmalloc, I'm still working to dig into why that might be
> >>the case).
> yes,from my test, for osd tcmalloc is a little faster (but very little)
> than jemalloc.
>
>
>
> >>However, I found that tcmalloc with QEMU/KVM was very detrimental to
> >>small I/O, but provided huge gains in I/O >=3D1MB. Jemalloc was much
> >>better for QEMU/KVM in the tests that we ran. [1]
>
>
> Just have done qemu test (4k randread - rbd_cache=3Doff), I don't see spe=
ed
> regression with tcmalloc.
> with qemu iothread, tcmalloc have a speed increase over glib
> with qemu iothread, jemalloc have a speed decrease
>
> without iothread, jemalloc have a big speed increase
>
> this is with
> -qemu 2.3
> -tcmalloc 2.2.1
> -jemmaloc 3.6
> -libc6 2.19
>
>
> qemu : no iothread : glibc : iops=3D33395
> qemu : no-iothread : tcmalloc : iops=3D34516 (+3%)
> qemu : no-iothread : jemmaloc : iops=3D42226 (+26%)
>
> qemu : iothread : glibc : iops=3D34516
> qemu : iothread : tcmalloc : iops=3D38676 (+12%)
> qemu : iothread : jemmaloc : iops=3D28023 (-19%)
>
>
> (The benefit of iothreads is that we can scale with more disks in 1vm)
>
>
> fio results:
> ------------
>
> qemu : iothread : tcmalloc : iops=3D38676
> -----------------------------------------
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> fio-2.1.11
> Starting 1 process
> Jobs: 1 (f=3D0): [r(1)] [100.0% done] [123.5MB/0KB/0KB /s] [31.6K/0/0 iop=
s]
> [eta 00m:00s]
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D1265: Tue Ju=
n 9
> 18:16:53 2015
> read : io=3D5120.0MB, bw=3D154707KB/s, iops=3D38676, runt=3D 33889msec
> slat (usec): min=3D1, max=3D715, avg=3D 3.63, stdev=3D 3.42
> clat (usec): min=3D152, max=3D5736, avg=3D822.12, stdev=3D289.34
> lat (usec): min=3D231, max=3D5740, avg=3D826.10, stdev=3D289.08
> clat percentiles (usec):
> | 1.00th=3D[ 402], 5.00th=3D[ 466], 10.00th=3D[ 510], 20.00th=3D[ 572],
> | 30.00th=3D[ 636], 40.00th=3D[ 716], 50.00th=3D[ 780], 60.00th=3D[ 852],
> | 70.00th=3D[ 932], 80.00th=3D[ 1020], 90.00th=3D[ 1160], 95.00th=3D[ 135=
2],
> | 99.00th=3D[ 1800], 99.50th=3D[ 1944], 99.90th=3D[ 2256], 99.95th=3D[ 24=
48],
> | 99.99th=3D[ 3888]
> bw (KB /s): min=3D123888, max=3D198584, per=3D100.00%, avg=3D154824.40,
> stdev=3D16978.03
> lat (usec) : 250=3D0.01%, 500=3D8.91%, 750=3D36.44%, 1000=3D32.63%
> lat (msec) : 2=3D21.65%, 4=3D0.37%, 10=3D0.01%
> cpu : usr=3D8.29%, sys=3D19.76%, ctx=3D55882, majf=3D0, minf=3D39
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0=
%, >=3D64=3D0.0%
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,=
 >=3D64=3D0.0%
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0=
%, >=3D64=3D0.0%
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
> READ: io=3D5120.0MB, aggrb=3D154707KB/s, minb=3D154707KB/s, maxb=3D154707=
KB/s,
> mint=3D33889msec, maxt=3D33889msec
>
> Disk stats (read/write):
> vdb: ios=3D1302739/0, merge=3D0/0, ticks=3D934444/0, in_queue=3D934096, u=
til=3D99.77%
>
>
>
> qemu : no-iothread : tcmalloc : iops=3D34516
> ---------------------------------------------
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [163.2MB/0KB/0KB /s] [41.8K/0/0 iop=
s]
> [eta 00m:00s]
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D896: Tue Jun=
 9
> 18:19:08 2015
> read : io=3D5120.0MB, bw=3D138065KB/s, iops=3D34516, runt=3D 37974msec
> slat (usec): min=3D1, max=3D708, avg=3D 3.98, stdev=3D 3.57
> clat (usec): min=3D208, max=3D11858, avg=3D921.43, stdev=3D333.61
> lat (usec): min=3D266, max=3D11862, avg=3D925.77, stdev=3D333.40
> clat percentiles (usec):
> | 1.00th=3D[ 434], 5.00th=3D[ 510], 10.00th=3D[ 564], 20.00th=3D[ 652],
> | 30.00th=3D[ 732], 40.00th=3D[ 812], 50.00th=3D[ 876], 60.00th=3D[ 940],
> | 70.00th=3D[ 1020], 80.00th=3D[ 1112], 90.00th=3D[ 1320], 95.00th=3D[ 15=
76],
> | 99.00th=3D[ 1992], 99.50th=3D[ 2128], 99.90th=3D[ 2736], 99.95th=3D[ 32=
48],
> | 99.99th=3D[ 4320]
> bw (KB /s): min=3D77312, max=3D185576, per=3D99.74%, avg=3D137709.88,
> stdev=3D16883.77
> lat (usec) : 250=3D0.01%, 500=3D4.36%, 750=3D27.61%, 1000=3D35.60%
> lat (msec) : 2=3D31.49%, 4=3D0.92%, 10=3D0.02%, 20=3D0.01%
> cpu : usr=3D7.19%, sys=3D19.52%, ctx=3D55903, majf=3D0, minf=3D38
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0=
%, >=3D64=3D0.0%
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,=
 >=3D64=3D0.0%
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0=
%, >=3D64=3D0.0%
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
> READ: io=3D5120.0MB, aggrb=3D138064KB/s, minb=3D138064KB/s, maxb=3D138064=
KB/s,
> mint=3D37974msec, maxt=3D37974msec
>
> Disk stats (read/write):
> vdb: ios=3D1309902/0, merge=3D0/0, ticks=3D1068768/0, in_queue=3D1068396,
> util=3D99.86%
>
>
>
> qemu : iothread : glibc : iops=3D34516
> -------------------------------------
>
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> fio-2.1.11
> Starting 1 process
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [133.4MB/0KB/0KB /s] [34.2K/0/0 iop=
s]
> [eta 00m:00s]
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D876: Tue Jun=
 9
> 18:24:01 2015
> read : io=3D5120.0MB, bw=3D137786KB/s, iops=3D34446, runt=3D 38051msec
> slat (usec): min=3D1, max=3D496, avg=3D 3.88, stdev=3D 3.66
> clat (usec): min=3D283, max=3D7515, avg=3D923.34, stdev=3D300.28
> lat (usec): min=3D286, max=3D7519, avg=3D927.58, stdev=3D300.02
> clat percentiles (usec):
> | 1.00th=3D[ 506], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 652],
> | 30.00th=3D[ 724], 40.00th=3D[ 804], 50.00th=3D[ 884], 60.00th=3D[ 964],
> | 70.00th=3D[ 1048], 80.00th=3D[ 1144], 90.00th=3D[ 1304], 95.00th=3D[ 14=
48],
> | 99.00th=3D[ 1896], 99.50th=3D[ 2096], 99.90th=3D[ 2480], 99.95th=3D[ 26=
40],
> | 99.99th=3D[ 3984]
> bw (KB /s): min=3D102680, max=3D171112, per=3D100.00%, avg=3D137877.78,
> stdev=3D15521.30
> lat (usec) : 500=3D0.84%, 750=3D32.97%, 1000=3D30.82%
> lat (msec) : 2=3D34.65%, 4=3D0.71%, 10=3D0.01%
> cpu : usr=3D7.42%, sys=3D19.47%, ctx=3D52455, majf=3D0, minf=3D38
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0=
%, >=3D64=3D0.0%
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,=
 >=3D64=3D0.0%
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0=
%, >=3D64=3D0.0%
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
> READ: io=3D5120.0MB, aggrb=3D137785KB/s, minb=3D137785KB/s, maxb=3D137785=
KB/s,
> mint=3D38051msec, maxt=3D38051msec
>
> Disk stats (read/write):
> vdb: ios=3D1307426/0, merge=3D0/0, ticks=3D1051416/0, in_queue=3D1050972,
> util=3D99.85%
>
>
>
> qemu : no iothread : glibc : iops=3D33395
> -----------------------------------------
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> fio-2.1.11
> Starting 1 process
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [125.4MB/0KB/0KB /s] [32.9K/0/0 iop=
s]
> [eta 00m:00s]
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D886: Tue Jun=
 9
> 18:27:18 2015
> read : io=3D5120.0MB, bw=3D133583KB/s, iops=3D33395, runt=3D 39248msec
> slat (usec): min=3D1, max=3D1054, avg=3D 3.86, stdev=3D 4.29
> clat (usec): min=3D139, max=3D12635, avg=3D952.85, stdev=3D335.51
> lat (usec): min=3D303, max=3D12638, avg=3D957.01, stdev=3D335.29
> clat percentiles (usec):
> | 1.00th=3D[ 516], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 652],
> | 30.00th=3D[ 724], 40.00th=3D[ 820], 50.00th=3D[ 924], 60.00th=3D[ 996],
> | 70.00th=3D[ 1080], 80.00th=3D[ 1176], 90.00th=3D[ 1336], 95.00th=3D[ 15=
28],
> | 99.00th=3D[ 2096], 99.50th=3D[ 2320], 99.90th=3D[ 2672], 99.95th=3D[ 29=
28],
> | 99.99th=3D[ 4832]
> bw (KB /s): min=3D98136, max=3D171624, per=3D100.00%, avg=3D133682.64,
> stdev=3D19121.91
> lat (usec) : 250=3D0.01%, 500=3D0.57%, 750=3D32.57%, 1000=3D26.98%
> lat (msec) : 2=3D38.59%, 4=3D1.28%, 10=3D0.01%, 20=3D0.01%
> cpu : usr=3D9.24%, sys=3D15.92%, ctx=3D51219, majf=3D0, minf=3D38
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0=
%, >=3D64=3D0.0%
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,=
 >=3D64=3D0.0%
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0=
%, >=3D64=3D0.0%
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
> READ: io=3D5120.0MB, aggrb=3D133583KB/s, minb=3D133583KB/s, maxb=3D133583=
KB/s,
> mint=3D39248msec, maxt=3D39248msec
>
> Disk stats (read/write):
> vdb: ios=3D1304526/0, merge=3D0/0, ticks=3D1075020/0, in_queue=3D1074536,
> util=3D99.84%
>
>
>
> qemu : iothread : jemmaloc : iops=3D28023
> ----------------------------------------
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> fio-2.1.11
> Starting 1 process
> Jobs: 1 (f=3D1): [r(1)] [97.9% done] [155.2MB/0KB/0KB /s] [39.1K/0/0 iops=
]
> [eta 00m:01s]
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D899: Tue Jun=
 9
> 18:30:26 2015
> read : io=3D5120.0MB, bw=3D112094KB/s, iops=3D28023, runt=3D 46772msec
> slat (usec): min=3D1, max=3D467, avg=3D 4.33, stdev=3D 4.77
> clat (usec): min=3D253, max=3D11307, avg=3D1135.63, stdev=3D346.55
> lat (usec): min=3D256, max=3D11309, avg=3D1140.39, stdev=3D346.22
> clat percentiles (usec):
> | 1.00th=3D[ 510], 5.00th=3D[ 628], 10.00th=3D[ 700], 20.00th=3D[ 820],
> | 30.00th=3D[ 924], 40.00th=3D[ 1032], 50.00th=3D[ 1128], 60.00th=3D[ 122=
4],
> | 70.00th=3D[ 1320], 80.00th=3D[ 1416], 90.00th=3D[ 1560], 95.00th=3D[ 16=
88],
> | 99.00th=3D[ 2096], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=3D[ 28=
32],
> | 99.99th=3D[ 3760]
> bw (KB /s): min=3D91792, max=3D174416, per=3D99.90%, avg=3D111985.27,
> stdev=3D17381.70
> lat (usec) : 500=3D0.80%, 750=3D13.10%, 1000=3D23.33%
> lat (msec) : 2=3D61.30%, 4=3D1.46%, 10=3D0.01%, 20=3D0.01%
> cpu : usr=3D7.12%, sys=3D17.43%, ctx=3D54507, majf=3D0, minf=3D38
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0=
%, >=3D64=3D0.0%
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,=
 >=3D64=3D0.0%
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0=
%, >=3D64=3D0.0%
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
> READ: io=3D5120.0MB, aggrb=3D112094KB/s, minb=3D112094KB/s, maxb=3D112094=
KB/s,
> mint=3D46772msec, maxt=3D46772msec
>
> Disk stats (read/write):
> vdb: ios=3D1309169/0, merge=3D0/0, ticks=3D1305796/0, in_queue=3D1305376,
> util=3D98.68%
>
>
>
> qemu : non-iothread : jemmaloc : iops=3D42226
> --------------------------------------------
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Dlibaio, iodepth=3D32
> fio-2.1.11
> Starting 1 process
> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.2MB/0KB/0KB /s] [43.9K/0/0 iop=
s]
> [eta 00m:00s]
> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D892: Tue Jun=
 9
> 18:34:11 2015
> read : io=3D5120.0MB, bw=3D177130KB/s, iops=3D44282, runt=3D 29599msec
> slat (usec): min=3D1, max=3D527, avg=3D 3.80, stdev=3D 3.74
> clat (usec): min=3D174, max=3D3841, avg=3D717.08, stdev=3D237.53
> lat (usec): min=3D210, max=3D3844, avg=3D721.23, stdev=3D237.22
> clat percentiles (usec):
> | 1.00th=3D[ 354], 5.00th=3D[ 422], 10.00th=3D[ 462], 20.00th=3D[ 516],
> | 30.00th=3D[ 572], 40.00th=3D[ 628], 50.00th=3D[ 684], 60.00th=3D[ 740],
> | 70.00th=3D[ 804], 80.00th=3D[ 884], 90.00th=3D[ 1004], 95.00th=3D[ 1128=
],
> | 99.00th=3D[ 1544], 99.50th=3D[ 1672], 99.90th=3D[ 1928], 99.95th=3D[ 20=
64],
> | 99.99th=3D[ 2608]
> bw (KB /s): min=3D138120, max=3D230816, per=3D100.00%, avg=3D177192.14,
> stdev=3D23440.79
> lat (usec) : 250=3D0.01%, 500=3D16.24%, 750=3D45.93%, 1000=3D27.46%
> lat (msec) : 2=3D10.30%, 4=3D0.07%
> cpu : usr=3D10.14%, sys=3D23.84%, ctx=3D60938, majf=3D0, minf=3D39
> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0=
%, >=3D64=3D0.0%
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,=
 >=3D64=3D0.0%
> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0=
%, >=3D64=3D0.0%
> issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
> READ: io=3D5120.0MB, aggrb=3D177130KB/s, minb=3D177130KB/s, maxb=3D177130=
KB/s,
> mint=3D29599msec, maxt=3D29599msec
>
> Disk stats (read/write):
> vdb: ios=3D1303992/0, merge=3D0/0, ticks=3D798008/0, in_queue=3D797636, u=
til=3D99.80%
>
>
>
> ----- Mail original -----
> De: "Robert LeBlanc" <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
> =C3=80: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> Cc: "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel" <
> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pushpesh sharma" <pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
> "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> Envoy=C3=A9: Mardi 9 Juin 2015 18:00:29
> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 40k
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> I also saw a similar performance increase by using alternative memory
> allocators. What I found was that Ceph OSDs performed well with either
> tcmalloc or jemalloc (except when RocksDB was built with jemalloc
> instead of tcmalloc, I'm still working to dig into why that might be
> the case).
>
> However, I found that tcmalloc with QEMU/KVM was very detrimental to
> small I/O, but provided huge gains in I/O >=3D1MB. Jemalloc was much
> better for QEMU/KVM in the tests that we ran. [1]
>
> I'm currently looking into I/O bottlenecks around the 16KB range and
> I'm seeing a lot of time in thread creation and destruction, the
> memory allocators are quite a bit down the list (both fio with
> ioengine rbd and on the OSDs). I wonder what the difference can be.
> I've tried using the async messenger but there wasn't a huge
> difference. [2]
>
> Further down the rabbit hole....
>
> [1] https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg20197.html
> [2] https://www.mail-archive.com/ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg23982.html
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v0.13.1
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJVdw2ZCRDmVDuy+mK58QAA4MwP/1vt65cvTyyVGGSGRrE8
> unuWjafMHzl486XH+EaVrDVTXFVFOoncJ6kugSpD7yavtCpZNdhsIaTRZguU
> YpfAppNAJU5biSwNv9QPI7kPP2q2+I7Z8ZkvhcVnkjIythoeNnSjV7zJrw87
> afq46GhPHqEXdjp3rOB4RRPniOMnub5oU6QRnKn3HPW8Dx9ZqTeCofRDnCY2
> S695Dt1gzt0ERUOgrUUkt0FQJdkkV6EURcUschngjtEd5727VTLp02HivVl3
> vDYWxQHPK8oS6Xe8GOW0JjulwiqlYotSlrqSU5FMU5gozbk9zMFPIUW1e+51
> 9ART8Ta2ItMhPWtAhRwwvxgy51exCy9kBc+m+ptKW5XRUXOImGcOQxszPGOO
> qIIOG1vVG/GBmo/0i6tliqBFYdXmw1qFV7tFiIbisZRH7Q/1NahjYTHqHhu3
> Dv61T6WrerD+9N6S1Lrz1QYe2Fqa56BHhHSXM82NE86SVxEvUkoGegQU+c7b
> 6rY1JvuJHJzva7+M2XHApYCchCs4a1Yyd1qWB7yThJD57RIyX1TOg0+siV13
> R+v6wxhQU0vBovH+5oAWmCZaPNT+F0Uvs3xWAxxaIR9r83wMj9qQeBZTKVzQ
> 1aFIi15KqAwOp12yWCmrqKTeXhjwYQNd8viCQCGN7AQyPglmzfbuEHalVjz4
> oSJX
> =3Dk281
> -----END PGP SIGNATURE-----
> ----------------
> Robert LeBlanc
> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904 C70E E654 3BB2 FA62 B9F1
>
>
> On Tue, Jun 9, 2015 at 6:02 AM, Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> wrote:
> >>>Frankly, I'm a little impressed that without RBD cache we can hit 80K
> >>>IOPS from 1 VM!
> >
> > Note that theses result are not in a vm (fio-rbd on host), so in a vm
> we'll have overhead.
> > (I'm planning to send results in qemu soon)
> >
> >>>How fast are the SSDs in those 3 OSDs?
> >
> > Theses results are with datas in buffer memory of osd nodes.
> >
> > When reading fulling on ssd (intel s3500),
> >
> > For 1 client,
> >
> > I'm around 33k iops without cache and 32k iops with cache, with 1 osd.
> > I'm around 55k iops without cache and 38k iops with cache, with 3 osd.
> >
> > with multiple clients jobs, I can reach around 70kiops by osd , and 250=
k
> iops by osd when datas are in buffer.
> >
> > (cpus servers/clients are 2x 10 cores 3,1ghz e5 xeon)
> >
> >
> >
> > small tip :
> > I'm using tcmalloc for fio-rbd or rados bench to improve latencies by
> around 20%
> >
> > LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 fio ...
> > LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 rados bench ...
> >
> > as a lot of time is spent in malloc/free
> >
> >
> > (qemu support also tcmalloc since some months , I'll bench it too
> > https://lists.gnu.org/archive/html/qemu-devel/2015-03/msg05372.html)
> >
> >
> >
> > I'll try to send full bench results soon, from 1 to 18 ssd osd.
> >
> >
> >
> >
> > ----- Mail original -----
> > De: "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > =C3=80: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>, "pushpesh sharma" <
> pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> > Envoy=C3=A9: Mardi 9 Juin 2015 13:36:31
> > Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 40=
k
> >
> > Hi All,
> >
> > In the past we've hit some performance issues with RBD cache that we've
> > fixed, but we've never really tried pushing a single VM beyond 40+K rea=
d
> > IOPS in testing (or at least I never have). I suspect there's a couple
> > of possibilities as to why it might be slower, but perhaps joshd can
> > chime in as he's more familiar with what that code looks like.
> >
> > Frankly, I'm a little impressed that without RBD cache we can hit 80K
> > IOPS from 1 VM! How fast are the SSDs in those 3 OSDs?
> >
> > Mark
> >
> > On 06/09/2015 03:36 AM, Alexandre DERUMIER wrote:
> >> It's seem that the limit is mainly going in high queue depth (+- > 16)
> >>
> >> Here the result in iops with 1client- 4krandread- 3osd - with
> differents queue depth size.
> >> rbd_cache is almost the same than without cache with queue depth <16
> >>
> >>
> >> cache
> >> -----
> >> qd1: 1651
> >> qd2: 3482
> >> qd4: 7958
> >> qd8: 17912
> >> qd16: 36020
> >> qd32: 42765
> >> qd64: 46169
> >>
> >> no cache
> >> --------
> >> qd1: 1748
> >> qd2: 3570
> >> qd4: 8356
> >> qd8: 17732
> >> qd16: 41396
> >> qd32: 78633
> >> qd64: 79063
> >> qd128: 79550
> >>
> >>
> >> ----- Mail original -----
> >> De: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> >> =C3=80: "pushpesh sharma" <pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Cc: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> >> Envoy=C3=A9: Mardi 9 Juin 2015 09:28:21
> >> Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 4=
0k
> >>
> >> Hi,
> >>
> >>>> We tried adding more RBDs to single VM, but no luck.
> >>
> >> If you want to scale with more disks in a single qemu vm, you need to
> use iothread feature from qemu and assign 1 iothread by disk (works with
> virtio-blk).
> >> It's working for me, I can scale with adding more disks.
> >>
> >>
> >> My bench here are done with fio-rbd on host.
> >> I can scale up to 400k iops with 10clients-rbd_cache=3Doff on a single
> host and around 250kiops 10clients-rbdcache=3Don.
> >>
> >>
> >> I just wonder why I don't have performance decrease around 30k iops
> with 1osd.
> >>
> >> I'm going to see if this tracker
> >> http://tracker.ceph.com/issues/11056
> >>
> >> could be the cause.
> >>
> >> (My master build was done some week ago)
> >>
> >>
> >>
> >> ----- Mail original -----
> >> De: "pushpesh sharma" <pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> =C3=80: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> >> Cc: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> >> Envoy=C3=A9: Mardi 9 Juin 2015 09:21:04
> >> Objet: Re: rbd_cache, limiting read on high iops around 40k
> >>
> >> Hi Alexandre,
> >>
> >> We have also seen something very similar on Hammer(0.94-1). We were
> doing some benchmarking for VMs hosted on hypervisor (QEMU-KVM,
> openstack-juno). Each Ubuntu-VM has a RBD as root disk, and 1 RBD as
> additional storage. For some strange reason it was not able to scale 4K- =
RR
> iops on each VM beyond 35-40k. We tried adding more RBDs to single VM, bu=
t
> no luck. However increasing number of VMs to 4 on a single hypervisor did
> scale to some extent. After this there was no much benefit we got from
> adding more VMs.
> >>
> >> Here is the trend we have seen, x-axis is number of hypervisor, each
> hypervisor has 4 VM, each VM has 1 RBD:-
> >>
> >>
> >>
> >>
> >> VDbench is used as benchmarking tool. We were not saturating network
> and CPUs at OSD nodes. We were not able to saturate CPUs at hypervisors,
> and that is where we were suspecting of some throttling effect. However w=
e
> haven't setted any such limits from nova or kvm end. We tried some CPU
> pinning and other KVM related tuning as well, but no luck.
> >>
> >> We tried the same experiment on a bare metal. It was 4K RR IOPs were
> scaling from 40K(1 RBD) to 180K(4 RBDs). But after that rather than scali=
ng
> beyond that point the numbers were actually degrading. (Single pipe more
> congestion effect)
> >>
> >> We never suspected that rbd cache enable could be detrimental to
> performance. It would nice to route cause the problem if that is the case=
.
> >>
> >> On Tue, Jun 9, 2015 at 11:21 AM, Alexandre DERUMIER <
> aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > wrote:
> >>
> >>
> >> Hi,
> >>
> >> I'm doing benchmark (ceph master branch), with randread 4k qdepth=3D32=
,
> >> and rbd_cache=3Dtrue seem to limit the iops around 40k
> >>
> >>
> >> no cache
> >> --------
> >> 1 client - rbd_cache=3Dfalse - 1osd : 38300 iops
> >> 1 client - rbd_cache=3Dfalse - 2osd : 69073 iops
> >> 1 client - rbd_cache=3Dfalse - 3osd : 78292 iops
> >>
> >>
> >> cache
> >> -----
> >> 1 client - rbd_cache=3Dtrue - 1osd : 38100 iops
> >> 1 client - rbd_cache=3Dtrue - 2osd : 42457 iops
> >> 1 client - rbd_cache=3Dtrue - 3osd : 45823 iops
> >>
> >>
> >>
> >> Is it expected ?
> >>
> >>
> >>
> >> fio result rbd_cache=3Dfalse 3 osd
> >> --------------------------------
> >> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Drbd, iodepth=3D32
> >> fio-2.1.11
> >> Starting 1 process
> >> rbd engine: RBD version: 0.1.9
> >> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/0/0
> iops] [eta 00m:00s]
> >> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113548: T=
ue Jun 9
> 07:48:42 2015
> >> read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292, runt=3D 32698msec
> >> slat (usec): min=3D5, max=3D530, avg=3D11.77, stdev=3D 6.77
> >> clat (usec): min=3D70, max=3D2240, avg=3D336.08, stdev=3D94.82
> >> lat (usec): min=3D101, max=3D2247, avg=3D347.84, stdev=3D95.49
> >> clat percentiles (usec):
> >> | 1.00th=3D[ 173], 5.00th=3D[ 209], 10.00th=3D[ 231], 20.00th=3D[ 262]=
,
> >> | 30.00th=3D[ 282], 40.00th=3D[ 302], 50.00th=3D[ 322], 60.00th=3D[ 34=
6],
> >> | 70.00th=3D[ 370], 80.00th=3D[ 402], 90.00th=3D[ 454], 95.00th=3D[ 50=
6],
> >> | 99.00th=3D[ 628], 99.50th=3D[ 692], 99.90th=3D[ 860], 99.95th=3D[ 94=
8],
> >> | 99.99th=3D[ 1176]
> >> bw (KB /s): min=3D238856, max=3D360448, per=3D100.00%, avg=3D313402.34=
,
> stdev=3D25196.21
> >> lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5.19%, 100=
0=3D0.23%
> >> lat (msec) : 2=3D0.03%, 4=3D0.01%
> >> cpu : usr=3D74.48%, sys=3D13.25%, ctx=3D703225, majf=3D0, minf=3D12452
> >> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=3D87.0%, 32=3D1=
2.1%,
> >=3D64=3D0.0%
> >> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.=
0%, >=3D64=3D0.0%
> >> complete : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5%, 32=3D0.4%, 64=3D0=
.0%, >=3D64=3D0.0%
> >> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> >> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>
> >> Run status group 0 (all jobs):
> >> READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s, maxb=3D3131=
69KB/s,
> mint=3D32698msec, maxt=3D32698msec
> >>
> >> Disk stats (read/write):
> >> dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0.00%=
,
> aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, aggrin_queue=3D0, aggr=
util=3D0.00%
> >> sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0.00%
> >>
> >>
> >>
> >>
> >> fio result rbd_cache=3Dtrue 3osd
> >> ------------------------------
> >>
> >> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Drbd, iodepth=3D32
> >> fio-2.1.11
> >> Starting 1 process
> >> rbd engine: RBD version: 0.1.9
> >> Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/0/0
> iops] [eta 00m:00s]
> >> rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D113389: T=
ue Jun 9
> 07:47:30 2015
> >> read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823, runt=3D 55866msec
> >> slat (usec): min=3D7, max=3D805, avg=3D21.26, stdev=3D15.84
> >> clat (usec): min=3D101, max=3D4602, avg=3D478.55, stdev=3D143.73
> >> lat (usec): min=3D123, max=3D4669, avg=3D499.80, stdev=3D146.03
> >> clat percentiles (usec):
> >> | 1.00th=3D[ 227], 5.00th=3D[ 274], 10.00th=3D[ 306], 20.00th=3D[ 350]=
,
> >> | 30.00th=3D[ 390], 40.00th=3D[ 430], 50.00th=3D[ 470], 60.00th=3D[ 50=
6],
> >> | 70.00th=3D[ 548], 80.00th=3D[ 596], 90.00th=3D[ 660], 95.00th=3D[ 72=
4],
> >> | 99.00th=3D[ 844], 99.50th=3D[ 908], 99.90th=3D[ 1112], 99.95th=3D[ 1=
288],
> >> | 99.99th=3D[ 2192]
> >> bw (KB /s): min=3D115280, max=3D204416, per=3D100.00%, avg=3D183315.10=
,
> stdev=3D15079.93
> >> lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.48%, 1000=3D3.28%
> >> lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%
> >> cpu : usr=3D60.27%, sys=3D12.01%, ctx=3D2995393, majf=3D0, minf=3D1410=
0
> >> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=3D81.0%, 32=3D=
5.3%,
> >=3D64=3D0.0%
> >> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.=
0%, >=3D64=3D0.0%
> >> complete : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0%, 32=3D4.0%, 64=3D0=
.0%, >=3D64=3D0.0%
> >> issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0
> >> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>
> >> Run status group 0 (all jobs):
> >> READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s, maxb=3D1832=
95KB/s,
> mint=3D55866msec, maxt=3D55866msec
> >>
> >> Disk stats (read/write):
> >> dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_queue=3D8, util=3D0.01%=
,
> aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, aggrin_queue=3D8, aggr=
util=3D0.01%
> >> sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0.01%
> >>
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=
=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=
=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87
=D0=9C=D0=BE=D0=B1.: +79229045757

--001a1134d8b0142e700518230e78
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, Alexandre.<div><br><div>Very good work!<br></div><div>=
Do you have a rpm-file?<br></div><div>Thanks.</div></div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">2015-06-10 7:10 GMT+03:00 A=
lexandre DERUMIER <span dir=3D"ltr">&lt;<a href=3D"mailto:aderumier@odiso.c=
om" target=3D"_blank">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;</span>:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">Hi,<br>
<br>
I have tested qemu with last tcmalloc 2.4, and the improvement is huge with=
 iothread: 50k iops (+45%) !<br>
<span class=3D""><br>
<br>
<br>
qemu : no iothread : glibc : iops=3D33395<br>
</span>qemu : no-iothread : tcmalloc (2.2.1) : iops=3D34516 (+3%)<br>
<span class=3D"">qemu : no-iothread : jemmaloc : iops=3D42226 (+26%)<br>
</span>qemu : no-iothread : tcmalloc (2.4) : iops=3D35974 (+7%)<br>
<span class=3D""><br>
<br>
qemu : iothread : glibc : iops=3D34516<br>
qemu : iothread : tcmalloc : iops=3D38676 (+12%)<br>
qemu : iothread : jemmaloc : iops=3D28023 (-19%)<br>
</span>qemu : iothread : tcmalloc (2.4) : iops=3D50276 (+45%)<br>
<br>
<br>
<br>
<br>
<br>
qemu : iothread : tcmalloc (2.4) : iops=3D50276 (+45%)<br>
------------------------------------------------------<br>
<span class=3D"">rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-=
4K/4K-4K, ioengine=3Dlibaio, iodepth=3D32<br>
fio-2.1.11<br>
Starting 1 process<br>
</span>Jobs: 1 (f=3D1): [r(1)] [100.0% done] [214.7MB/0KB/0KB /s] [54.1K/0/=
0 iops] [eta 00m:00s]<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D894: Wed Jun 1=
0 05:54:24 2015<br>
=C2=A0 read : io=3D5120.0MB, bw=3D201108KB/s, iops=3D50276, runt=3D 26070ms=
ec<br>
=C2=A0 =C2=A0 slat (usec): min=3D1, max=3D1136, avg=3D 3.54, stdev=3D 3.58<=
br>
=C2=A0 =C2=A0 clat (usec): min=3D128, max=3D6262, avg=3D631.41, stdev=3D197=
.71<br>
=C2=A0 =C2=A0 =C2=A0lat (usec): min=3D149, max=3D6265, avg=3D635.27, stdev=
=3D197.40<br>
=C2=A0 =C2=A0 clat percentiles (usec):<br>
=C2=A0 =C2=A0 =C2=A0|=C2=A0 1.00th=3D[=C2=A0 318],=C2=A0 5.00th=3D[=C2=A0 3=
78], 10.00th=3D[=C2=A0 418], 20.00th=3D[=C2=A0 474],<br>
=C2=A0 =C2=A0 =C2=A0| 30.00th=3D[=C2=A0 516], 40.00th=3D[=C2=A0 564], 50.00=
th=3D[=C2=A0 612], 60.00th=3D[=C2=A0 652],<br>
=C2=A0 =C2=A0 =C2=A0| 70.00th=3D[=C2=A0 700], 80.00th=3D[=C2=A0 756], 90.00=
th=3D[=C2=A0 860], 95.00th=3D[=C2=A0 980],<br>
=C2=A0 =C2=A0 =C2=A0| 99.00th=3D[ 1272], 99.50th=3D[ 1384], 99.90th=3D[ 168=
8], 99.95th=3D[ 1896],<br>
=C2=A0 =C2=A0 =C2=A0| 99.99th=3D[ 3760]<br>
=C2=A0 =C2=A0 bw (KB=C2=A0 /s): min=3D145608, max=3D249688, per=3D100.00%, =
avg=3D201108.00, stdev=3D21718.87<br>
=C2=A0 =C2=A0 lat (usec) : 250=3D0.04%, 500=3D25.84%, 750=3D53.00%, 1000=3D=
16.63%<br>
=C2=A0 =C2=A0 lat (msec) : 2=3D4.46%, 4=3D0.03%, 10=3D0.01%<br>
=C2=A0 cpu=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : usr=3D9.73%, sys=3D24.93%, c=
tx=3D66417, majf=3D0, minf=3D38<br>
<span class=3D"">=C2=A0 IO depths=C2=A0 =C2=A0 : 1=3D0.1%, 2=3D0.1%, 4=3D0.=
1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0submit=C2=A0 =C2=A0 : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 1=
6=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0complete=C2=A0 : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0=
.0%, 32=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0issued=C2=A0 =C2=A0 : total=3Dr=3D1310720/w=3D0/d=3D0, =
short=3Dr=3D0/w=3D0/d=3D0<br>
=C2=A0 =C2=A0 =C2=A0latency=C2=A0 =C2=A0: target=3D0, window=3D0, percentil=
e=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
</span>=C2=A0 =C2=A0READ: io=3D5120.0MB, aggrb=3D201107KB/s, minb=3D201107K=
B/s, maxb=3D201107KB/s, mint=3D26070msec, maxt=3D26070msec<br>
<br>
Disk stats (read/write):<br>
=C2=A0 vdb: ios=3D1302555/0, merge=3D0/0, ticks=3D715176/0, in_queue=3D7148=
40, util=3D99.73%<br>
<span class=3D""><br>
<br>
<br>
<br>
<br>
<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Dlibaio, iodepth=3D32<br>
fio-2.1.11<br>
Starting 1 process<br>
</span>Jobs: 1 (f=3D1): [r(1)] [100.0% done] [158.7MB/0KB/0KB /s] [40.6K/0/=
0 iops] [eta 00m:00s]<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D889: Wed Jun 1=
0 06:05:06 2015<br>
=C2=A0 read : io=3D5120.0MB, bw=3D143897KB/s, iops=3D35974, runt=3D 36435ms=
ec<br>
=C2=A0 =C2=A0 slat (usec): min=3D1, max=3D710, avg=3D 3.31, stdev=3D 3.35<b=
r>
=C2=A0 =C2=A0 clat (usec): min=3D191, max=3D4740, avg=3D884.66, stdev=3D315=
.65<br>
=C2=A0 =C2=A0 =C2=A0lat (usec): min=3D289, max=3D4743, avg=3D888.31, stdev=
=3D315.51<br>
=C2=A0 =C2=A0 clat percentiles (usec):<br>
=C2=A0 =C2=A0 =C2=A0|=C2=A0 1.00th=3D[=C2=A0 462],=C2=A0 5.00th=3D[=C2=A0 5=
16], 10.00th=3D[=C2=A0 548], 20.00th=3D[=C2=A0 596],<br>
=C2=A0 =C2=A0 =C2=A0| 30.00th=3D[=C2=A0 652], 40.00th=3D[=C2=A0 764], 50.00=
th=3D[=C2=A0 868], 60.00th=3D[=C2=A0 940],<br>
=C2=A0 =C2=A0 =C2=A0| 70.00th=3D[ 1004], 80.00th=3D[ 1096], 90.00th=3D[ 125=
6], 95.00th=3D[ 1416],<br>
=C2=A0 =C2=A0 =C2=A0| 99.00th=3D[ 2024], 99.50th=3D[ 2224], 99.90th=3D[ 254=
4], 99.95th=3D[ 2640],<br>
=C2=A0 =C2=A0 =C2=A0| 99.99th=3D[ 3632]<br>
=C2=A0 =C2=A0 bw (KB=C2=A0 /s): min=3D98352, max=3D177328, per=3D99.91%, av=
g=3D143772.11, stdev=3D21782.39<br>
=C2=A0 =C2=A0 lat (usec) : 250=3D0.01%, 500=3D3.48%, 750=3D35.69%, 1000=3D3=
0.01%<br>
=C2=A0 =C2=A0 lat (msec) : 2=3D29.74%, 4=3D1.07%, 10=3D0.01%<br>
=C2=A0 cpu=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : usr=3D7.10%, sys=3D16.90%, c=
tx=3D54855, majf=3D0, minf=3D38<br>
<span class=3D"">=C2=A0 IO depths=C2=A0 =C2=A0 : 1=3D0.1%, 2=3D0.1%, 4=3D0.=
1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0submit=C2=A0 =C2=A0 : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 1=
6=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0complete=C2=A0 : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0=
.0%, 32=3D0.1%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
=C2=A0 =C2=A0 =C2=A0issued=C2=A0 =C2=A0 : total=3Dr=3D1310720/w=3D0/d=3D0, =
short=3Dr=3D0/w=3D0/d=3D0<br>
=C2=A0 =C2=A0 =C2=A0latency=C2=A0 =C2=A0: target=3D0, window=3D0, percentil=
e=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
</span>=C2=A0 =C2=A0READ: io=3D5120.0MB, aggrb=3D143896KB/s, minb=3D143896K=
B/s, maxb=3D143896KB/s, mint=3D36435msec, maxt=3D36435msec<br>
<br>
Disk stats (read/write):<br>
=C2=A0 vdb: ios=3D1301357/0, merge=3D0/0, ticks=3D1033036/0, in_queue=3D103=
2716, util=3D99.85%<br>
<span class=3D""><br>
<br>
----- Mail original -----<br>
De: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderum=
ier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
</span>=C3=80: &quot;Robert LeBlanc&quot; &lt;<a href=3D"mailto:robert@lebl=
ancnet.us">robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt;<br>
<span class=3D"">Cc: &quot;Mark Nelson&quot; &lt;<a href=3D"mailto:mnelson@=
redhat.com">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;, &quot;ceph-devel&quot; &lt;<a href=
=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, =
&quot;pushpesh sharma&quot; &lt;<a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">p=
ushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;, &quot;ceph-users&quot; &lt;<a href=3D"mailto=
:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;<br>
</span>Envoy=C3=A9: Mardi 9 Juin 2015 18:47:27<br>
<div class=3D"HOEnZb"><div class=3D"h5">Objet: Re: [ceph-users] rbd_cache, =
limiting read on high iops around 40k<br>
<br>
Hi Robert,<br>
<br>
&gt;&gt;What I found was that Ceph OSDs performed well with either<br>
&gt;&gt;tcmalloc or jemalloc (except when RocksDB was built with jemalloc<b=
r>
&gt;&gt;instead of tcmalloc, I&#39;m still working to dig into why that mig=
ht be<br>
&gt;&gt;the case).<br>
yes,from my test, for osd tcmalloc is a little faster (but very little) tha=
n jemalloc.<br>
<br>
<br>
<br>
&gt;&gt;However, I found that tcmalloc with QEMU/KVM was very detrimental t=
o<br>
&gt;&gt;small I/O, but provided huge gains in I/O &gt;=3D1MB. Jemalloc was =
much<br>
&gt;&gt;better for QEMU/KVM in the tests that we ran. [1]<br>
<br>
<br>
Just have done qemu test (4k randread - rbd_cache=3Doff), I don&#39;t see s=
peed regression with tcmalloc.<br>
with qemu iothread, tcmalloc have a speed increase over glib<br>
with qemu iothread, jemalloc have a speed decrease<br>
<br>
without iothread, jemalloc have a big speed increase<br>
<br>
this is with<br>
-qemu 2.3<br>
-tcmalloc 2.2.1<br>
-jemmaloc 3.6<br>
-libc6 2.19<br>
<br>
<br>
qemu : no iothread : glibc : iops=3D33395<br>
qemu : no-iothread : tcmalloc : iops=3D34516 (+3%)<br>
qemu : no-iothread : jemmaloc : iops=3D42226 (+26%)<br>
<br>
qemu : iothread : glibc : iops=3D34516<br>
qemu : iothread : tcmalloc : iops=3D38676 (+12%)<br>
qemu : iothread : jemmaloc : iops=3D28023 (-19%)<br>
<br>
<br>
(The benefit of iothreads is that we can scale with more disks in 1vm)<br>
<br>
<br>
fio results:<br>
------------<br>
<br>
qemu : iothread : tcmalloc : iops=3D38676<br>
-----------------------------------------<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Dlibaio, iodepth=3D32<br>
fio-2.1.11<br>
Starting 1 process<br>
Jobs: 1 (f=3D0): [r(1)] [100.0% done] [123.5MB/0KB/0KB /s] [31.6K/0/0 iops]=
 [eta 00m:00s]<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D1265: Tue Jun =
9 18:16:53 2015<br>
read : io=3D5120.0MB, bw=3D154707KB/s, iops=3D38676, runt=3D 33889msec<br>
slat (usec): min=3D1, max=3D715, avg=3D 3.63, stdev=3D 3.42<br>
clat (usec): min=3D152, max=3D5736, avg=3D822.12, stdev=3D289.34<br>
lat (usec): min=3D231, max=3D5740, avg=3D826.10, stdev=3D289.08<br>
clat percentiles (usec):<br>
| 1.00th=3D[ 402], 5.00th=3D[ 466], 10.00th=3D[ 510], 20.00th=3D[ 572],<br>
| 30.00th=3D[ 636], 40.00th=3D[ 716], 50.00th=3D[ 780], 60.00th=3D[ 852],<b=
r>
| 70.00th=3D[ 932], 80.00th=3D[ 1020], 90.00th=3D[ 1160], 95.00th=3D[ 1352]=
,<br>
| 99.00th=3D[ 1800], 99.50th=3D[ 1944], 99.90th=3D[ 2256], 99.95th=3D[ 2448=
],<br>
| 99.99th=3D[ 3888]<br>
bw (KB /s): min=3D123888, max=3D198584, per=3D100.00%, avg=3D154824.40, std=
ev=3D16978.03<br>
lat (usec) : 250=3D0.01%, 500=3D8.91%, 750=3D36.44%, 1000=3D32.63%<br>
lat (msec) : 2=3D21.65%, 4=3D0.37%, 10=3D0.01%<br>
cpu : usr=3D8.29%, sys=3D19.76%, ctx=3D55882, majf=3D0, minf=3D39<br>
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%,=
 &gt;=3D64=3D0.0%<br>
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0%<br>
complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0%,=
 &gt;=3D64=3D0.0%<br>
issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0<br>
latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
READ: io=3D5120.0MB, aggrb=3D154707KB/s, minb=3D154707KB/s, maxb=3D154707KB=
/s, mint=3D33889msec, maxt=3D33889msec<br>
<br>
Disk stats (read/write):<br>
vdb: ios=3D1302739/0, merge=3D0/0, ticks=3D934444/0, in_queue=3D934096, uti=
l=3D99.77%<br>
<br>
<br>
<br>
qemu : no-iothread : tcmalloc : iops=3D34516<br>
---------------------------------------------<br>
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [163.2MB/0KB/0KB /s] [41.8K/0/0 iops]=
 [eta 00m:00s]<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D896: Tue Jun 9=
 18:19:08 2015<br>
read : io=3D5120.0MB, bw=3D138065KB/s, iops=3D34516, runt=3D 37974msec<br>
slat (usec): min=3D1, max=3D708, avg=3D 3.98, stdev=3D 3.57<br>
clat (usec): min=3D208, max=3D11858, avg=3D921.43, stdev=3D333.61<br>
lat (usec): min=3D266, max=3D11862, avg=3D925.77, stdev=3D333.40<br>
clat percentiles (usec):<br>
| 1.00th=3D[ 434], 5.00th=3D[ 510], 10.00th=3D[ 564], 20.00th=3D[ 652],<br>
| 30.00th=3D[ 732], 40.00th=3D[ 812], 50.00th=3D[ 876], 60.00th=3D[ 940],<b=
r>
| 70.00th=3D[ 1020], 80.00th=3D[ 1112], 90.00th=3D[ 1320], 95.00th=3D[ 1576=
],<br>
| 99.00th=3D[ 1992], 99.50th=3D[ 2128], 99.90th=3D[ 2736], 99.95th=3D[ 3248=
],<br>
| 99.99th=3D[ 4320]<br>
bw (KB /s): min=3D77312, max=3D185576, per=3D99.74%, avg=3D137709.88, stdev=
=3D16883.77<br>
lat (usec) : 250=3D0.01%, 500=3D4.36%, 750=3D27.61%, 1000=3D35.60%<br>
lat (msec) : 2=3D31.49%, 4=3D0.92%, 10=3D0.02%, 20=3D0.01%<br>
cpu : usr=3D7.19%, sys=3D19.52%, ctx=3D55903, majf=3D0, minf=3D38<br>
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%,=
 &gt;=3D64=3D0.0%<br>
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0%<br>
complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0%,=
 &gt;=3D64=3D0.0%<br>
issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0<br>
latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
READ: io=3D5120.0MB, aggrb=3D138064KB/s, minb=3D138064KB/s, maxb=3D138064KB=
/s, mint=3D37974msec, maxt=3D37974msec<br>
<br>
Disk stats (read/write):<br>
vdb: ios=3D1309902/0, merge=3D0/0, ticks=3D1068768/0, in_queue=3D1068396, u=
til=3D99.86%<br>
<br>
<br>
<br>
qemu : iothread : glibc : iops=3D34516<br>
-------------------------------------<br>
<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Dlibaio, iodepth=3D32<br>
fio-2.1.11<br>
Starting 1 process<br>
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [133.4MB/0KB/0KB /s] [34.2K/0/0 iops]=
 [eta 00m:00s]<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D876: Tue Jun 9=
 18:24:01 2015<br>
read : io=3D5120.0MB, bw=3D137786KB/s, iops=3D34446, runt=3D 38051msec<br>
slat (usec): min=3D1, max=3D496, avg=3D 3.88, stdev=3D 3.66<br>
clat (usec): min=3D283, max=3D7515, avg=3D923.34, stdev=3D300.28<br>
lat (usec): min=3D286, max=3D7519, avg=3D927.58, stdev=3D300.02<br>
clat percentiles (usec):<br>
| 1.00th=3D[ 506], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 652],<br>
| 30.00th=3D[ 724], 40.00th=3D[ 804], 50.00th=3D[ 884], 60.00th=3D[ 964],<b=
r>
| 70.00th=3D[ 1048], 80.00th=3D[ 1144], 90.00th=3D[ 1304], 95.00th=3D[ 1448=
],<br>
| 99.00th=3D[ 1896], 99.50th=3D[ 2096], 99.90th=3D[ 2480], 99.95th=3D[ 2640=
],<br>
| 99.99th=3D[ 3984]<br>
bw (KB /s): min=3D102680, max=3D171112, per=3D100.00%, avg=3D137877.78, std=
ev=3D15521.30<br>
lat (usec) : 500=3D0.84%, 750=3D32.97%, 1000=3D30.82%<br>
lat (msec) : 2=3D34.65%, 4=3D0.71%, 10=3D0.01%<br>
cpu : usr=3D7.42%, sys=3D19.47%, ctx=3D52455, majf=3D0, minf=3D38<br>
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%,=
 &gt;=3D64=3D0.0%<br>
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0%<br>
complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0%,=
 &gt;=3D64=3D0.0%<br>
issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0<br>
latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
READ: io=3D5120.0MB, aggrb=3D137785KB/s, minb=3D137785KB/s, maxb=3D137785KB=
/s, mint=3D38051msec, maxt=3D38051msec<br>
<br>
Disk stats (read/write):<br>
vdb: ios=3D1307426/0, merge=3D0/0, ticks=3D1051416/0, in_queue=3D1050972, u=
til=3D99.85%<br>
<br>
<br>
<br>
qemu : no iothread : glibc : iops=3D33395<br>
-----------------------------------------<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Dlibaio, iodepth=3D32<br>
fio-2.1.11<br>
Starting 1 process<br>
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [125.4MB/0KB/0KB /s] [32.9K/0/0 iops]=
 [eta 00m:00s]<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D886: Tue Jun 9=
 18:27:18 2015<br>
read : io=3D5120.0MB, bw=3D133583KB/s, iops=3D33395, runt=3D 39248msec<br>
slat (usec): min=3D1, max=3D1054, avg=3D 3.86, stdev=3D 4.29<br>
clat (usec): min=3D139, max=3D12635, avg=3D952.85, stdev=3D335.51<br>
lat (usec): min=3D303, max=3D12638, avg=3D957.01, stdev=3D335.29<br>
clat percentiles (usec):<br>
| 1.00th=3D[ 516], 5.00th=3D[ 564], 10.00th=3D[ 596], 20.00th=3D[ 652],<br>
| 30.00th=3D[ 724], 40.00th=3D[ 820], 50.00th=3D[ 924], 60.00th=3D[ 996],<b=
r>
| 70.00th=3D[ 1080], 80.00th=3D[ 1176], 90.00th=3D[ 1336], 95.00th=3D[ 1528=
],<br>
| 99.00th=3D[ 2096], 99.50th=3D[ 2320], 99.90th=3D[ 2672], 99.95th=3D[ 2928=
],<br>
| 99.99th=3D[ 4832]<br>
bw (KB /s): min=3D98136, max=3D171624, per=3D100.00%, avg=3D133682.64, stde=
v=3D19121.91<br>
lat (usec) : 250=3D0.01%, 500=3D0.57%, 750=3D32.57%, 1000=3D26.98%<br>
lat (msec) : 2=3D38.59%, 4=3D1.28%, 10=3D0.01%, 20=3D0.01%<br>
cpu : usr=3D9.24%, sys=3D15.92%, ctx=3D51219, majf=3D0, minf=3D38<br>
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%,=
 &gt;=3D64=3D0.0%<br>
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0%<br>
complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0%,=
 &gt;=3D64=3D0.0%<br>
issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0<br>
latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
READ: io=3D5120.0MB, aggrb=3D133583KB/s, minb=3D133583KB/s, maxb=3D133583KB=
/s, mint=3D39248msec, maxt=3D39248msec<br>
<br>
Disk stats (read/write):<br>
vdb: ios=3D1304526/0, merge=3D0/0, ticks=3D1075020/0, in_queue=3D1074536, u=
til=3D99.84%<br>
<br>
<br>
<br>
qemu : iothread : jemmaloc : iops=3D28023<br>
----------------------------------------<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Dlibaio, iodepth=3D32<br>
fio-2.1.11<br>
Starting 1 process<br>
Jobs: 1 (f=3D1): [r(1)] [97.9% done] [155.2MB/0KB/0KB /s] [39.1K/0/0 iops] =
[eta 00m:01s]<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D899: Tue Jun 9=
 18:30:26 2015<br>
read : io=3D5120.0MB, bw=3D112094KB/s, iops=3D28023, runt=3D 46772msec<br>
slat (usec): min=3D1, max=3D467, avg=3D 4.33, stdev=3D 4.77<br>
clat (usec): min=3D253, max=3D11307, avg=3D1135.63, stdev=3D346.55<br>
lat (usec): min=3D256, max=3D11309, avg=3D1140.39, stdev=3D346.22<br>
clat percentiles (usec):<br>
| 1.00th=3D[ 510], 5.00th=3D[ 628], 10.00th=3D[ 700], 20.00th=3D[ 820],<br>
| 30.00th=3D[ 924], 40.00th=3D[ 1032], 50.00th=3D[ 1128], 60.00th=3D[ 1224]=
,<br>
| 70.00th=3D[ 1320], 80.00th=3D[ 1416], 90.00th=3D[ 1560], 95.00th=3D[ 1688=
],<br>
| 99.00th=3D[ 2096], 99.50th=3D[ 2224], 99.90th=3D[ 2544], 99.95th=3D[ 2832=
],<br>
| 99.99th=3D[ 3760]<br>
bw (KB /s): min=3D91792, max=3D174416, per=3D99.90%, avg=3D111985.27, stdev=
=3D17381.70<br>
lat (usec) : 500=3D0.80%, 750=3D13.10%, 1000=3D23.33%<br>
lat (msec) : 2=3D61.30%, 4=3D1.46%, 10=3D0.01%, 20=3D0.01%<br>
cpu : usr=3D7.12%, sys=3D17.43%, ctx=3D54507, majf=3D0, minf=3D38<br>
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%,=
 &gt;=3D64=3D0.0%<br>
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0%<br>
complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0%,=
 &gt;=3D64=3D0.0%<br>
issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0<br>
latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
READ: io=3D5120.0MB, aggrb=3D112094KB/s, minb=3D112094KB/s, maxb=3D112094KB=
/s, mint=3D46772msec, maxt=3D46772msec<br>
<br>
Disk stats (read/write):<br>
vdb: ios=3D1309169/0, merge=3D0/0, ticks=3D1305796/0, in_queue=3D1305376, u=
til=3D98.68%<br>
<br>
<br>
<br>
qemu : non-iothread : jemmaloc : iops=3D42226<br>
--------------------------------------------<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Dlibaio, iodepth=3D32<br>
fio-2.1.11<br>
Starting 1 process<br>
Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.2MB/0KB/0KB /s] [43.9K/0/0 iops]=
 [eta 00m:00s]<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D892: Tue Jun 9=
 18:34:11 2015<br>
read : io=3D5120.0MB, bw=3D177130KB/s, iops=3D44282, runt=3D 29599msec<br>
slat (usec): min=3D1, max=3D527, avg=3D 3.80, stdev=3D 3.74<br>
clat (usec): min=3D174, max=3D3841, avg=3D717.08, stdev=3D237.53<br>
lat (usec): min=3D210, max=3D3844, avg=3D721.23, stdev=3D237.22<br>
clat percentiles (usec):<br>
| 1.00th=3D[ 354], 5.00th=3D[ 422], 10.00th=3D[ 462], 20.00th=3D[ 516],<br>
| 30.00th=3D[ 572], 40.00th=3D[ 628], 50.00th=3D[ 684], 60.00th=3D[ 740],<b=
r>
| 70.00th=3D[ 804], 80.00th=3D[ 884], 90.00th=3D[ 1004], 95.00th=3D[ 1128],=
<br>
| 99.00th=3D[ 1544], 99.50th=3D[ 1672], 99.90th=3D[ 1928], 99.95th=3D[ 2064=
],<br>
| 99.99th=3D[ 2608]<br>
bw (KB /s): min=3D138120, max=3D230816, per=3D100.00%, avg=3D177192.14, std=
ev=3D23440.79<br>
lat (usec) : 250=3D0.01%, 500=3D16.24%, 750=3D45.93%, 1000=3D27.46%<br>
lat (msec) : 2=3D10.30%, 4=3D0.07%<br>
cpu : usr=3D10.14%, sys=3D23.84%, ctx=3D60938, majf=3D0, minf=3D39<br>
IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D100.0%,=
 &gt;=3D64=3D0.0%<br>
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0%<br>
complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.1%, 64=3D0.0%,=
 &gt;=3D64=3D0.0%<br>
issued : total=3Dr=3D1310720/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0<br>
latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
READ: io=3D5120.0MB, aggrb=3D177130KB/s, minb=3D177130KB/s, maxb=3D177130KB=
/s, mint=3D29599msec, maxt=3D29599msec<br>
<br>
Disk stats (read/write):<br>
vdb: ios=3D1303992/0, merge=3D0/0, ticks=3D798008/0, in_queue=3D797636, uti=
l=3D99.80%<br>
<br>
<br>
<br>
----- Mail original -----<br>
De: &quot;Robert LeBlanc&quot; &lt;<a href=3D"mailto:robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org">=
robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org</a>&gt;<br>
=C3=80: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">ad=
erumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Cc: &quot;Mark Nelson&quot; &lt;<a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">mnels=
on-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;, &quot;ceph-devel&quot; &lt;<a href=3D"mailto:ceph-de=
vel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;pushpesh sha=
rma&quot; &lt;<a href=3D"mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck@gmail.=
com</a>&gt;, &quot;ceph-users&quot; &lt;<a href=3D"mailto:ceph-users@lists.=
ceph.com">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;<br>
Envoy=C3=A9: Mardi 9 Juin 2015 18:00:29<br>
Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 40k<br=
>
<br>
-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA256<br>
<br>
I also saw a similar performance increase by using alternative memory<br>
allocators. What I found was that Ceph OSDs performed well with either<br>
tcmalloc or jemalloc (except when RocksDB was built with jemalloc<br>
instead of tcmalloc, I&#39;m still working to dig into why that might be<br=
>
the case).<br>
<br>
However, I found that tcmalloc with QEMU/KVM was very detrimental to<br>
small I/O, but provided huge gains in I/O &gt;=3D1MB. Jemalloc was much<br>
better for QEMU/KVM in the tests that we ran. [1]<br>
<br>
I&#39;m currently looking into I/O bottlenecks around the 16KB range and<br=
>
I&#39;m seeing a lot of time in thread creation and destruction, the<br>
memory allocators are quite a bit down the list (both fio with<br>
ioengine rbd and on the OSDs). I wonder what the difference can be.<br>
I&#39;ve tried using the async messenger but there wasn&#39;t a huge<br>
difference. [2]<br>
<br>
Further down the rabbit hole....<br>
<br>
[1] <a href=3D"https://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg20=
197.html" target=3D"_blank">https://www.mail-archive.com/ceph-users@lists.c=
eph.com/msg20197.html</a><br>
[2] <a href=3D"https://www.mail-archive.com/ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg2=
3982.html" target=3D"_blank">https://www.mail-archive.com/ceph-devel@vger.k=
ernel.org/msg23982.html</a><br>
-----BEGIN PGP SIGNATURE-----<br>
Version: Mailvelope v0.13.1<br>
Comment: <a href=3D"https://www.mailvelope.com" target=3D"_blank">https://w=
ww.mailvelope.com</a><br>
<br>
wsFcBAEBCAAQBQJVdw2ZCRDmVDuy+mK58QAA4MwP/1vt65cvTyyVGGSGRrE8<br>
unuWjafMHzl486XH+EaVrDVTXFVFOoncJ6kugSpD7yavtCpZNdhsIaTRZguU<br>
YpfAppNAJU5biSwNv9QPI7kPP2q2+I7Z8ZkvhcVnkjIythoeNnSjV7zJrw87<br>
afq46GhPHqEXdjp3rOB4RRPniOMnub5oU6QRnKn3HPW8Dx9ZqTeCofRDnCY2<br>
S695Dt1gzt0ERUOgrUUkt0FQJdkkV6EURcUschngjtEd5727VTLp02HivVl3<br>
vDYWxQHPK8oS6Xe8GOW0JjulwiqlYotSlrqSU5FMU5gozbk9zMFPIUW1e+51<br>
9ART8Ta2ItMhPWtAhRwwvxgy51exCy9kBc+m+ptKW5XRUXOImGcOQxszPGOO<br>
qIIOG1vVG/GBmo/0i6tliqBFYdXmw1qFV7tFiIbisZRH7Q/1NahjYTHqHhu3<br>
Dv61T6WrerD+9N6S1Lrz1QYe2Fqa56BHhHSXM82NE86SVxEvUkoGegQU+c7b<br>
6rY1JvuJHJzva7+M2XHApYCchCs4a1Yyd1qWB7yThJD57RIyX1TOg0+siV13<br>
R+v6wxhQU0vBovH+5oAWmCZaPNT+F0Uvs3xWAxxaIR9r83wMj9qQeBZTKVzQ<br>
1aFIi15KqAwOp12yWCmrqKTeXhjwYQNd8viCQCGN7AQyPglmzfbuEHalVjz4<br>
oSJX<br>
=3Dk281<br>
-----END PGP SIGNATURE-----<br>
----------------<br>
Robert LeBlanc<br>
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904 C70E E654 3BB2 FA62 B9F1<br>
<br>
<br>
On Tue, Jun 9, 2015 at 6:02 AM, Alexandre DERUMIER &lt;<a href=3D"mailto:ad=
erumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;Frankly, I&#39;m a little impressed that without RBD cache we c=
an hit 80K<br>
&gt;&gt;&gt;IOPS from 1 VM!<br>
&gt;<br>
&gt; Note that theses result are not in a vm (fio-rbd on host), so in a vm =
we&#39;ll have overhead.<br>
&gt; (I&#39;m planning to send results in qemu soon)<br>
&gt;<br>
&gt;&gt;&gt;How fast are the SSDs in those 3 OSDs?<br>
&gt;<br>
&gt; Theses results are with datas in buffer memory of osd nodes.<br>
&gt;<br>
&gt; When reading fulling on ssd (intel s3500),<br>
&gt;<br>
&gt; For 1 client,<br>
&gt;<br>
&gt; I&#39;m around 33k iops without cache and 32k iops with cache, with 1 =
osd.<br>
&gt; I&#39;m around 55k iops without cache and 38k iops with cache, with 3 =
osd.<br>
&gt;<br>
&gt; with multiple clients jobs, I can reach around 70kiops by osd , and 25=
0k iops by osd when datas are in buffer.<br>
&gt;<br>
&gt; (cpus servers/clients are 2x 10 cores 3,1ghz e5 xeon)<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; small tip :<br>
&gt; I&#39;m using tcmalloc for fio-rbd or rados bench to improve latencies=
 by around 20%<br>
&gt;<br>
&gt; LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 fio ...<br>
&gt; LD_PRELOAD=3D/usr/lib/libtcmalloc_minimal.so.4 rados bench ...<br>
&gt;<br>
&gt; as a lot of time is spent in malloc/free<br>
&gt;<br>
&gt;<br>
&gt; (qemu support also tcmalloc since some months , I&#39;ll bench it too<=
br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2015-03/msg05=
372.html" target=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel/2=
015-03/msg05372.html</a>)<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I&#39;ll try to send full bench results soon, from 1 to 18 ssd osd.<br=
>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ----- Mail original -----<br>
&gt; De: &quot;Mark Nelson&quot; &lt;<a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">=
mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
&gt; =C3=80: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10@public.gmane.org=
m">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;, &quot;pushpesh sharma&quot; &lt;<a href=3D"=
mailto:pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; Cc: &quot;ceph-devel&quot; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TZNg+MwTxZMZA@public.gmane.org=
l.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;ceph-users&quot; &lt;<a hr=
ef=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;<b=
r>
&gt; Envoy=C3=A9: Mardi 9 Juin 2015 13:36:31<br>
&gt; Objet: Re: [ceph-users] rbd_cache, limiting read on high iops around 4=
0k<br>
&gt;<br>
&gt; Hi All,<br>
&gt;<br>
&gt; In the past we&#39;ve hit some performance issues with RBD cache that =
we&#39;ve<br>
&gt; fixed, but we&#39;ve never really tried pushing a single VM beyond 40+=
K read<br>
&gt; IOPS in testing (or at least I never have). I suspect there&#39;s a co=
uple<br>
&gt; of possibilities as to why it might be slower, but perhaps joshd can<b=
r>
&gt; chime in as he&#39;s more familiar with what that code looks like.<br>
&gt;<br>
&gt; Frankly, I&#39;m a little impressed that without RBD cache we can hit =
80K<br>
&gt; IOPS from 1 VM! How fast are the SSDs in those 3 OSDs?<br>
&gt;<br>
&gt; Mark<br>
&gt;<br>
&gt; On 06/09/2015 03:36 AM, Alexandre DERUMIER wrote:<br>
&gt;&gt; It&#39;s seem that the limit is mainly going in high queue depth (=
+- &gt; 16)<br>
&gt;&gt;<br>
&gt;&gt; Here the result in iops with 1client- 4krandread- 3osd - with diff=
erents queue depth size.<br>
&gt;&gt; rbd_cache is almost the same than without cache with queue depth &=
lt;16<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; cache<br>
&gt;&gt; -----<br>
&gt;&gt; qd1: 1651<br>
&gt;&gt; qd2: 3482<br>
&gt;&gt; qd4: 7958<br>
&gt;&gt; qd8: 17912<br>
&gt;&gt; qd16: 36020<br>
&gt;&gt; qd32: 42765<br>
&gt;&gt; qd64: 46169<br>
&gt;&gt;<br>
&gt;&gt; no cache<br>
&gt;&gt; --------<br>
&gt;&gt; qd1: 1748<br>
&gt;&gt; qd2: 3570<br>
&gt;&gt; qd4: 8356<br>
&gt;&gt; qd8: 17732<br>
&gt;&gt; qd16: 41396<br>
&gt;&gt; qd32: 78633<br>
&gt;&gt; qd64: 79063<br>
&gt;&gt; qd128: 79550<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ----- Mail original -----<br>
&gt;&gt; De: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10@public.gmane.org=
m">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; =C3=80: &quot;pushpesh sharma&quot; &lt;<a href=3D"mailto:pushpesh=
.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; Cc: &quot;ceph-devel&quot; &lt;<a href=3D"mailto:ceph-devel@vger.k=
ernel.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;ceph-users&quot; &lt;<=
a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&g=
t;<br>
&gt;&gt; Envoy=C3=A9: Mardi 9 Juin 2015 09:28:21<br>
&gt;&gt; Objet: Re: [ceph-users] rbd_cache, limiting read on high iops arou=
nd 40k<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt; We tried adding more RBDs to single VM, but no luck.<br>
&gt;&gt;<br>
&gt;&gt; If you want to scale with more disks in a single qemu vm, you need=
 to use iothread feature from qemu and assign 1 iothread by disk (works wit=
h virtio-blk).<br>
&gt;&gt; It&#39;s working for me, I can scale with adding more disks.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; My bench here are done with fio-rbd on host.<br>
&gt;&gt; I can scale up to 400k iops with 10clients-rbd_cache=3Doff on a si=
ngle host and around 250kiops 10clients-rbdcache=3Don.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I just wonder why I don&#39;t have performance decrease around 30k=
 iops with 1osd.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m going to see if this tracker<br>
&gt;&gt; <a href=3D"http://tracker.ceph.com/issues/11056" target=3D"_blank"=
>http://tracker.ceph.com/issues/11056</a><br>
&gt;&gt;<br>
&gt;&gt; could be the cause.<br>
&gt;&gt;<br>
&gt;&gt; (My master build was done some week ago)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ----- Mail original -----<br>
&gt;&gt; De: &quot;pushpesh sharma&quot; &lt;<a href=3D"mailto:pushpesh.eck=
@gmail.com">pushpesh.eck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; =C3=80: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier@odis=
o.com">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; Cc: &quot;ceph-devel&quot; &lt;<a href=3D"mailto:ceph-devel@vger.k=
ernel.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;ceph-users&quot; &lt;<=
a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&g=
t;<br>
&gt;&gt; Envoy=C3=A9: Mardi 9 Juin 2015 09:21:04<br>
&gt;&gt; Objet: Re: rbd_cache, limiting read on high iops around 40k<br>
&gt;&gt;<br>
&gt;&gt; Hi Alexandre,<br>
&gt;&gt;<br>
&gt;&gt; We have also seen something very similar on Hammer(0.94-1). We wer=
e doing some benchmarking for VMs hosted on hypervisor (QEMU-KVM, openstack=
-juno). Each Ubuntu-VM has a RBD as root disk, and 1 RBD as additional stor=
age. For some strange reason it was not able to scale 4K- RR iops on each V=
M beyond 35-40k. We tried adding more RBDs to single VM, but no luck. Howev=
er increasing number of VMs to 4 on a single hypervisor did scale to some e=
xtent. After this there was no much benefit we got from adding more VMs.<br=
>
&gt;&gt;<br>
&gt;&gt; Here is the trend we have seen, x-axis is number of hypervisor, ea=
ch hypervisor has 4 VM, each VM has 1 RBD:-<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; VDbench is used as benchmarking tool. We were not saturating netwo=
rk and CPUs at OSD nodes. We were not able to saturate CPUs at hypervisors,=
 and that is where we were suspecting of some throttling effect. However we=
 haven&#39;t setted any such limits from nova or kvm end. We tried some CPU=
 pinning and other KVM related tuning as well, but no luck.<br>
&gt;&gt;<br>
&gt;&gt; We tried the same experiment on a bare metal. It was 4K RR IOPs we=
re scaling from 40K(1 RBD) to 180K(4 RBDs). But after that rather than scal=
ing beyond that point the numbers were actually degrading. (Single pipe mor=
e congestion effect)<br>
&gt;&gt;<br>
&gt;&gt; We never suspected that rbd cache enable could be detrimental to p=
erformance. It would nice to route cause the problem if that is the case.<b=
r>
&gt;&gt;<br>
&gt;&gt; On Tue, Jun 9, 2015 at 11:21 AM, Alexandre DERUMIER &lt; <a href=
=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m doing benchmark (ceph master branch), with randread 4k qde=
pth=3D32,<br>
&gt;&gt; and rbd_cache=3Dtrue seem to limit the iops around 40k<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; no cache<br>
&gt;&gt; --------<br>
&gt;&gt; 1 client - rbd_cache=3Dfalse - 1osd : 38300 iops<br>
&gt;&gt; 1 client - rbd_cache=3Dfalse - 2osd : 69073 iops<br>
&gt;&gt; 1 client - rbd_cache=3Dfalse - 3osd : 78292 iops<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; cache<br>
&gt;&gt; -----<br>
&gt;&gt; 1 client - rbd_cache=3Dtrue - 1osd : 38100 iops<br>
&gt;&gt; 1 client - rbd_cache=3Dtrue - 2osd : 42457 iops<br>
&gt;&gt; 1 client - rbd_cache=3Dtrue - 3osd : 45823 iops<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Is it expected ?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; fio result rbd_cache=3Dfalse 3 osd<br>
&gt;&gt; --------------------------------<br>
&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K=
, ioengine=3Drbd, iodepth=3D32<br>
&gt;&gt; fio-2.1.11<br>
&gt;&gt; Starting 1 process<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [100.0% done] [307.5MB/0KB/0KB /s] [78.8K/=
0/0 iops] [eta 00m:00s]<br>
&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D11354=
8: Tue Jun 9 07:48:42 2015<br>
&gt;&gt; read : io=3D10000MB, bw=3D313169KB/s, iops=3D78292, runt=3D 32698m=
sec<br>
&gt;&gt; slat (usec): min=3D5, max=3D530, avg=3D11.77, stdev=3D 6.77<br>
&gt;&gt; clat (usec): min=3D70, max=3D2240, avg=3D336.08, stdev=3D94.82<br>
&gt;&gt; lat (usec): min=3D101, max=3D2247, avg=3D347.84, stdev=3D95.49<br>
&gt;&gt; clat percentiles (usec):<br>
&gt;&gt; | 1.00th=3D[ 173], 5.00th=3D[ 209], 10.00th=3D[ 231], 20.00th=3D[ =
262],<br>
&gt;&gt; | 30.00th=3D[ 282], 40.00th=3D[ 302], 50.00th=3D[ 322], 60.00th=3D=
[ 346],<br>
&gt;&gt; | 70.00th=3D[ 370], 80.00th=3D[ 402], 90.00th=3D[ 454], 95.00th=3D=
[ 506],<br>
&gt;&gt; | 99.00th=3D[ 628], 99.50th=3D[ 692], 99.90th=3D[ 860], 99.95th=3D=
[ 948],<br>
&gt;&gt; | 99.99th=3D[ 1176]<br>
&gt;&gt; bw (KB /s): min=3D238856, max=3D360448, per=3D100.00%, avg=3D31340=
2.34, stdev=3D25196.21<br>
&gt;&gt; lat (usec) : 100=3D0.01%, 250=3D15.94%, 500=3D78.60%, 750=3D5.19%,=
 1000=3D0.23%<br>
&gt;&gt; lat (msec) : 2=3D0.03%, 4=3D0.01%<br>
&gt;&gt; cpu : usr=3D74.48%, sys=3D13.25%, ctx=3D703225, majf=3D0, minf=3D1=
2452<br>
&gt;&gt; IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.8%, 16=3D87.0%, 32=
=3D12.1%, &gt;=3D64=3D0.0%<br>
&gt;&gt; submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt; complete : 0=3D0.0%, 4=3D91.6%, 8=3D3.4%, 16=3D4.5%, 32=3D0.4%, 64=
=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt; issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D=
0<br>
&gt;&gt; latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=
<br>
&gt;&gt;<br>
&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt; READ: io=3D10000MB, aggrb=3D313169KB/s, minb=3D313169KB/s, maxb=3D=
313169KB/s, mint=3D32698msec, maxt=3D32698msec<br>
&gt;&gt;<br>
&gt;&gt; Disk stats (read/write):<br>
&gt;&gt; dm-0: ios=3D0/45, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0=
.00%, aggrios=3D0/24, aggrmerge=3D0/21, aggrticks=3D0/0, aggrin_queue=3D0, =
aggrutil=3D0.00%<br>
&gt;&gt; sda: ios=3D0/24, merge=3D0/21, ticks=3D0/0, in_queue=3D0, util=3D0=
.00%<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; fio result rbd_cache=3Dtrue 3osd<br>
&gt;&gt; ------------------------------<br>
&gt;&gt;<br>
&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K=
, ioengine=3Drbd, iodepth=3D32<br>
&gt;&gt; fio-2.1.11<br>
&gt;&gt; Starting 1 process<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; Jobs: 1 (f=3D1): [r(1)] [100.0% done] [171.6MB/0KB/0KB /s] [43.1K/=
0/0 iops] [eta 00m:00s]<br>
&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D11338=
9: Tue Jun 9 07:47:30 2015<br>
&gt;&gt; read : io=3D10000MB, bw=3D183296KB/s, iops=3D45823, runt=3D 55866m=
sec<br>
&gt;&gt; slat (usec): min=3D7, max=3D805, avg=3D21.26, stdev=3D15.84<br>
&gt;&gt; clat (usec): min=3D101, max=3D4602, avg=3D478.55, stdev=3D143.73<b=
r>
&gt;&gt; lat (usec): min=3D123, max=3D4669, avg=3D499.80, stdev=3D146.03<br=
>
&gt;&gt; clat percentiles (usec):<br>
&gt;&gt; | 1.00th=3D[ 227], 5.00th=3D[ 274], 10.00th=3D[ 306], 20.00th=3D[ =
350],<br>
&gt;&gt; | 30.00th=3D[ 390], 40.00th=3D[ 430], 50.00th=3D[ 470], 60.00th=3D=
[ 506],<br>
&gt;&gt; | 70.00th=3D[ 548], 80.00th=3D[ 596], 90.00th=3D[ 660], 95.00th=3D=
[ 724],<br>
&gt;&gt; | 99.00th=3D[ 844], 99.50th=3D[ 908], 99.90th=3D[ 1112], 99.95th=
=3D[ 1288],<br>
&gt;&gt; | 99.99th=3D[ 2192]<br>
&gt;&gt; bw (KB /s): min=3D115280, max=3D204416, per=3D100.00%, avg=3D18331=
5.10, stdev=3D15079.93<br>
&gt;&gt; lat (usec) : 250=3D2.42%, 500=3D55.61%, 750=3D38.48%, 1000=3D3.28%=
<br>
&gt;&gt; lat (msec) : 2=3D0.19%, 4=3D0.01%, 10=3D0.01%<br>
&gt;&gt; cpu : usr=3D60.27%, sys=3D12.01%, ctx=3D2995393, majf=3D0, minf=3D=
14100<br>
&gt;&gt; IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D13.5%, 16=3D81.0%, 3=
2=3D5.3%, &gt;=3D64=3D0.0%<br>
&gt;&gt; submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt; complete : 0=3D0.0%, 4=3D95.0%, 8=3D0.1%, 16=3D1.0%, 32=3D4.0%, 64=
=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt; issued : total=3Dr=3D2560000/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D=
0<br>
&gt;&gt; latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=
<br>
&gt;&gt;<br>
&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt; READ: io=3D10000MB, aggrb=3D183295KB/s, minb=3D183295KB/s, maxb=3D=
183295KB/s, mint=3D55866msec, maxt=3D55866msec<br>
&gt;&gt;<br>
&gt;&gt; Disk stats (read/write):<br>
&gt;&gt; dm-0: ios=3D0/61, merge=3D0/0, ticks=3D0/8, in_queue=3D8, util=3D0=
.01%, aggrios=3D0/29, aggrmerge=3D0/32, aggrticks=3D0/8, aggrin_queue=3D8, =
aggrutil=3D0.01%<br>
&gt;&gt; sda: ios=3D0/29, merge=3D0/32, ticks=3D0/8, in_queue=3D8, util=3D0=
.01%<br>
&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" tar=
get=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><b=
r>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr">=D0=A1 =D1=83=D0=B2=D0=B0=
=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=
=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=
=D0=BE=D0=B2=D0=B8=D1=87<div>=D0=9C=D0=BE=D0=B1.: +79229045757</div></div><=
/div>
</div>

--001a1134d8b0142e700518230e78--

--===============2106350416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2106350416==--
