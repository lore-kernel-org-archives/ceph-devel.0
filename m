From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Fri, 21 Aug 2015 10:26:58 -0400
Message-ID: <CANP1eJH=mhQ1rBkUD8=yuF26s2t2vO0JMO-wKOLQ8VbWdEmxxw@mail.gmail.com>
References: <55D409F0.3050802@redhat.com>
	<1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE127C5@SACMBXIP01.sdcorp.global.sandisk.com>
	<55D4E470.9030501@profihost.ag>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12841@SACMBXIP01.sdcorp.global.sandisk.com>
	<55D4E793.9040408@profihost.ag>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12899@SACMBXIP01.sdcorp.global.sandisk.com>
	<55D4E9BE.8000309@profihost.ag>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12966@SACMBXIP01.sdcorp.global.sandisk.com>
	<EA545303A8F8E842820A172C3D641D6E1B09E891@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:35886 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbbHUO1A convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Aug 2015 10:27:00 -0400
Received: by lagz9 with SMTP id z9so42315650lag.3
        for <ceph-devel@vger.kernel.org>; Fri, 21 Aug 2015 07:26:58 -0700 (PDT)
In-Reply-To: <EA545303A8F8E842820A172C3D641D6E1B09E891@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shishir Gowda <Shishir.Gowda@sandisk.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Stefan Priebe <s.priebe@profihost.ag>, Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Aug 21, 2015 at 12:22 AM, Shishir Gowda
<Shishir.Gowda@sandisk.com> wrote:
> Hi All,
>
> Have sent out a pull request which enables building librados/librbd w=
ith either tcmalloc(as default)  or jemalloc.
>
> Please find the pull request @ https://github.com/ceph/ceph/pull/5628
>
> With regards,
> Shishir

Unless I'm missing something here, this seams like the wrong thing to.
Libraries that will be linked in by other external applications should
not have a 3rd party malloc linked in there. That seams like an
application choice. At the very least the default should not be to
link in a 3rd party malloc.

>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Somnath Roy
>> Sent: Thursday, August 20, 2015 2:14 AM
>> To: Stefan Priebe; Alexandre DERUMIER; Mark Nelson
>> Cc: ceph-devel
>> Subject: RE: Ceph Hackathon: More Memory Allocator Testing
>>
>> Yeah , I can see ceph-osd/ceph-mon built with jemalloc.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Stefan Priebe [mailto:s.priebe@profihost.ag]
>> Sent: Wednesday, August 19, 2015 1:41 PM
>> To: Somnath Roy; Alexandre DERUMIER; Mark Nelson
>> Cc: ceph-devel
>> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>>
>>
>> Am 19.08.2015 um 22:34 schrieb Somnath Roy:
>> > But, you said you need to remove libcmalloc *not* libtcmalloc...
>> > I saw librbd/librados is built with libcmalloc not with libtcmallo=
c..
>> > So, are you saying to remove libtcmalloc (not libcmalloc) to enabl=
e jemalloc
>> ?
>>
>> Ouch my mistake. I read libtcmalloc - too late here.
>>
>> My build (Hammer) says:
>> # ldd /usr/lib/librados.so.2.0.0
>>          linux-vdso.so.1 =3D>  (0x00007fff4f71d000)
>>          libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fa=
fdb26c000)
>>          libboost_thread.so.1.49.0 =3D> /usr/lib/libboost_thread.so.=
1.49.0
>> (0x00007fafdb24f000)
>>          libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
>> (0x00007fafdb032000)
>>          libcrypto++.so.9 =3D> /usr/lib/libcrypto++.so.9 (0x00007faf=
da924000)
>>          libuuid.so.1 =3D> /lib/x86_64-linux-gnu/libuuid.so.1
>> (0x00007fafda71f000)
>>          librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x00007fa=
fda516000)
>>          libboost_system.so.1.49.0 =3D> /usr/lib/libboost_system.so.=
1.49.0
>> (0x00007fafda512000)
>>          libstdc++.so.6 =3D> /usr/lib/x86_64-linux-gnu/libstdc++.so.=
6
>> (0x00007fafda20b000)
>>          libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6 (0x00007fafd=
9f88000)
>>          libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007fafd=
9bfd000)
>>          libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so.1
>> (0x00007fafd99e7000)
>>          /lib64/ld-linux-x86-64.so.2 (0x000056358ecfe000)
>>
>> Only ceph-osd is linked against libjemalloc for me.
>>
>> Stefan
>>
>> > -----Original Message-----
>> > From: Stefan Priebe [mailto:s.priebe@profihost.ag]
>> > Sent: Wednesday, August 19, 2015 1:31 PM
>> > To: Somnath Roy; Alexandre DERUMIER; Mark Nelson
>> > Cc: ceph-devel
>> > Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>> >
>> >
>> > Am 19.08.2015 um 22:29 schrieb Somnath Roy:
>> >> Hmm...We need to fix that as part of configure/Makefile I guess (=
?)..
>> >> Since we have done this jemalloc integration originally, we can t=
ake that
>> ownership unless anybody sees a problem of enabling tcmalloc/jemallo=
c with
>> librbd/librados.
>> >>
>> >> << You have to remove libcmalloc out of your build environment to=
 get
>> >> this done How do I do that ? I am using Ubuntu and can't afford t=
o remove
>> libc* packages.
>> >
>> > I always use a chroot to build packages where only a minimal boots=
trap +
>> the build deps are installed. googleperftools where libtcmalloc come=
s from is
>> not Ubuntu "core/minimal".
>> >
>> > Stefan
>> >
>> >>
>> >> Thanks & Regards
>> >> Somnath
>> >>
>> >> -----Original Message-----
>> >> From: Stefan Priebe [mailto:s.priebe@profihost.ag]
>> >> Sent: Wednesday, August 19, 2015 1:18 PM
>> >> To: Somnath Roy; Alexandre DERUMIER; Mark Nelson
>> >> Cc: ceph-devel
>> >> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>> >>
>> >>
>> >> Am 19.08.2015 um 22:16 schrieb Somnath Roy:
>> >>> Alexandre,
>> >>> I am not able to build librados/librbd by using the following co=
nfig option.
>> >>>
>> >>> ./configure =E2=80=93without-tcmalloc =E2=80=93with-jemalloc
>> >>
>> >> Same issue to me. You have to remove libcmalloc out of your build
>> environment to get this done.
>> >>
>> >> Stefan
>> >>
>> >>
>> >>> It seems it is building osd/mon/Mds/RGW with jemalloc enabled..
>> >>>
>> >>> root@emsnode10:~/ceph-latest/src# ldd ./ceph-osd
>> >>>            linux-vdso.so.1 =3D>  (0x00007ffd0eb43000)
>> >>>            libjemalloc.so.1 =3D> /usr/lib/x86_64-linux-gnu/libje=
malloc.so.1
>> (0x00007f5f92d70000)
>> >>>            .......
>> >>>
>> >>> root@emsnode10:~/ceph-latest/src/.libs# ldd ./librados.so.2.0.0
>> >>>            linux-vdso.so.1 =3D>  (0x00007ffed46f2000)
>> >>>            libboost_thread.so.1.55.0 =3D> /usr/lib/x86_64-linux-
>> gnu/libboost_thread.so.1.55.0 (0x00007ff687887000)
>> >>>            liblttng-ust.so.0 =3D> /usr/lib/x86_64-linux-gnu/libl=
ttng-ust.so.0
>> (0x00007ff68763d000)
>> >>>            libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2 (0x0=
0007ff687438000)
>> >>>            libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread=
=2Eso.0
>> (0x00007ff68721a000)
>> >>>            libnss3.so =3D> /usr/lib/x86_64-linux-gnu/libnss3.so
>> (0x00007ff686ee0000)
>> >>>            libsmime3.so =3D> /usr/lib/x86_64-linux-gnu/libsmime3=
=2Eso
>> (0x00007ff686cb3000)
>> >>>            libnspr4.so =3D> /usr/lib/x86_64-linux-gnu/libnspr4.s=
o
>> (0x00007ff686a76000)
>> >>>            libuuid.so.1 =3D> /lib/x86_64-linux-gnu/libuuid.so.1
>> (0x00007ff686871000)
>> >>>            librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x0=
0007ff686668000)
>> >>>            libboost_system.so.1.55.0 =3D> /usr/lib/x86_64-linux-
>> gnu/libboost_system.so.1.55.0 (0x00007ff686464000)
>> >>>            libstdc++.so.6 =3D> /usr/lib/x86_64-linux-gnu/libstdc=
++.so.6
>> (0x00007ff686160000)
>> >>>            libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6 (0x000=
07ff685e59000)
>> >>>            libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x000=
07ff685a94000)
>> >>>            libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so.=
1
>> (0x00007ff68587e000)
>> >>>            liblttng-ust-tracepoint.so.0 =3D> /usr/lib/x86_64-lin=
ux-gnu/liblttng-
>> ust-tracepoint.so.0 (0x00007ff685663000)
>> >>>            liburcu-bp.so.1 =3D> /usr/lib/liburcu-bp.so.1 (0x0000=
7ff68545c000)
>> >>>            liburcu-cds.so.1 =3D> /usr/lib/liburcu-cds.so.1 (0x00=
007ff685255000)
>> >>>            /lib64/ld-linux-x86-64.so.2 (0x00007ff68a0f6000)
>> >>>            libnssutil3.so =3D> /usr/lib/x86_64-linux-gnu/libnssu=
til3.so
>> (0x00007ff685029000)
>> >>>            libplc4.so =3D> /usr/lib/x86_64-linux-gnu/libplc4.so
>> (0x00007ff684e24000)
>> >>>            libplds4.so =3D> /usr/lib/x86_64-linux-gnu/libplds4.s=
o
>> >>> (0x00007ff684c20000)
>> >>>
>> >>> It is building with libcmalloc always...
>> >>>
>> >>> Did you change the ceph makefiles to build librbd/librados with =
jemalloc
>> ?
>> >>>
>> >>> Thanks & Regards
>> >>> Somnath
>> >>>
>> >>> -----Original Message-----
>> >>> From: ceph-devel-owner@vger.kernel.org
>> >>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Alexandre
>> >>> DERUMIER
>> >>> Sent: Wednesday, August 19, 2015 7:01 AM
>> >>> To: Mark Nelson
>> >>> Cc: ceph-devel
>> >>> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>> >>>
>> >>> Thanks Marc,
>> >>>
>> >>> Results are matching exactly what I have seen with tcmalloc 2.1 =
vs 2.4 vs
>> jemalloc.
>> >>>
>> >>> and indeed tcmalloc, even with bigger cache, seem decrease over =
time.
>> >>>
>> >>>
>> >>> What is funny, is that I see exactly same behaviour client librb=
d side, with
>> qemu and multiple iothreads.
>> >>>
>> >>>
>> >>> Switching both server and client to jemalloc give me best perfor=
mance
>> on small read currently.
>> >>>
>> >>>
>> >>>
>> >>>
>> >>>
>> >>>
>> >>> ----- Mail original -----
>> >>> De: "Mark Nelson" <mnelson@redhat.com>
>> >>> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
>> >>> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 06:45:36
>> >>> Objet: Ceph Hackathon: More Memory Allocator Testing
>> >>>
>> >>> Hi Everyone,
>> >>>
>> >>> One of the goals at the Ceph Hackathon last week was to examine =
how
>> to improve Ceph Small IO performance. Jian Zhang presented findings
>> showing a dramatic improvement in small random IO performance when
>> Ceph is used with jemalloc. His results build upon Sandisk's origina=
l findings
>> that the default thread cache values are a major bottleneck in TCMal=
loc 2.1.
>> To further verify these results, we sat down at the Hackathon and co=
nfigured
>> the new performance test cluster that Intel generously donated to th=
e Ceph
>> community laboratory to run through a variety of tests with differen=
t
>> memory allocator configurations. I've since written the results of t=
hose tests
>> up in pdf form for folks who are interested.
>> >>>
>> >>> The results are located here:
>> >>>
>> >>>
>> http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Tes
>> ting.
>> >>> pdf
>> >>>
>> >>> I want to be clear that many other folks have done the heavy lif=
ting
>> here. These results are simply a validation of the many tests that o=
ther folks
>> have already done. Many thanks to Sandisk and others for figuring th=
is out as
>> it's a pretty big deal!
>> >>>
>> >>> Side note: Very little tuning other than swapping the memory all=
ocator
>> and a couple of quick and dirty ceph tunables were set during these =
tests. It's
>> quite possible that higher IOPS will be achieved as we really start =
digging into
>> the cluster and learning what the bottlenecks are.
>> >>>
>> >>> Thanks,
>> >>> Mark
>> >>> --
>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>> >>> in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> >>> info at http://vger.kernel.org/majordomo-info.html
>> >>>
>> >>> --
>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>> >>> in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> >>> info at  http://vger.kernel.org/majordomo-info.html
>> >>>
>> >>> ________________________________
>> >>>
>> >>> PLEASE NOTE: The information contained in this electronic mail m=
essage
>> is intended only for the use of the designated recipient(s) named ab=
ove. If
>> the reader of this message is not the intended recipient, you are he=
reby
>> notified that you have received this message in error and that any r=
eview,
>> dissemination, distribution, or copying of this message is strictly =
prohibited. If
>> you have received this communication in error, please notify the sen=
der by
>> telephone or e-mail (as shown above) immediately and destroy any and=
 all
>> copies of this message in your possession (whether hard copies or
>> electronically stored copies).
>> >>>
>> >>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay  =CA=87=DA=
=99 ,j   f   h   z   w
>> >>      j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>> >>>
>> >> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay  =CA=87=DA=99=
 ,j   f   h   z   w
>> >     j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>> >>
>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD =CA=87=DA=99=EF=BF=BD,j
> =EF=BF=BD=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=
=BDz=EF=BF=BD
>> =EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD
>>
>> =EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BD=
j=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!=EF=BF=BDi
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>



--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
