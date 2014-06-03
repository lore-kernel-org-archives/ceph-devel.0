From: Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Annonce]The progress of KeyValueStore in Firely
Date: Tue, 3 Jun 2014 15:06:55 +0800
Message-ID: <CACJqLyY=BBKKdwOsEoDbo8OfD+o2B2XoSEtmnQ8=nNCm4EaADQ@mail.gmail.com>
References: <CACJqLybuA48Jnz6Qwc7cs2kHJO30C4GwazXi8yGp8ZhvfFc2ZQ@mail.gmail.com>
	<531123F6.5070007@bisect.de>
	<CACJqLybtitrDOcTcRXBZYJy552JzeYZWp_d=yWGUofxT7E46+A@mail.gmail.com>
	<CAOj3taPYaJfdipyiqFavw1AT24ZumrCVWm4FrUnEc1Ki7cah9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAOj3taPYaJfdipyiqFavw1AT24ZumrCVWm4FrUnEc1Ki7cah9Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sushma R <gsushma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I don't know the actual size of "small io". And what's ceph version you used.

But I think it's possible if KeyValueStore only has half performance
compared to FileStore in small io size. A new config value let user
can tunes it will be introduced and maybe help.

All in all, maybe you could tell more about "ceph_smalliobench"

On Tue, Jun 3, 2014 at 1:36 PM, Sushma R <gsushma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Haomai,
>
> I tried to compare the READ performance of FileStore and KeyValueStore using
> the internal tool "ceph_smalliobench" and I see KeyValueStore's performance
> is approx half that of FileStore. I'm using similar conf file as yours. Is
> this the expected behavior or am I missing something?
>
> Thanks,
> Sushma
>
>
> On Fri, Feb 28, 2014 at 11:00 PM, Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> On Sat, Mar 1, 2014 at 8:04 AM, Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
>> wrote:
>> > Hi,
>> >
>> > Am 28.02.2014 03:45, schrieb Haomai Wang:
>> > [...]
>> >> I use fio which rbd supported from
>> >> TelekomCloud(https://github.com/TelekomCloud/fio/commits/rbd-engine)
>> >> to test rbd.
>> >
>> > I would recommend to no longer use this branch, it's outdated. The rbd
>> > engine got contributed back to upstream fio and is now merged [1]. For
>> > more information read [2].
>> >
>> > [1] https://github.com/axboe/fio/commits/master
>> > [2]
>> >
>> > http://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html
>> >
>> >>
>> >> The fio command: fio -direct=1 -iodepth=64 -thread -rw=randwrite
>> >> -ioengine=rbd -bs=4k -size=19G -numjobs=1 -runtime=100
>> >> -group_reporting -name=ebs_test -pool=openstack -rbdname=image
>> >> -clientname=fio -invalidate=0
>> >
>> > Don't use runtime and size at the same time, since runtime limits the
>> > size. What we normally do we let the fio job fill up the whole rbd or we
>> > limit it only via runtime.
>> >
>> >> ============================================
>> >>
>> >> FileStore result:
>> >> ebs_test: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd,
>> >> iodepth=64
>> >> fio-2.1.4
>> >> Starting 1 thread
>> >> rbd engine: RBD version: 0.1.8
>> >>
>> >> ebs_test: (groupid=0, jobs=1): err= 0: pid=30886: Thu Feb 27 08:09:18
>> >> 2014
>> >>   write: io=283040KB, bw=6403.4KB/s, iops=1600, runt= 44202msec
>> >>     slat (usec): min=116, max=2817, avg=195.78, stdev=56.45
>> >>     clat (msec): min=8, max=661, avg=39.57, stdev=29.26
>> >>      lat (msec): min=9, max=661, avg=39.77, stdev=29.25
>> >>     clat percentiles (msec):
>> >>      |  1.00th=[   15],  5.00th=[   20], 10.00th=[   23], 20.00th=[
>> >> 28],
>> >>      | 30.00th=[   31], 40.00th=[   35], 50.00th=[   37], 60.00th=[
>> >> 40],
>> >>      | 70.00th=[   43], 80.00th=[   46], 90.00th=[   51], 95.00th=[
>> >> 58],
>> >>      | 99.00th=[  128], 99.50th=[  210], 99.90th=[  457], 99.95th=[
>> >> 494],
>> >>      | 99.99th=[  545]
>> >>     bw (KB  /s): min= 2120, max=12656, per=100.00%, avg=6464.27,
>> >> stdev=1726.55
>> >>     lat (msec) : 10=0.01%, 20=5.91%, 50=83.35%, 100=8.88%, 250=1.47%
>> >>     lat (msec) : 500=0.34%, 750=0.05%
>> >>   cpu          : usr=29.83%, sys=1.36%, ctx=84002, majf=0, minf=216
>> >>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=17.4%,
>> >> >=64=82.6%
>> >>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>> >> >=64=0.0%
>> >>      complete  : 0=0.0%, 4=99.1%, 8=0.5%, 16=0.3%, 32=0.1%, 64=0.1%,
>> >> >=64=0.0%
>> >>      issued    : total=r=0/w=70760/d=0, short=r=0/w=0/d=0
>> >>      latency   : target=0, window=0, percentile=100.00%, depth=64
>> >>
>> >> Run status group 0 (all jobs):
>> >>   WRITE: io=283040KB, aggrb=6403KB/s, minb=6403KB/s, maxb=6403KB/s,
>> >> mint=44202msec, maxt=44202msec
>> >>
>> >> Disk stats (read/write):
>> >>   sdb: ios=5/9512, merge=0/69, ticks=4/10649, in_queue=10645,
>> >> util=0.92%
>> >>
>> >> ===============================================
>> >>
>> >> KeyValueStore:
>> >> ebs_test: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd,
>> >> iodepth=64
>> >> fio-2.1.4
>> >> Starting 1 thread
>> >> rbd engine: RBD version: 0.1.8
>> >>
>> >> ebs_test: (groupid=0, jobs=1): err= 0: pid=29137: Thu Feb 27 08:06:30
>> >> 2014
>> >>   write: io=444376KB, bw=6280.2KB/s, iops=1570, runt= 70759msec
>> >>     slat (usec): min=122, max=3237, avg=184.51, stdev=37.76
>> >>     clat (msec): min=10, max=168, avg=40.57, stdev= 5.70
>> >>      lat (msec): min=11, max=168, avg=40.75, stdev= 5.71
>> >>     clat percentiles (msec):
>> >>      |  1.00th=[   34],  5.00th=[   37], 10.00th=[   39], 20.00th=[
>> >> 39],
>> >>      | 30.00th=[   40], 40.00th=[   40], 50.00th=[   41], 60.00th=[
>> >> 41],
>> >>      | 70.00th=[   42], 80.00th=[   42], 90.00th=[   44], 95.00th=[
>> >> 45],
>> >>      | 99.00th=[   48], 99.50th=[   50], 99.90th=[  163], 99.95th=[
>> >> 167],
>> >>      | 99.99th=[  167]
>> >>     bw (KB  /s): min= 4590, max= 7480, per=100.00%, avg=6285.69,
>> >> stdev=374.22
>> >>     lat (msec) : 20=0.02%, 50=99.58%, 100=0.23%, 250=0.17%
>> >>   cpu          : usr=29.11%, sys=1.10%, ctx=118564, majf=0, minf=194
>> >>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.7%,
>> >> >=64=99.3%
>> >>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>> >> >=64=0.0%
>> >>      complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.1%, 32=0.0%, 64=0.1%,
>> >> >=64=0.0%
>> >>      issued    : total=r=0/w=111094/d=0, short=r=0/w=0/d=0
>> >>      latency   : target=0, window=0, percentile=100.00%, depth=64
>> >>
>> >> Run status group 0 (all jobs):
>> >>   WRITE: io=444376KB, aggrb=6280KB/s, minb=6280KB/s, maxb=6280KB/s,
>> >> mint=70759msec, maxt=70759msec
>> >>
>> >> Disk stats (read/write):
>> >>   sdb: ios=0/15936, merge=0/272, ticks=0/17157, in_queue=17146,
>> >> util=0.94%
>> >>
>> >>
>> >> It's just a simple test, maybe exist some misleadings on the config or
>> >> results. But
>> >> we can obviously see the conspicuous improvement for KeyValueStore.
>> >
>> > The numbers are hard to compare. Since the tests wrote a different
>> > amount of data. This could influence the numbers.
>> >
>> > Do you mean improvements compared to former implementation or to
>> > FileStore?
>> >
>> > Without a retest with the latest fio rbd engine: there is not so much
>> > difference between KVS and FS atm.
>> >
>> > Btw. Nice to see the rbd engine is useful to others ;-)
>>
>> Thanks for your advise and jobs on fio-rbd. :)
>>
>> The test isn't preciseness and just a simple test to show the progress
>> of kvstore.
>>
>> >
>> > Regards
>> >
>> > Danny
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>



-- 
Best Regards,

Wheat
