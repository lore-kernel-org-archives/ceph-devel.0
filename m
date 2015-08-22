From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Sat, 22 Aug 2015 06:52:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508220650190.13116@cobra.newdream.net>
References: <55D409F0.3050802@redhat.com> <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE127C5@SACMBXIP01.sdcorp.global.sandisk.com> <55D4E470.9030501@profihost.ag> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12841@SACMBXIP01.sdcorp.global.sandisk.com>
 <55D4E793.9040408@profihost.ag> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12899@SACMBXIP01.sdcorp.global.sandisk.com> <55D4E9BE.8000309@profihost.ag> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12966@SACMBXIP01.sdcorp.global.sandisk.com>
 <EA545303A8F8E842820A172C3D641D6E1B09E891@SACMBXIP01.sdcorp.global.sandisk.com> <CANP1eJH=mhQ1rBkUD8=yuF26s2t2vO0JMO-wKOLQ8VbWdEmxxw@mail.gmail.com> <CAANLjFofTxsVxAFOaAVveTXSp4Z51XpLtHxs01yBajMg7GXfPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-457727926-1440251566=:13116"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56347 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbbHVNwr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Aug 2015 09:52:47 -0400
In-Reply-To: <CAANLjFofTxsVxAFOaAVveTXSp4Z51XpLtHxs01yBajMg7GXfPg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Milosz Tanski <milosz@adfin.com>, Shishir Gowda <Shishir.Gowda@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Stefan Priebe <s.priebe@profihost.ag>, Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-457727926-1440251566=:13116
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Aug 2015, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>=20
> Please excuse me if I'm naive about this (I'm not a programmer by
> trade), but wouldn't it be possible to load/link to tcmalloc or
> jemalloc at run time instead of having to do so at compile time?
> Except for tcmalloc being statically linked (is this even a
> requirement?) it seems like it would be much more flexible to have a
> config option, or a list of allocators to try (i.e. jemalloc, then
> tcmalloc then glib depending on what is available). Then people would
> have the option of choosing an allocator without having to recompile
> packages.
>=20
> We'd like to use jemalloc, but don't want to deviate from the Ceph
> provided packages if at all possible. I also understand from some
> discussion earlier that it would be very difficult/near impossible to
> perform adequate testing on all Ceph versions x Distro allocators.
>=20
> A possible compromise might be that Ceph is tested and distributed
> with the recommended tcmalloc/jemalloc/etc, but if an end user chooses
> can override the allocator in the config. We would be able to perform

I don't think it's possible to select the allocator at runtime, since the=
=20
dynamic loading happens while loading the executable.  You can select an=20
allocator using LD_PRELOAD, though, so in your environment it would be=20
pretty straightforward to do this by modifying the init script or=20
upstart/systemd file:

 LD_PRELOAD=3D${JEMALLOC_PATH}/lib/libjemalloc.so.1 ceph-osd ...

I suppose we could bake this into the upstream init files?

sage




> the testing of our allocator of choce, Ceph version on our distro to
> our satisfaction. Ceph could also test specific versions of
> jemalloc/tcmalloc/glibc and just state that it is "certified" on
> specific versions of these allocators and running a different version
> is not tested or supported. I would suspect that a 3-way allocator
> testing would help find most of the bugs/issues to make it fairly
> stable across most versions.
>=20
> On a different note, we ran into some memory allocation/deallocation
> issues in some kernel code that we are writing. We wound up moving the
> allocation code to a parent function and are just rewriting the memory
> space in the child which has resolved a lot of the performance and
> stability issues we were seeing. I think Ceph has some more complex
> challenges like unknown buffer size (not sure we want to allocate max
> buffers for each request/thread), thread safety and even thread scope.
> If we can somehow reduce these memory operations, I think it will be a
> great win regardless of the allocator. (I think I'm stating the
> obvious here, sorry).
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>=20
>=20
> On Fri, Aug 21, 2015 at 8:26 AM, Milosz Tanski  wrote:
> > On Fri, Aug 21, 2015 at 12:22 AM, Shishir Gowda
> >  wrote:
> >> Hi All,
> >>
> >> Have sent out a pull request which enables building librados/librbd =
with either tcmalloc(as default)  or jemalloc.
> >>
> >> Please find the pull request @ https://github.com/ceph/ceph/pull/562=
8
> >>
> >> With regards,
> >> Shishir
> >
> > Unless I'm missing something here, this seams like the wrong thing to=
.
> > Libraries that will be linked in by other external applications shoul=
d
> > not have a 3rd party malloc linked in there. That seams like an
> > application choice. At the very least the default should not be to
> > link in a 3rd party malloc.
> >
> >>
> >>> -----Original Message-----
> >>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >>> owner@vger.kernel.org] On Behalf Of Somnath Roy
> >>> Sent: Thursday, August 20, 2015 2:14 AM
> >>> To: Stefan Priebe; Alexandre DERUMIER; Mark Nelson
> >>> Cc: ceph-devel
> >>> Subject: RE: Ceph Hackathon: More Memory Allocator Testing
> >>>
> >>> Yeah , I can see ceph-osd/ceph-mon built with jemalloc.
> >>>
> >>> Thanks & Regards
> >>> Somnath
> >>>
> >>> -----Original Message-----
> >>> From: Stefan Priebe [mailto:s.priebe@profihost.ag]
> >>> Sent: Wednesday, August 19, 2015 1:41 PM
> >>> To: Somnath Roy; Alexandre DERUMIER; Mark Nelson
> >>> Cc: ceph-devel
> >>> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
> >>>
> >>>
> >>> Am 19.08.2015 um 22:34 schrieb Somnath Roy:
> >>> > But, you said you need to remove libcmalloc *not* libtcmalloc...
> >>> > I saw librbd/librados is built with libcmalloc not with libtcmall=
oc..
> >>> > So, are you saying to remove libtcmalloc (not libcmalloc) to enab=
le jemalloc
> >>> ?
> >>>
> >>> Ouch my mistake. I read libtcmalloc - too late here.
> >>>
> >>> My build (Hammer) says:
> >>> # ldd /usr/lib/librados.so.2.0.0
> >>>          linux-vdso.so.1 =3D>  (0x00007fff4f71d000)
> >>>          libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f=
afdb26c000)
> >>>          libboost_thread.so.1.49.0 =3D> /usr/lib/libboost_thread.so=
.1.49.0
> >>> (0x00007fafdb24f000)
> >>>          libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
> >>> (0x00007fafdb032000)
> >>>          libcrypto++.so.9 =3D> /usr/lib/libcrypto++.so.9 (0x00007fa=
fda924000)
> >>>          libuuid.so.1 =3D> /lib/x86_64-linux-gnu/libuuid.so.1
> >>> (0x00007fafda71f000)
> >>>          librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x00007f=
afda516000)
> >>>          libboost_system.so.1.49.0 =3D> /usr/lib/libboost_system.so=
.1.49.0
> >>> (0x00007fafda512000)
> >>>          libstdc++.so.6 =3D> /usr/lib/x86_64-linux-gnu/libstdc++.so=
.6
> >>> (0x00007fafda20b000)
> >>>          libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6 (0x00007faf=
d9f88000)
> >>>          libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007faf=
d9bfd000)
> >>>          libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so.1
> >>> (0x00007fafd99e7000)
> >>>          /lib64/ld-linux-x86-64.so.2 (0x000056358ecfe000)
> >>>
> >>> Only ceph-osd is linked against libjemalloc for me.
> >>>
> >>> Stefan
> >>>
> >>> > -----Original Message-----
> >>> > From: Stefan Priebe [mailto:s.priebe@profihost.ag]
> >>> > Sent: Wednesday, August 19, 2015 1:31 PM
> >>> > To: Somnath Roy; Alexandre DERUMIER; Mark Nelson
> >>> > Cc: ceph-devel
> >>> > Subject: Re: Ceph Hackathon: More Memory Allocator Testing
> >>> >
> >>> >
> >>> > Am 19.08.2015 um 22:29 schrieb Somnath Roy:
> >>> >> Hmm...We need to fix that as part of configure/Makefile I guess =
(?)..
> >>> >> Since we have done this jemalloc integration originally, we can =
take that
> >>> ownership unless anybody sees a problem of enabling tcmalloc/jemall=
oc with
> >>> librbd/librados.
> >>> >>
> >>> >> << You have to remove libcmalloc out of your build environment t=
o get
> >>> >> this done How do I do that ? I am using Ubuntu and can't afford =
to remove
> >>> libc* packages.
> >>> >
> >>> > I always use a chroot to build packages where only a minimal boot=
strap +
> >>> the build deps are installed. googleperftools where libtcmalloc com=
es from is
> >>> not Ubuntu "core/minimal".
> >>> >
> >>> > Stefan
> >>> >
> >>> >>
> >>> >> Thanks & Regards
> >>> >> Somnath
> >>> >>
> >>> >> -----Original Message-----
> >>> >> From: Stefan Priebe [mailto:s.priebe@profihost.ag]
> >>> >> Sent: Wednesday, August 19, 2015 1:18 PM
> >>> >> To: Somnath Roy; Alexandre DERUMIER; Mark Nelson
> >>> >> Cc: ceph-devel
> >>> >> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
> >>> >>
> >>> >>
> >>> >> Am 19.08.2015 um 22:16 schrieb Somnath Roy:
> >>> >>> Alexandre,
> >>> >>> I am not able to build librados/librbd by using the following c=
onfig option.
> >>> >>>
> >>> >>> ./configure ?without-tcmalloc ?with-jemalloc
> >>> >>
> >>> >> Same issue to me. You have to remove libcmalloc out of your buil=
d
> >>> environment to get this done.
> >>> >>
> >>> >> Stefan
> >>> >>
> >>> >>
> >>> >>> It seems it is building osd/mon/Mds/RGW with jemalloc enabled..
> >>> >>>
> >>> >>> root@emsnode10:~/ceph-latest/src# ldd ./ceph-osd
> >>> >>>            linux-vdso.so.1 =3D>  (0x00007ffd0eb43000)
> >>> >>>            libjemalloc.so.1 =3D> /usr/lib/x86_64-linux-gnu/libj=
emalloc.so.1
> >>> (0x00007f5f92d70000)
> >>> >>>            .......
> >>> >>>
> >>> >>> root@emsnode10:~/ceph-latest/src/.libs# ldd ./librados.so.2.0.0
> >>> >>>            linux-vdso.so.1 =3D>  (0x00007ffed46f2000)
> >>> >>>            libboost_thread.so.1.55.0 =3D> /usr/lib/x86_64-linux=
-
> >>> gnu/libboost_thread.so.1.55.0 (0x00007ff687887000)
> >>> >>>            liblttng-ust.so.0 =3D> /usr/lib/x86_64-linux-gnu/lib=
lttng-ust.so.0
> >>> (0x00007ff68763d000)
> >>> >>>            libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2 (0x=
00007ff687438000)
> >>> >>>            libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthrea=
d.so.0
> >>> (0x00007ff68721a000)
> >>> >>>            libnss3.so =3D> /usr/lib/x86_64-linux-gnu/libnss3.so
> >>> (0x00007ff686ee0000)
> >>> >>>            libsmime3.so =3D> /usr/lib/x86_64-linux-gnu/libsmime=
3.so
> >>> (0x00007ff686cb3000)
> >>> >>>            libnspr4.so =3D> /usr/lib/x86_64-linux-gnu/libnspr4.=
so
> >>> (0x00007ff686a76000)
> >>> >>>            libuuid.so.1 =3D> /lib/x86_64-linux-gnu/libuuid.so.1
> >>> (0x00007ff686871000)
> >>> >>>            librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x=
00007ff686668000)
> >>> >>>            libboost_system.so.1.55.0 =3D> /usr/lib/x86_64-linux=
-
> >>> gnu/libboost_system.so.1.55.0 (0x00007ff686464000)
> >>> >>>            libstdc++.so.6 =3D> /usr/lib/x86_64-linux-gnu/libstd=
c++.so.6
> >>> (0x00007ff686160000)
> >>> >>>            libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6 (0x00=
007ff685e59000)
> >>> >>>            libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00=
007ff685a94000)
> >>> >>>            libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so=
.1
> >>> (0x00007ff68587e000)
> >>> >>>            liblttng-ust-tracepoint.so.0 =3D> /usr/lib/x86_64-li=
nux-gnu/liblttng-
> >>> ust-tracepoint.so.0 (0x00007ff685663000)
> >>> >>>            liburcu-bp.so.1 =3D> /usr/lib/liburcu-bp.so.1 (0x000=
07ff68545c000)
> >>> >>>            liburcu-cds.so.1 =3D> /usr/lib/liburcu-cds.so.1 (0x0=
0007ff685255000)
> >>> >>>            /lib64/ld-linux-x86-64.so.2 (0x00007ff68a0f6000)
> >>> >>>            libnssutil3.so =3D> /usr/lib/x86_64-linux-gnu/libnss=
util3.so
> >>> (0x00007ff685029000)
> >>> >>>            libplc4.so =3D> /usr/lib/x86_64-linux-gnu/libplc4.so
> >>> (0x00007ff684e24000)
> >>> >>>            libplds4.so =3D> /usr/lib/x86_64-linux-gnu/libplds4.=
so
> >>> >>> (0x00007ff684c20000)
> >>> >>>
> >>> >>> It is building with libcmalloc always...
> >>> >>>
> >>> >>> Did you change the ceph makefiles to build librbd/librados with=
 jemalloc
> >>> ?
> >>> >>>
> >>> >>> Thanks & Regards
> >>> >>> Somnath
> >>> >>>
> >>> >>> -----Original Message-----
> >>> >>> From: ceph-devel-owner@vger.kernel.org
> >>> >>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Alexandr=
e
> >>> >>> DERUMIER
> >>> >>> Sent: Wednesday, August 19, 2015 7:01 AM
> >>> >>> To: Mark Nelson
> >>> >>> Cc: ceph-devel
> >>> >>> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
> >>> >>>
> >>> >>> Thanks Marc,
> >>> >>>
> >>> >>> Results are matching exactly what I have seen with tcmalloc 2.1=
 vs 2.4 vs
> >>> jemalloc.
> >>> >>>
> >>> >>> and indeed tcmalloc, even with bigger cache, seem decrease over=
 time.
> >>> >>>
> >>> >>>
> >>> >>> What is funny, is that I see exactly same behaviour client libr=
bd side, with
> >>> qemu and multiple iothreads.
> >>> >>>
> >>> >>>
> >>> >>> Switching both server and client to jemalloc give me best perfo=
rmance
> >>> on small read currently.
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>> ----- Mail original -----
> >>> >>> De: "Mark Nelson"
> >>> >>> =C3=80: "ceph-devel"
> >>> >>> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 06:45:36
> >>> >>> Objet: Ceph Hackathon: More Memory Allocator Testing
> >>> >>>
> >>> >>> Hi Everyone,
> >>> >>>
> >>> >>> One of the goals at the Ceph Hackathon last week was to examine=
 how
> >>> to improve Ceph Small IO performance. Jian Zhang presented findings
> >>> showing a dramatic improvement in small random IO performance when
> >>> Ceph is used with jemalloc. His results build upon Sandisk's origin=
al findings
> >>> that the default thread cache values are a major bottleneck in TCMa=
lloc 2.1.
> >>> To further verify these results, we sat down at the Hackathon and c=
onfigured
> >>> the new performance test cluster that Intel generously donated to t=
he Ceph
> >>> community laboratory to run through a variety of tests with differe=
nt
> >>> memory allocator configurations. I've since written the results of =
those tests
> >>> up in pdf form for folks who are interested.
> >>> >>>
> >>> >>> The results are located here:
> >>> >>>
> >>> >>>
> >>> http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Tes
> >>> ting.
> >>> >>> pdf
> >>> >>>
> >>> >>> I want to be clear that many other folks have done the heavy li=
fting
> >>> here. These results are simply a validation of the many tests that =
other folks
> >>> have already done. Many thanks to Sandisk and others for figuring t=
his out as
> >>> it's a pretty big deal!
> >>> >>>
> >>> >>> Side note: Very little tuning other than swapping the memory al=
locator
> >>> and a couple of quick and dirty ceph tunables were set during these=
 tests. It's
> >>> quite possible that higher IOPS will be achieved as we really start=
 digging into
> >>> the cluster and learning what the bottlenecks are.
> >>> >>>
> >>> >>> Thanks,
> >>> >>> Mark
> >>> >>> --
> >>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel"
> >>> >>> in the body of a message to majordomo@vger.kernel.org More
> >>> majordomo
> >>> >>> info at http://vger.kernel.org/majordomo-info.html
> >>> >>>
> >>> >>> --
> >>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel"
> >>> >>> in the body of a message to majordomo@vger.kernel.org More
> >>> majordomo
> >>> >>> info at  http://vger.kernel.org/majordomo-info.html
> >>> >>>
> >>> >>> ________________________________
> >>> >>>
> >>> >>> PLEASE NOTE: The information contained in this electronic mail =
message
> >>> is intended only for the use of the designated recipient(s) named a=
bove. If
> >>> the reader of this message is not the intended recipient, you are h=
ereby
> >>> notified that you have received this message in error and that any =
review,
> >>> dissemination, distribution, or copying of this message is strictly=
 prohibited. If
> >>> you have received this communication in error, please notify the se=
nder by
> >>> telephone or e-mail (as shown above) immediately and destroy any an=
d all
> >>> copies of this message in your possession (whether hard copies or
> >>> electronically stored copies).
> >>> >>>
> >>> >>> N     r  y   b X  ?v ^ )?{.n +   z ]z   {ay  ?? ,j   f   h   z =
  w
> >>> >>      j:+v   w j m         zZ+     ?j"  !tml=3D
> >>> >>>
> >>> >> N     r  y   b X  ?v ^ )?{.n +   z ]z   {ay  ?? ,j   f   h   z  =
 w
> >>> >     j:+v   w j m         zZ+     ?j"  !tml=3D
> >>> >>
> >>> N???????????????r??????y?????????b???X???????v???^???)?{.n???+?????=
????z???]z?????????{ay??? ?????,j
> >> ??????f?????????h?????????z???
> >>> ???w?????????
> >>>
> >>> ?????????j:+v?????????w???j???m????????????
> >> ????????????zZ+????????????????j"??????!???i
> >>
> >> ________________________________
> >>
> >> PLEASE NOTE: The information contained in this electronic mail messa=
ge is intended only for the use of the designated recipient(s) named abov=
e. If the reader of this message is not the intended recipient, you are h=
ereby notified that you have received this message in error and that any =
review, dissemination, distribution, or copying of this message is strict=
ly prohibited. If you have received this communication in error, please n=
otify the sender by telephone or e-mail (as shown above) immediately and =
destroy any and all copies of this message in your possession (whether ha=
rd copies or electronically stored copies).
> >>
> >
> >
> >
> > --
> > Milosz Tanski
> > CTO
> > 16 East 34th Street, 15th floor
> > New York, NY 10016
> >
> > p: 646-253-9055
> > e: milosz@adfin.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.0.0
> Comment: https://www.mailvelope.com
>=20
> wsFcBAEBCAAQBQJV13b/CRDmVDuy+mK58QAAxvkQAI7s/5W4hJ/DCp3h50Lh
> 1zz9oq2RM6wyTX5SFOcTgdqUKvZOPFHVAt2M3s/q1aCwT2X7+N+AJkFU6rya
> d2xCz9BXXgb3EWXdYAIY96QTA4ZL3khcz8HznNVd4bJwRAT8DcM2Q3/O+KPT
> GkyaSE1WDvC1M1jKZH1O1CNk0t0qn2TbABvsnPHmfaJ7kA/HdXGA/wGTnFoK
> ugAEVVaCBQezxFlU+FOYa72ov0m8IGaoPx7AEbkkzXcH2jNBb2toBMjQPVjo
> xes9TkZcw99hMFStlUFMhzuopB9N11yS/UBXjrQm2g1irgFpT/6XKqqrNZwl
> AEtk4iC8sAw4CNLzSPx1i6errWqi7Bo2V9ylH+mhBEUZ2I7m40HtWqlu7RyK
> FjmDBEEyeI4Osim3r1h7jb4juaq0uuQXZzAeRgyHaH/IDA5ZStwUdOSZ4YNJ
> xvq1TLctO64CG6GZeLM45q7V/yOCnOL8wLIDjtea8mAz8x6ugkV5LjdLZ9oh
> dEStoZyDEfKmgud8NMbAmCNJOrBSsA9a4Sxe2uoroSiwN60hJxYXmZ11dNv3
> 9Sraox44Sq4FWWZgCIqS0sJK11kYeF03Cy7fllr9mq9BHr9E4dlhXVLzdPDE
> z23QBHSEJDtvOfGXg+nP0UTTjwStWA3UTX7poy+ydR2goTcNZscMSDSOjIFo
> ChIM
> =3DWlNV
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-457727926-1440251566=:13116--
