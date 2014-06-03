From: Sushma R <gsushma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Annonce]The progress of KeyValueStore in Firely
Date: Mon, 2 Jun 2014 22:36:33 -0700
Message-ID: <CAOj3taPYaJfdipyiqFavw1AT24ZumrCVWm4FrUnEc1Ki7cah9Q@mail.gmail.com>
References: <CACJqLybuA48Jnz6Qwc7cs2kHJO30C4GwazXi8yGp8ZhvfFc2ZQ@mail.gmail.com>
	<531123F6.5070007@bisect.de>
	<CACJqLybtitrDOcTcRXBZYJy552JzeYZWp_d=yWGUofxT7E46+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0150332241=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CACJqLybtitrDOcTcRXBZYJy552JzeYZWp_d=yWGUofxT7E46+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0150332241==
Content-Type: multipart/alternative; boundary=047d7b2e3e440959b204fae7e56e

--047d7b2e3e440959b204fae7e56e
Content-Type: text/plain; charset=UTF-8

Hi Haomai,

I tried to compare the READ performance of FileStore and KeyValueStore
using the internal tool "ceph_smalliobench" and I see KeyValueStore's
performance is approx half that of FileStore. I'm using similar conf file
as yours. Is this the expected behavior or am I missing something?

Thanks,
Sushma


On Fri, Feb 28, 2014 at 11:00 PM, Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Sat, Mar 1, 2014 at 8:04 AM, Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
> wrote:
> > Hi,
> >
> > Am 28.02.2014 03:45, schrieb Haomai Wang:
> > [...]
> >> I use fio which rbd supported from
> >> TelekomCloud(https://github.com/TelekomCloud/fio/commits/rbd-engine)
> >> to test rbd.
> >
> > I would recommend to no longer use this branch, it's outdated. The rbd
> > engine got contributed back to upstream fio and is now merged [1]. For
> > more information read [2].
> >
> > [1] https://github.com/axboe/fio/commits/master
> > [2]
> >
> http://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html
> >
> >>
> >> The fio command: fio -direct=1 -iodepth=64 -thread -rw=randwrite
> >> -ioengine=rbd -bs=4k -size=19G -numjobs=1 -runtime=100
> >> -group_reporting -name=ebs_test -pool=openstack -rbdname=image
> >> -clientname=fio -invalidate=0
> >
> > Don't use runtime and size at the same time, since runtime limits the
> > size. What we normally do we let the fio job fill up the whole rbd or we
> > limit it only via runtime.
> >
> >> ============================================
> >>
> >> FileStore result:
> >> ebs_test: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd,
> iodepth=64
> >> fio-2.1.4
> >> Starting 1 thread
> >> rbd engine: RBD version: 0.1.8
> >>
> >> ebs_test: (groupid=0, jobs=1): err= 0: pid=30886: Thu Feb 27 08:09:18
> 2014
> >>   write: io=283040KB, bw=6403.4KB/s, iops=1600, runt= 44202msec
> >>     slat (usec): min=116, max=2817, avg=195.78, stdev=56.45
> >>     clat (msec): min=8, max=661, avg=39.57, stdev=29.26
> >>      lat (msec): min=9, max=661, avg=39.77, stdev=29.25
> >>     clat percentiles (msec):
> >>      |  1.00th=[   15],  5.00th=[   20], 10.00th=[   23], 20.00th=[
> 28],
> >>      | 30.00th=[   31], 40.00th=[   35], 50.00th=[   37], 60.00th=[
> 40],
> >>      | 70.00th=[   43], 80.00th=[   46], 90.00th=[   51], 95.00th=[
> 58],
> >>      | 99.00th=[  128], 99.50th=[  210], 99.90th=[  457], 99.95th=[
>  494],
> >>      | 99.99th=[  545]
> >>     bw (KB  /s): min= 2120, max=12656, per=100.00%, avg=6464.27,
> stdev=1726.55
> >>     lat (msec) : 10=0.01%, 20=5.91%, 50=83.35%, 100=8.88%, 250=1.47%
> >>     lat (msec) : 500=0.34%, 750=0.05%
> >>   cpu          : usr=29.83%, sys=1.36%, ctx=84002, majf=0, minf=216
> >>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=17.4%,
> >=64=82.6%
> >>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
> >>      complete  : 0=0.0%, 4=99.1%, 8=0.5%, 16=0.3%, 32=0.1%, 64=0.1%,
> >=64=0.0%
> >>      issued    : total=r=0/w=70760/d=0, short=r=0/w=0/d=0
> >>      latency   : target=0, window=0, percentile=100.00%, depth=64
> >>
> >> Run status group 0 (all jobs):
> >>   WRITE: io=283040KB, aggrb=6403KB/s, minb=6403KB/s, maxb=6403KB/s,
> >> mint=44202msec, maxt=44202msec
> >>
> >> Disk stats (read/write):
> >>   sdb: ios=5/9512, merge=0/69, ticks=4/10649, in_queue=10645, util=0.92%
> >>
> >> ===============================================
> >>
> >> KeyValueStore:
> >> ebs_test: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd,
> iodepth=64
> >> fio-2.1.4
> >> Starting 1 thread
> >> rbd engine: RBD version: 0.1.8
> >>
> >> ebs_test: (groupid=0, jobs=1): err= 0: pid=29137: Thu Feb 27 08:06:30
> 2014
> >>   write: io=444376KB, bw=6280.2KB/s, iops=1570, runt= 70759msec
> >>     slat (usec): min=122, max=3237, avg=184.51, stdev=37.76
> >>     clat (msec): min=10, max=168, avg=40.57, stdev= 5.70
> >>      lat (msec): min=11, max=168, avg=40.75, stdev= 5.71
> >>     clat percentiles (msec):
> >>      |  1.00th=[   34],  5.00th=[   37], 10.00th=[   39], 20.00th=[
> 39],
> >>      | 30.00th=[   40], 40.00th=[   40], 50.00th=[   41], 60.00th=[
> 41],
> >>      | 70.00th=[   42], 80.00th=[   42], 90.00th=[   44], 95.00th=[
> 45],
> >>      | 99.00th=[   48], 99.50th=[   50], 99.90th=[  163], 99.95th=[
>  167],
> >>      | 99.99th=[  167]
> >>     bw (KB  /s): min= 4590, max= 7480, per=100.00%, avg=6285.69,
> stdev=374.22
> >>     lat (msec) : 20=0.02%, 50=99.58%, 100=0.23%, 250=0.17%
> >>   cpu          : usr=29.11%, sys=1.10%, ctx=118564, majf=0, minf=194
> >>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.7%,
> >=64=99.3%
> >>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
> >>      complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.1%, 32=0.0%, 64=0.1%,
> >=64=0.0%
> >>      issued    : total=r=0/w=111094/d=0, short=r=0/w=0/d=0
> >>      latency   : target=0, window=0, percentile=100.00%, depth=64
> >>
> >> Run status group 0 (all jobs):
> >>   WRITE: io=444376KB, aggrb=6280KB/s, minb=6280KB/s, maxb=6280KB/s,
> >> mint=70759msec, maxt=70759msec
> >>
> >> Disk stats (read/write):
> >>   sdb: ios=0/15936, merge=0/272, ticks=0/17157, in_queue=17146,
> util=0.94%
> >>
> >>
> >> It's just a simple test, maybe exist some misleadings on the config or
> >> results. But
> >> we can obviously see the conspicuous improvement for KeyValueStore.
> >
> > The numbers are hard to compare. Since the tests wrote a different
> > amount of data. This could influence the numbers.
> >
> > Do you mean improvements compared to former implementation or to
> FileStore?
> >
> > Without a retest with the latest fio rbd engine: there is not so much
> > difference between KVS and FS atm.
> >
> > Btw. Nice to see the rbd engine is useful to others ;-)
>
> Thanks for your advise and jobs on fio-rbd. :)
>
> The test isn't preciseness and just a simple test to show the progress
> of kvstore.
>
> >
> > Regards
> >
> > Danny
>
>
>
> --
> Best Regards,
>
> Wheat
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--047d7b2e3e440959b204fae7e56e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Haomai,<div><br></div><div>I tried to compare the READ =
performance of FileStore and KeyValueStore using the internal tool &quot;ce=
ph_smalliobench&quot; and I see KeyValueStore&#39;s performance is approx h=
alf that of FileStore. I&#39;m using similar conf file as yours. Is this th=
e expected behavior or am I missing something?</div>
<div><br></div><div>Thanks,</div><div>Sushma</div></div><div class=3D"gmail=
_extra"><br><br><div class=3D"gmail_quote">On Fri, Feb 28, 2014 at 11:00 PM=
, Haomai Wang <span dir=3D"ltr">&lt;<a href=3D"mailto:haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
 target=3D"_blank">haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On S=
at, Mar 1, 2014 at 8:04 AM, Danny Al-Gaaf &lt;<a href=3D"mailto:danny.al-ga=
af-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org">danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org</a>&gt; wrote:<br>

&gt; Hi,<br>
&gt;<br>
&gt; Am 28.02.2014 03:45, schrieb Haomai Wang:<br>
&gt; [...]<br>
&gt;&gt; I use fio which rbd supported from<br>
&gt;&gt; TelekomCloud(<a href=3D"https://github.com/TelekomCloud/fio/commit=
s/rbd-engine" target=3D"_blank">https://github.com/TelekomCloud/fio/commits=
/rbd-engine</a>)<br>
&gt;&gt; to test rbd.<br>
&gt;<br>
&gt; I would recommend to no longer use this branch, it&#39;s outdated. The=
 rbd<br>
&gt; engine got contributed back to upstream fio and is now merged [1]. For=
<br>
&gt; more information read [2].<br>
&gt;<br>
&gt; [1] <a href=3D"https://github.com/axboe/fio/commits/master" target=3D"=
_blank">https://github.com/axboe/fio/commits/master</a><br>
&gt; [2]<br>
&gt; <a href=3D"http://telekomcloud.github.io/ceph/2014/02/26/ceph-performa=
nce-analysis_fio_rbd.html" target=3D"_blank">http://telekomcloud.github.io/=
ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html</a><br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; The fio command: fio -direct=3D1 -iodepth=3D64 -thread -rw=3Drandw=
rite<br>
&gt;&gt; -ioengine=3Drbd -bs=3D4k -size=3D19G -numjobs=3D1 -runtime=3D100<b=
r>
&gt;&gt; -group_reporting -name=3Debs_test -pool=3Dopenstack -rbdname=3Dima=
ge<br>
&gt;&gt; -clientname=3Dfio -invalidate=3D0<br>
&gt;<br>
&gt; Don&#39;t use runtime and size at the same time, since runtime limits =
the<br>
&gt; size. What we normally do we let the fio job fill up the whole rbd or =
we<br>
&gt; limit it only via runtime.<br>
&gt;<br>
&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;<br>
&gt;&gt; FileStore result:<br>
&gt;&gt; ebs_test: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Drbd, iodepth=3D64<br>
&gt;&gt; fio-2.1.4<br>
&gt;&gt; Starting 1 thread<br>
&gt;&gt; rbd engine: RBD version: 0.1.8<br>
&gt;&gt;<br>
&gt;&gt; ebs_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D30886: Thu Feb =
27 08:09:18 2014<br>
&gt;&gt; =C2=A0 write: io=3D283040KB, bw=3D6403.4KB/s, iops=3D1600, runt=3D=
 44202msec<br>
&gt;&gt; =C2=A0 =C2=A0 slat (usec): min=3D116, max=3D2817, avg=3D195.78, st=
dev=3D56.45<br>
&gt;&gt; =C2=A0 =C2=A0 clat (msec): min=3D8, max=3D661, avg=3D39.57, stdev=
=3D29.26<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0lat (msec): min=3D9, max=3D661, avg=3D39.77, s=
tdev=3D29.25<br>
&gt;&gt; =C2=A0 =C2=A0 clat percentiles (msec):<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0| =C2=A01.00th=3D[ =C2=A0 15], =C2=A05.00th=3D=
[ =C2=A0 20], 10.00th=3D[ =C2=A0 23], 20.00th=3D[ =C2=A0 28],<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0| 30.00th=3D[ =C2=A0 31], 40.00th=3D[ =C2=A0 3=
5], 50.00th=3D[ =C2=A0 37], 60.00th=3D[ =C2=A0 40],<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0| 70.00th=3D[ =C2=A0 43], 80.00th=3D[ =C2=A0 4=
6], 90.00th=3D[ =C2=A0 51], 95.00th=3D[ =C2=A0 58],<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0| 99.00th=3D[ =C2=A0128], 99.50th=3D[ =C2=A021=
0], 99.90th=3D[ =C2=A0457], 99.95th=3D[ =C2=A0494],<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0| 99.99th=3D[ =C2=A0545]<br>
&gt;&gt; =C2=A0 =C2=A0 bw (KB =C2=A0/s): min=3D 2120, max=3D12656, per=3D10=
0.00%, avg=3D6464.27, stdev=3D1726.55<br>
&gt;&gt; =C2=A0 =C2=A0 lat (msec) : 10=3D0.01%, 20=3D5.91%, 50=3D83.35%, 10=
0=3D8.88%, 250=3D1.47%<br>
&gt;&gt; =C2=A0 =C2=A0 lat (msec) : 500=3D0.34%, 750=3D0.05%<br>
&gt;&gt; =C2=A0 cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: usr=3D29.83%, sys=
=3D1.36%, ctx=3D84002, majf=3D0, minf=3D216<br>
&gt;&gt; =C2=A0 IO depths =C2=A0 =C2=A0: 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D=
0.1%, 16=3D0.1%, 32=3D17.4%, &gt;=3D64=3D82.6%<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0submit =C2=A0 =C2=A0: 0=3D0.0%, 4=3D100.0%, 8=
=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0complete =C2=A0: 0=3D0.0%, 4=3D99.1%, 8=3D0.5%=
, 16=3D0.3%, 32=3D0.1%, 64=3D0.1%, &gt;=3D64=3D0.0%<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0issued =C2=A0 =C2=A0: total=3Dr=3D0/w=3D70760/=
d=3D0, short=3Dr=3D0/w=3D0/d=3D0<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0latency =C2=A0 : target=3D0, window=3D0, perce=
ntile=3D100.00%, depth=3D64<br>
&gt;&gt;<br>
&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt; =C2=A0 WRITE: io=3D283040KB, aggrb=3D6403KB/s, minb=3D6403KB/s, ma=
xb=3D6403KB/s,<br>
&gt;&gt; mint=3D44202msec, maxt=3D44202msec<br>
&gt;&gt;<br>
&gt;&gt; Disk stats (read/write):<br>
&gt;&gt; =C2=A0 sdb: ios=3D5/9512, merge=3D0/69, ticks=3D4/10649, in_queue=
=3D10645, util=3D0.92%<br>
&gt;&gt;<br>
&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
&gt;&gt;<br>
&gt;&gt; KeyValueStore:<br>
&gt;&gt; ebs_test: (g=3D0): rw=3Drandwrite, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Drbd, iodepth=3D64<br>
&gt;&gt; fio-2.1.4<br>
&gt;&gt; Starting 1 thread<br>
&gt;&gt; rbd engine: RBD version: 0.1.8<br>
&gt;&gt;<br>
&gt;&gt; ebs_test: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D29137: Thu Feb =
27 08:06:30 2014<br>
&gt;&gt; =C2=A0 write: io=3D444376KB, bw=3D6280.2KB/s, iops=3D1570, runt=3D=
 70759msec<br>
&gt;&gt; =C2=A0 =C2=A0 slat (usec): min=3D122, max=3D3237, avg=3D184.51, st=
dev=3D37.76<br>
&gt;&gt; =C2=A0 =C2=A0 clat (msec): min=3D10, max=3D168, avg=3D40.57, stdev=
=3D 5.70<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0lat (msec): min=3D11, max=3D168, avg=3D40.75, =
stdev=3D 5.71<br>
&gt;&gt; =C2=A0 =C2=A0 clat percentiles (msec):<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0| =C2=A01.00th=3D[ =C2=A0 34], =C2=A05.00th=3D=
[ =C2=A0 37], 10.00th=3D[ =C2=A0 39], 20.00th=3D[ =C2=A0 39],<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0| 30.00th=3D[ =C2=A0 40], 40.00th=3D[ =C2=A0 4=
0], 50.00th=3D[ =C2=A0 41], 60.00th=3D[ =C2=A0 41],<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0| 70.00th=3D[ =C2=A0 42], 80.00th=3D[ =C2=A0 4=
2], 90.00th=3D[ =C2=A0 44], 95.00th=3D[ =C2=A0 45],<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0| 99.00th=3D[ =C2=A0 48], 99.50th=3D[ =C2=A0 5=
0], 99.90th=3D[ =C2=A0163], 99.95th=3D[ =C2=A0167],<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0| 99.99th=3D[ =C2=A0167]<br>
&gt;&gt; =C2=A0 =C2=A0 bw (KB =C2=A0/s): min=3D 4590, max=3D 7480, per=3D10=
0.00%, avg=3D6285.69, stdev=3D374.22<br>
&gt;&gt; =C2=A0 =C2=A0 lat (msec) : 20=3D0.02%, 50=3D99.58%, 100=3D0.23%, 2=
50=3D0.17%<br>
&gt;&gt; =C2=A0 cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: usr=3D29.11%, sys=
=3D1.10%, ctx=3D118564, majf=3D0, minf=3D194<br>
&gt;&gt; =C2=A0 IO depths =C2=A0 =C2=A0: 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D=
0.1%, 16=3D0.1%, 32=3D0.7%, &gt;=3D64=3D99.3%<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0submit =C2=A0 =C2=A0: 0=3D0.0%, 4=3D100.0%, 8=
=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0complete =C2=A0: 0=3D0.0%, 4=3D100.0%, 8=3D0.1=
%, 16=3D0.1%, 32=3D0.0%, 64=3D0.1%, &gt;=3D64=3D0.0%<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0issued =C2=A0 =C2=A0: total=3Dr=3D0/w=3D111094=
/d=3D0, short=3Dr=3D0/w=3D0/d=3D0<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0latency =C2=A0 : target=3D0, window=3D0, perce=
ntile=3D100.00%, depth=3D64<br>
&gt;&gt;<br>
&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt; =C2=A0 WRITE: io=3D444376KB, aggrb=3D6280KB/s, minb=3D6280KB/s, ma=
xb=3D6280KB/s,<br>
&gt;&gt; mint=3D70759msec, maxt=3D70759msec<br>
&gt;&gt;<br>
&gt;&gt; Disk stats (read/write):<br>
&gt;&gt; =C2=A0 sdb: ios=3D0/15936, merge=3D0/272, ticks=3D0/17157, in_queu=
e=3D17146, util=3D0.94%<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s just a simple test, maybe exist some misleadings on the c=
onfig or<br>
&gt;&gt; results. But<br>
&gt;&gt; we can obviously see the conspicuous improvement for KeyValueStore=
.<br>
&gt;<br>
&gt; The numbers are hard to compare. Since the tests wrote a different<br>
&gt; amount of data. This could influence the numbers.<br>
&gt;<br>
&gt; Do you mean improvements compared to former implementation or to FileS=
tore?<br>
&gt;<br>
&gt; Without a retest with the latest fio rbd engine: there is not so much<=
br>
&gt; difference between KVS and FS atm.<br>
&gt;<br>
&gt; Btw. Nice to see the rbd engine is useful to others ;-)<br>
<br>
</div></div>Thanks for your advise and jobs on fio-rbd. :)<br>
<br>
The test isn&#39;t preciseness and just a simple test to show the progress<=
br>
of kvstore.<br>
<br>
&gt;<br>
&gt; Regards<br>
&gt;<br>
&gt; Danny<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
Best Regards,<br>
<br>
Wheat<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">_____________________=
__________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div></div></blockquote></div><br></div>

--047d7b2e3e440959b204fae7e56e--

--===============0150332241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0150332241==--
