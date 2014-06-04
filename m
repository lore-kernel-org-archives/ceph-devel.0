From: Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Annonce]The progress of KeyValueStore in Firely
Date: Wed, 4 Jun 2014 13:02:39 +0800
Message-ID: <CACJqLyZk9soijDtM1QfsL76AdthvWkHWp0=1rBWBswgza4evqg@mail.gmail.com>
References: <CACJqLybuA48Jnz6Qwc7cs2kHJO30C4GwazXi8yGp8ZhvfFc2ZQ@mail.gmail.com>
	<531123F6.5070007@bisect.de>
	<CACJqLybtitrDOcTcRXBZYJy552JzeYZWp_d=yWGUofxT7E46+A@mail.gmail.com>
	<CAOj3taPYaJfdipyiqFavw1AT24ZumrCVWm4FrUnEc1Ki7cah9Q@mail.gmail.com>
	<CACJqLyY=BBKKdwOsEoDbo8OfD+o2B2XoSEtmnQ8=nNCm4EaADQ@mail.gmail.com>
	<CAOj3taONVV8rMAgu8Cen=eCZ2ycYjSs8u3nfKiJUptdb7ffyEA@mail.gmail.com>
	<538E2361.2040400@bisect.de>
	<CAOj3taNQeKyicMvmaMU-EcE_abzoZ1fSERDNqONy99jvJLCg-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAOj3taNQeKyicMvmaMU-EcE_abzoZ1fSERDNqONy99jvJLCg-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

The fix pull request is https://github.com/ceph/ceph/pull/1912/files.

Someone can help to review and merge

On Wed, Jun 4, 2014 at 3:38 AM, Sushma R <gsushma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> ceph version : master (ceph version 0.80-713-g86754cc
> (86754cc78ca570f19f5a68fb634d613f952a22eb))
> fio version : fio-2.1.9-20-g290a
>
> gdb backtrace
> #0  0x00007ffff6de5249 in AO_fetch_and_add_full (incr=1, p=0x7fff00000018)
> at /usr/include/atomic_ops/sysdeps/gcc/x86.h:68
> #1  inc (this=0x7fff00000018) at ./include/atomic.h:98
> #2  ceph::buffer::ptr::ptr (this=0x7fffecf74820, p=..., o=<optimized out>,
> l=0) at common/buffer.cc:575
> #3  0x00007ffff6de63df in ceph::buffer::list::append
> (this=this@entry=0x7fffc80008e8, bp=..., off=<optimized out>,
> len=len@entry=0) at common/buffer.cc:1267
> #4  0x00007ffff6de6a44 in ceph::buffer::list::splice (this=0x7fffe4014590,
> off=<optimized out>, len=64512, claim_by=0x7fffc80008e8) at
> common/buffer.cc:1426
> #5  0x00007ffff7b89d45 in
> Striper::StripedReadResult::add_partial_sparse_result (this=0x7fffe4014278,
> cct=0x7fffe4006f50, bl=..., bl_map=..., bl_off=3670016,
>     buffer_extents=...) at osdc/Striper.cc:291
> #6  0x00007ffff7b180d8 in librbd::C_AioRead::finish (this=0x7fffe400d6a0,
> r=<optimized out>) at librbd/AioCompletion.cc:94
> #7  0x00007ffff7b182f9 in Context::complete (this=0x7fffe400d6a0,
> r=<optimized out>) at ./include/Context.h:64
> #8  0x00007ffff7b1840d in librbd::AioRequest::complete (this=0x7fffe4014540,
> r=0) at ./librbd/AioRequest.h:40
> #9  0x00007ffff6d3a538 in librados::C_AioComplete::finish
> (this=0x7fffdc0025c0, r=<optimized out>) at
> ./librados/AioCompletionImpl.h:178
> #10 0x00007ffff7b182f9 in Context::complete (this=0x7fffdc0025c0,
> r=<optimized out>) at ./include/Context.h:64
> #11 0x00007ffff6dc85f0 in Finisher::finisher_thread_entry
> (this=0x7fffe400c7c8) at common/Finisher.cc:56
> #12 0x00007ffff5f49f8e in start_thread (arg=0x7fffecf75700) at
> pthread_create.c:311
> #13 0x00007ffff5a6fa0d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:113
>
> Thanks,
> Sushma
>
>
> On Tue, Jun 3, 2014 at 12:34 PM, Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
> wrote:
>>
>> Am 03.06.2014 20:55, schrieb Sushma R:
>> > Haomai,
>> >
>> > I'm using the latest ceph master branch.
>> >
>> > ceph_smalliobench is a Ceph internal benchmarking tool similar to rados
>> > bench and the performance is more or less similar to that reported by
>> > fio.
>> >
>> > I tried to use fio with rbd ioengine (
>> >
>> > http://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html)
>> > and below are the numbers with different workloads on our setup.
>> > Note : fio rbd engine segfaults with randread IO pattern, only with
>> > LevelDB
>> > (no issues with FileStore). With FileStore, performance of
>> > ceph_smalliobench and fio-rbd is similar for READs, so the numbers for
>> > randread for LevelDB are with ceph_smalliobench (since fio rbd
>> > segfaults).
>>
>> Could you send me a backtrace of the segfault and some info about the
>> ceph and fio version you used so that I can take a look at it?
>>
>> Thanks,
>>
>> Danny
>>
>



-- 
Best Regards,

Wheat
