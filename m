From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 22:40:30 +0200
Message-ID: <55D4E9BE.8000309@profihost.ag>
References: <55D409F0.3050802@redhat.com>
 <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE127C5@SACMBXIP01.sdcorp.global.sandisk.com>
 <55D4E470.9030501@profihost.ag>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12841@SACMBXIP01.sdcorp.global.sandisk.com>
 <55D4E793.9040408@profihost.ag>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12899@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:30388 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbbHSUk3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 16:40:29 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12899@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


Am 19.08.2015 um 22:34 schrieb Somnath Roy:
> But, you said you need to remove libcmalloc *not* libtcmalloc...
> I saw librbd/librados is built with libcmalloc not with libtcmalloc..
> So, are you saying to remove libtcmalloc (not libcmalloc) to enable j=
emalloc ?

Ouch my mistake. I read libtcmalloc - too late here.

My build (Hammer) says:
# ldd /usr/lib/librados.so.2.0.0
         linux-vdso.so.1 =3D>  (0x00007fff4f71d000)
         libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fafdb=
26c000)
         libboost_thread.so.1.49.0 =3D> /usr/lib/libboost_thread.so.1.4=
9.0=20
(0x00007fafdb24f000)
         libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0=20
(0x00007fafdb032000)
         libcrypto++.so.9 =3D> /usr/lib/libcrypto++.so.9 (0x00007fafda9=
24000)
         libuuid.so.1 =3D> /lib/x86_64-linux-gnu/libuuid.so.1=20
(0x00007fafda71f000)
         librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x00007fafda=
516000)
         libboost_system.so.1.49.0 =3D> /usr/lib/libboost_system.so.1.4=
9.0=20
(0x00007fafda512000)
         libstdc++.so.6 =3D> /usr/lib/x86_64-linux-gnu/libstdc++.so.6=20
(0x00007fafda20b000)
         libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6 (0x00007fafd9f8=
8000)
         libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007fafd9bf=
d000)
         libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so.1=20
(0x00007fafd99e7000)
         /lib64/ld-linux-x86-64.so.2 (0x000056358ecfe000)

Only ceph-osd is linked against libjemalloc for me.

Stefan

> -----Original Message-----
> From: Stefan Priebe [mailto:s.priebe@profihost.ag]
> Sent: Wednesday, August 19, 2015 1:31 PM
> To: Somnath Roy; Alexandre DERUMIER; Mark Nelson
> Cc: ceph-devel
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>
>
> Am 19.08.2015 um 22:29 schrieb Somnath Roy:
>> Hmm...We need to fix that as part of configure/Makefile I guess (?).=
=2E
>> Since we have done this jemalloc integration originally, we can take=
 that ownership unless anybody sees a problem of enabling tcmalloc/jema=
lloc with librbd/librados.
>>
>> << You have to remove libcmalloc out of your build environment to ge=
t
>> this done How do I do that ? I am using Ubuntu and can't afford to r=
emove libc* packages.
>
> I always use a chroot to build packages where only a minimal bootstra=
p + the build deps are installed. googleperftools where libtcmalloc com=
es from is not Ubuntu "core/minimal".
>
> Stefan
>
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Stefan Priebe [mailto:s.priebe@profihost.ag]
>> Sent: Wednesday, August 19, 2015 1:18 PM
>> To: Somnath Roy; Alexandre DERUMIER; Mark Nelson
>> Cc: ceph-devel
>> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>>
>>
>> Am 19.08.2015 um 22:16 schrieb Somnath Roy:
>>> Alexandre,
>>> I am not able to build librados/librbd by using the following confi=
g option.
>>>
>>> ./configure =E2=80=93without-tcmalloc =E2=80=93with-jemalloc
>>
>> Same issue to me. You have to remove libcmalloc out of your build en=
vironment to get this done.
>>
>> Stefan
>>
>>
>>> It seems it is building osd/mon/Mds/RGW with jemalloc enabled..
>>>
>>> root@emsnode10:~/ceph-latest/src# ldd ./ceph-osd
>>>            linux-vdso.so.1 =3D>  (0x00007ffd0eb43000)
>>>            libjemalloc.so.1 =3D> /usr/lib/x86_64-linux-gnu/libjemal=
loc.so.1 (0x00007f5f92d70000)
>>>            .......
>>>
>>> root@emsnode10:~/ceph-latest/src/.libs# ldd ./librados.so.2.0.0
>>>            linux-vdso.so.1 =3D>  (0x00007ffed46f2000)
>>>            libboost_thread.so.1.55.0 =3D> /usr/lib/x86_64-linux-gnu=
/libboost_thread.so.1.55.0 (0x00007ff687887000)
>>>            liblttng-ust.so.0 =3D> /usr/lib/x86_64-linux-gnu/liblttn=
g-ust.so.0 (0x00007ff68763d000)
>>>            libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2 (0x0000=
7ff687438000)
>>>            libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so=
=2E0 (0x00007ff68721a000)
>>>            libnss3.so =3D> /usr/lib/x86_64-linux-gnu/libnss3.so (0x=
00007ff686ee0000)
>>>            libsmime3.so =3D> /usr/lib/x86_64-linux-gnu/libsmime3.so=
 (0x00007ff686cb3000)
>>>            libnspr4.so =3D> /usr/lib/x86_64-linux-gnu/libnspr4.so (=
0x00007ff686a76000)
>>>            libuuid.so.1 =3D> /lib/x86_64-linux-gnu/libuuid.so.1 (0x=
00007ff686871000)
>>>            librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x0000=
7ff686668000)
>>>            libboost_system.so.1.55.0 =3D> /usr/lib/x86_64-linux-gnu=
/libboost_system.so.1.55.0 (0x00007ff686464000)
>>>            libstdc++.so.6 =3D> /usr/lib/x86_64-linux-gnu/libstdc++.=
so.6 (0x00007ff686160000)
>>>            libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6 (0x00007f=
f685e59000)
>>>            libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007f=
f685a94000)
>>>            libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so.1 (=
0x00007ff68587e000)
>>>            liblttng-ust-tracepoint.so.0 =3D> /usr/lib/x86_64-linux-=
gnu/liblttng-ust-tracepoint.so.0 (0x00007ff685663000)
>>>            liburcu-bp.so.1 =3D> /usr/lib/liburcu-bp.so.1 (0x00007ff=
68545c000)
>>>            liburcu-cds.so.1 =3D> /usr/lib/liburcu-cds.so.1 (0x00007=
ff685255000)
>>>            /lib64/ld-linux-x86-64.so.2 (0x00007ff68a0f6000)
>>>            libnssutil3.so =3D> /usr/lib/x86_64-linux-gnu/libnssutil=
3.so (0x00007ff685029000)
>>>            libplc4.so =3D> /usr/lib/x86_64-linux-gnu/libplc4.so (0x=
00007ff684e24000)
>>>            libplds4.so =3D> /usr/lib/x86_64-linux-gnu/libplds4.so
>>> (0x00007ff684c20000)
>>>
>>> It is building with libcmalloc always...
>>>
>>> Did you change the ceph makefiles to build librbd/librados with jem=
alloc ?
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Alexandre
>>> DERUMIER
>>> Sent: Wednesday, August 19, 2015 7:01 AM
>>> To: Mark Nelson
>>> Cc: ceph-devel
>>> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>>>
>>> Thanks Marc,
>>>
>>> Results are matching exactly what I have seen with tcmalloc 2.1 vs =
2.4 vs jemalloc.
>>>
>>> and indeed tcmalloc, even with bigger cache, seem decrease over tim=
e.
>>>
>>>
>>> What is funny, is that I see exactly same behaviour client librbd s=
ide, with qemu and multiple iothreads.
>>>
>>>
>>> Switching both server and client to jemalloc give me best performan=
ce on small read currently.
>>>
>>>
>>>
>>>
>>>
>>>
>>> ----- Mail original -----
>>> De: "Mark Nelson" <mnelson@redhat.com>
>>> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
>>> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 06:45:36
>>> Objet: Ceph Hackathon: More Memory Allocator Testing
>>>
>>> Hi Everyone,
>>>
>>> One of the goals at the Ceph Hackathon last week was to examine how=
 to improve Ceph Small IO performance. Jian Zhang presented findings sh=
owing a dramatic improvement in small random IO performance when Ceph i=
s used with jemalloc. His results build upon Sandisk's original finding=
s that the default thread cache values are a major bottleneck in TCMall=
oc 2.1. To further verify these results, we sat down at the Hackathon a=
nd configured the new performance test cluster that Intel generously do=
nated to the Ceph community laboratory to run through a variety of test=
s with different memory allocator configurations. I've since written th=
e results of those tests up in pdf form for folks who are interested.
>>>
>>> The results are located here:
>>>
>>> http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Testi=
ng.
>>> pdf
>>>
>>> I want to be clear that many other folks have done the heavy liftin=
g here. These results are simply a validation of the many tests that ot=
her folks have already done. Many thanks to Sandisk and others for figu=
ring this out as it's a pretty big deal!
>>>
>>> Side note: Very little tuning other than swapping the memory alloca=
tor and a couple of quick and dirty ceph tunables were set during these=
 tests. It's quite possible that higher IOPS will be achieved as we rea=
lly start digging into the cluster and learning what the bottlenecks ar=
e.
>>>
>>> Thanks,
>>> Mark
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o
>>> info at http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> ________________________________
>>>
>>> PLEASE NOTE: The information contained in this electronic mail mess=
age is intended only for the use of the designated recipient(s) named a=
bove. If the reader of this message is not the intended recipient, you =
are hereby notified that you have received this message in error and th=
at any review, dissemination, distribution, or copying of this message =
is strictly prohibited. If you have received this communication in erro=
r, please notify the sender by telephone or e-mail (as shown above) imm=
ediately and destroy any and all copies of this message in your possess=
ion (whether hard copies or electronically stored copies).
>>>
>>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=99=
 ,j   f   h   z =1E w
>>      j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>>
>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=99=
 ,j   f   h   z =1E w
>     j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
