From: Sushma R <gsushma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Annonce]The progress of KeyValueStore in Firely
Date: Tue, 3 Jun 2014 12:38:50 -0700
Message-ID: <CAOj3taNQeKyicMvmaMU-EcE_abzoZ1fSERDNqONy99jvJLCg-A@mail.gmail.com>
References: <CACJqLybuA48Jnz6Qwc7cs2kHJO30C4GwazXi8yGp8ZhvfFc2ZQ@mail.gmail.com>
	<531123F6.5070007@bisect.de>
	<CACJqLybtitrDOcTcRXBZYJy552JzeYZWp_d=yWGUofxT7E46+A@mail.gmail.com>
	<CAOj3taPYaJfdipyiqFavw1AT24ZumrCVWm4FrUnEc1Ki7cah9Q@mail.gmail.com>
	<CACJqLyY=BBKKdwOsEoDbo8OfD+o2B2XoSEtmnQ8=nNCm4EaADQ@mail.gmail.com>
	<CAOj3taONVV8rMAgu8Cen=eCZ2ycYjSs8u3nfKiJUptdb7ffyEA@mail.gmail.com>
	<538E2361.2040400@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2142690474=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <538E2361.2040400-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2142690474==
Content-Type: multipart/alternative; boundary=047d7b67207241ea4904faf3a9a4

--047d7b67207241ea4904faf3a9a4
Content-Type: text/plain; charset=UTF-8

ceph version : master (ceph version 0.80-713-g86754cc
(86754cc78ca570f19f5a68fb634d613f952a22eb))
fio version : fio-2.1.9-20-g290a

gdb backtrace
#0  0x00007ffff6de5249 in AO_fetch_and_add_full (incr=1, p=0x7fff00000018)
at /usr/include/atomic_ops/sysdeps/gcc/x86.h:68
#1  inc (this=0x7fff00000018) at ./include/atomic.h:98
#2  ceph::buffer::ptr::ptr (this=0x7fffecf74820, p=..., o=<optimized out>,
l=0) at common/buffer.cc:575
#3  0x00007ffff6de63df in ceph::buffer::list::append
(this=this@entry=0x7fffc80008e8,
bp=..., off=<optimized out>, len=len@entry=0) at common/buffer.cc:1267
#4  0x00007ffff6de6a44 in ceph::buffer::list::splice (this=0x7fffe4014590,
off=<optimized out>, len=64512, claim_by=0x7fffc80008e8) at
common/buffer.cc:1426
#5  0x00007ffff7b89d45 in
Striper::StripedReadResult::add_partial_sparse_result (this=0x7fffe4014278,
cct=0x7fffe4006f50, bl=..., bl_map=..., bl_off=3670016,
    buffer_extents=...) at osdc/Striper.cc:291
#6  0x00007ffff7b180d8 in librbd::C_AioRead::finish (this=0x7fffe400d6a0,
r=<optimized out>) at librbd/AioCompletion.cc:94
#7  0x00007ffff7b182f9 in Context::complete (this=0x7fffe400d6a0,
r=<optimized out>) at ./include/Context.h:64
#8  0x00007ffff7b1840d in librbd::AioRequest::complete
(this=0x7fffe4014540, r=0) at ./librbd/AioRequest.h:40
#9  0x00007ffff6d3a538 in librados::C_AioComplete::finish
(this=0x7fffdc0025c0, r=<optimized out>) at
./librados/AioCompletionImpl.h:178
#10 0x00007ffff7b182f9 in Context::complete (this=0x7fffdc0025c0,
r=<optimized out>) at ./include/Context.h:64
#11 0x00007ffff6dc85f0 in Finisher::finisher_thread_entry
(this=0x7fffe400c7c8) at common/Finisher.cc:56
#12 0x00007ffff5f49f8e in start_thread (arg=0x7fffecf75700) at
pthread_create.c:311
#13 0x00007ffff5a6fa0d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:113

Thanks,
Sushma


On Tue, Jun 3, 2014 at 12:34 PM, Danny Al-Gaaf <danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org>
wrote:

> Am 03.06.2014 20:55, schrieb Sushma R:
> > Haomai,
> >
> > I'm using the latest ceph master branch.
> >
> > ceph_smalliobench is a Ceph internal benchmarking tool similar to rados
> > bench and the performance is more or less similar to that reported by
> fio.
> >
> > I tried to use fio with rbd ioengine (
> >
> http://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html
> )
> > and below are the numbers with different workloads on our setup.
> > Note : fio rbd engine segfaults with randread IO pattern, only with
> LevelDB
> > (no issues with FileStore). With FileStore, performance of
> > ceph_smalliobench and fio-rbd is similar for READs, so the numbers for
> > randread for LevelDB are with ceph_smalliobench (since fio rbd
> segfaults).
>
> Could you send me a backtrace of the segfault and some info about the
> ceph and fio version you used so that I can take a look at it?
>
> Thanks,
>
> Danny
>
>

--047d7b67207241ea4904faf3a9a4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ceph version : master (ceph version 0.80-713-g86754cc (867=
54cc78ca570f19f5a68fb634d613f952a22eb))<div>fio version :=C2=A0fio-2.1.9-20=
-g290a</div><div><br></div><div>gdb backtrace</div><div><div>#0 =C2=A00x000=
07ffff6de5249 in AO_fetch_and_add_full (incr=3D1, p=3D0x7fff00000018) at /u=
sr/include/atomic_ops/sysdeps/gcc/x86.h:68</div>
<div>#1 =C2=A0inc (this=3D0x7fff00000018) at ./include/atomic.h:98</div><di=
v>#2 =C2=A0ceph::buffer::ptr::ptr (this=3D0x7fffecf74820, p=3D..., o=3D&lt;=
optimized out&gt;, l=3D0) at common/buffer.cc:575</div><div>#3 =C2=A00x0000=
7ffff6de63df in ceph::buffer::list::append (this=3Dthis@entry=3D0x7fffc8000=
8e8, bp=3D..., off=3D&lt;optimized out&gt;, len=3Dlen@entry=3D0) at common/=
buffer.cc:1267</div>
<div>#4 =C2=A00x00007ffff6de6a44 in ceph::buffer::list::splice (this=3D0x7f=
ffe4014590, off=3D&lt;optimized out&gt;, len=3D64512, claim_by=3D0x7fffc800=
08e8) at common/buffer.cc:1426</div><div>#5 =C2=A00x00007ffff7b89d45 in Str=
iper::StripedReadResult::add_partial_sparse_result (this=3D0x7fffe4014278, =
cct=3D0x7fffe4006f50, bl=3D..., bl_map=3D..., bl_off=3D3670016,</div>
<div>=C2=A0 =C2=A0 buffer_extents=3D...) at osdc/Striper.cc:291</div><div>#=
6 =C2=A00x00007ffff7b180d8 in librbd::C_AioRead::finish (this=3D0x7fffe400d=
6a0, r=3D&lt;optimized out&gt;) at librbd/AioCompletion.cc:94</div><div>#7 =
=C2=A00x00007ffff7b182f9 in Context::complete (this=3D0x7fffe400d6a0, r=3D&=
lt;optimized out&gt;) at ./include/Context.h:64</div>
<div>#8 =C2=A00x00007ffff7b1840d in librbd::AioRequest::complete (this=3D0x=
7fffe4014540, r=3D0) at ./librbd/AioRequest.h:40</div><div>#9 =C2=A00x00007=
ffff6d3a538 in librados::C_AioComplete::finish (this=3D0x7fffdc0025c0, r=3D=
&lt;optimized out&gt;) at ./librados/AioCompletionImpl.h:178</div>
<div>#10 0x00007ffff7b182f9 in Context::complete (this=3D0x7fffdc0025c0, r=
=3D&lt;optimized out&gt;) at ./include/Context.h:64</div><div>#11 0x00007ff=
ff6dc85f0 in Finisher::finisher_thread_entry (this=3D0x7fffe400c7c8) at com=
mon/Finisher.cc:56</div>
<div>#12 0x00007ffff5f49f8e in start_thread (arg=3D0x7fffecf75700) at pthre=
ad_create.c:311</div><div>#13 0x00007ffff5a6fa0d in clone () at ../sysdeps/=
unix/sysv/linux/x86_64/clone.S:113</div></div><div><br></div><div>Thanks,</=
div>
<div>Sushma</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gma=
il_quote">On Tue, Jun 3, 2014 at 12:34 PM, Danny Al-Gaaf <span dir=3D"ltr">=
&lt;<a href=3D"mailto:danny.al-gaaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org" target=3D"_blank">danny.al-g=
aaf-2YacvwyR+KOzQB+pC5nmwQ@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Am 03.06.2014 20:55, schrieb Sushma R:<br>
<div class=3D"">&gt; Haomai,<br>
&gt;<br>
&gt; I&#39;m using the latest ceph master branch.<br>
&gt;<br>
&gt; ceph_smalliobench is a Ceph internal benchmarking tool similar to rado=
s<br>
&gt; bench and the performance is more or less similar to that reported by =
fio.<br>
&gt;<br>
&gt; I tried to use fio with rbd ioengine (<br>
&gt; <a href=3D"http://telekomcloud.github.io/ceph/2014/02/26/ceph-performa=
nce-analysis_fio_rbd.html" target=3D"_blank">http://telekomcloud.github.io/=
ceph/2014/02/26/ceph-performance-analysis_fio_rbd.html</a>)<br>
&gt; and below are the numbers with different workloads on our setup.<br>
&gt; Note : fio rbd engine segfaults with randread IO pattern, only with Le=
velDB<br>
&gt; (no issues with FileStore). With FileStore, performance of<br>
&gt; ceph_smalliobench and fio-rbd is similar for READs, so the numbers for=
<br>
&gt; randread for LevelDB are with ceph_smalliobench (since fio rbd segfaul=
ts).<br>
<br>
</div>Could you send me a backtrace of the segfault and some info about the=
<br>
ceph and fio version you used so that I can take a look at it?<br>
<br>
Thanks,<br>
<br>
Danny<br>
<br>
</blockquote></div><br></div>

--047d7b67207241ea4904faf3a9a4--

--===============2142690474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2142690474==--
