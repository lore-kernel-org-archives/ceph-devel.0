From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 22:17:52 +0200
Message-ID: <55D4E470.9030501@profihost.ag>
References: <55D409F0.3050802@redhat.com>
 <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE127C5@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:47992 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbbHSURw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 16:17:52 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE127C5@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


Am 19.08.2015 um 22:16 schrieb Somnath Roy:
> Alexandre,
> I am not able to build librados/librbd by using the following config =
option.
>
> ./configure =E2=80=93without-tcmalloc =E2=80=93with-jemalloc

Same issue to me. You have to remove libcmalloc out of your build=20
environment to get this done.

Stefan


> It seems it is building osd/mon/Mds/RGW with jemalloc enabled..
>
> root@emsnode10:~/ceph-latest/src# ldd ./ceph-osd
>          linux-vdso.so.1 =3D>  (0x00007ffd0eb43000)
>          libjemalloc.so.1 =3D> /usr/lib/x86_64-linux-gnu/libjemalloc.=
so.1 (0x00007f5f92d70000)
>          .......
>
> root@emsnode10:~/ceph-latest/src/.libs# ldd ./librados.so.2.0.0
>          linux-vdso.so.1 =3D>  (0x00007ffed46f2000)
>          libboost_thread.so.1.55.0 =3D> /usr/lib/x86_64-linux-gnu/lib=
boost_thread.so.1.55.0 (0x00007ff687887000)
>          liblttng-ust.so.0 =3D> /usr/lib/x86_64-linux-gnu/liblttng-us=
t.so.0 (0x00007ff68763d000)
>          libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2 (0x00007ff6=
87438000)
>          libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0 (=
0x00007ff68721a000)
>          libnss3.so =3D> /usr/lib/x86_64-linux-gnu/libnss3.so (0x0000=
7ff686ee0000)
>          libsmime3.so =3D> /usr/lib/x86_64-linux-gnu/libsmime3.so (0x=
00007ff686cb3000)
>          libnspr4.so =3D> /usr/lib/x86_64-linux-gnu/libnspr4.so (0x00=
007ff686a76000)
>          libuuid.so.1 =3D> /lib/x86_64-linux-gnu/libuuid.so.1 (0x0000=
7ff686871000)
>          librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1 (0x00007ff6=
86668000)
>          libboost_system.so.1.55.0 =3D> /usr/lib/x86_64-linux-gnu/lib=
boost_system.so.1.55.0 (0x00007ff686464000)
>          libstdc++.so.6 =3D> /usr/lib/x86_64-linux-gnu/libstdc++.so.6=
 (0x00007ff686160000)
>          libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6 (0x00007ff685=
e59000)
>          libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007ff685=
a94000)
>          libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00=
007ff68587e000)
>          liblttng-ust-tracepoint.so.0 =3D> /usr/lib/x86_64-linux-gnu/=
liblttng-ust-tracepoint.so.0 (0x00007ff685663000)
>          liburcu-bp.so.1 =3D> /usr/lib/liburcu-bp.so.1 (0x00007ff6854=
5c000)
>          liburcu-cds.so.1 =3D> /usr/lib/liburcu-cds.so.1 (0x00007ff68=
5255000)
>          /lib64/ld-linux-x86-64.so.2 (0x00007ff68a0f6000)
>          libnssutil3.so =3D> /usr/lib/x86_64-linux-gnu/libnssutil3.so=
 (0x00007ff685029000)
>          libplc4.so =3D> /usr/lib/x86_64-linux-gnu/libplc4.so (0x0000=
7ff684e24000)
>          libplds4.so =3D> /usr/lib/x86_64-linux-gnu/libplds4.so (0x00=
007ff684c20000)
>
> It is building with libcmalloc always...
>
> Did you change the ceph makefiles to build librbd/librados with jemal=
loc ?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Alexandre DERUMIER
> Sent: Wednesday, August 19, 2015 7:01 AM
> To: Mark Nelson
> Cc: ceph-devel
> Subject: Re: Ceph Hackathon: More Memory Allocator Testing
>
> Thanks Marc,
>
> Results are matching exactly what I have seen with tcmalloc 2.1 vs 2.=
4 vs jemalloc.
>
> and indeed tcmalloc, even with bigger cache, seem decrease over time.
>
>
> What is funny, is that I see exactly same behaviour client librbd sid=
e, with qemu and multiple iothreads.
>
>
> Switching both server and client to jemalloc give me best performance=
 on small read currently.
>
>
>
>
>
>
> ----- Mail original -----
> De: "Mark Nelson" <mnelson@redhat.com>
> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Mercredi 19 Ao=C3=BBt 2015 06:45:36
> Objet: Ceph Hackathon: More Memory Allocator Testing
>
> Hi Everyone,
>
> One of the goals at the Ceph Hackathon last week was to examine how t=
o improve Ceph Small IO performance. Jian Zhang presented findings show=
ing a dramatic improvement in small random IO performance when Ceph is =
used with jemalloc. His results build upon Sandisk's original findings =
that the default thread cache values are a major bottleneck in TCMalloc=
 2.1. To further verify these results, we sat down at the Hackathon and=
 configured the new performance test cluster that Intel generously dona=
ted to the Ceph community laboratory to run through a variety of tests =
with different memory allocator configurations. I've since written the =
results of those tests up in pdf form for folks who are interested.
>
> The results are located here:
>
> http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Testing=
=2Epdf
>
> I want to be clear that many other folks have done the heavy lifting =
here. These results are simply a validation of the many tests that othe=
r folks have already done. Many thanks to Sandisk and others for figuri=
ng this out as it's a pretty big deal!
>
> Side note: Very little tuning other than swapping the memory allocato=
r and a couple of quick and dirty ceph tunables were set during these t=
ests. It's quite possible that higher IOPS will be achieved as we reall=
y start digging into the cluster and learning what the bottlenecks are.
>
> Thanks,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html
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
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
