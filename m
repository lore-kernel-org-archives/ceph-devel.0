From: Sushma R <gsushma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Annonce]The progress of KeyValueStore in Firely
Date: Tue, 3 Jun 2014 11:55:02 -0700
Message-ID: <CAOj3taONVV8rMAgu8Cen=eCZ2ycYjSs8u3nfKiJUptdb7ffyEA@mail.gmail.com>
References: <CACJqLybuA48Jnz6Qwc7cs2kHJO30C4GwazXi8yGp8ZhvfFc2ZQ@mail.gmail.com>
	<531123F6.5070007@bisect.de>
	<CACJqLybtitrDOcTcRXBZYJy552JzeYZWp_d=yWGUofxT7E46+A@mail.gmail.com>
	<CAOj3taPYaJfdipyiqFavw1AT24ZumrCVWm4FrUnEc1Ki7cah9Q@mail.gmail.com>
	<CACJqLyY=BBKKdwOsEoDbo8OfD+o2B2XoSEtmnQ8=nNCm4EaADQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1626202749=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CACJqLyY=BBKKdwOsEoDbo8OfD+o2B2XoSEtmnQ8=nNCm4EaADQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1626202749==
Content-Type: multipart/alternative; boundary=047d7b339d4399e4a504faf30c83

--047d7b339d4399e4a504faf30c83
Content-Type: text/plain; charset=UTF-8

Haomai,

I'm using the latest ceph master branch.

ceph_smalliobench is a Ceph internal benchmarking tool similar to rados
bench and the performance is more or less similar to that reported by fio.

I tried to use fio with rbd ioengine (
http://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html)
and below are the numbers with different workloads on our setup.
Note : fio rbd engine segfaults with randread IO pattern, only with LevelDB
(no issues with FileStore). With FileStore, performance of
ceph_smalliobench and fio-rbd is similar for READs, so the numbers for
randread for LevelDB are with ceph_smalliobench (since fio rbd segfaults).

  I/O Pattern

XFS FileStore

LevelDB



IOPs

Avg. Latency

IOPs

Avg. Latency











4K randwrite

1415

22.55 msec

853

37.48 msec

64K randwrite

311

214.86 msec

328

97.42 msec

4K randread

9477

3.346 msec

3000

11 msec

64K randread

3961

8.072 msec

4000

8 msec


Based on the above, it appears that LevelDB performs better than FileStore
only for 64K random writes - the latency is particularly low compared to
FileStore.
For the rest of the workloads, XFS FileStore seems to perform better.
Can you please let me know any config values that can be tuned for better
performance? Currently I'm using the same ceph.conf as you posted as part
of this thread.

Appreciate all help in this regard.

Thanks,
Sushma

On Tue, Jun 3, 2014 at 12:06 AM, Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I don't know the actual size of "small io". And what's ceph version you
> used.
>
> But I think it's possible if KeyValueStore only has half performance
> compared to FileStore in small io size. A new config value let user
> can tunes it will be introduced and maybe help.
>
> All in all, maybe you could tell more about "ceph_smalliobench"
>
> On Tue, Jun 3, 2014 at 1:36 PM, Sushma R <gsushma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hi Haomai,
> >
> > I tried to compare the READ performance of FileStore and KeyValueStore
> using
> > the internal tool "ceph_smalliobench" and I see KeyValueStore's
> performance
> > is approx half that of FileStore. I'm using similar conf file as yours.
> Is
> > this the expected behavior or am I missing something?
> >
> > Thanks,
> > Sushma
> >
> >
> > On Fri, Feb 28, 2014 at 11:00 PM, Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >>
> >> On Sat, Mar 1, 2014 at 8:04 AM, Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
> >> wrote:
> >> > Hi,
> >> >
> >> > Am 28.02.2014 03:45, schrieb Haomai Wang:
> >> > [...]
> >> >> I use fio which rbd supported from
> >> >> TelekomCloud(https://github.com/TelekomCloud/fio/commits/rbd-engine)
> >> >> to test rbd.
> >> >
> >> > I would recommend to no longer use this branch, it's outdated. The rbd
> >> > engine got contributed back to upstream fio and is now merged [1]. For
> >> > more information read [2].
> >> >
> >> > [1] https://github.com/axboe/fio/commits/master
> >> > [2]
> >> >
> >> >
> http://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html
> >> >
> >> >>
> >> >> The fio command: fio -direct=1 -iodepth=64 -thread -rw=randwrite
> >> >> -ioengine=rbd -bs=4k -size=19G -numjobs=1 -runtime=100
> >> >> -group_reporting -name=ebs_test -pool=openstack -rbdname=image
> >> >> -clientname=fio -invalidate=0
> >> >
> >> > Don't use runtime and size at the same time, since runtime limits the
> >> > size. What we normally do we let the fio job fill up the whole rbd or
> we
> >> > limit it only via runtime.
> >> >
> >> >> ============================================
> >> >>
> >> >> FileStore result:
> >> >> ebs_test: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd,
> >> >> iodepth=64
> >> >> fio-2.1.4
> >> >> Starting 1 thread
> >> >> rbd engine: RBD version: 0.1.8
> >> >>
> >> >> ebs_test: (groupid=0, jobs=1): err= 0: pid=30886: Thu Feb 27 08:09:18
> >> >> 2014
> >> >>   write: io=283040KB, bw=6403.4KB/s, iops=1600, runt= 44202msec
> >> >>     slat (usec): min=116, max=2817, avg=195.78, stdev=56.45
> >> >>     clat (msec): min=8, max=661, avg=39.57, stdev=29.26
> >> >>      lat (msec): min=9, max=661, avg=39.77, stdev=29.25
> >> >>     clat percentiles (msec):
> >> >>      |  1.00th=[   15],  5.00th=[   20], 10.00th=[   23], 20.00th=[
> >> >> 28],
> >> >>      | 30.00th=[   31], 40.00th=[   35], 50.00th=[   37], 60.00th=[
> >> >> 40],
> >> >>      | 70.00th=[   43], 80.00th=[   46], 90.00th=[   51], 95.00th=[
> >> >> 58],
> >> >>      | 99.00th=[  128], 99.50th=[  210], 99.90th=[  457], 99.95th=[
> >> >> 494],
> >> >>      | 99.99th=[  545]
> >> >>     bw (KB  /s): min= 2120, max=12656, per=100.00%, avg=6464.27,
> >> >> stdev=1726.55
> >> >>     lat (msec) : 10=0.01%, 20=5.91%, 50=83.35%, 100=8.88%, 250=1.47%
> >> >>     lat (msec) : 500=0.34%, 750=0.05%
> >> >>   cpu          : usr=29.83%, sys=1.36%, ctx=84002, majf=0, minf=216
> >> >>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=17.4%,
> >> >> >=64=82.6%
> >> >>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >> >> >=64=0.0%
> >> >>      complete  : 0=0.0%, 4=99.1%, 8=0.5%, 16=0.3%, 32=0.1%, 64=0.1%,
> >> >> >=64=0.0%
> >> >>      issued    : total=r=0/w=70760/d=0, short=r=0/w=0/d=0
> >> >>      latency   : target=0, window=0, percentile=100.00%, depth=64
> >> >>
> >> >> Run status group 0 (all jobs):
> >> >>   WRITE: io=283040KB, aggrb=6403KB/s, minb=6403KB/s, maxb=6403KB/s,
> >> >> mint=44202msec, maxt=44202msec
> >> >>
> >> >> Disk stats (read/write):
> >> >>   sdb: ios=5/9512, merge=0/69, ticks=4/10649, in_queue=10645,
> >> >> util=0.92%
> >> >>
> >> >> ===============================================
> >> >>
> >> >> KeyValueStore:
> >> >> ebs_test: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd,
> >> >> iodepth=64
> >> >> fio-2.1.4
> >> >> Starting 1 thread
> >> >> rbd engine: RBD version: 0.1.8
> >> >>
> >> >> ebs_test: (groupid=0, jobs=1): err= 0: pid=29137: Thu Feb 27 08:06:30
> >> >> 2014
> >> >>   write: io=444376KB, bw=6280.2KB/s, iops=1570, runt= 70759msec
> >> >>     slat (usec): min=122, max=3237, avg=184.51, stdev=37.76
> >> >>     clat (msec): min=10, max=168, avg=40.57, stdev= 5.70
> >> >>      lat (msec): min=11, max=168, avg=40.75, stdev= 5.71
> >> >>     clat percentiles (msec):
> >> >>      |  1.00th=[   34],  5.00th=[   37], 10.00th=[   39], 20.00th=[
> >> >> 39],
> >> >>      | 30.00th=[   40], 40.00th=[   40], 50.00th=[   41], 60.00th=[
> >> >> 41],
> >> >>      | 70.00th=[   42], 80.00th=[   42], 90.00th=[   44], 95.00th=[
> >> >> 45],
> >> >>      | 99.00th=[   48], 99.50th=[   50], 99.90th=[  163], 99.95th=[
> >> >> 167],
> >> >>      | 99.99th=[  167]
> >> >>     bw (KB  /s): min= 4590, max= 7480, per=100.00%, avg=6285.69,
> >> >> stdev=374.22
> >> >>     lat (msec) : 20=0.02%, 50=99.58%, 100=0.23%, 250=0.17%
> >> >>   cpu          : usr=29.11%, sys=1.10%, ctx=118564, majf=0, minf=194
> >> >>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.7%,
> >> >> >=64=99.3%
> >> >>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >> >> >=64=0.0%
> >> >>      complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.1%, 32=0.0%, 64=0.1%,
> >> >> >=64=0.0%
> >> >>      issued    : total=r=0/w=111094/d=0, short=r=0/w=0/d=0
> >> >>      latency   : target=0, window=0, percentile=100.00%, depth=64
> >> >>
> >> >> Run status group 0 (all jobs):
> >> >>   WRITE: io=444376KB, aggrb=6280KB/s, minb=6280KB/s, maxb=6280KB/s,
> >> >> mint=70759msec, maxt=70759msec
> >> >>
> >> >> Disk stats (read/write):
> >> >>   sdb: ios=0/15936, merge=0/272, ticks=0/17157, in_queue=17146,
> >> >> util=0.94%
> >> >>
> >> >>
> >> >> It's just a simple test, maybe exist some misleadings on the config
> or
> >> >> results. But
> >> >> we can obviously see the conspicuous improvement for KeyValueStore.
> >> >
> >> > The numbers are hard to compare. Since the tests wrote a different
> >> > amount of data. This could influence the numbers.
> >> >
> >> > Do you mean improvements compared to former implementation or to
> >> > FileStore?
> >> >
> >> > Without a retest with the latest fio rbd engine: there is not so much
> >> > difference between KVS and FS atm.
> >> >
> >> > Btw. Nice to see the rbd engine is useful to others ;-)
> >>
> >> Thanks for your advise and jobs on fio-rbd. :)
> >>
> >> The test isn't preciseness and just a simple test to show the progress
> >> of kvstore.
> >>
> >> >
> >> > Regards
> >> >
> >> > Danny
> >>
> >>
> >>
> >> --
> >> Best Regards,
> >>
> >> Wheat
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> >
>
>
>
> --
> Best Regards,
>
> Wheat
>

--047d7b339d4399e4a504faf30c83
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Haomai,<div><br></div><div>I&#39;m using the latest ceph m=
aster branch.</div><div><br></div><div>ceph_smalliobench is a Ceph internal=
 benchmarking tool similar to rados bench and the performance is more or le=
ss similar to that reported by fio.</div>
<div><br></div><div>I tried to use fio with rbd ioengine (<a href=3D"http:/=
/telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analysis_fio_rbd.h=
tml">http://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analysi=
s_fio_rbd.html</a>) and below are the numbers with different workloads on o=
ur setup.=C2=A0</div>
<div>Note : fio rbd engine segfaults with randread IO pattern, only with Le=
velDB (no issues with FileStore). With FileStore, performance of ceph_small=
iobench and fio-rbd is similar for READs, so the numbers for randread for L=
evelDB are with ceph_smalliobench (since fio rbd segfaults).<br>
</div><div><br></div><div><div align=3D"center">

<table class=3D"" border=3D"1" cellspacing=3D"0" cellpadding=3D"0" style=3D=
"border-collapse:collapse;border:none">
 <tbody><tr>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border:1pt solid =
windowtext;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">I/O P=
attern</p>
  </td>
  <td width=3D"255" colspan=3D"2" valign=3D"top" style=3D"width:191.5pt;bor=
der-style:solid solid solid none;border-top-color:windowtext;border-right-c=
olor:windowtext;border-bottom-color:windowtext;border-top-width:1pt;border-=
right-width:1pt;border-bottom-width:1pt;padding:0in 5.4pt">

  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">XFS F=
ileStore</p>
  </td>
  <td width=3D"255" colspan=3D"2" valign=3D"top" style=3D"width:191.55pt;bo=
rder-style:solid solid solid none;border-top-color:windowtext;border-right-=
color:windowtext;border-bottom-color:windowtext;border-top-width:1pt;border=
-right-width:1pt;border-bottom-width:1pt;padding:0in 5.4pt">

  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">Level=
DB</p>
  </td>
 </tr>
 <tr>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid;border-right-color:windowtext;border-bottom-color:windowtext;b=
order-left-color:windowtext;border-right-width:1pt;border-bottom-width:1pt;=
border-left-width:1pt;padding:0in 5.4pt">

  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">=C2=
=A0</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">IOPs<=
/p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">Avg. =
Latency</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">IOPs<=
/p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.8pt;border-style:none =
solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bor=
der-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">Avg. =
Latency</p>
  </td>
 </tr>
 <tr>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid;border-right-color:windowtext;border-bottom-color:windowtext;b=
order-left-color:windowtext;border-right-width:1pt;border-bottom-width:1pt;=
border-left-width:1pt;padding:0in 5.4pt">

  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">=C2=
=A0</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">=C2=
=A0</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">=C2=
=A0</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">=C2=
=A0</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.8pt;border-style:none =
solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bor=
der-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">=C2=
=A0</p>
  </td>
 </tr>
 <tr>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid;border-right-color:windowtext;border-bottom-color:windowtext;b=
order-left-color:windowtext;border-right-width:1pt;border-bottom-width:1pt;=
border-left-width:1pt;padding:0in 5.4pt">

  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">4K ra=
ndwrite</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">1415<=
/p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">22.55=
 msec</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">853</=
p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.8pt;border-style:none =
solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bor=
der-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">37.48=
 msec</p>
  </td>
 </tr>
 <tr>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid;border-right-color:windowtext;border-bottom-color:windowtext;b=
order-left-color:windowtext;border-right-width:1pt;border-bottom-width:1pt;=
border-left-width:1pt;padding:0in 5.4pt">

  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">64K r=
andwrite</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">311</=
p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">214.8=
6 msec</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">328</=
p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.8pt;border-style:none =
solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bor=
der-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">97.42=
 msec</p>
  </td>
 </tr>
 <tr>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid;border-right-color:windowtext;border-bottom-color:windowtext;b=
order-left-color:windowtext;border-right-width:1pt;border-bottom-width:1pt;=
border-left-width:1pt;padding:0in 5.4pt">

  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">4K ra=
ndread</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">9477<=
/p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">3.346=
 msec</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">3000<=
/p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.8pt;border-style:none =
solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bor=
der-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">11 ms=
ec</p>
  </td>
 </tr>
 <tr>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid;border-right-color:windowtext;border-bottom-color:windowtext;b=
order-left-color:windowtext;border-right-width:1pt;border-bottom-width:1pt;=
border-left-width:1pt;padding:0in 5.4pt">

  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">64K r=
andread</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">3961<=
/p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">8.072=
 msec</p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.75pt;border-style:none=
 solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bo=
rder-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">4000<=
/p>
  </td>
  <td width=3D"128" valign=3D"top" style=3D"width:95.8pt;border-style:none =
solid solid none;border-bottom-color:windowtext;border-bottom-width:1pt;bor=
der-right-color:windowtext;border-right-width:1pt;padding:0in 5.4pt">
  <p class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">8 mse=
c</p>
  </td>
 </tr>
</tbody></table>

</div></div><div><br></div><div><br></div><div>Based on the above, it appea=
rs that LevelDB performs better than FileStore only for 64K random writes -=
 the latency is particularly low compared to FileStore.</div><div>For the r=
est of the workloads, XFS FileStore seems to perform better.</div>
<div>Can you please let me know any config values that can be tuned for bet=
ter performance? Currently I&#39;m using the same ceph.conf as you posted a=
s part of this thread.</div><div><br></div><div>Appreciate all help in this=
 regard.</div>
<div><br></div><div>Thanks,</div><div>Sushma</div><div><br></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote">On Tue, Jun 3, 2014 at 12:06 AM=
, Haomai Wang <span dir=3D"ltr">&lt;<a href=3D"mailto:haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
 target=3D"_blank">haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">I don&#39;t know the actual size of &quot;small io&quot;. =
And what&#39;s ceph version you used.<br>

<br>
But I think it&#39;s possible if KeyValueStore only has half performance<br=
>
compared to FileStore in small io size. A new config value let user<br>
can tunes it will be introduced and maybe help.<br>
<br>
All in all, maybe you could tell more about &quot;ceph_smalliobench&quot;<b=
r>
<div class=3D""><div class=3D"h5"><br>
On Tue, Jun 3, 2014 at 1:36 PM, Sushma R &lt;<a href=3D"mailto:gsushma@gmai=
l.com">gsushma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; Hi Haomai,<br>
&gt;<br>
&gt; I tried to compare the READ performance of FileStore and KeyValueStore=
 using<br>
&gt; the internal tool &quot;ceph_smalliobench&quot; and I see KeyValueStor=
e&#39;s performance<br>
&gt; is approx half that of FileStore. I&#39;m using similar conf file as y=
ours. Is<br>
&gt; this the expected behavior or am I missing something?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Sushma<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Feb 28, 2014 at 11:00 PM, Haomai Wang &lt;<a href=3D"mailto:ha=
omaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Sat, Mar 1, 2014 at 8:04 AM, Danny Al-Gaaf &lt;<a href=3D"mailt=
o:danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org">danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Am 28.02.2014 03:45, schrieb Haomai Wang:<br>
&gt;&gt; &gt; [...]<br>
&gt;&gt; &gt;&gt; I use fio which rbd supported from<br>
&gt;&gt; &gt;&gt; TelekomCloud(<a href=3D"https://github.com/TelekomCloud/f=
io/commits/rbd-engine" target=3D"_blank">https://github.com/TelekomCloud/fi=
o/commits/rbd-engine</a>)<br>
&gt;&gt; &gt;&gt; to test rbd.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I would recommend to no longer use this branch, it&#39;s outd=
ated. The rbd<br>
&gt;&gt; &gt; engine got contributed back to upstream fio and is now merged=
 [1]. For<br>
&gt;&gt; &gt; more information read [2].<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; [1] <a href=3D"https://github.com/axboe/fio/commits/master" t=
arget=3D"_blank">https://github.com/axboe/fio/commits/master</a><br>
&gt;&gt; &gt; [2]<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; <a href=3D"http://telekomcloud.github.io/ceph/2014/02/26/ceph=
-performance-analysis_fio_rbd.html" target=3D"_blank">http://telekomcloud.g=
ithub.io/ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; The fio command: fio -direct=3D1 -iodepth=3D64 -thread -r=
w=3Drandwrite<br>
&gt;&gt; &gt;&gt; -ioengine=3Drbd -bs=3D4k -size=3D19G -numjobs=3D1 -runtim=
e=3D100<br>
&gt;&gt; &gt;&gt; -group_reporting -name=3Debs_test -pool=3Dopenstack -rbdn=
ame=3Dimage<br>
&gt;&gt; &gt;&gt; -clientname=3Dfio -invalidate=3D0<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Don&#39;t use runtime and size at the same time, since runtim=
e limits the<br>
&gt;&gt; &gt; size. What we normally do we let the fio job fill up the whol=
e rbd or we<br>
&gt;&gt; &gt; limit it only via runtime.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; FileStore result:<br>
&gt;&gt; &gt;&gt; ebs_test: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K/4K-4K=
, ioengine=3Drbd,<br>
&gt;&gt; &gt;&gt; iodepth=3D64<br>
&gt;&gt; &gt;&gt; fio-2.1.4<br>
&gt;&gt; &gt;&gt; Starting 1 thread<br>
&gt;&gt; &gt;&gt; rbd engine: RBD version: 0.1.8<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; ebs_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D30886:=
 Thu Feb 27 08:09:18<br>
&gt;&gt; &gt;&gt; 2014<br>
&gt;&gt; &gt;&gt; =C2=A0 write: io=3D283040KB, bw=3D6403.4KB/s, iops=3D1600=
, runt=3D 44202msec<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 slat (usec): min=3D116, max=3D2817, avg=3D1=
95.78, stdev=3D56.45<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 clat (msec): min=3D8, max=3D661, avg=3D39.5=
7, stdev=3D29.26<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0lat (msec): min=3D9, max=3D661, avg=
=3D39.77, stdev=3D29.25<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 clat percentiles (msec):<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0| =C2=A01.00th=3D[ =C2=A0 15], =C2=A0=
5.00th=3D[ =C2=A0 20], 10.00th=3D[ =C2=A0 23], 20.00th=3D[<br>
&gt;&gt; &gt;&gt; 28],<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0| 30.00th=3D[ =C2=A0 31], 40.00th=3D[=
 =C2=A0 35], 50.00th=3D[ =C2=A0 37], 60.00th=3D[<br>
&gt;&gt; &gt;&gt; 40],<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0| 70.00th=3D[ =C2=A0 43], 80.00th=3D[=
 =C2=A0 46], 90.00th=3D[ =C2=A0 51], 95.00th=3D[<br>
&gt;&gt; &gt;&gt; 58],<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0| 99.00th=3D[ =C2=A0128], 99.50th=3D[=
 =C2=A0210], 99.90th=3D[ =C2=A0457], 99.95th=3D[<br>
&gt;&gt; &gt;&gt; 494],<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0| 99.99th=3D[ =C2=A0545]<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 bw (KB =C2=A0/s): min=3D 2120, max=3D12656,=
 per=3D100.00%, avg=3D6464.27,<br>
&gt;&gt; &gt;&gt; stdev=3D1726.55<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 lat (msec) : 10=3D0.01%, 20=3D5.91%, 50=3D8=
3.35%, 100=3D8.88%, 250=3D1.47%<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 lat (msec) : 500=3D0.34%, 750=3D0.05%<br>
&gt;&gt; &gt;&gt; =C2=A0 cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: usr=3D29.8=
3%, sys=3D1.36%, ctx=3D84002, majf=3D0, minf=3D216<br>
&gt;&gt; &gt;&gt; =C2=A0 IO depths =C2=A0 =C2=A0: 1=3D0.1%, 2=3D0.1%, 4=3D0=
.1%, 8=3D0.1%, 16=3D0.1%, 32=3D17.4%,<br>
&gt;&gt; &gt;&gt; &gt;=3D64=3D82.6%<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0submit =C2=A0 =C2=A0: 0=3D0.0%, 4=3D1=
00.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,<br>
&gt;&gt; &gt;&gt; &gt;=3D64=3D0.0%<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0complete =C2=A0: 0=3D0.0%, 4=3D99.1%,=
 8=3D0.5%, 16=3D0.3%, 32=3D0.1%, 64=3D0.1%,<br>
&gt;&gt; &gt;&gt; &gt;=3D64=3D0.0%<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0issued =C2=A0 =C2=A0: total=3Dr=3D0/w=
=3D70760/d=3D0, short=3Dr=3D0/w=3D0/d=3D0<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0latency =C2=A0 : target=3D0, window=
=3D0, percentile=3D100.00%, depth=3D64<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt; &gt;&gt; =C2=A0 WRITE: io=3D283040KB, aggrb=3D6403KB/s, minb=3D640=
3KB/s, maxb=3D6403KB/s,<br>
&gt;&gt; &gt;&gt; mint=3D44202msec, maxt=3D44202msec<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Disk stats (read/write):<br>
&gt;&gt; &gt;&gt; =C2=A0 sdb: ios=3D5/9512, merge=3D0/69, ticks=3D4/10649, =
in_queue=3D10645,<br>
&gt;&gt; &gt;&gt; util=3D0.92%<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; KeyValueStore:<br>
&gt;&gt; &gt;&gt; ebs_test: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K/4K-4K=
, ioengine=3Drbd,<br>
&gt;&gt; &gt;&gt; iodepth=3D64<br>
&gt;&gt; &gt;&gt; fio-2.1.4<br>
&gt;&gt; &gt;&gt; Starting 1 thread<br>
&gt;&gt; &gt;&gt; rbd engine: RBD version: 0.1.8<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; ebs_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D29137:=
 Thu Feb 27 08:06:30<br>
&gt;&gt; &gt;&gt; 2014<br>
&gt;&gt; &gt;&gt; =C2=A0 write: io=3D444376KB, bw=3D6280.2KB/s, iops=3D1570=
, runt=3D 70759msec<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 slat (usec): min=3D122, max=3D3237, avg=3D1=
84.51, stdev=3D37.76<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 clat (msec): min=3D10, max=3D168, avg=3D40.=
57, stdev=3D 5.70<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0lat (msec): min=3D11, max=3D168, avg=
=3D40.75, stdev=3D 5.71<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 clat percentiles (msec):<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0| =C2=A01.00th=3D[ =C2=A0 34], =C2=A0=
5.00th=3D[ =C2=A0 37], 10.00th=3D[ =C2=A0 39], 20.00th=3D[<br>
&gt;&gt; &gt;&gt; 39],<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0| 30.00th=3D[ =C2=A0 40], 40.00th=3D[=
 =C2=A0 40], 50.00th=3D[ =C2=A0 41], 60.00th=3D[<br>
&gt;&gt; &gt;&gt; 41],<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0| 70.00th=3D[ =C2=A0 42], 80.00th=3D[=
 =C2=A0 42], 90.00th=3D[ =C2=A0 44], 95.00th=3D[<br>
&gt;&gt; &gt;&gt; 45],<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0| 99.00th=3D[ =C2=A0 48], 99.50th=3D[=
 =C2=A0 50], 99.90th=3D[ =C2=A0163], 99.95th=3D[<br>
&gt;&gt; &gt;&gt; 167],<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0| 99.99th=3D[ =C2=A0167]<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 bw (KB =C2=A0/s): min=3D 4590, max=3D 7480,=
 per=3D100.00%, avg=3D6285.69,<br>
&gt;&gt; &gt;&gt; stdev=3D374.22<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 lat (msec) : 20=3D0.02%, 50=3D99.58%, 100=
=3D0.23%, 250=3D0.17%<br>
&gt;&gt; &gt;&gt; =C2=A0 cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: usr=3D29.1=
1%, sys=3D1.10%, ctx=3D118564, majf=3D0, minf=3D194<br>
&gt;&gt; &gt;&gt; =C2=A0 IO depths =C2=A0 =C2=A0: 1=3D0.1%, 2=3D0.1%, 4=3D0=
.1%, 8=3D0.1%, 16=3D0.1%, 32=3D0.7%,<br>
&gt;&gt; &gt;&gt; &gt;=3D64=3D99.3%<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0submit =C2=A0 =C2=A0: 0=3D0.0%, 4=3D1=
00.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,<br>
&gt;&gt; &gt;&gt; &gt;=3D64=3D0.0%<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0complete =C2=A0: 0=3D0.0%, 4=3D100.0%=
, 8=3D0.1%, 16=3D0.1%, 32=3D0.0%, 64=3D0.1%,<br>
&gt;&gt; &gt;&gt; &gt;=3D64=3D0.0%<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0issued =C2=A0 =C2=A0: total=3Dr=3D0/w=
=3D111094/d=3D0, short=3Dr=3D0/w=3D0/d=3D0<br>
&gt;&gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0latency =C2=A0 : target=3D0, window=
=3D0, percentile=3D100.00%, depth=3D64<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt; &gt;&gt; =C2=A0 WRITE: io=3D444376KB, aggrb=3D6280KB/s, minb=3D628=
0KB/s, maxb=3D6280KB/s,<br>
&gt;&gt; &gt;&gt; mint=3D70759msec, maxt=3D70759msec<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Disk stats (read/write):<br>
&gt;&gt; &gt;&gt; =C2=A0 sdb: ios=3D0/15936, merge=3D0/272, ticks=3D0/17157=
, in_queue=3D17146,<br>
&gt;&gt; &gt;&gt; util=3D0.94%<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; It&#39;s just a simple test, maybe exist some misleadings=
 on the config or<br>
&gt;&gt; &gt;&gt; results. But<br>
&gt;&gt; &gt;&gt; we can obviously see the conspicuous improvement for KeyV=
alueStore.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The numbers are hard to compare. Since the tests wrote a diff=
erent<br>
&gt;&gt; &gt; amount of data. This could influence the numbers.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Do you mean improvements compared to former implementation or=
 to<br>
&gt;&gt; &gt; FileStore?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Without a retest with the latest fio rbd engine: there is not=
 so much<br>
&gt;&gt; &gt; difference between KVS and FS atm.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Btw. Nice to see the rbd engine is useful to others ;-)<br>
&gt;&gt;<br>
&gt;&gt; Thanks for your advise and jobs on fio-rbd. :)<br>
&gt;&gt;<br>
&gt;&gt; The test isn&#39;t preciseness and just a simple test to show the =
progress<br>
&gt;&gt; of kvstore.<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Regards<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Danny<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Best Regards,<br>
&gt;&gt;<br>
&gt;&gt; Wheat<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; ceph-users mailing list<br>
&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com</a><br>
&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com"=
 target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</=
a><br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
</div></div><span class=3D""><font color=3D"#888888">--<br>
Best Regards,<br>
<br>
Wheat<br>
</font></span></blockquote></div><br></div></div>

--047d7b339d4399e4a504faf30c83--

--===============1626202749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1626202749==--
