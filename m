From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Re: How to enable the debug symbols
Date: Tue, 17 May 2011 00:00:40 -0500
Message-ID: <a0a2c4260f9ec3397d8e2242169c0fdb@pl1.haspere.com>
References: <BANLkTi=aKfr4ZpqsnhCpzREin8c5Y_sbpg@mail.gmail.com>
 <10709e0d5db695dae3ba2d07c2fe73ff.squirrel@pl1.haspere.com>
 <BANLkTikCB1gAL-WPGv1u8AZk_OjD4TLgyA@mail.gmail.com>
 <77a86a15068ca287fcc7343f071f093e@pl1.haspere.com>
 <BANLkTimcMtBi0HpqxsrbJ_oQ-mkNCZctZQ@mail.gmail.com>
 <BANLkTi=Y4E2_6gjo9z0-H104GXspG1Kpng@mail.gmail.com>
 <Pine.LNX.4.64.1105160939350.12367@cobra.newdream.net>
 <BANLkTinC5dbZi9TKRSjSTm5forSXsE-GMw@mail.gmail.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:34597 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab1EQFAl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 May 2011 01:00:41 -0400
In-Reply-To: <BANLkTinC5dbZi9TKRSjSTm5forSXsE-GMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

 Hi Simon!

 A couple things come to mind:
 1. Are you using the same prefix now as you had when=20
 /usr/local/lib/libceph.so.1 was built?
 2. Does the timestamp of the /usr/local/lib/libceph.so.1 change after=20
 you ran make install?
 3. Try deleting /usr/local/lib/libceph.so.1 (or move it to some other=20
 folder) and then ./configure, make, make install.


 Thanks,
 Dyweni



 On Tue, 17 May 2011 11:29:37 +0800, Simon Tian wrote:

> Well, I tried all these:
> 1) ./configure #(with desired environment settings)
> 2) ./autogen.sh
> 2.5) make clean
> 3) make -j 14
>
> 1) ./configure #(with desired environment settings)
> 2) ./autogen.sh
> 2.5) make clean
> 2.6=EF=BC=89make uninstall
> 3) make -j 14
>
> 1) ./autogen.sh
> 2) ./configure #(with desired environment settings)
> 2.5) make clean
> 2.6=EF=BC=89make uninstall
> 3) make -j 14
>
> 0.5)tar zxvf ceph-0.27.1.tar.gz
> 1) ./configure #(with desired environment settings)
> 2) ./autogen.sh
> 2.6=EF=BC=89make uninstall
> 3) make -j 14
>
> The result is all the same:
>
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> Breakpoint 1, ceph_write (fd=3D10, buf=3D0x7fff76bf0120 "", size=3D20=
97152,
> offset=3D0) at libceph.cc:322
> 322 return client->write(fd, buf, size, offset);
> (gdb)
> (gdb) c
> Continuing.
>
> Breakpoint 3, 0x00007fa7a61f8c32 in ?? () from
> /usr/local/lib/libceph.so.1
> ^^^^^
> (gdb) info b
> Num Type Disp Enb Address What
> 1 breakpoint keep y 0x00007fa7a61ca20f in ceph_write at
> libceph.cc:322
> breakpoint already hit 1 time
> 2 breakpoint keep y 0x00007fa7a61ca20f in ceph_write at
> libceph.cc:321
> breakpoint already hit 1 time
> 3 breakpoint keep y 0x00007fa7a61f8c32 client/Client.cc:4999
> breakpoint already hit 1 time
> (gdb)
>
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> Seem like no symbol for client/Client.cc.... Hmm, what do you think?
> Makefile attached. FYI
>
> 2011/5/17 Sage Weil :
>> On Mon, 16 May 2011, Gregory Farnum wrote:
>>
>>> Did you actually re-build the code? Configure just sets up some of
>>> the scripts: 1) ./configure #(with desired environment settings) 2)
>>> ./autogen.sh
>> 2.5) make clean
>>
>>> 3) make #(hopefully -j8 or something)
>> sage
>>
>>> Then you'll need to make sure that the built library is the one
>>> you're linking with -- how to do this varies a bit depending on=20
>>> your
>>> environment but probably the easiest way to do it is to run "make
>>> install". -Greg On Mon, May 16, 2011 at 5:45 AM, Simon Tian wrote:
>>>
>>>> Hi, I tried ( CFLAGS=3D"-march=3Dx86_64 -pipe -ggdb"
>>>> CXXFLAGS=3D"${CFLAGS}" ), but error comes:
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>> root@houyi-vm06.dev.sd.aliyun.com [1] # ./configure checking build
>>>> system type... x86_64-unknown-linux-gnu checking host system
>>>> type... x86_64-unknown-linux-gnu checking target system type...
>>>> x86_64-unknown-linux-gnu checking for a BSD-compatible install...
>>>> /usr/bin/install -c checking whether build environment is sane...
>>>> yes checking for a thread-safe mkdir -p... /bin/mkdir -p checking
>>>> for gawk... gawk checking whether make sets $(MAKE)... yes=20
>>>> checking
>>>> for style of include used by make... GNU checking for gcc... gcc
>>>> checking for C compiler default output file name... configure:
>>>> error: C compiler cannot create executables See `config.log' for
>>>> more details.
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D So I tried
>>>> ( CFLAGS=3D"-pipe -ggdb" CXXFLAGS=3D"${CFLAGS}" ), all the FLAGS i=
n=20
>>>> the
>>>> Makefile was set to "-pipe -ggdb", as the attachment showed.. Hmm,
>>>> but there was still "??" in the back trace: (gdb) bt #0
>>>> 0x00007fd007491c32 in ?? () from /usr/local/lib/libceph.so.1 #1
>>>> 0x00007fd00746322d in ceph_write (fd=3D10, buf=3D0x7fff4ffe2210 ""=
,
>>>> size=3D2097152, offset=3D0) at libceph.cc:322 #2 0x0000000000400fd=
3 in
>>>> main (argc=3D1, argv=3D0x7fff501e23d8) at testceph.cc:72 There is =
a
>>>> exception when running my application with libceph, so I need the
>>>> stack in the libceph to point the problem. It's a little
>>>> URGENT...But I don't know what happened in the libceph, so
>>>> unlucky.....Here is my stack:
>>>>
>>>
>>
>
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> (gdb) c Continuing. Program received signal SIGABRT, Aborted.
>>>> [Switching to Thread 0x40838940 (LWP 9118)] 0x000000312b630265 in
>>>> raise () from /lib64/libc.so.6 (gdb) bt #0 0x000000312b630265 in
>>>> raise () from /lib64/libc.so.6 #1 0x000000312b631d10 in abort ()
>>>> from /lib64/libc.so.6 #2 0x000000312debec44 in
>>>> __gnu_cxx::__verbose_terminate_handler () from
>>>> /usr/lib64/libstdc++.so.6 #3 0x000000312debcdb6 in ?? () from
>>>> /usr/lib64/libstdc++.so.6 #4 0x000000312debcde3 in std::terminate
>>>> () from /usr/lib64/libstdc++.so.6 #5 0x000000312debceca in
>>>> __cxa_throw () from /usr/lib64/libstdc++.so.6 #6=20
>>>> 0x00007fdb4cce7a78
>>>> in ?? () from /usr/local/lib/libceph.so.1 #7 0x00007fdb4cbb4e1c in
>>>> Mutex::Lock (this=3D0x66d790, no_lockdep=3Dfalse) at
>>>> ./common/Mutex.h:118 #8 0x00007fdb4cbcf5f4 in ?? () from
>>>> /usr/local/lib/libceph.so.1 #9 0x00007fdb4cc45304 in ?? () from
>>>> /usr/local/lib/libceph.so.1 #10 0x00007fdb4cd2b1d5 in ?? () from
>>>> /usr/local/lib/libceph.so.1 #11 0x00007fdb4cbec038 in ?? () from
>>>> /usr/local/lib/libceph.so.1 #12 0x00007fdb4cc6101d in ?? () from
>>>> /usr/local/lib/libceph.so.1 #13 0x00007fdb4cc4862b in ?? () from
>>>> /usr/local/lib/libceph.so.1 #14 0x00007fdb4cbb8641 in ?? () from
>>>> /usr/local/lib/libceph.so.1 #15 0x00007fdb4cbf0a28 in ?? () from
>>>> /usr/local/lib/libceph.so.1 #16 0x000000312be064a7 in start_thread
>>>> () from /lib64/libpthread.so.0 #17 0x000000312b6d3c2d in clone ()
>>>> from /lib64/libc.so.6 (gdb)
>>>>
>>>
>>
>
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> Thx! Simon 2011/5/15 Dyweni - Ceph-Devel :
>>>>
>>>>> Hi Simon! Set your CFLAGS and CXXFLAGS environment variables
>>>>> before calling configure and make. Example: CFLAGS=3D"-march=3Dna=
tive
>>>>> -pipe -ggdb" CXXFLAGS=3D"${CFLAGS}" ./configure
>>>>> CFLAGS=3D"-march=3Dnative -pipe -ggdb" CXXFLAGS=3D"${CFLAGS}" mak=
e etc
>>>>> Thanks, Dyweni On Sun, 15 May 2011 20:37:16 +0800, Simon Tian
>>>>> wrote:
>>>>>
>>>>>> Hi Dyweni, Can I do this by any options of "./configure"? or
>>>>>> JUST modify the Makefile manually? Thx! Simon
>>> -- To unsubscribe from this list: send the line "unsubscribe
>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org=20
>>> [4]
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>> [5]


 Links:
 ------
 [1] mailto:root@houyi-vm06.dev.sd.aliyun.com
 [2] mailto:YS3fpFE2ykfB@dyweni.com
 [3] mailto:aixt2006@gmail.com
 [4] mailto:majordomo@vger.kernel.org
 [5] http://vger.kernel.org/majordomo-info.html
 [6] mailto:sage@newdream.net
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
